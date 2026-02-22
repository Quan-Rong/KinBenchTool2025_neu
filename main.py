"""主程序入口

KnC Bewertung Tool - K&C分析工具主程序
"""

import sys
from pathlib import Path

# 添加Python_Target/src目录到路径，使导入能够工作
# 获取当前文件所在目录（根目录）
root_dir = Path(__file__).parent
src_dir = root_dir / "Python_Target" / "src"
# 添加src目录到路径，这样相对导入可以工作
sys.path.insert(0, str(src_dir))
# 添加Python_Target目录到路径，这样绝对导入也可以工作
sys.path.insert(0, str(src_dir.parent))

from PyQt6.QtWidgets import QApplication
from PyQt6.QtGui import QIcon

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
    
    # 设置应用程序图标
    try:
        resources_dir = root_dir / "Resources"
        # 尝试使用多个可能的图标文件
        icon_paths = [
            resources_dir / "icons" / "Icon_plot_custerm.png",
            resources_dir / "images" / "Icon_plot_custerm.png",
            resources_dir / "images" / "kc_pic_02.png",
            resources_dir / "images" / "kc_pic_03.png",
        ]
        
        icon_set = False
        for icon_path in icon_paths:
            if icon_path.exists():
                app.setWindowIcon(QIcon(str(icon_path)))
                logger.info(f"应用程序图标已设置: {icon_path}")
                icon_set = True
                break
        
        if not icon_set:
            logger.warning("未找到应用程序图标文件，使用默认图标")
    except Exception as e:
        logger.warning(f"设置应用程序图标失败: {e}")
    
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
