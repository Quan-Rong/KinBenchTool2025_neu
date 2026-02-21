"""K&C分析Tab模块

提供各种K&C测试工况的Tab界面，包括Bump、Roll、Static Load等。
"""

from typing import Optional, Dict, Any
from pathlib import Path
from PyQt6.QtWidgets import (QWidget, QVBoxLayout, QHBoxLayout, QLabel, 
                            QPushButton, QLineEdit, QTabWidget, QGroupBox,
                            QGridLayout, QDoubleSpinBox, QSpinBox, QColorDialog,
                            QMessageBox, QFileDialog, QTextEdit, QScrollArea,
                            QProgressDialog)
from PyQt6.QtCore import Qt, pyqtSignal, QThread, pyqtSlot
from PyQt6.QtGui import QFont, QColor

from .plot_widgets import ComparisonPlotWidget, MatplotlibWidget
from ..data import ResParser, DataExtractor, KCCalculator
from ..plot import (
    plot_bump_steer, plot_bump_camber, plot_wheel_rate,
    plot_wheel_recession, plot_track_change,
    plot_roll_steer, plot_roll_camber, plot_roll_camber_relative_ground,
    plot_roll_rate, plot_roll_center_height,
    plot_lateral_toe_compliance, plot_lateral_camber_compliance,
    plot_braking_toe_compliance, plot_acceleration_toe_compliance,
)
from ..utils.logger import get_logger

logger = get_logger(__name__)


