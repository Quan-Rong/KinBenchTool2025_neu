"""主程序入口

KnC Bewertung Tool - K&C分析工具主程序
"""

import sys
from pathlib import Path

# 添加src目录和其父目录到路径，使相对导入和绝对导入都能工作
src_dir = Path(__file__).parent
parent_dir = src_dir.parent
# 先添加src目录，这样相对导入可以工作
sys.path.insert(0, str(src_dir))
# 再添加父目录，这样绝对导入也可以工作
sys.path.insert(0, str(parent_dir))

from PyQt6.QtWidgets import QApplication

from src.utils.logger import setup_logger, get_logger
from src.gui.main_window import MainWindow

# 设置日志
setup_logger()
logger = get_logger(__name__)


def main():
    """主函数"""
    logger.info("KnC Bewertung Tool 启动")
    
    # 创建QApplication
    app = QApplication(sys.argv)
    app.setApplicationName("KinBench Tool")
    app.setOrganizationName("CAE")
    
    # PyQt6默认启用高DPI缩放，无需手动设置
    
    # 创建主窗口
    try:
        window = MainWindow()
        window.show()
        
        logger.info("GUI界面启动成功")
        
        # 运行事件循环
        sys.exit(app.exec())
        
    except Exception as e:
        logger.error(f"GUI启动失败: {e}", exc_info=True)
        sys.exit(1)


if __name__ == "__main__":
    main()
