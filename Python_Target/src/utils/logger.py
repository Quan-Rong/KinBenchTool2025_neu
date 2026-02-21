"""日志系统。

提供统一的日志记录功能。
"""

import logging
import sys
from pathlib import Path
from typing import Optional


def setup_logger(
    name: str = "knc_tool",
    log_file: Optional[str] = None,
    level: int = logging.INFO,
) -> logging.Logger:
    """设置并返回logger。
    
    Args:
        name: logger名称
        log_file: 日志文件路径（可选）
        level: 日志级别
        
    Returns:
        配置好的logger对象
    """
    logger = logging.getLogger(name)
    logger.setLevel(level)

    # 避免重复添加handler
    if logger.handlers:
        return logger

    # 格式化器
    formatter = logging.Formatter(
        "%(asctime)s - %(name)s - %(levelname)s - %(message)s",
        datefmt="%Y-%m-%d %H:%M:%S",
    )

    # 控制台handler
    console_handler = logging.StreamHandler(sys.stdout)
    console_handler.setLevel(level)
    console_handler.setFormatter(formatter)
    logger.addHandler(console_handler)

    # 文件handler（如果指定）
    if log_file:
        log_path = Path(log_file)
        log_path.parent.mkdir(parents=True, exist_ok=True)
        file_handler = logging.FileHandler(log_file, encoding="utf-8")
        file_handler.setLevel(level)
        file_handler.setFormatter(formatter)
        logger.addHandler(file_handler)

    return logger


# 默认logger
default_logger = setup_logger()


def get_logger(name: Optional[str] = None) -> logging.Logger:
    """获取logger实例
    
    Args:
        name: logger名称，如果为None则使用默认名称
        
    Returns:
        logger实例
    """
    if name is None:
        return default_logger
    return logging.getLogger(name)