class BaseTestTab(QWidget):
    """基础测试Tab类
    
    所有测试Tab的基类，提供通用的功能。
    """
    
    # 信号
    file_loaded = pyqtSignal(str)
    calculation_completed = pyqtSignal(dict)
    status_message = pyqtSignal(str, int)  # 消息, 持续时间(ms)
    
    def __init__(self, parent: Optional[QWidget] = None, vehicle_params_panel: Optional[QWidget] = None):
        """初始化基础测试Tab
        
        Args:
            parent: 父Widget
            vehicle_params_panel: 车辆参数面板，用于获取车辆参数
        """
        super().__init__(parent)
        
        # 数据相关
        self.parser: Optional[ResParser] = None
        self.extractor: Optional[DataExtractor] = None
        self.calculator: Optional[KCCalculator] = None
        
        # 车辆参数面板引用
        self.vehicle_params_panel = vehicle_params_panel
        
        # 颜色设置
        self.curve_color = '#1f77b4'  # 默认蓝色
        self.fit_color = '#0000ff'    # 默认蓝色
        self.compare_count = 0
        
        self.setup_ui()
    
    def get_vehicle_params(self) -> Dict[str, float]:
        """获取车辆参数
        
        Returns:
            车辆参数字典
        """
        if self.vehicle_params_panel and hasattr(self.vehicle_params_panel, 'get_vehicle_params'):
            return self.vehicle_params_panel.get_vehicle_params()
        return {}
        
    def setup_ui(self):
        """设置UI界面（子类需要重写）"""
        pass
    
    def setup_file_selection(self, layout: QVBoxLayout):
        """设置文件选择组件
        
        Args:
            layout: 布局对象
        """
        file_group = QGroupBox("File Selection")
        file_layout = QHBoxLayout()
        
        self.file_path_edit = QLineEdit()
        self.file_path_edit.setPlaceholderText("Select .res file...")
        self.file_path_edit.setReadOnly(True)
        
        browse_btn = QPushButton("Browse...")
        browse_btn.clicked.connect(self._browse_file)
        
        go_btn = QPushButton("GO")
        go_btn.setStyleSheet("background-color: #4CAF50; color: white; font-weight: bold; padding: 5px 15px;")
        go_btn.clicked.connect(self._load_and_process_file)
        
        file_layout.addWidget(QLabel("File:"))
        file_layout.addWidget(self.file_path_edit, 1)
        file_layout.addWidget(browse_btn)
        file_layout.addWidget(go_btn)
        
        file_group.setLayout(file_layout)
        layout.addWidget(file_group)
    
    def setup_global_controls(self, layout: QVBoxLayout):
        """设置全局控制组件
        
        Args:
            layout: 布局对象
        """
        controls_group = QGroupBox("Global Controls")
        controls_layout = QGridLayout()
        
        # 颜色选择器
        controls_layout.addWidget(QLabel("Curve Color:"), 0, 0)
        self.curve_color_btn = QPushButton()
        self.curve_color_btn.setStyleSheet(f"background-color: {self.curve_color};")
        self.curve_color_btn.setFixedSize(50, 25)
        self.curve_color_btn.clicked.connect(self._select_curve_color)
        controls_layout.addWidget(self.curve_color_btn, 0, 1)
        
        controls_layout.addWidget(QLabel("Fit Color:"), 0, 2)
        self.fit_color_btn = QPushButton()
        self.fit_color_btn.setStyleSheet(f"background-color: {self.fit_color};")
        self.fit_color_btn.setFixedSize(50, 25)
        self.fit_color_btn.clicked.connect(self._select_fit_color)
        controls_layout.addWidget(self.fit_color_btn, 0, 3)
        
        # 对比数量
        controls_layout.addWidget(QLabel("Compare Count:"), 1, 0)
        self.compare_spinner = QSpinBox()
        self.compare_spinner.setMinimum(0)
        self.compare_spinner.setMaximum(10)
        self.compare_spinner.setValue(0)
        self.compare_spinner.valueChanged.connect(self._on_compare_count_changed)
        controls_layout.addWidget(self.compare_spinner, 1, 1)
        
        # Reset按钮
        reset_btn = QPushButton("Reset")
        reset_btn.clicked.connect(self._reset_all)
        controls_layout.addWidget(reset_btn, 1, 2, 1, 2)
        
        controls_group.setLayout(controls_layout)
        layout.addWidget(controls_group)
    
    def _browse_file(self):
        """浏览文件"""
        file_path, _ = QFileDialog.getOpenFileName(
            self, "Select .res file", "", "RES Files (*.res);;All Files (*)")
        if file_path:
            self.file_path_edit.setText(file_path)
    
    def _load_and_process_file(self):
        """加载并处理文件"""
        file_path = self.file_path_edit.text()
        if not file_path or not Path(file_path).exists():
            QMessageBox.warning(self, "Error", "Please select a valid .res file!")
            return
        
        # 创建进度对话框
        progress = QProgressDialog("Loading file...", "Cancel", 0, 0, self)
        progress.setWindowModality(Qt.WindowModality.WindowModal)
        progress.setMinimumDuration(0)
        progress.setValue(0)
        progress.show()
        
        try:
            # 显示加载状态
            self.setCursor(Qt.CursorShape.WaitCursor)
            progress.setLabelText("Parsing file...")
            
            # 解析文件
            self.parser = ResParser(file_path)
            self.parser.parse()
            
            progress.setLabelText("Creating data extractor...")
            # 创建提取器和计算器
            self.extractor = DataExtractor(self.parser)
            vehicle_params = self.get_vehicle_params()
            self.calculator = KCCalculator(self.extractor, vehicle_params)
            
            progress.setLabelText("Processing data...")
            self.file_loaded.emit(file_path)
            logger.info(f"文件加载成功: {file_path}")
            
            # 处理数据并更新显示
            self.process_data()
            
            progress.setLabelText("Complete!")
            self.status_message.emit(f"File loaded: {Path(file_path).name}", 3000)
            
        except FileNotFoundError:
            QMessageBox.critical(self, "Error", f"File not found:\n{file_path}")
            logger.error(f"文件不存在: {file_path}")
        except PermissionError:
            QMessageBox.critical(self, "Error", f"Permission denied:\n{file_path}")
            logger.error(f"文件权限错误: {file_path}")
        except Exception as e:
            error_msg = str(e)
            if len(error_msg) > 200:
                error_msg = error_msg[:200] + "..."
            QMessageBox.critical(
                self, "Error", 
                f"Failed to load file:\n{error_msg}\n\nPlease check the file format and try again.")
            logger.error(f"文件加载失败: {e}", exc_info=True)
        finally:
            progress.close()
            self.setCursor(Qt.CursorShape.ArrowCursor)
    
    def update_vehicle_params(self):
        """更新车辆参数到计算器"""
        if self.calculator:
            vehicle_params = self.get_vehicle_params()
            self.calculator.set_vehicle_params(vehicle_params)
            # 如果数据已加载，重新处理数据
            if self.parser:
                self.process_data()
    
    def process_data(self):
        """处理数据（子类需要重写）"""
        pass
    
    def _select_curve_color(self):
        """选择曲线颜色"""
        color = QColorDialog.getColor(QColor(self.curve_color), self, "Select Curve Color")
        if color.isValid():
            self.curve_color = color.name()
            self.curve_color_btn.setStyleSheet(f"background-color: {self.curve_color};")
            self.update_plots()
    
    def _select_fit_color(self):
        """选择拟合线颜色"""
        color = QColorDialog.getColor(QColor(self.fit_color), self, "Select Fit Color")
        if color.isValid():
            self.fit_color = color.name()
            self.fit_color_btn.setStyleSheet(f"background-color: {self.fit_color};")
            self.update_plots()
    
    def _on_compare_count_changed(self, value: int):
        """对比数量改变"""
        self.compare_count = value
        self.update_plots()
    
    def _reset_all(self):
        """重置所有"""
        self.file_path_edit.clear()
        self.parser = None
        self.extractor = None
        self.calculator = None
        self.clear_all_plots()
        self.clear_results()
    
    def clear_all_plots(self):
        """清空所有图表（子类需要重写）"""
        pass
    
    def clear_results(self):
        """清空结果面板（子类需要重写）"""
        pass
    
    def update_plots(self):
        """更新图表（子类需要重写）"""
        pass


class StartInfoTab(QWidget):
    """START/INFO Tab
    
    显示启动信息和说明。
    """
    
    def __init__(self, parent: Optional[QWidget] = None):
        """初始化START/INFO Tab"""
        super().__init__(parent)
        self.setup_ui()
    
    def setup_ui(self):
        """设置UI界面"""
        layout = QVBoxLayout()
        layout.setContentsMargins(20, 20, 20, 20)
        
        # 标题
        title = QLabel("KinBench Tool - K&C Analysis")
        title.setFont(QFont("Arial", 16, QFont.Weight.Bold))
        title.setAlignment(Qt.AlignmentFlag.AlignCenter)
        layout.addWidget(title)
        
        # 说明文本
        info_text = QTextEdit()
        info_text.setReadOnly(True)
        info_text.setHtml("""
        <h2>Welcome to KinBench Tool</h2>
        <p>This tool is designed for K&C (Kinematics & Compliance) analysis of vehicle suspension systems.</p>
        
        <h3>Features:</h3>
        <ul>
            <li><b>Bump Test:</b> Analyze suspension behavior during vertical wheel travel</li>
            <li><b>Roll Test:</b> Analyze suspension behavior during body roll</li>
            <li><b>Static Load Test:</b> Analyze compliance under lateral, braking, and acceleration loads</li>
        </ul>
        
        <h3>How to Use:</h3>
        <ol>
            <li>Enter vehicle parameters in the left panel</li>
            <li>Select a test tab (Bump, Roll, or Static Load)</li>
            <li>Browse and select a .res file</li>
            <li>Click "GO" to process the file</li>
            <li>View results and plots in the tabs</li>
        </ol>
        
        <h3>Version:</h3>
        <p>Version 1.0.0 - Python Implementation</p>
        """)
        
        layout.addWidget(info_text)
        layout.addStretch()
        
        self.setLayout(layout)


