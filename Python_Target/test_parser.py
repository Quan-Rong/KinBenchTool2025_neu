"""测试脚本：验证数据解析模块

用于测试res_parser、data_extractor等模块是否正常工作。
"""

import sys
from pathlib import Path

# 添加src目录到路径
sys.path.insert(0, str(Path(__file__).parent / "src"))

from src.data.res_parser import ResParser
from src.data.data_extractor import DataExtractor
from src.utils.logger import setup_logger, get_logger

# 设置日志
setup_logger(level=20)  # INFO级别
logger = get_logger(__name__)


def test_parser():
    """测试解析器"""
    # 使用一个测试文件
    test_file = Path(__file__).parent.parent / "NRAC_G023_Results" / "NRAC_G023_parallel_travel.res"
    
    if not test_file.exists():
        logger.error(f"测试文件不存在: {test_file}")
        return
    
    logger.info(f"测试文件: {test_file.name}")
    
    try:
        # 创建解析器
        parser = ResParser(str(test_file))
        
        # 解析文件
        param_ids, quasi_static_data = parser.parse()
        
        logger.info(f"解析成功！")
        logger.info(f"  参数ID数量: {len(param_ids)}")
        logger.info(f"  数据矩阵形状: {quasi_static_data.shape}")
        
        # 显示一些参数ID
        logger.info("\n提取的参数ID示例:")
        for i, (name, ids) in enumerate(list(param_ids.items())[:5]):
            logger.info(f"  {name}: {ids}")
        
        # 测试数据提取器
        extractor = DataExtractor(parser)
        
        # 提取toe_angle数据
        try:
            toe_angle = extractor.extract_by_name('toe_angle', convert_angle=True)
            logger.info(f"\ntoe_angle数据形状: {toe_angle.shape}")
            logger.info(f"  前5个值: {toe_angle[:5] if len(toe_angle) >= 5 else toe_angle}")
        except Exception as e:
            logger.warning(f"提取toe_angle失败: {e}")
        
        logger.info("\n测试完成！")
        
    except Exception as e:
        logger.error(f"测试失败: {e}", exc_info=True)


if __name__ == "__main__":
    test_parser()
