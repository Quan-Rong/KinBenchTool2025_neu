"""主程序入口

KnC Bewertung Tool - K&C分析工具主程序
"""

import sys
from pathlib import Path

# 添加src目录到路径
sys.path.insert(0, str(Path(__file__).parent))

from PyQt6.QtWidgets import QApplication
from PyQt6.QtCore import Qt

from utils.logger import setup_logger, get_logger
from gui.main_window import MainWindow

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
    
    # 设置应用程序属性
    QApplication.setAttribute(Qt.ApplicationAttribute.AA_EnableHighDpiScaling, True)
    QApplication.setAttribute(Qt.ApplicationAttribute.AA_UseHighDpiPixmaps, True)
    
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