class BumpTestTab(BaseTestTab):
    """Bump测试Tab"""
    
    def __init__(self, parent: Optional[QWidget] = None, vehicle_params_panel: Optional[QWidget] = None):
        """初始化Bump测试Tab"""
        super().__init__(parent, vehicle_params_panel)
        self.fit_range = 15  # mm
    
    def setup_ui(self):
        """设置UI界面"""
        main_layout = QVBoxLayout()
        main_layout.setContentsMargins(10, 10, 10, 10)
        main_layout.setSpacing(10)
        
        # 文件选择
        self.setup_file_selection(main_layout)
        
        # 拟合范围设置
        fit_group = QGroupBox("Fit Range")
        fit_layout = QHBoxLayout()
        fit_layout.addWidget(QLabel("Range (mm):"))
        self.fit_range_spinbox = QSpinBox()
        self.fit_range_spinbox.setMinimum(5)
        self.fit_range_spinbox.setMaximum(50)
        self.fit_range_spinbox.setValue(15)
        self.fit_range_spinbox.valueChanged.connect(self._on_fit_range_changed)
        fit_layout.addWidget(self.fit_range_spinbox)
        fit_layout.addStretch()
        fit_group.setLayout(fit_layout)
        main_layout.addWidget(fit_group)
        
        # 结果面板
        results_group = QGroupBox("Results")
        results_layout = QGridLayout()
        
        self.result_labels = {}
        result_fields = [
            ('bump_steer_left', 'Bump Steer Left (deg/m)'),
            ('bump_steer_right', 'Bump Steer Right (deg/m)'),
            ('bump_steer_avg', 'Bump Steer Avg (deg/m)'),
            ('bump_camber_left', 'Bump Camber Left (deg/m)'),
            ('bump_camber_right', 'Bump Camber Right (deg/m)'),
            ('bump_camber_avg', 'Bump Camber Avg (deg/m)'),
            ('wheel_rate_left', 'Wheel Rate Left (N/mm)'),
            ('wheel_rate_right', 'Wheel Rate Right (N/mm)'),
        ]
        
        row = 0
        for key, label in result_fields:
            results_layout.addWidget(QLabel(f"{label}:"), row, 0)
            value_label = QLabel("--")
            value_label.setStyleSheet("font-weight: bold;")
            self.result_labels[key] = value_label
            results_layout.addWidget(value_label, row, 1)
            row += 1
        
        results_group.setLayout(results_layout)
        main_layout.addWidget(results_group)
        
        # 图表Tab组
        self.plot_tabs = QTabWidget()
        
        # Bump Steer图表
        self.bump_steer_widget = ComparisonPlotWidget()
        self.plot_tabs.addTab(self.bump_steer_widget, "Bump Steer")
        
        # Bump Camber图表
        self.bump_camber_widget = ComparisonPlotWidget()
        self.plot_tabs.addTab(self.bump_camber_widget, "Bump Camber")
        
        # Wheel Rate图表
        self.wheel_rate_widget = ComparisonPlotWidget()
        self.plot_tabs.addTab(self.wheel_rate_widget, "Wheel Rate")
        
        # Wheel Recession图表
        self.wheel_recession_widget = ComparisonPlotWidget()
        self.plot_tabs.addTab(self.wheel_recession_widget, "Wheel Recession")
        
        # Track Change图表
        self.track_change_widget = ComparisonPlotWidget()
        self.plot_tabs.addTab(self.track_change_widget, "Track Change")
        
        main_layout.addWidget(self.plot_tabs, 1)
        
        # 控制按钮
        controls_layout = QHBoxLayout()
        clear_btn = QPushButton("Clear Axes")
        clear_btn.clicked.connect(self.clear_all_plots)
        controls_layout.addWidget(clear_btn)
        controls_layout.addStretch()
        
        main_layout.addLayout(controls_layout)
        
        # 全局控制
        self.setup_global_controls(main_layout)
        
        self.setLayout(main_layout)
    
    def _on_fit_range_changed(self, value: int):
        """拟合范围改变"""
        self.fit_range = value
        if self.calculator:
            self.process_data()
    
    def process_data(self):
        """处理数据"""
        if not self.calculator:
            return
        
        try:
            # 计算Bump Steer
            bump_steer_result = self.calculator.calculate_bump_steer(fit_range=self.fit_range)
            self.result_labels['bump_steer_left'].setText(f"{bump_steer_result['left_slope']:.2f}")
            self.result_labels['bump_steer_right'].setText(f"{bump_steer_result['right_slope']:.2f}")
            self.result_labels['bump_steer_avg'].setText(f"{bump_steer_result['average_slope']:.2f}")
            
            # 计算Bump Camber
            bump_camber_result = self.calculator.calculate_bump_camber(fit_range=self.fit_range)
            self.result_labels['bump_camber_left'].setText(f"{bump_camber_result['left_slope']:.2f}")
            self.result_labels['bump_camber_right'].setText(f"{bump_camber_result['right_slope']:.2f}")
            self.result_labels['bump_camber_avg'].setText(f"{bump_camber_result['average_slope']:.2f}")
            
            # 计算Wheel Rate
            wheel_rate_result = self.calculator.calculate_wheel_rate()
            self.result_labels['wheel_rate_left'].setText(f"{wheel_rate_result['left_rate']:.2f}")
            self.result_labels['wheel_rate_right'].setText(f"{wheel_rate_result['right_rate']:.2f}")
            
            # 更新图表
            self.update_plots()
            
        except Exception as e:
            QMessageBox.critical(self, "Error", f"Failed to process data:\n{str(e)}")
            logger.error(f"数据处理失败: {e}", exc_info=True)
    
    def update_plots(self):
        """更新图表"""
        if not self.calculator:
            return
        
        try:
            # 更新Bump Steer图
            self.bump_steer_widget.clear()
            plot_bump_steer(
                self.bump_steer_widget.get_axes_left(),
                self.bump_steer_widget.get_axes_right(),
                self.calculator,
                fit_range=self.fit_range,
                curve_color=self.curve_color,
                fit_color=self.fit_color,
                compare_count=self.compare_count
            )
            self.bump_steer_widget.draw()
            
            # 更新Bump Camber图
            self.bump_camber_widget.clear()
            plot_bump_camber(
                self.bump_camber_widget.get_axes_left(),
                self.bump_camber_widget.get_axes_right(),
                self.calculator,
                fit_range=self.fit_range,
                curve_color=self.curve_color,
                fit_color=self.fit_color,
                compare_count=self.compare_count
            )
            self.bump_camber_widget.draw()
            
            # 更新Wheel Rate图
            self.wheel_rate_widget.clear()
            plot_wheel_rate(
                self.wheel_rate_widget.get_axes_left(),
                self.wheel_rate_widget.get_axes_right(),
                self.calculator,
                curve_color=self.curve_color,
                fit_color=self.fit_color,
                compare_count=self.compare_count
            )
            self.wheel_rate_widget.draw()
            
            # 更新Wheel Recession图
            self.wheel_recession_widget.clear()
            plot_wheel_recession(
                self.wheel_recession_widget.get_axes_left(),
                self.wheel_recession_widget.get_axes_right(),
                self.calculator,
                curve_color=self.curve_color,
                fit_color=self.fit_color,
                compare_count=self.compare_count
            )
            self.wheel_recession_widget.draw()
            
            # 更新Track Change图
            self.track_change_widget.clear()
            plot_track_change(
                self.track_change_widget.get_axes_left(),
                self.track_change_widget.get_axes_right(),
                self.calculator,
                curve_color=self.curve_color,
                fit_color=self.fit_color,
                compare_count=self.compare_count
            )
            self.track_change_widget.draw()
            
        except Exception as e:
            logger.error(f"图表更新失败: {e}", exc_info=True)
    
    def clear_all_plots(self):
        """清空所有图表"""
        self.bump_steer_widget.clear()
        self.bump_camber_widget.clear()
        self.wheel_rate_widget.clear()
        self.wheel_recession_widget.clear()
        self.track_change_widget.clear()
    
    def clear_results(self):
        """清空结果面板"""
        for label in self.result_labels.values():
            label.setText("--")


