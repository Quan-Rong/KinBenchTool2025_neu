"""主窗口模块

提供应用程序主窗口，整合所有UI组件。
"""

from typing import Optional
from datetime import datetime
from PyQt6.QtWidgets import (QMainWindow, QWidget, QVBoxLayout, QHBoxLayout,
                            QTabWidget, QMenuBar, QStatusBar, QLabel, QMessageBox,
                            QSplitter, QToolBar, QToolButton, QPushButton, QComboBox, QGroupBox, QSizePolicy, QTabBar, QStyle, QStyleOptionTab)
from PyQt6.QtCore import Qt, QSize
from PyQt6.QtGui import QFont, QAction, QIcon, QPixmap, QPainter, QColor
from pathlib import Path

from .vehicle_params import VehicleParamsPanel
from .kc_tabs import (StartInfoTab, BumpTestTab, RollTestTab,
                     StaticLoadLateralTab, StaticLoadBrakingTab,
                     StaticLoadAccelerationTab)
from ..utils.logger import get_logger

logger = get_logger(__name__)


class ColoredTabBar(QTabBar):
    """自定义TabBar，为每个标签设置不同的背景色（像文件夹一样）"""
    
    def __init__(self, parent=None):
        super().__init__(parent)
        # 定义每个标签的背景颜色
        self.tab_colors = [
            QColor(200, 220, 255, 180),   # START/INFO - 浅蓝色
            QColor(200, 255, 200, 180),   # Bump - 浅绿色
            QColor(255, 255, 200, 180),   # Roll Test - 浅黄色
            QColor(255, 200, 200, 180),   # Static Load Lateral - 浅红色
            QColor(255, 200, 255, 180),   # Static Load Braking - 浅紫色
            QColor(200, 255, 255, 180),   # Static Load Acceleration - 浅青色
            QColor(220, 220, 220, 180),   # Align Torque - 浅灰色
        ]
    
    def paintEvent(self, event):
        """重写绘制事件，为每个标签绘制不同背景色"""
        painter = QPainter(self)
        painter.setRenderHint(QPainter.RenderHint.Antialiasing)
        
        # 绘制每个标签的背景
        for i in range(self.count()):
            if not self.isTabVisible(i):
                continue
            
            tab_rect = self.tabRect(i)
            if tab_rect.isEmpty():
                continue
            
            # 获取标签颜色
            bg_color = self.tab_colors[i] if i < len(self.tab_colors) else QColor(200, 220, 255, 180)
            
            # 如果是选中的标签，使用白色背景
            if i == self.currentIndex():
                bg_color = QColor(255, 255, 255, 240)
            
            # 绘制标签背景（圆角矩形）
            painter.setBrush(bg_color)
            painter.setPen(QColor(255, 255, 255, 80))
            # 只绘制上方的圆角
            painter.drawRoundedRect(tab_rect.adjusted(0, 0, -1, 0), 8, 8)
            
            # 如果是选中的标签，绘制底部边框
            if i == self.currentIndex():
                painter.setPen(QColor(102, 126, 234, 255))
                painter.setBrush(Qt.BrushStyle.NoBrush)
                painter.drawLine(tab_rect.left() + 1, tab_rect.bottom() - 1, 
                               tab_rect.right() - 1, tab_rect.bottom() - 1)
                painter.drawLine(tab_rect.left() + 1, tab_rect.bottom() - 2, 
                               tab_rect.right() - 1, tab_rect.bottom() - 2)
        
        # 调用父类方法绘制文字和图标（但需要确保文字是黑色的）
        # 先设置文字颜色为黑色
        for i in range(self.count()):
            if self.isTabVisible(i):
                self.setTabTextColor(i, QColor(0, 0, 0))
        
        # 调用父类方法绘制
        super().paintEvent(event)


