"""主窗口模块

提供应用程序主窗口，整合所有UI组件。
"""

from typing import Optional
from PyQt6.QtWidgets import (QMainWindow, QWidget, QVBoxLayout, QHBoxLayout,
                            QTabWidget, QMenuBar, QStatusBar, QLabel, QMessageBox)
from PyQt6.QtCore import Qt, pyqtSignal
from PyQt6.QtGui import QFont, QAction, QIcon

from .vehicle_params import VehicleParamsPanel
from .kc_tabs import (StartInfoTab, BumpTestTab, RollTestTab,
                     StaticLoadLateralTab, StaticLoadBrakingTab,
                     StaticLoadAccelerationTab)
from ..utils.logger import get_logger

logger = get_logger(__name__)


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
        self.setMinimumSize(1400, 800)
        
        # 设置样式
        self.setup_style()
        
        # 设置UI
        self.setup_ui()
        
        # 设置菜单栏
        self.setup_menu_bar()
        
        # 设置状态栏
        self.setup_status_bar()
        
        # 连接信号
        self.connect_signals()
        
        logger.info("主窗口初始化完成")
    
    def setup_style(self):
        """设置窗口样式"""
        # 设置全局样式表
        self.setStyleSheet("""
            QMainWindow {
                background-color: #f5f5f5;
            }
            QGroupBox {
                font-weight: bold;
                border: 2px solid #cccccc;
                border-radius: 5px;
                margin-top: 10px;
                padding-top: 10px;
            }
            QGroupBox::title {
                subcontrol-origin: margin;
                left: 10px;
                padding: 0 5px;
            }
            QPushButton {
                background-color: #4CAF50;
                color: white;
                border: none;
                padding: 6px 12px;
                border-radius: 4px;
                font-weight: bold;
            }
            QPushButton:hover {
                background-color: #45a049;
            }
            QPushButton:pressed {
                background-color: #3d8b40;
            }
            QLineEdit {
                padding: 5px;
                border: 1px solid #cccccc;
                border-radius: 3px;
            }
            QLineEdit:focus {
                border: 2px solid #4CAF50;
            }
            QTabWidget::pane {
                border: 1px solid #cccccc;
                background-color: white;
            }
            QTabBar::tab {
                background-color: #e0e0e0;
                color: #333333;
                padding: 8px 16px;
                margin-right: 2px;
                border-top-left-radius: 4px;
                border-top-right-radius: 4px;
            }
            QTabBar::tab:selected {
                background-color: white;
                color: #4CAF50;
                font-weight: bold;
            }
            QTabBar::tab:hover {
                background-color: #f0f0f0;
            }
        """)
    
    def setup_ui(self):
        """设置UI界面"""
        # 创建中央Widget
        central_widget = QWidget()
        self.setCentralWidget(central_widget)
        
        # 创建主布局
        main_layout = QHBoxLayout()
        main_layout.setContentsMargins(5, 5, 5, 5)
        main_layout.setSpacing(5)
        
        # 左侧：车辆参数面板
        self.vehicle_params_panel = VehicleParamsPanel()
        self.vehicle_params_panel.setMaximumWidth(250)
        self.vehicle_params_panel.setMinimumWidth(200)
        main_layout.addWidget(self.vehicle_params_panel)
        
        # 右侧：K&C分析Tab组
        self.kc_tabs = QTabWidget()
        self.kc_tabs.setTabPosition(QTabWidget.TabPosition.North)
        
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
        
        main_layout.addWidget(self.kc_tabs, 1)
        
        central_widget.setLayout(main_layout)
    
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
        self.status_bar.showMessage("Ready")
    
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
    
    def _show_status_message(self, message: str, duration: int = 2000):
        """显示状态消息
        
        Args:
            message: 消息内容
            duration: 显示持续时间（毫秒）
        """
        self.status_bar.showMessage(message, duration)
    
    def _show_about(self):
        """显示关于对话框"""
        QMessageBox.about(
            self, "About KinBench Tool",
            """
            <h2>KinBench Tool</h2>
            <p>K&C (Kinematics & Compliance) Analysis Tool</p>
            <p><b>Version:</b> 1.0.0</p>
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