class RollTestTab(BaseTestTab):
    """Roll测试Tab"""
    
    def __init__(self, parent: Optional[QWidget] = None, vehicle_params_panel: Optional[QWidget] = None):
        """初始化Roll测试Tab"""
        super().__init__(parent, vehicle_params_panel)
        self.fit_range = 1.0  # deg
    
    def setup_ui(self):
        """设置UI界面"""
        main_layout = QVBoxLayout()
        main_layout.setContentsMargins(10, 10, 10, 10)
        main_layout.setSpacing(10)
        
        # 文件选择
        self.setup_file_selection(main_layout)
        
        # 拟合范围设置
        fit_group = QGroupBox("Fit Range")
        fit_layout = QHBoxLayout()
        fit_layout.addWidget(QLabel("Range (deg):"))
        self.fit_range_spinbox = QDoubleSpinBox()
        self.fit_range_spinbox.setMinimum(0.1)
        self.fit_range_spinbox.setMaximum(5.0)
        self.fit_range_spinbox.setValue(1.0)
        self.fit_range_spinbox.setSingleStep(0.1)
        self.fit_range_spinbox.setDecimals(1)
        self.fit_range_spinbox.valueChanged.connect(self._on_fit_range_changed)
        fit_layout.addWidget(self.fit_range_spinbox)
        fit_layout.addStretch()
        fit_group.setLayout(fit_layout)
        main_layout.addWidget(fit_group)
        
        # 结果面板
        results_group = QGroupBox("Results")
        results_layout = QGridLayout()
        
        self.result_labels = {}
        result_fields = [
            ('roll_steer_left', 'Roll Steer Left (deg/deg)'),
            ('roll_steer_right', 'Roll Steer Right (deg/deg)'),
            ('roll_steer_avg', 'Roll Steer Avg (deg/deg)'),
            ('roll_camber_left', 'Roll Camber Left (deg/deg)'),
            ('roll_camber_right', 'Roll Camber Right (deg/deg)'),
            ('roll_camber_avg', 'Roll Camber Avg (deg/deg)'),
            ('roll_rate_susp', 'Roll Rate Susp (N·m/deg)'),
            ('roll_rate_total', 'Roll Rate Total (N·m/deg)'),
            ('roll_center_height', 'Roll Center Height (mm)'),
        ]
        
        row = 0
        for key, label in result_fields:
            results_layout.addWidget(QLabel(f"{label}:"), row, 0)
            value_label = QLabel("--")
            value_label.setStyleSheet("font-weight: bold;")
            self.result_labels[key] = value_label
            results_layout.addWidget(value_label, row, 1)
            row += 1
        
        results_group.setLayout(results_layout)
        main_layout.addWidget(results_group)
        
        # 图表Tab组
        self.plot_tabs = QTabWidget()
        
        # Roll Steer图表
        self.roll_steer_widget = ComparisonPlotWidget()
        self.plot_tabs.addTab(self.roll_steer_widget, "Roll Steer")
        
        # Roll Camber图表
        self.roll_camber_widget = ComparisonPlotWidget()
        self.plot_tabs.addTab(self.roll_camber_widget, "Roll Camber")
        
        # Roll Camber Relative Ground图表
        self.roll_camber_ground_widget = ComparisonPlotWidget()
        self.plot_tabs.addTab(self.roll_camber_ground_widget, "Roll Camber (Rel. Ground)")
        
        # Roll Rate图表
        self.roll_rate_widget = MatplotlibWidget()
        self.plot_tabs.addTab(self.roll_rate_widget, "Roll Rate")
        
        # Roll Center Height图表
        self.roll_center_height_widget = MatplotlibWidget()
        self.plot_tabs.addTab(self.roll_center_height_widget, "Roll Center Height")
        
        main_layout.addWidget(self.plot_tabs, 1)
        
        # 控制按钮
        controls_layout = QHBoxLayout()
        clear_btn = QPushButton("Clear Axes")
        clear_btn.clicked.connect(self.clear_all_plots)
        controls_layout.addWidget(clear_btn)
        controls_layout.addStretch()
        
        main_layout.addLayout(controls_layout)
        
        # 全局控制
        self.setup_global_controls(main_layout)
        
        self.setLayout(main_layout)
    
    def _on_fit_range_changed(self, value: float):
        """拟合范围改变"""
        self.fit_range = value
        if self.calculator:
            self.process_data()
    
    def process_data(self):
        """处理数据"""
        if not self.calculator:
            return
        
        try:
            # 计算Roll Steer
            roll_steer_result = self.calculator.calculate_roll_steer(fit_range=self.fit_range)
            self.result_labels['roll_steer_left'].setText(f"{roll_steer_result['left_slope']:.4f}")
            self.result_labels['roll_steer_right'].setText(f"{roll_steer_result['right_slope']:.4f}")
            self.result_labels['roll_steer_avg'].setText(f"{roll_steer_result['average_slope']:.4f}")
            
            # 计算Roll Camber
            roll_camber_result = self.calculator.calculate_roll_camber(fit_range=self.fit_range)
            self.result_labels['roll_camber_left'].setText(f"{roll_camber_result['left_slope']:.4f}")
            self.result_labels['roll_camber_right'].setText(f"{roll_camber_result['right_slope']:.4f}")
            self.result_labels['roll_camber_avg'].setText(f"{roll_camber_result['average_slope']:.4f}")
            
            # 计算Roll Rate
            roll_rate_result = self.calculator.calculate_roll_rate()
            self.result_labels['roll_rate_susp'].setText(f"{roll_rate_result['suspension_roll_rate']:.2f}")
            self.result_labels['roll_rate_total'].setText(f"{roll_rate_result['total_roll_rate']:.2f}")
            
            # 计算Roll Center Height
            rch_result = self.calculator.calculate_roll_center_height()
            self.result_labels['roll_center_height'].setText(f"{rch_result['height']:.2f}")
            
            # 更新图表
            self.update_plots()
            
        except Exception as e:
            QMessageBox.critical(self, "Error", f"Failed to process data:\n{str(e)}")
            logger.error(f"数据处理失败: {e}", exc_info=True)
    
    def update_plots(self):
        """更新图表"""
        if not self.calculator:
            return
        
        try:
            # 更新Roll Steer图
            self.roll_steer_widget.clear()
            plot_roll_steer(
                self.roll_steer_widget.get_axes_left(),
                self.roll_steer_widget.get_axes_right(),
                self.calculator,
                fit_range=self.fit_range,
                curve_color=self.curve_color,
                fit_color=self.fit_color,
                compare_count=self.compare_count
            )
            self.roll_steer_widget.draw()
            
            # 更新Roll Camber图
            self.roll_camber_widget.clear()
            plot_roll_camber(
                self.roll_camber_widget.get_axes_left(),
                self.roll_camber_widget.get_axes_right(),
                self.calculator,
                fit_range=self.fit_range,
                curve_color=self.curve_color,
                fit_color=self.fit_color,
                compare_count=self.compare_count
            )
            self.roll_camber_widget.draw()
            
            # 更新Roll Camber Relative Ground图
            self.roll_camber_ground_widget.clear()
            plot_roll_camber_relative_ground(
                self.roll_camber_ground_widget.get_axes_left(),
                self.roll_camber_ground_widget.get_axes_right(),
                self.calculator,
                fit_range=self.fit_range,
                curve_color=self.curve_color,
                fit_color=self.fit_color,
                compare_count=self.compare_count
            )
            self.roll_camber_ground_widget.draw()
            
            # 更新Roll Rate图
            self.roll_rate_widget.clear()
            plot_roll_rate(
                self.roll_rate_widget.get_axes(),
                self.calculator,
                curve_color=self.curve_color
            )
            self.roll_rate_widget.draw()
            
            # 更新Roll Center Height图
            self.roll_center_height_widget.clear()
            plot_roll_center_height(
                self.roll_center_height_widget.get_axes(),
                self.calculator,
                curve_color=self.curve_color
            )
            self.roll_center_height_widget.draw()
            
        except Exception as e:
            logger.error(f"图表更新失败: {e}", exc_info=True)
    
    def clear_all_plots(self):
        """清空所有图表"""
        self.roll_steer_widget.clear()
        self.roll_camber_widget.clear()
        self.roll_camber_ground_widget.clear()
        self.roll_rate_widget.clear()
        self.roll_center_height_widget.clear()
    
    def clear_results(self):
        """清空结果面板"""
        for label in self.result_labels.values():
            label.setText("--")