class MainWindow(QMainWindow):
    """主窗口类
    
    应用程序的主窗口，包含菜单栏、状态栏、车辆参数面板和K&C分析Tab。
    """
    
    def __init__(self, parent: Optional[QWidget] = None):
        """初始化主窗口
        
        Args:
            parent: 父Widget
        """
        super().__init__(parent)
        
        self.setWindowTitle("KinBench Tool - K&C Analysis")
        # 设置窗口大小，优化比例：宽度1600，高度1000，黄金比例更和谐
        self.resize(1600, 1000)
        self.setMinimumSize(1280, 720)
        
        # 设置窗口图标
        self._set_window_icon()
        
        # 设置样式
        self.setup_style()
        
        # 保存面板默认宽度，优化比例（约占总宽度的20%）
        self.vehicle_params_panel_default_width = 320
        
        # 设置UI
        self.setup_ui()
        
        # 设置工具栏
        self.setup_toolbar()
        
        # 设置菜单栏
        self.setup_menu_bar()
        
        # 设置状态栏
        self.setup_status_bar()
        
        # 连接信号
        self.connect_signals()
        
        logger.info("主窗口初始化完成")
    
    def _set_window_icon(self):
        """设置窗口图标"""
        try:
            # 从main_window.py的位置计算Resources目录
            current_file = Path(__file__)
            resources_dir = current_file.parent.parent.parent.parent / "Resources"
            
            # 尝试使用多个可能的图标文件
            icon_paths = [
                resources_dir / "icons" / "Icon_plot_custerm.png",
                resources_dir / "images" / "Icon_plot_custerm.png",
                resources_dir / "images" / "kc_pic_02.png",
                resources_dir / "images" / "kc_pic_03.png",
            ]
            
            for icon_path in icon_paths:
                if icon_path.exists():
                    self.setWindowIcon(QIcon(str(icon_path)))
                    logger.info(f"窗口图标已设置: {icon_path}")
                    return
            
            logger.warning("未找到窗口图标文件，使用默认图标")
        except Exception as e:
            logger.warning(f"设置窗口图标失败: {e}")
    
    def setup_style(self):
        """设置窗口样式 - 现代化Material Design风格 + 毛玻璃效果"""
        # 现代化样式表 - Material Design 3.0风格 + 半透明毛玻璃效果
        self.setStyleSheet("""
            /* 主窗口 - 彩色渐变背景 */
            QMainWindow {
                background: qlineargradient(x1:0, y1:0, x2:1, y2:1,
                    stop:0 #667eea, stop:0.5 #764ba2, stop:1 #f093fb);
            }
            
            /* 中央Widget - 透明，让背景显示 */
            QWidget#centralwidget {
                background: transparent;
            }
            
            /* 菜单栏 - 半透明毛玻璃效果 */
            QMenuBar {
                background-color: rgba(255, 255, 255, 0.85);
                border-bottom: 2px solid rgba(102, 126, 234, 0.3);
                padding: 4px;
                spacing: 3px;
            }
            QMenuBar::item {
                background-color: transparent;
                padding: 6px 12px;
                border-radius: 6px;
                color: #1e293b;
                font-weight: 500;
                font-size: 11px;
            }
            QMenuBar::item:selected {
                background-color: #f1f5f9;
                color: #6366f1;
            }
            QMenu {
                background-color: rgba(255, 255, 255, 0.9);
                border: 1px solid rgba(255, 255, 255, 0.3);
                border-radius: 12px;
                padding: 8px;
            }
            QMenu::item {
                padding: 6px 16px;
                border-radius: 6px;
                color: #334155;
                font-size: 11px;
            }
            QMenu::item:selected {
                background-color: #6366f1;
                color: white;
            }
            
            /* 状态栏 - 半透明毛玻璃效果 */
            QStatusBar {
                background-color: rgba(255, 255, 255, 0.85);
                border-top: 1px solid rgba(102, 126, 234, 0.3);
                color: #64748b;
                padding: 4px;
            }
            
            /* GroupBox - 半透明毛玻璃效果 */
            QGroupBox {
                font-weight: 600;
                font-size: 11px;
                color: #1e293b;
                border: 1px solid rgba(255, 255, 255, 0.3);
                border-radius: 12px;
                margin-top: 12px;
                padding-top: 16px;
                padding-bottom: 8px;
                padding-left: 10px;
                padding-right: 10px;
                background-color: rgba(255, 255, 255, 0.75);
            }
            QGroupBox::title {
                subcontrol-origin: margin;
                subcontrol-position: top left;
                left: 16px;
                padding: 0 8px;
                background-color: rgba(255, 255, 255, 0.9);
                color: #000000;
                font-weight: 700;
                font-size: 13px;
            }
            
            /* 按钮 - 现代化渐变设计（保持不透明以确保可读性） */
            QPushButton {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 #667eea, stop:1 #764ba2);
                color: white;
                border: none;
                padding: 4px 12px;
                border-radius: 6px;
                font-weight: 600;
                font-size: 11px;
                min-height: 24px;
                max-height: 28px;
                min-width: 60px;
            }
            QPushButton:hover {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 #818cf8, stop:1 #8b7fb8);
            }
            QPushButton:pressed {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 #5568d3, stop:1 #6a3d7a);
            }
            QPushButton:disabled {
                background-color: #cbd5e1;
                color: #94a3b8;
            }
            
            /* 次要按钮样式 */
            QPushButton[class="secondary"] {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 #f1f5f9, stop:1 #e2e8f0);
                color: #475569;
            }
            QPushButton[class="secondary"]:hover {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 #e2e8f0, stop:1 #cbd5e1);
            }
            
            /* 输入框 - 半透明毛玻璃效果 */
            QLineEdit {
                padding: 4px 10px;
                border: 1px solid rgba(255, 255, 255, 0.4);
                border-radius: 6px;
                background-color: rgba(255, 255, 255, 0.85);
                color: #1e293b;
                font-size: 11px;
                min-height: 24px;
                max-height: 28px;
                selection-background-color: #667eea;
                selection-color: white;
            }
            QLineEdit:focus {
                border: 2px solid #667eea;
                background-color: rgba(255, 255, 255, 0.95);
            }
            QLineEdit:disabled {
                background-color: rgba(241, 245, 249, 0.6);
                color: #94a3b8;
                border-color: rgba(203, 213, 225, 0.5);
            }
            
            /* SpinBox - 半透明毛玻璃效果 */
            QSpinBox, QDoubleSpinBox {
                padding: 4px 10px;
                border: 1px solid rgba(255, 255, 255, 0.4);
                border-radius: 6px;
                background-color: rgba(255, 255, 255, 0.85);
                color: #1e293b;
                font-size: 11px;
                min-height: 24px;
                max-height: 28px;
                selection-background-color: #667eea;
                selection-color: white;
            }
            QSpinBox:focus, QDoubleSpinBox:focus {
                border: 1px solid #667eea;
                background-color: rgba(255, 255, 255, 0.95);
            }
            QSpinBox::up-button, QDoubleSpinBox::up-button {
                background-color: #f1f5f9;
                border-left: 1px solid #e2e8f0;
                border-top-right-radius: 6px;
                width: 16px;
            }
            QSpinBox::up-button:hover, QDoubleSpinBox::up-button:hover {
                background-color: #e2e8f0;
            }
            QSpinBox::down-button, QDoubleSpinBox::down-button {
                background-color: #f1f5f9;
                border-left: 1px solid #e2e8f0;
                border-bottom-right-radius: 6px;
                width: 16px;
            }
            QSpinBox::down-button:hover, QDoubleSpinBox::down-button:hover {
                background-color: #e2e8f0;
            }
            
            /* Tab Widget - 半透明毛玻璃效果 */
            QTabWidget::pane {
                border: 1px solid rgba(255, 255, 255, 0.3);
                border-radius: 12px;
                background-color: rgba(255, 255, 255, 0.75);
                top: -1px;
            }
            QTabBar::tab {
                background: transparent;
                color: #000000;
                padding: 6px 14px;
                margin-right: 4px;
                border-top-left-radius: 8px;
                border-top-right-radius: 8px;
                border: none;
                font-weight: 600;
                font-size: 13px;
                min-width: 70px;
                min-height: 26px;
                max-height: 30px;
            }
            QTabBar::tab:selected {
                background: transparent;
                color: #000000;
                font-weight: 700;
                border: none;
            }
            QTabBar::tab:hover:!selected {
                background: transparent;
                color: #000000;
            }
            
            /* Label - 现代化设计 */
            QLabel {
                color: #334155;
                font-size: 11px;
            }
            
            /* ComboBox - 半透明毛玻璃效果 */
            QComboBox {
                padding: 4px 8px;
                border: 1px solid rgba(255, 255, 255, 0.4);
                border-radius: 6px;
                background-color: rgba(255, 255, 255, 0.85);
                color: #1e293b;
                font-size: 11px;
                min-height: 24px;
                max-height: 28px;
            }
            QComboBox:hover {
                border-color: rgba(255, 255, 255, 0.6);
            }
            QComboBox:focus {
                border: 1px solid #667eea;
            }
            QComboBox::drop-down {
                border: none;
                width: 16px;
            }
            QComboBox::down-arrow {
                width: 0;
                height: 0;
                border-left: 3px solid transparent;
                border-right: 3px solid transparent;
                border-top: 4px solid #64748b;
                margin-right: 4px;
            }
            QComboBox QAbstractItemView {
                background-color: rgba(255, 255, 255, 0.95);
                border: 1px solid rgba(255, 255, 255, 0.4);
                border-radius: 6px;
                selection-background-color: #667eea;
                selection-color: white;
                padding: 2px;
            }
            QComboBox QAbstractItemView::item {
                padding: 3px 6px;
                border-radius: 4px;
                min-height: 16px;
                font-size: 11px;
            }
            QComboBox QAbstractItemView::item:hover {
                background-color: rgba(241, 245, 249, 0.8);
            }
            QComboBox QAbstractItemView::item:selected {
                background-color: #667eea;
                color: white;
            }
            
            /* TextEdit - 半透明毛玻璃效果 */
            QTextEdit {
                padding: 12px;
                border: 2px solid rgba(255, 255, 255, 0.4);
                border-radius: 10px;
                background-color: rgba(255, 255, 255, 0.85);
                color: #1e293b;
                font-size: 13px;
                selection-background-color: #667eea;
                selection-color: white;
            }
            QTextEdit:focus {
                border: 2px solid #667eea;
            }
            
            /* ScrollBar - 现代化设计 */
            QScrollBar:vertical {
                background-color: #f1f5f9;
                width: 12px;
                border-radius: 6px;
                margin: 0;
            }
            QScrollBar::handle:vertical {
                background-color: #cbd5e1;
                border-radius: 6px;
                min-height: 30px;
                margin: 2px;
            }
            QScrollBar::handle:vertical:hover {
                background-color: #94a3b8;
            }
            QScrollBar::add-line:vertical, QScrollBar::sub-line:vertical {
                height: 0px;
            }
            
            QScrollBar:horizontal {
                background-color: #f1f5f9;
                height: 12px;
                border-radius: 6px;
                margin: 0;
            }
            QScrollBar::handle:horizontal {
                background-color: #cbd5e1;
                border-radius: 6px;
                min-width: 30px;
                margin: 2px;
            }
            QScrollBar::handle:horizontal:hover {
                background-color: #94a3b8;
            }
            QScrollBar::add-line:horizontal, QScrollBar::sub-line:horizontal {
                width: 0px;
            }
            
            /* 消息框 - 现代化设计 */
            QMessageBox {
                background-color: #ffffff;
            }
            QMessageBox QPushButton {
                min-width: 80px;
                padding: 8px 16px;
            }
        """)
    
    def setup_ui(self):
        """设置UI界面"""
        # 创建中央Widget
        central_widget = QWidget()
        central_widget.setObjectName("centralwidget")
        self.setCentralWidget(central_widget)
        
        # 创建主布局
        main_layout = QVBoxLayout()
        main_layout.setContentsMargins(12, 8, 12, 8)  # 左右各12px，上下各8px
        main_layout.setSpacing(0)
        
        # 使用Splitter支持拖动调节宽度
        self.splitter = QSplitter(Qt.Orientation.Horizontal)
        self.splitter.setChildrenCollapsible(False)  # 防止面板被完全折叠
        
        # 左侧：创建左侧面板容器（包含车辆参数面板和附加功能区）
        left_panel_container = QWidget()
        left_panel_container.setObjectName("leftPanelContainer")
        left_panel_container.setStyleSheet("""
            QWidget#leftPanelContainer {
                background-color: rgba(255, 255, 255, 0.7);
                border-radius: 16px;
                border: 1px solid rgba(255, 255, 255, 0.4);
            }
        """)
        left_panel_layout = QVBoxLayout()
        left_panel_layout.setContentsMargins(12, 0, 12, 0)  # 左右各12px边距
        left_panel_layout.setSpacing(12)
        
        # 上方：车辆参数面板（缩小）
        self.vehicle_params_panel = VehicleParamsPanel()
        # 设置大小策略，使其可以缩小，但优先保持内容大小
        self.vehicle_params_panel.setSizePolicy(QSizePolicy.Policy.Expanding, QSizePolicy.Policy.Preferred)
        left_panel_layout.addWidget(self.vehicle_params_panel, 0)  # 不拉伸
        
        # 下方：附加功能区
        self.setup_additional_functions_panel(left_panel_layout)
        
        # Logo和版本信息面板（位于附加功能区下方）
        self.setup_logo_version_panel(left_panel_layout)
        
        left_panel_container.setLayout(left_panel_layout)
        # 设置初始宽度和范围（优化比例：最小240，最大480，默认320）
        left_panel_container.setMinimumWidth(240)
        left_panel_container.setMaximumWidth(480)
        self.splitter.addWidget(left_panel_container)
        
        # 左侧面板不可折叠（通过拖动）
        self.splitter.setCollapsible(0, False)  # 左侧面板不可通过拖动折叠
        
        # 右侧：K&C分析Tab组（添加容器以设置边距）
        right_panel_container = QWidget()
        right_panel_container.setObjectName("rightPanelContainer")
        right_panel_container.setStyleSheet("""
            QWidget#rightPanelContainer {
                background-color: rgba(255, 255, 255, 0.7);
                border-radius: 16px;
                border: 1px solid rgba(255, 255, 255, 0.4);
            }
        """)
        right_panel_layout = QVBoxLayout()
        right_panel_layout.setContentsMargins(12, 0, 12, 0)  # 左右各12px边距
        right_panel_layout.setSpacing(0)
        
        self.kc_tabs = QTabWidget()
        self.kc_tabs.setTabPosition(QTabWidget.TabPosition.North)
        # 使用自定义的ColoredTabBar
        custom_tab_bar = ColoredTabBar()
        self.kc_tabs.setTabBar(custom_tab_bar)
        
        # 添加各个Tab（传递车辆参数面板引用）
        self.start_info_tab = StartInfoTab()
        self.kc_tabs.addTab(self.start_info_tab, "START/INFO")
        
        self.bump_tab = BumpTestTab(vehicle_params_panel=self.vehicle_params_panel)
        self.kc_tabs.addTab(self.bump_tab, "Bump")
        
        self.roll_tab = RollTestTab(vehicle_params_panel=self.vehicle_params_panel)
        self.kc_tabs.addTab(self.roll_tab, "Roll Test")
        
        self.static_lateral_tab = StaticLoadLateralTab(vehicle_params_panel=self.vehicle_params_panel)
        self.kc_tabs.addTab(self.static_lateral_tab, "Static Load Lateral")
        
        self.static_braking_tab = StaticLoadBrakingTab(vehicle_params_panel=self.vehicle_params_panel)
        self.kc_tabs.addTab(self.static_braking_tab, "Static Load Braking")
        
        self.static_acceleration_tab = StaticLoadAccelerationTab(vehicle_params_panel=self.vehicle_params_panel)
        self.kc_tabs.addTab(self.static_acceleration_tab, "Static Load Acceleration")
        
        # 添加Align Torque Tab（保留，未实现）
        align_torque_tab = QWidget()
        align_torque_layout = QVBoxLayout()
        align_torque_label = QLabel("Align Torque Test\n(Not implemented yet)")
        align_torque_label.setAlignment(Qt.AlignmentFlag.AlignCenter)
        align_torque_label.setFont(QFont("Arial", 12))
        align_torque_layout.addWidget(align_torque_label)
        align_torque_tab.setLayout(align_torque_layout)
        self.kc_tabs.addTab(align_torque_tab, "Align Torque")
        
        # 为不同标签设置不同颜色
        self._setup_tab_colors()
        
        right_panel_layout.addWidget(self.kc_tabs)
        right_panel_container.setLayout(right_panel_layout)
        self.splitter.addWidget(right_panel_container)
        
        # 右侧面板不可折叠（通过拖动）
        self.splitter.setCollapsible(1, False)  # 右侧面板不可折叠
        
        # 设置splitter的比例：左侧320，右侧占剩余空间（1280）
        self.splitter.setSizes([self.vehicle_params_panel_default_width, 1280])
        
        main_layout.addWidget(self.splitter)
        central_widget.setLayout(main_layout)
    
    def setup_additional_functions_panel(self, parent_layout: QVBoxLayout):
        """设置附加功能区面板
        
        Args:
            parent_layout: 父布局对象
        """
        # 创建附加功能区GroupBox
        additional_group = QGroupBox("Additional Functions")
        additional_layout = QVBoxLayout()
        additional_layout.setContentsMargins(12, 20, 12, 12)
        additional_layout.setSpacing(12)
        
        # Clear Axes按钮
        self.clear_axes_btn = QPushButton("Clear Axes")
        self.clear_axes_btn.setStyleSheet("""
            QPushButton {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 #f1f5f9, stop:1 #e2e8f0);
                color: #475569;
                border: 1px solid #cbd5e1;
                padding: 4px 12px;
                border-radius: 6px;
                font-weight: 600;
                font-size: 11px;
                min-height: 24px;
                max-height: 28px;
            }
            QPushButton:hover {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 #e2e8f0, stop:1 #cbd5e1);
                border-color: #94a3b8;
            }
            QPushButton:pressed {
                background: #cbd5e1;
            }
        """)
        additional_layout.addWidget(self.clear_axes_btn)
        
        # Positive Direction按钮
        self.positive_direction_btn = QPushButton("Positive Direction")
        self.positive_direction_btn.setStyleSheet("""
            QPushButton {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 #f1f5f9, stop:1 #e2e8f0);
                color: #475569;
                border: 1px solid #cbd5e1;
                padding: 4px 12px;
                border-radius: 6px;
                font-weight: 600;
                font-size: 11px;
                min-height: 24px;
                max-height: 28px;
            }
            QPushButton:hover {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 #e2e8f0, stop:1 #cbd5e1);
                border-color: #94a3b8;
            }
            QPushButton:pressed {
                background: #cbd5e1;
            }
        """)
        additional_layout.addWidget(self.positive_direction_btn)
        
        # Custom Plot按钮
        self.custom_plot_btn = QPushButton("Custom Plot")
        self.custom_plot_btn.setToolTip("Custom Plot (Not implemented yet)")
        self.custom_plot_btn.setStyleSheet("""
            QPushButton {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 #fef3c7, stop:1 #fde68a);
                color: #92400e;
                border: 1px solid #fcd34d;
                padding: 4px 12px;
                border-radius: 6px;
                font-weight: 600;
                font-size: 11px;
                min-height: 24px;
                max-height: 28px;
            }
            QPushButton:hover {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 #fde68a, stop:1 #fcd34d);
                border-color: #fbbf24;
            }
            QPushButton:pressed {
                background: #fcd34d;
            }
        """)
        additional_layout.addWidget(self.custom_plot_btn)
        
        # Export PPT按钮
        self.export_ppt_btn = QPushButton("Export to PPT")
        self.export_ppt_btn.setToolTip("Export to PPT (Not implemented yet)")
        self.export_ppt_btn.setStyleSheet("""
            QPushButton {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 #ddd6fe, stop:1 #c4b5fd);
                color: #5b21b6;
                border: 1px solid #a78bfa;
                padding: 4px 12px;
                border-radius: 6px;
                font-weight: 600;
                font-size: 11px;
                min-height: 24px;
                max-height: 28px;
            }
            QPushButton:hover {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 #c4b5fd, stop:1 #a78bfa);
                border-color: #8b5cf6;
            }
            QPushButton:pressed {
                background: #a78bfa;
            }
        """)
        additional_layout.addWidget(self.export_ppt_btn)
        
        # Ref. Vehicle下拉菜单
        ref_layout = QHBoxLayout()
        ref_label = QLabel("Ref. Vehicle:")
        ref_label.setStyleSheet("""
            QLabel {
                color: #475569;
                font-weight: 500;
                font-size: 11px;
            }
        """)
        ref_layout.addWidget(ref_label)
        
        self.ref_vehicle_combo = QComboBox()
        reference_vehicles = [
            "VW UP!",
            "VW Golf",
            "BYD Dolphin",
            "TOYOTA Yaris",
            "BMW 325i",
            "VW ID.3",
            "FORD EDGE",
            "Tesla Model 3",
            "VW Passat",
            "BYD Delphin"
        ]
        self.ref_vehicle_combo.addItems(reference_vehicles)
        self.ref_vehicle_combo.setCurrentIndex(-1)  # 默认不选择任何项
        self.ref_vehicle_combo.setStyleSheet("""
            QComboBox {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 #ffffff, stop:1 #f8fafc);
                color: #475569;
                border: 1px solid #e2e8f0;
                padding: 3px 6px;
                border-radius: 5px;
                font-weight: 500;
                font-size: 10px;
                min-height: 22px;
                max-height: 26px;
            }
            QComboBox:hover {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 #f8fafc, stop:1 #f1f5f9);
                border-color: #cbd5e1;
            }
            QComboBox:focus {
                border: 1px solid #6366f1;
                background-color: #fafafa;
            }
            QComboBox::drop-down {
                border: none;
                width: 16px;
            }
            QComboBox::down-arrow {
                image: none;
                border-left: 3px solid transparent;
                border-right: 3px solid transparent;
                border-top: 4px solid #64748b;
                width: 0;
                height: 0;
                margin-right: 4px;
            }
            QComboBox::down-arrow:hover {
                border-top-color: #475569;
            }
            QComboBox QAbstractItemView {
                background-color: #ffffff;
                border: 1px solid #e2e8f0;
                border-radius: 6px;
                selection-background-color: #6366f1;
                selection-color: white;
                padding: 2px;
            }
            QComboBox QAbstractItemView::item {
                padding: 3px 6px;
                border-radius: 4px;
                min-height: 16px;
                font-size: 10px;
            }
            QComboBox QAbstractItemView::item:hover {
                background-color: #f1f5f9;
            }
            QComboBox QAbstractItemView::item:selected {
                background-color: #6366f1;
                color: white;
            }
        """)
        ref_layout.addWidget(self.ref_vehicle_combo)
        ref_layout.addStretch()
        additional_layout.addLayout(ref_layout)
        
        additional_group.setLayout(additional_layout)
        parent_layout.addWidget(additional_group)
    
    def setup_logo_version_panel(self, parent_layout: QVBoxLayout):
        """设置Logo和版本信息面板
        
        Args:
            parent_layout: 父布局对象
        """
        # 创建Logo和版本信息GroupBox
        logo_version_group = QGroupBox()
        logo_version_group.setStyleSheet("""
            QGroupBox {
                border: none;
                margin-top: 0px;
                padding-top: 0px;
            }
        """)
        logo_version_layout = QVBoxLayout()
        logo_version_layout.setContentsMargins(12, 12, 12, 12)
        logo_version_layout.setSpacing(8)
        
        # 创建包含Logo、版本号和版权信息的容器
        logo_version_widget = QWidget()
        logo_version_h_layout = QHBoxLayout()
        logo_version_h_layout.setContentsMargins(0, 0, 0, 0)
        logo_version_h_layout.setSpacing(6)
        
        # 获取资源路径
        try:
            # 从main_window.py的位置计算Resources目录
            current_file = Path(__file__)
            resources_dir = current_file.parent.parent.parent.parent / "Resources"
            
            # 加载Gestamp Logo
            gestamp_logo_path = resources_dir / "logos" / "Gestamp_Logo.png"
            
            if gestamp_logo_path.exists():
                logo_label = QLabel()
                pixmap = QPixmap(str(gestamp_logo_path))
                # 缩放Logo到合适大小（高度约24-28px，保持宽高比）
                scaled_pixmap = pixmap.scaled(120, 28, Qt.AspectRatioMode.KeepAspectRatio, Qt.TransformationMode.SmoothTransformation)
                logo_label.setPixmap(scaled_pixmap)
                logo_label.setAlignment(Qt.AlignmentFlag.AlignLeft | Qt.AlignmentFlag.AlignVCenter)
                logo_version_h_layout.addWidget(logo_label)
            else:
                # 如果Logo不存在，显示文字
                logo_label = QLabel("Gestamp")
                logo_label.setStyleSheet("color: #64748b; font-weight: 600; font-size: 11px;")
                logo_version_h_layout.addWidget(logo_label)
                logger.warning(f"Logo文件不存在: {gestamp_logo_path}")
        except Exception as e:
            logger.warning(f"无法加载Logo: {e}")
            # 如果加载失败，显示文字
            logo_label = QLabel("Gestamp")
            logo_label.setStyleSheet("color: #64748b; font-weight: 600; font-size: 11px;")
            logo_version_h_layout.addWidget(logo_label)
        
        logo_version_h_layout.addStretch()
        
        # 添加软件名称和版本号
        app_info_layout = QVBoxLayout()
        app_info_layout.setContentsMargins(0, 0, 0, 0)
        app_info_layout.setSpacing(2)
        
        # 软件名称
        app_name_label = QLabel("KinBench Tool")
        app_name_label.setStyleSheet("color: #475569; font-weight: 600; font-size: 11px;")
        app_info_layout.addWidget(app_name_label)
        
        # 版本号
        try:
            from .. import __version__
            version_text = f"v{__version__}"
        except ImportError:
            # 如果无法导入版本号，尝试从VERSION文件读取
            try:
                version_file = Path(__file__).parent.parent.parent / "VERSION"
                if version_file.exists():
                    version_text = f"v{version_file.read_text().strip()}"
                else:
                    version_text = "v0.3.2"
            except Exception:
                version_text = "v0.3.2"
        
        version_label = QLabel(version_text)
        version_label.setStyleSheet("color: #64748b; font-size: 10px;")
        app_info_layout.addWidget(version_label)
        
        logo_version_h_layout.addLayout(app_info_layout)
        logo_version_widget.setLayout(logo_version_h_layout)
        logo_version_layout.addWidget(logo_version_widget)
        
        # 添加分隔线
        separator_line = QWidget()
        separator_line.setFixedHeight(1)
        separator_line.setStyleSheet("background-color: #e2e8f0;")
        logo_version_layout.addWidget(separator_line)
        
        # 添加版权信息
        current_year = datetime.now().year
        copyright_label = QLabel(f"© {current_year} Gestamp. All rights reserved.")
        copyright_label.setStyleSheet("color: #94a3b8; font-size: 9px;")
        copyright_label.setAlignment(Qt.AlignmentFlag.AlignCenter)
        logo_version_layout.addWidget(copyright_label)
        
        logo_version_group.setLayout(logo_version_layout)
        parent_layout.addWidget(logo_version_group)
    
    def setup_toolbar(self):
        """设置工具栏"""
        pass
    
    def setup_menu_bar(self):
        """设置菜单栏"""
        menubar = self.menuBar()
        
        # File菜单
        file_menu = menubar.addMenu("&File")
        
        # Open File
        open_action = QAction("&Open File...", self)
        open_action.setShortcut("Ctrl+O")
        open_action.triggered.connect(self._open_file)
        file_menu.addAction(open_action)
        
        file_menu.addSeparator()
        
        # Exit
        exit_action = QAction("E&xit", self)
        exit_action.setShortcut("Ctrl+Q")
        exit_action.triggered.connect(self.close)
        file_menu.addAction(exit_action)
        
        # Tools菜单
        tools_menu = menubar.addMenu("&Tools")
        
        # Reset All
        reset_action = QAction("&Reset All", self)
        reset_action.setShortcut("Ctrl+R")
        reset_action.triggered.connect(self._reset_all)
        tools_menu.addAction(reset_action)
        
        # Help菜单
        help_menu = menubar.addMenu("&Help")
        
        # About
        about_action = QAction("&About", self)
        about_action.triggered.connect(self._show_about)
        help_menu.addAction(about_action)
    
    def setup_status_bar(self):
        """设置状态栏"""
        self.status_bar = QStatusBar()
        self.setStatusBar(self.status_bar)
        
        # Logo和版本号已移至左侧面板，不再在状态栏显示
        # self._add_logo_and_version()
        
        # 显示初始消息
        self.status_bar.showMessage("Ready", 2000)  # 2秒后自动清除
    
    def _setup_tab_colors(self):
        """为不同标签设置不同颜色（像文件夹一样）"""
        # 使用自定义的ColoredTabBar，颜色已经在ColoredTabBar类中定义
        # 这里只需要确保标签文字颜色是黑色
        tab_bar = self.kc_tabs.tabBar()
        if tab_bar:
            # 设置所有标签的文字颜色为黑色
            for i in range(self.kc_tabs.count()):
                tab_bar.setTabTextColor(i, QColor(0, 0, 0))
        
        # 连接标签切换信号，更新选中标签的样式
        self.kc_tabs.currentChanged.connect(self._update_tab_color_style)
        
        # 初始化样式
        self._update_tab_color_style(self.kc_tabs.currentIndex())
    
    def _update_tab_color_style(self, current_index: int):
        """更新标签颜色样式（当标签切换时调用）"""
        # 确保所有标签文字都是黑色
        tab_bar = self.kc_tabs.tabBar()
        if tab_bar:
            for i in range(self.kc_tabs.count()):
                tab_bar.setTabTextColor(i, QColor(0, 0, 0))
            
            # 触发重绘
            tab_bar.update()
    
    def connect_signals(self):
        """连接信号"""
        # 车辆参数改变信号
        self.vehicle_params_panel.params_changed.connect(self._on_vehicle_params_changed)
        
        # Tab切换信号
        self.kc_tabs.currentChanged.connect(self._on_tab_changed)
        
        # 连接各个Tab的状态消息信号
        self.bump_tab.status_message.connect(self._show_status_message)
        self.roll_tab.status_message.connect(self._show_status_message)
        self.static_lateral_tab.status_message.connect(self._show_status_message)
        self.static_braking_tab.status_message.connect(self._show_status_message)
        self.static_acceleration_tab.status_message.connect(self._show_status_message)
        
        # 初始连接附加功能区控件到当前Tab
        self._connect_additional_functions_to_tab()
    
    def _open_file(self):
        """打开文件"""
        from PyQt6.QtWidgets import QFileDialog
        file_path, _ = QFileDialog.getOpenFileName(
            self, "Open .res file", "", "RES Files (*.res);;All Files (*)")
        if file_path:
            # 将文件路径设置到当前Tab
            current_tab = self.kc_tabs.currentWidget()
            if hasattr(current_tab, 'file_path_edit'):
                current_tab.file_path_edit.setText(file_path)
                current_tab._load_and_process_file()
    
    def _reset_all(self):
        """重置所有"""
        reply = QMessageBox.question(
            self, "Reset All", "Are you sure you want to reset all?",
            QMessageBox.StandardButton.Yes | QMessageBox.StandardButton.No)
        
        if reply == QMessageBox.StandardButton.Yes:
            # 重置车辆参数
            self.vehicle_params_panel.reset_to_defaults()
            
            # 重置所有Tab
            for i in range(self.kc_tabs.count()):
                tab = self.kc_tabs.widget(i)
                if hasattr(tab, '_reset_all'):
                    tab._reset_all()
            
            self.status_bar.showMessage("All reset", 3000)
            logger.info("所有数据已重置")
    
    def _on_vehicle_params_changed(self, params: dict):
        """车辆参数改变"""
        self.status_bar.showMessage("Vehicle parameters updated", 2000)
        logger.debug(f"车辆参数已更新: {params}")
        
        # 通知所有Tab更新车辆参数
        for i in range(self.kc_tabs.count()):
            tab = self.kc_tabs.widget(i)
            if hasattr(tab, 'update_vehicle_params'):
                tab.update_vehicle_params()
    
    def _on_tab_changed(self, index: int):
        """Tab切换"""
        tab = self.kc_tabs.widget(index)
        tab_name = self.kc_tabs.tabText(index)
        self.status_bar.showMessage(f"Switched to {tab_name} tab", 2000)
        logger.debug(f"切换到Tab: {tab_name}")
        
        # 重新连接附加功能区控件到当前Tab
        self._connect_additional_functions_to_tab()
    
    def _connect_additional_functions_to_tab(self):
        """连接附加功能区控件到当前Tab的方法"""
        # 断开之前的连接
        try:
            self.clear_axes_btn.clicked.disconnect()
        except TypeError:
            pass  # 如果没有连接，忽略错误
        
        try:
            self.positive_direction_btn.clicked.disconnect()
        except TypeError:
            pass
        
        try:
            self.custom_plot_btn.clicked.disconnect()
        except TypeError:
            pass
        
        try:
            self.export_ppt_btn.clicked.disconnect()
        except TypeError:
            pass
        
        try:
            self.ref_vehicle_combo.currentTextChanged.disconnect()
        except TypeError:
            pass
        
        # 获取当前Tab
        current_tab = self.kc_tabs.currentWidget()
        
        # 连接Clear Axes按钮
        if hasattr(current_tab, 'clear_all_plots'):
            self.clear_axes_btn.clicked.connect(current_tab.clear_all_plots)
            self.clear_axes_btn.setEnabled(True)
        else:
            self.clear_axes_btn.setEnabled(False)
        
        # 连接Positive Direction按钮
        if hasattr(current_tab, '_on_positive_direction'):
            self.positive_direction_btn.clicked.connect(current_tab._on_positive_direction)
            self.positive_direction_btn.setEnabled(True)
        else:
            self.positive_direction_btn.setEnabled(False)
        
        # 连接Custom Plot按钮
        if hasattr(current_tab, '_on_custom_plot'):
            self.custom_plot_btn.clicked.connect(current_tab._on_custom_plot)
            self.custom_plot_btn.setEnabled(True)
        else:
            self.custom_plot_btn.setEnabled(False)
        
        # 连接Export PPT按钮
        if hasattr(current_tab, '_on_export_ppt'):
            self.export_ppt_btn.clicked.connect(current_tab._on_export_ppt)
            self.export_ppt_btn.setEnabled(True)
        else:
            self.export_ppt_btn.setEnabled(False)
        
        # 连接Ref. Vehicle下拉菜单
        if hasattr(current_tab, '_on_ref_vehicle_selected'):
            self.ref_vehicle_combo.currentTextChanged.connect(current_tab._on_ref_vehicle_selected)
            self.ref_vehicle_combo.setEnabled(True)
        else:
            self.ref_vehicle_combo.setEnabled(False)
    
    def _show_status_message(self, message: str, duration: int = 2000):
        """显示状态消息
        
        Args:
            message: 消息内容
            duration: 显示持续时间（毫秒）
        """
        self.status_bar.showMessage(message, duration)
    
    def _add_logo_and_version(self):
        """在状态栏左下角添加Logo、版本号和版权信息"""
        # 创建包含Logo、版本号和版权信息的容器
        logo_version_widget = QWidget()
        logo_version_layout = QHBoxLayout()
        logo_version_layout.setContentsMargins(8, 0, 8, 0)
        logo_version_layout.setSpacing(6)
        
        # 获取资源路径
        try:
            # 从main_window.py的位置计算Resources目录
            # main_window.py在 Python_Target/src/gui/main_window.py
            # Resources在项目根目录
            current_file = Path(__file__)
            resources_dir = current_file.parent.parent.parent.parent / "Resources"
            
            # 加载Gestamp Logo - 使用用户指定的路径
            gestamp_logo_path = resources_dir / "logos" / "Gestamp_Logo.png"
            
            if gestamp_logo_path.exists():
                logo_label = QLabel()
                pixmap = QPixmap(str(gestamp_logo_path))
                # 缩放Logo到合适大小（高度约20-24px，保持宽高比）
                scaled_pixmap = pixmap.scaled(100, 24, Qt.AspectRatioMode.KeepAspectRatio, Qt.TransformationMode.SmoothTransformation)
                logo_label.setPixmap(scaled_pixmap)
                logo_label.setAlignment(Qt.AlignmentFlag.AlignLeft | Qt.AlignmentFlag.AlignVCenter)
                logo_version_layout.addWidget(logo_label)
            else:
                # 如果Logo不存在，显示文字
                logo_label = QLabel("Gestamp")
                logo_label.setStyleSheet("color: #64748b; font-weight: 600; font-size: 11px;")
                logo_version_layout.addWidget(logo_label)
                logger.warning(f"Logo文件不存在: {gestamp_logo_path}")
        except Exception as e:
            logger.warning(f"无法加载Logo: {e}")
            # 如果加载失败，显示文字
            logo_label = QLabel("Gestamp")
            logo_label.setStyleSheet("color: #64748b; font-weight: 600; font-size: 11px;")
            logo_version_layout.addWidget(logo_label)
        
        # 添加分隔符
        separator1 = QLabel("|")
        separator1.setStyleSheet("color: #cbd5e1; font-size: 10px;")
        logo_version_layout.addWidget(separator1)
        
        # 添加软件名称
        app_name_label = QLabel("KinBench Tool")
        app_name_label.setStyleSheet("color: #475569; font-weight: 500; font-size: 10px;")
        logo_version_layout.addWidget(app_name_label)
        
        # 添加版本号
        try:
            from .. import __version__
            version_text = f"v{__version__}"
        except ImportError:
            # 如果无法导入版本号，尝试从VERSION文件读取
            try:
                version_file = Path(__file__).parent.parent.parent / "VERSION"
                if version_file.exists():
                    version_text = f"v{version_file.read_text().strip()}"
                else:
                    version_text = "v0.3.2"
            except Exception:
                version_text = "v0.3.2"
        
        version_label = QLabel(version_text)
        version_label.setStyleSheet("color: #64748b; font-size: 10px;")
        logo_version_layout.addWidget(version_label)
        
        # 添加分隔符
        separator2 = QLabel("|")
        separator2.setStyleSheet("color: #cbd5e1; font-size: 10px;")
        logo_version_layout.addWidget(separator2)
        
        # 添加版权信息
        current_year = datetime.now().year
        copyright_label = QLabel(f"© {current_year} Gestamp. All rights reserved.")
        copyright_label.setStyleSheet("color: #64748b; font-size: 9px;")
        logo_version_layout.addWidget(copyright_label)
        
        logo_version_widget.setLayout(logo_version_layout)
        
        # 确保widget可见
        logo_version_widget.setVisible(True)
        logo_version_widget.show()
        
        # 将Logo和版本号添加到状态栏
        # 使用addPermanentWidget确保widget始终显示，不会被状态消息覆盖
        # 注意：addPermanentWidget会将widget添加到右侧，但这是确保显示的唯一可靠方法
        # 如果需要在左侧显示，可以考虑使用自定义状态栏布局
        try:
            self.status_bar.addPermanentWidget(logo_version_widget, stretch=0)
            logger.info("使用addPermanentWidget添加Logo和版本号到状态栏右侧")
        except Exception as e:
            # 如果addPermanentWidget失败，尝试使用addWidget
            logger.warning(f"addPermanentWidget失败，尝试使用addWidget: {e}")
            self.status_bar.addWidget(logo_version_widget)
        
        # 记录日志以便调试
        try:
            logo_path_str = str(gestamp_logo_path) if 'gestamp_logo_path' in locals() and gestamp_logo_path.exists() else "未找到"
            logger.info(f"已添加Logo和版本号到状态栏，Logo路径: {logo_path_str}")
        except:
            logger.info("已添加Logo和版本号到状态栏")
    
    def _show_about(self):
        """显示关于对话框"""
        QMessageBox.about(
            self, "About KinBench Tool",
            """
            <h2>KinBench Tool</h2>
            <p>K&C (Kinematics & Compliance) Analysis Tool</p>
            <p><b>Version:</b> 0.3.2</p>
            <p><b>Description:</b></p>
            <p>This tool is designed for analyzing vehicle suspension systems.</p>
            <p>It supports Bump, Roll, and Static Load tests.</p>
            <p><b>Python Implementation</b></p>
            """
        )
    
    def closeEvent(self, event):
        """窗口关闭事件"""
        reply = QMessageBox.question(
            self, "Exit", "Are you sure you want to exit?",
            QMessageBox.StandardButton.Yes | QMessageBox.StandardButton.No)
        
        if reply == QMessageBox.StandardButton.Yes:
            event.accept()
            logger.info("应用程序退出")
        else:
            event.ignore()
