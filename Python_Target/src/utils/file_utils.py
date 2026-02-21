"""文件工具模块

提供文件读取、行数统计等工具函数。
"""

import os
import platform
import subprocess
from pathlib import Path
from typing import Optional, List

from .exceptions import FileError
from .logger import get_logger

logger = get_logger(__name__)


def count_lines(file_path: str) -> int:
    """统计文件行数（跨平台兼容）
    
    Windows系统使用Perl脚本，Linux/Mac系统使用wc命令。
    
    Args:
        file_path: 文件路径
        
    Returns:
        文件行数
        
    Raises:
        FileError: 文件不存在或无法读取
    """
    file_path = Path(file_path)
    
    if not file_path.exists():
        raise FileError(f"文件不存在: {file_path}")
    
    if not file_path.is_file():
        raise FileError(f"路径不是文件: {file_path}")
    
    system = platform.system()
    
    try:
        if system == "Windows":
            # Windows系统使用Perl脚本
            perl_script = """
while (<>) {};
print $.,"\\n";
"""
            # 创建临时Perl脚本
            temp_script = file_path.parent / "countlines_temp.pl"
            try:
                with open(temp_script, 'w', encoding='utf-8') as f:
                    f.write(perl_script)
                
                # 执行Perl脚本（兼容旧版Python）
                result = subprocess.run(
                    ['perl', str(temp_script), str(file_path)],
                    stdout=subprocess.PIPE,
                    stderr=subprocess.PIPE,
                    universal_newlines=True,
                    check=True
                )
                line_count = int(result.stdout.strip())
                logger.debug(f"使用Perl脚本统计行数: {line_count}")
                return line_count
            finally:
                # 清理临时脚本
                if temp_script.exists():
                    temp_script.unlink()
        else:
            # Linux/Mac系统使用wc命令（兼容旧版Python）
            result = subprocess.run(
                ['wc', '-l', str(file_path)],
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                universal_newlines=True,
                check=True
            )
            line_count = int(result.stdout.split()[0])
            logger.debug(f"使用wc命令统计行数: {line_count}")
            return line_count
    except subprocess.CalledProcessError as e:
        raise FileError(f"执行行数统计命令失败: {e}")
    except ValueError as e:
        raise FileError(f"解析行数失败: {e}")
    except Exception as e:
        # 如果命令执行失败，回退到Python方式（较慢但可靠）
        logger.warning(f"使用系统命令统计行数失败，回退到Python方式: {e}")
        return _count_lines_python(file_path)


def _count_lines_python(file_path: Path) -> int:
    """使用Python方式统计文件行数（回退方案）
    
    Args:
        file_path: 文件路径
        
    Returns:
        文件行数
    """
    try:
        with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
            count = sum(1 for _ in f)
        logger.debug(f"使用Python方式统计行数: {count}")
        return count
    except Exception as e:
        raise FileError(f"读取文件失败: {e}")


def read_file_lines(file_path: str, encoding: str = 'utf-8') -> List[str]:
    """读取文件所有行
    
    Args:
        file_path: 文件路径
        encoding: 文件编码，默认为utf-8
        
    Returns:
        文件行列表
        
    Raises:
        FileError: 文件读取失败
    """
    file_path = Path(file_path)
    
    if not file_path.exists():
        raise FileError(f"文件不存在: {file_path}")
    
    try:
        with open(file_path, 'r', encoding=encoding, errors='ignore') as f:
            lines = f.readlines()
        logger.debug(f"读取文件 {file_path.name}: {len(lines)} 行")
        return [line.rstrip('\n\r') for line in lines]
    except Exception as e:
        raise FileError(f"读取文件失败: {e}")


def read_file_generator(file_path: str, encoding: str = 'utf-8'):
    """生成器方式逐行读取文件（适用于大文件）
    
    Args:
        file_path: 文件路径
        encoding: 文件编码，默认为utf-8
        
    Yields:
        文件行（去除换行符）
        
    Raises:
        FileError: 文件读取失败
    """
    file_path = Path(file_path)
    
    if not file_path.exists():
        raise FileError(f"文件不存在: {file_path}")
    
    try:
        with open(file_path, 'r', encoding=encoding, errors='ignore') as f:
            for line in f:
                yield line.rstrip('\n\r')
    except Exception as e:
        raise FileError(f"读取文件失败: {e}")