class StaticLoadLateralTab(BaseTestTab):
    """Static Load Lateral测试Tab"""
    
    def __init__(self, parent: Optional[QWidget] = None, vehicle_params_panel: Optional[QWidget] = None):
        """初始化Static Load Lateral测试Tab"""
        super().__init__(parent, vehicle_params_panel)
        self.fit_range = 1.0  # kN
    
    def setup_ui(self):
        """设置UI界面"""
        main_layout = QVBoxLayout()
        main_layout.setContentsMargins(10, 10, 10, 10)
        main_layout.setSpacing(10)
        
        # 文件选择
        self.setup_file_selection(main_layout)
        
        # 拟合范围设置
        fit_group = QGroupBox("Fit Range")
        fit_layout = QHBoxLayout()
        fit_layout.addWidget(QLabel("Range (kN):"))
        self.fit_range_spinbox = QDoubleSpinBox()
        self.fit_range_spinbox.setMinimum(0.1)
        self.fit_range_spinbox.setMaximum(10.0)
        self.fit_range_spinbox.setValue(1.0)
        self.fit_range_spinbox.setSingleStep(0.1)
        self.fit_range_spinbox.setDecimals(1)
        self.fit_range_spinbox.valueChanged.connect(self._on_fit_range_changed)
        fit_layout.addWidget(self.fit_range_spinbox)
        fit_layout.addStretch()
        fit_group.setLayout(fit_layout)
        main_layout.addWidget(fit_group)
        
        # 结果面板
        results_group = QGroupBox("Results")
        results_layout = QGridLayout()
        
        self.result_labels = {}
        result_fields = [
            ('lateral_toe_left', 'Lateral Toe Left (deg/kN)'),
            ('lateral_toe_right', 'Lateral Toe Right (deg/kN)'),
            ('lateral_toe_avg', 'Lateral Toe Avg (deg/kN)'),
            ('lateral_camber_left', 'Lateral Camber Left (deg/kN)'),
            ('lateral_camber_right', 'Lateral Camber Right (deg/kN)'),
            ('lateral_camber_avg', 'Lateral Camber Avg (deg/kN)'),
        ]
        
        row = 0
        for key, label in result_fields:
            results_layout.addWidget(QLabel(f"{label}:"), row, 0)
            value_label = QLabel("--")
            value_label.setStyleSheet("font-weight: bold;")
            self.result_labels[key] = value_label
            results_layout.addWidget(value_label, row, 1)
            row += 1
        
        results_group.setLayout(results_layout)
        main_layout.addWidget(results_group)
        
        # 图表Tab组
        self.plot_tabs = QTabWidget()
        
        # Lateral Toe Compliance图表
        self.lateral_toe_widget = ComparisonPlotWidget()
        self.plot_tabs.addTab(self.lateral_toe_widget, "Lateral Toe Compliance")
        
        # Lateral Camber Compliance图表
        self.lateral_camber_widget = ComparisonPlotWidget()
        self.plot_tabs.addTab(self.lateral_camber_widget, "Lateral Camber Compliance")
        
        main_layout.addWidget(self.plot_tabs, 1)
        
        # 控制按钮
        controls_layout = QHBoxLayout()
        clear_btn = QPushButton("Clear Axes")
        clear_btn.clicked.connect(self.clear_all_plots)
        controls_layout.addWidget(clear_btn)
        controls_layout.addStretch()
        
        main_layout.addLayout(controls_layout)
        
        # 全局控制
        self.setup_global_controls(main_layout)
        
        self.setLayout(main_layout)
    
    def _on_fit_range_changed(self, value: float):
        """拟合范围改变"""
        self.fit_range = value
        if self.calculator:
            self.process_data()
    
    def process_data(self):
        """处理数据"""
        if not self.calculator:
            return
        
        try:
            # 计算Lateral Toe Compliance
            lateral_toe_result = self.calculator.calculate_lateral_toe_compliance(fit_range=self.fit_range)
            self.result_labels['lateral_toe_left'].setText(f"{lateral_toe_result['left_slope']:.4f}")
            self.result_labels['lateral_toe_right'].setText(f"{lateral_toe_result['right_slope']:.4f}")
            self.result_labels['lateral_toe_avg'].setText(f"{lateral_toe_result['average_slope']:.4f}")
            
            # 计算Lateral Camber Compliance
            lateral_camber_result = self.calculator.calculate_lateral_camber_compliance(fit_range=self.fit_range)
            self.result_labels['lateral_camber_left'].setText(f"{lateral_camber_result['left_slope']:.4f}")
            self.result_labels['lateral_camber_right'].setText(f"{lateral_camber_result['right_slope']:.4f}")
            self.result_labels['lateral_camber_avg'].setText(f"{lateral_camber_result['average_slope']:.4f}")
            
            # 更新图表
            self.update_plots()
            
        except Exception as e:
            QMessageBox.critical(self, "Error", f"Failed to process data:\n{str(e)}")
            logger.error(f"数据处理失败: {e}", exc_info=True)
    
    def update_plots(self):
        """更新图表"""
        if not self.calculator:
            return
        
        try:
            # 更新Lateral Toe Compliance图
            self.lateral_toe_widget.clear()
            plot_lateral_toe_compliance(
                self.lateral_toe_widget.get_axes_left(),
                self.lateral_toe_widget.get_axes_right(),
                self.calculator,
                fit_range=self.fit_range,
                curve_color=self.curve_color,
                fit_color=self.fit_color,
                compare_count=self.compare_count
            )
            self.lateral_toe_widget.draw()
            
            # 更新Lateral Camber Compliance图
            self.lateral_camber_widget.clear()
            plot_lateral_camber_compliance(
                self.lateral_camber_widget.get_axes_left(),
                self.lateral_camber_widget.get_axes_right(),
                self.calculator,
                fit_range=self.fit_range,
                curve_color=self.curve_color,
                fit_color=self.fit_color,
                compare_count=self.compare_count
            )
            self.lateral_camber_widget.draw()
            
        except Exception as e:
            logger.error(f"图表更新失败: {e}", exc_info=True)
    
    def clear_all_plots(self):
        """清空所有图表"""
        self.lateral_toe_widget.clear()
        self.lateral_camber_widget.clear()
    
    def clear_results(self):
        """清空结果面板"""
        for label in self.result_labels.values():
            label.setText("--")


class StaticLoadBrakingTab(BaseTestTab):
    """Static Load Braking测试Tab"""
    
    def __init__(self, parent: Optional[QWidget] = None, vehicle_params_panel: Optional[QWidget] = None):
        """初始化Static Load Braking测试Tab"""
        super().__init__(parent, vehicle_params_panel)
        self.fit_range = 1.0  # kN
    
    def setup_ui(self):
        """设置UI界面"""
        main_layout = QVBoxLayout()
        main_layout.setContentsMargins(10, 10, 10, 10)
        main_layout.setSpacing(10)
        
        # 文件选择
        self.setup_file_selection(main_layout)
        
        # 拟合范围设置
        fit_group = QGroupBox("Fit Range")
        fit_layout = QHBoxLayout()
        fit_layout.addWidget(QLabel("Range (kN):"))
        self.fit_range_spinbox = QDoubleSpinBox()
        self.fit_range_spinbox.setMinimum(0.1)
        self.fit_range_spinbox.setMaximum(10.0)
        self.fit_range_spinbox.setValue(1.0)
        self.fit_range_spinbox.setSingleStep(0.1)
        self.fit_range_spinbox.setDecimals(1)
        self.fit_range_spinbox.valueChanged.connect(self._on_fit_range_changed)
        fit_layout.addWidget(self.fit_range_spinbox)
        fit_layout.addStretch()
        fit_group.setLayout(fit_layout)
        main_layout.addWidget(fit_group)
        
        # 结果面板
        results_group = QGroupBox("Results")
        results_layout = QGridLayout()
        
        self.result_labels = {}
        result_fields = [
            ('braking_toe_left', 'Braking Toe Left (deg/kN)'),
            ('braking_toe_right', 'Braking Toe Right (deg/kN)'),
            ('braking_toe_avg', 'Braking Toe Avg (deg/kN)'),
        ]
        
        row = 0
        for key, label in result_fields:
            results_layout.addWidget(QLabel(f"{label}:"), row, 0)
            value_label = QLabel("--")
            value_label.setStyleSheet("font-weight: bold;")
            self.result_labels[key] = value_label
            results_layout.addWidget(value_label, row, 1)
            row += 1
        
        results_group.setLayout(results_layout)
        main_layout.addWidget(results_group)
        
        # 图表Tab组
        self.plot_tabs = QTabWidget()
        
        # Braking Toe Compliance图表
        self.braking_toe_widget = ComparisonPlotWidget()
        self.plot_tabs.addTab(self.braking_toe_widget, "Braking Toe Compliance")
        
        main_layout.addWidget(self.plot_tabs, 1)
        
        # 控制按钮
        controls_layout = QHBoxLayout()
        clear_btn = QPushButton("Clear Axes")
        clear_btn.clicked.connect(self.clear_all_plots)
        controls_layout.addWidget(clear_btn)
        controls_layout.addStretch()
        
        main_layout.addLayout(controls_layout)
        
        # 全局控制
        self.setup_global_controls(main_layout)
        
        self.setLayout(main_layout)
    
    def _on_fit_range_changed(self, value: float):
        """拟合范围改变"""
        self.fit_range = value
        if self.calculator:
            self.process_data()
    
    def process_data(self):
        """处理数据"""
        if not self.calculator:
            return
        
        try:
            # 计算Braking Toe Compliance
            braking_toe_result = self.calculator.calculate_braking_toe_compliance(fit_range=self.fit_range)
            self.result_labels['braking_toe_left'].setText(f"{braking_toe_result['left_slope']:.4f}")
            self.result_labels['braking_toe_right'].setText(f"{braking_toe_result['right_slope']:.4f}")
            self.result_labels['braking_toe_avg'].setText(f"{braking_toe_result['average_slope']:.4f}")
            
            # 更新图表
            self.update_plots()
            
        except Exception as e:
            QMessageBox.critical(self, "Error", f"Failed to process data:\n{str(e)}")
            logger.error(f"数据处理失败: {e}", exc_info=True)
    
    def update_plots(self):
        """更新图表"""
        if not self.calculator:
            return
        
        try:
            # 更新Braking Toe Compliance图
            self.braking_toe_widget.clear()
            plot_braking_toe_compliance(
                self.braking_toe_widget.get_axes_left(),
                self.braking_toe_widget.get_axes_right(),
                self.calculator,
                fit_range=self.fit_range,
                curve_color=self.curve_color,
                fit_color=self.fit_color,
                compare_count=self.compare_count
            )
            self.braking_toe_widget.draw()
            
        except Exception as e:
            logger.error(f"图表更新失败: {e}", exc_info=True)
    
    def clear_all_plots(self):
        """清空所有图表"""
        self.braking_toe_widget.clear()
    
    def clear_results(self):
        """清空结果面板"""
        for label in self.result_labels.values():
            label.setText("--")


class StaticLoadAccelerationTab(BaseTestTab):
    """Static Load Acceleration测试Tab"""
    
    def __init__(self, parent: Optional[QWidget] = None, vehicle_params_panel: Optional[QWidget] = None):
        """初始化Static Load Acceleration测试Tab"""
        super().__init__(parent, vehicle_params_panel)
        self.fit_range = 1.0  # kN
    
    def setup_ui(self):
        """设置UI界面"""
        main_layout = QVBoxLayout()
        main_layout.setContentsMargins(10, 10, 10, 10)
        main_layout.setSpacing(10)
        
        # 文件选择
        self.setup_file_selection(main_layout)
        
        # 拟合范围设置
        fit_group = QGroupBox("Fit Range")
        fit_layout = QHBoxLayout()
        fit_layout.addWidget(QLabel("Range (kN):"))
        self.fit_range_spinbox = QDoubleSpinBox()
        self.fit_range_spinbox.setMinimum(0.1)
        self.fit_range_spinbox.setMaximum(10.0)
        self.fit_range_spinbox.setValue(1.0)
        self.fit_range_spinbox.setSingleStep(0.1)
        self.fit_range_spinbox.setDecimals(1)
        self.fit_range_spinbox.valueChanged.connect(self._on_fit_range_changed)
        fit_layout.addWidget(self.fit_range_spinbox)
        fit_layout.addStretch()
        fit_group.setLayout(fit_layout)
        main_layout.addWidget(fit_group)
        
        # 结果面板
        results_group = QGroupBox("Results")
        results_layout = QGridLayout()
        
        self.result_labels = {}
        result_fields = [
            ('acceleration_toe_left', 'Acceleration Toe Left (deg/kN)'),
            ('acceleration_toe_right', 'Acceleration Toe Right (deg/kN)'),
            ('acceleration_toe_avg', 'Acceleration Toe Avg (deg/kN)'),
        ]
        
        row = 0
        for key, label in result_fields:
            results_layout.addWidget(QLabel(f"{label}:"), row, 0)
            value_label = QLabel("--")
            value_label.setStyleSheet("font-weight: bold;")
            self.result_labels[key] = value_label
            results_layout.addWidget(value_label, row, 1)
            row += 1
        
        results_group.setLayout(results_layout)
        main_layout.addWidget(results_group)
        
        # 图表Tab组
        self.plot_tabs = QTabWidget()
        
        # Acceleration Toe Compliance图表
        self.acceleration_toe_widget = ComparisonPlotWidget()
        self.plot_tabs.addTab(self.acceleration_toe_widget, "Acceleration Toe Compliance")
        
        main_layout.addWidget(self.plot_tabs, 1)
        
        # 控制按钮
        controls_layout = QHBoxLayout()
        clear_btn = QPushButton("Clear Axes")
        clear_btn.clicked.connect(self.clear_all_plots)
        controls_layout.addWidget(clear_btn)
        controls_layout.addStretch()
        
        main_layout.addLayout(controls_layout)
        
        # 全局控制
        self.setup_global_controls(main_layout)
        
        self.setLayout(main_layout)
    
    def _on_fit_range_changed(self, value: float):
        """拟合范围改变"""
        self.fit_range = value
        if self.calculator:
            self.process_data()
    
    def process_data(self):
        """处理数据"""
        if not self.calculator:
            return
        
        try:
            # 计算Acceleration Toe Compliance
            acceleration_toe_result = self.calculator.calculate_acceleration_toe_compliance(fit_range=self.fit_range)
            self.result_labels['acceleration_toe_left'].setText(f"{acceleration_toe_result['left_slope']:.4f}")
            self.result_labels['acceleration_toe_right'].setText(f"{acceleration_toe_result['right_slope']:.4f}")
            self.result_labels['acceleration_toe_avg'].setText(f"{acceleration_toe_result['average_slope']:.4f}")
            
            # 更新图表
            self.update_plots()
            
        except Exception as e:
            QMessageBox.critical(self, "Error", f"Failed to process data:\n{str(e)}")
            logger.error(f"数据处理失败: {e}", exc_info=True)
    
    def update_plots(self):
        """更新图表"""
        if not self.calculator:
            return
        
        try:
            # 更新Acceleration Toe Compliance图
            self.acceleration_toe_widget.clear()
            plot_acceleration_toe_compliance(
                self.acceleration_toe_widget.get_axes_left(),
                self.acceleration_toe_widget.get_axes_right(),
                self.calculator,
                fit_range=self.fit_range,
                curve_color=self.curve_color,
                fit_color=self.fit_color,
                compare_count=self.compare_count
            )
            self.acceleration_toe_widget.draw()
            
        except Exception as e:
            logger.error(f"图表更新失败: {e}", exc_info=True)
    
    def clear_all_plots(self):
        """清空所有图表"""
        self.acceleration_toe_widget.clear()
    
    def clear_results(self):
        """清空结果面板"""
        for label in self.result_labels.values():
            label.setText("--")
