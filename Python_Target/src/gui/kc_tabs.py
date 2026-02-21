"""K&C分析Tab模块

提供各种K&C测试工况的Tab界面，包括Bump、Roll、Static Load等。
"""

from typing import Optional, Dict, Any
from pathlib import Path
from PyQt6.QtWidgets import (QWidget, QVBoxLayout, QHBoxLayout, QLabel, 
                            QPushButton, QLineEdit, QTabWidget, QGroupBox,
                            QGridLayout, QDoubleSpinBox, QSpinBox, QColorDialog,
                            QMessageBox, QFileDialog, QTextEdit, QScrollArea,
                            QProgressDialog, QButtonGroup, QSlider)
from PyQt6.QtCore import Qt, pyqtSignal, QThread, pyqtSlot
from PyQt6.QtGui import QFont, QColor, QPixmap

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
        
        # 多套结果对比存储
        self.results_history: list = []  # 存储多套计算结果
        self.max_compare_count = 10  # 最大对比数量
        self.color_palette = [
            '#1f77b4', '#ff7f0e', '#2ca02c', '#d62728', '#9467bd',
            '#8c564b', '#e377c2', '#7f7f7f', '#bcbd22', '#17becf'
        ]  # 10种不同颜色用于对比
        
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
        browse_btn.setStyleSheet("""
            QPushButton {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 #f1f5f9, stop:1 #e2e8f0);
                color: #475569;
                border: 1px solid #cbd5e1;
                padding: 10px 20px;
                border-radius: 10px;
                font-weight: 600;
                font-size: 13px;
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
        
        go_btn = QPushButton("GO")
        go_btn.setStyleSheet("""
            QPushButton {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 #10b981, stop:1 #059669);
                color: white;
                border: none;
                padding: 10px 24px;
                border-radius: 10px;
                font-weight: 700;
                font-size: 14px;
                min-width: 80px;
                box-shadow: 0 2px 8px rgba(16, 185, 129, 0.3);
            }
            QPushButton:hover {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 #34d399, stop:1 #10b981);
                box-shadow: 0 4px 12px rgba(16, 185, 129, 0.4);
            }
            QPushButton:pressed {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 #059669, stop:1 #047857);
                box-shadow: 0 1px 4px rgba(16, 185, 129, 0.3);
            }
        """)
        go_btn.clicked.connect(self._load_and_process_file)
        
        file_layout.addWidget(QLabel("File:"))
        file_layout.addWidget(self.file_path_edit, 1)
        file_layout.addWidget(browse_btn)
        file_layout.addWidget(go_btn)
        
        file_group.setLayout(file_layout)
        layout.addWidget(file_group)
    
    def create_fit_range_slider(self, min_val: float, max_val: float, default_val: float, 
                                 step: float = 1.0, unit: str = "", is_int: bool = False) -> tuple:
        """创建漂亮的fit range滑块控件
        
        Args:
            min_val: 最小值
            max_val: 最大值
            default_val: 默认值
            step: 步长
            unit: 单位（如"mm", "deg", "kN"）
            is_int: 是否为整数滑块
            
        Returns:
            (slider, value_label, container_layout): 滑块控件、数值显示标签和容器布局
        """
        # 创建容器布局
        container = QHBoxLayout()
        container.setSpacing(8)
        
        # 创建滑块
        if is_int:
            slider = QSlider(Qt.Orientation.Horizontal)
            slider.setMinimum(int(min_val))
            slider.setMaximum(int(max_val))
            slider.setValue(int(default_val))
            slider.setSingleStep(int(step))
        else:
            # 对于浮点数，使用整数滑块，然后映射到浮点数
            # 将浮点数范围映射到整数范围（乘以10或100以保持精度）
            multiplier = 10 if step >= 0.1 else 100
            slider = QSlider(Qt.Orientation.Horizontal)
            slider.setMinimum(int(min_val * multiplier))
            slider.setMaximum(int(max_val * multiplier))
            slider.setValue(int(default_val * multiplier))
            slider.setSingleStep(int(step * multiplier))
        
        # 设置滑块样式
        slider.setStyleSheet("""
            QSlider::groove:horizontal {
                border: 1px solid #cbd5e1;
                height: 8px;
                background: qlineargradient(x1:0, y1:0, x2:1, y2:0,
                    stop:0 #e2e8f0, stop:1 #cbd5e1);
                border-radius: 4px;
            }
            QSlider::handle:horizontal {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 #3b82f6, stop:1 #2563eb);
                border: 2px solid #ffffff;
                width: 20px;
                height: 20px;
                margin: -6px 0;
                border-radius: 10px;
            }
            QSlider::handle:horizontal:hover {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 #60a5fa, stop:1 #3b82f6);
                border: 2px solid #dbeafe;
            }
            QSlider::handle:horizontal:pressed {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 #2563eb, stop:1 #1d4ed8);
            }
            QSlider::sub-page:horizontal {
                background: qlineargradient(x1:0, y1:0, x2:1, y2:0,
                    stop:0 #3b82f6, stop:1 #60a5fa);
                border-radius: 4px;
            }
        """)
        
        # 创建数值显示标签
        value_label = QLabel()
        value_label.setMinimumWidth(80)
        value_label.setAlignment(Qt.AlignmentFlag.AlignCenter)
        value_label.setStyleSheet("""
            QLabel {
                background-color: #f8fafc;
                border: 2px solid #e2e8f0;
                border-radius: 8px;
                padding: 6px 12px;
                font-weight: 600;
                font-size: 13px;
                color: #1e293b;
            }
        """)
        
        # 更新标签显示
        def update_label(value):
            if is_int:
                val = value
            else:
                multiplier = 10 if step >= 0.1 else 100
                val = value / multiplier
            if unit:
                value_label.setText(f"{val:.1f} {unit}" if not is_int else f"{val} {unit}")
            else:
                value_label.setText(f"{val:.1f}" if not is_int else f"{val}")
        
        # 连接滑块值改变信号
        def on_slider_changed(value):
            update_label(value)
            if is_int:
                self._on_fit_range_changed(value)
            else:
                multiplier = 10 if step >= 0.1 else 100
                self._on_fit_range_changed(value / multiplier)
        
        slider.valueChanged.connect(on_slider_changed)
        
        # 初始化标签
        update_label(slider.value())
        
        # 添加滑块和标签到布局
        container.addWidget(slider, 1)
        container.addWidget(value_label)
        
        return slider, value_label, container
    
    def setup_global_controls(self, layout: QVBoxLayout):
        """设置全局控制组件
        
        Args:
            layout: 布局对象
        """
        controls_group = QGroupBox("Global Controls")
        controls_layout = QGridLayout()
        
        # 颜色选择器 - 现代化样式
        color_label = QLabel("Curve Color:")
        color_label.setStyleSheet("color: #475569; font-weight: 500;")
        controls_layout.addWidget(color_label, 0, 0)
        self.curve_color_btn = QPushButton()
        self.curve_color_btn.setStyleSheet(f"""
            QPushButton {{
                background-color: {self.curve_color};
                border: 2px solid #e2e8f0;
                border-radius: 8px;
            }}
            QPushButton:hover {{
                border-color: #94a3b8;
                transform: scale(1.05);
            }}
        """)
        self.curve_color_btn.setFixedSize(60, 32)
        self.curve_color_btn.clicked.connect(self._select_curve_color)
        controls_layout.addWidget(self.curve_color_btn, 0, 1)
        
        fit_label = QLabel("Fit Color:")
        fit_label.setStyleSheet("color: #475569; font-weight: 500;")
        controls_layout.addWidget(fit_label, 0, 2)
        self.fit_color_btn = QPushButton()
        self.fit_color_btn.setStyleSheet(f"""
            QPushButton {{
                background-color: {self.fit_color};
                border: 2px solid #e2e8f0;
                border-radius: 8px;
            }}
            QPushButton:hover {{
                border-color: #94a3b8;
                transform: scale(1.05);
            }}
        """)
        self.fit_color_btn.setFixedSize(60, 32)
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
        
        # Reset按钮 - 现代化样式
        reset_btn = QPushButton("Reset")
        reset_btn.setStyleSheet("""
            QPushButton {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 #fef2f2, stop:1 #fee2e2);
                color: #dc2626;
                border: 1px solid #fecaca;
                padding: 10px 20px;
                border-radius: 10px;
                font-weight: 600;
                font-size: 13px;
            }
            QPushButton:hover {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 #fee2e2, stop:1 #fecaca);
                border-color: #fca5a5;
                color: #b91c1c;
            }
            QPushButton:pressed {
                background: #fecaca;
            }
        """)
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
            
            # 处理数据
            result_data = self.process_data()
            
            # 根据compare_count决定是否存储到历史记录
            if self.compare_count > 0 and result_data:
                # 存储当前结果（包含计算器、提取器等）
                result_entry = {
                    'calculator': self.calculator,
                    'extractor': self.extractor,
                    'parser': self.parser,
                    'file_path': file_path,
                    'result_data': result_data,
                    'curve_color': self.curve_color,
                    'fit_color': self.fit_color,
                }
                
                # 如果历史记录已满，移除最旧的
                if len(self.results_history) >= self.compare_count:
                    self.results_history.pop(0)
                
                # 添加新结果
                self.results_history.append(result_entry)
            
            # 更新图表（会显示所有历史记录）
            self.update_plots()
            
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
    
    def process_data(self) -> Optional[Dict[str, Any]]:
        """处理数据（子类需要重写）
        
        Returns:
            处理后的结果数据字典，用于存储到历史记录
        """
        return None
    
    def _select_curve_color(self):
        """选择曲线颜色"""
        color = QColorDialog.getColor(QColor(self.curve_color), self, "Select Curve Color")
        if color.isValid():
            self.curve_color = color.name()
            self.curve_color_btn.setStyleSheet(f"""
                QPushButton {{
                    background-color: {self.curve_color};
                    border: 2px solid #e2e8f0;
                    border-radius: 8px;
                }}
                QPushButton:hover {{
                    border-color: #94a3b8;
                    transform: scale(1.05);
                }}
            """)
            self.update_plots()
    
    def _select_fit_color(self):
        """选择拟合线颜色"""
        color = QColorDialog.getColor(QColor(self.fit_color), self, "Select Fit Color")
        if color.isValid():
            self.fit_color = color.name()
            self.fit_color_btn.setStyleSheet(f"""
                QPushButton {{
                    background-color: {self.fit_color};
                    border: 2px solid #e2e8f0;
                    border-radius: 8px;
                }}
                QPushButton:hover {{
                    border-color: #94a3b8;
                    transform: scale(1.05);
                }}
            """)
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
        self.results_history.clear()  # 清空历史记录
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
    
    def setup_reference_vehicles(self, layout: QVBoxLayout):
        """设置参考车辆选择按钮组（公共方法）
        
        Args:
            layout: 布局对象
        """
        # 参考车辆列表（与Matlab程序一致）
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
        
        ref_group = QGroupBox("Ref. Vehicle")
        ref_layout = QVBoxLayout()
        
        # 创建按钮组（互斥选择）
        if not hasattr(self, 'ref_vehicle_button_group'):
            self.ref_vehicle_button_group = QButtonGroup(self)
            self.ref_vehicle_buttons = []
        
        for vehicle in reference_vehicles:
            btn = QPushButton(vehicle)
            btn.setCheckable(True)  # 设置为可选中状态
            btn.setStyleSheet("""
                QPushButton {
                    background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                        stop:0 #ffffff, stop:1 #f8fafc);
                    color: #475569;
                    border: 2px solid #e2e8f0;
                    padding: 10px 16px;
                    border-radius: 10px;
                    font-weight: 500;
                    font-size: 12px;
                    text-align: left;
                }
                QPushButton:hover {
                    background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                        stop:0 #f8fafc, stop:1 #f1f5f9);
                    border-color: #cbd5e1;
                }
                QPushButton:checked {
                    background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                        stop:0 #6366f1, stop:1 #4f46e5);
                    color: white;
                    border-color: #6366f1;
                    font-weight: 600;
                }
            """)
            btn.clicked.connect(lambda checked, v=vehicle: self._on_ref_vehicle_selected(v))
            self.ref_vehicle_button_group.addButton(btn)
            self.ref_vehicle_buttons.append(btn)
            ref_layout.addWidget(btn)
        
        ref_group.setLayout(ref_layout)
        # 将参考车辆组放在右侧（使用水平布局包装）
        ref_container = QHBoxLayout()
        ref_container.addStretch()
        ref_container.addWidget(ref_group)
        layout.addLayout(ref_container)
    
    def setup_control_buttons(self, layout: QVBoxLayout):
        """设置控制按钮（公共方法）
        
        Args:
            layout: 布局对象
        """
        controls_layout = QHBoxLayout()
        
        # Clear Axes按钮 - 现代化样式
        clear_btn = QPushButton("Clear Axes")
        clear_btn.setStyleSheet("""
            QPushButton {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 #f1f5f9, stop:1 #e2e8f0);
                color: #475569;
                border: 1px solid #cbd5e1;
                padding: 10px 20px;
                border-radius: 10px;
                font-weight: 600;
                font-size: 13px;
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
        clear_btn.clicked.connect(self.clear_all_plots)
        controls_layout.addWidget(clear_btn)
        
        # Positive Direction按钮（功能未实现，但UI存在）
        positive_dir_btn = QPushButton("Positive Direction")
        positive_dir_btn.setStyleSheet("""
            QPushButton {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 #f1f5f9, stop:1 #e2e8f0);
                color: #475569;
                border: 1px solid #cbd5e1;
                padding: 10px 20px;
                border-radius: 10px;
                font-weight: 600;
                font-size: 13px;
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
        positive_dir_btn.clicked.connect(self._on_positive_direction)
        controls_layout.addWidget(positive_dir_btn)
        
        controls_layout.addStretch()
        
        # 自定义绘图按钮（功能未实现，但UI存在）
        custom_plot_btn = QPushButton("Custom Plot")
        custom_plot_btn.setToolTip("Custom Plot (Not implemented yet)")
        custom_plot_btn.setStyleSheet("""
            QPushButton {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 #fef3c7, stop:1 #fde68a);
                color: #92400e;
                border: 1px solid #fcd34d;
                padding: 10px 20px;
                border-radius: 10px;
                font-weight: 600;
                font-size: 13px;
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
        custom_plot_btn.clicked.connect(self._on_custom_plot)
        controls_layout.addWidget(custom_plot_btn)
        
        # 导出PPT按钮（功能未实现，但UI存在）
        export_ppt_btn = QPushButton("Export to PPT")
        export_ppt_btn.setToolTip("Export to PPT (Not implemented yet)")
        export_ppt_btn.setStyleSheet("""
            QPushButton {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 #ddd6fe, stop:1 #c4b5fd);
                color: #5b21b6;
                border: 1px solid #a78bfa;
                padding: 10px 20px;
                border-radius: 10px;
                font-weight: 600;
                font-size: 13px;
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
        export_ppt_btn.clicked.connect(self._on_export_ppt)
        controls_layout.addWidget(export_ppt_btn)
        
        layout.addLayout(controls_layout)
    
    def _on_ref_vehicle_selected(self, vehicle: str):
        """参考车辆选择回调（功能未实现，但UI存在）"""
        logger.info(f"参考车辆选择: {vehicle} (功能未实现)")
        # TODO: 实现参考车辆数据加载和对比功能
    
    def _on_positive_direction(self):
        """Positive Direction按钮回调（功能未实现，但UI存在）"""
        QMessageBox.information(self, "Info", "Positive Direction功能尚未实现")
        logger.info("Positive Direction按钮点击（功能未实现）")
    
    def _on_custom_plot(self):
        """自定义绘图按钮回调（功能未实现，但UI存在）"""
        QMessageBox.information(self, "Info", "Custom Plot功能尚未实现")
        logger.info("Custom Plot按钮点击（功能未实现）")
    
    def _on_export_ppt(self):
        """导出PPT按钮回调（功能未实现，但UI存在）"""
        QMessageBox.information(self, "Info", "Export to PPT功能尚未实现")
        logger.info("Export to PPT按钮点击（功能未实现）")


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
        layout.setContentsMargins(24, 24, 24, 24)
        layout.setSpacing(20)
        
        # Logo区域 - 顶部
        logo_layout = QHBoxLayout()
        logo_layout.setSpacing(20)
        
        # 获取资源路径
        try:
            from pathlib import Path
            resources_dir = Path(__file__).parent.parent.parent.parent / "Resources"
            
            # Gestamp Logo
            gestamp_logo_path = resources_dir / "logos" / "Gestamp_Logo.png"
            if not gestamp_logo_path.exists():
                gestamp_logo_path = resources_dir / "images" / "Gestamp_Logo.png"
            
            if gestamp_logo_path.exists():
                gestamp_logo = QLabel()
                pixmap = QPixmap(str(gestamp_logo_path))
                # 缩放Logo到合适大小（保持宽高比）
                scaled_pixmap = pixmap.scaled(200, 60, Qt.AspectRatioMode.KeepAspectRatio, Qt.TransformationMode.SmoothTransformation)
                gestamp_logo.setPixmap(scaled_pixmap)
                gestamp_logo.setAlignment(Qt.AlignmentFlag.AlignLeft | Qt.AlignmentFlag.AlignVCenter)
                logo_layout.addWidget(gestamp_logo)
            
            logo_layout.addStretch()
            
            # MATLAB Logo
            matlab_logo_path = resources_dir / "logos" / "matlab-logo.png"
            if not matlab_logo_path.exists():
                matlab_logo_path = resources_dir / "images" / "matlab-logo.png"
            
            if matlab_logo_path.exists():
                matlab_logo = QLabel()
                pixmap = QPixmap(str(matlab_logo_path))
                # 缩放Logo到合适大小
                scaled_pixmap = pixmap.scaled(40, 40, Qt.AspectRatioMode.KeepAspectRatio, Qt.TransformationMode.SmoothTransformation)
                matlab_logo.setPixmap(scaled_pixmap)
                matlab_logo.setAlignment(Qt.AlignmentFlag.AlignRight | Qt.AlignmentFlag.AlignVCenter)
                logo_layout.addWidget(matlab_logo)
        except Exception as e:
            logger.warning(f"无法加载Logo: {e}")
        
        layout.addLayout(logo_layout)
        
        # 标题 - 现代化样式
        title = QLabel("KinBench Tool - K&C Analysis")
        title.setFont(QFont("Segoe UI", 24, QFont.Weight.Bold))
        title.setAlignment(Qt.AlignmentFlag.AlignCenter)
        title.setStyleSheet("""
            QLabel {
                color: #1e293b;
                padding: 20px;
            }
        """)
        layout.addWidget(title)
        
        # 说明文本 - 现代化样式
        info_text = QTextEdit()
        info_text.setReadOnly(True)
        info_text.setStyleSheet("""
            QTextEdit {
                background-color: #ffffff;
                border: 2px solid #e2e8f0;
                border-radius: 12px;
                padding: 16px;
                font-size: 13px;
                line-height: 1.6;
            }
        """)
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
        <p>Version 0.1.1 - Python Implementation</p>
        """)
        
        layout.addWidget(info_text, 1)
        
        self.setLayout(layout)


class BumpTestTab(BaseTestTab):
    """Bump测试Tab"""
    
    def __init__(self, parent: Optional[QWidget] = None, vehicle_params_panel: Optional[QWidget] = None):
        """初始化Bump测试Tab"""
        super().__init__(parent, vehicle_params_panel)
        self.fit_range = 15  # mm
    
    def setup_ui(self):
        """设置UI界面 - 优化为左右分栏布局"""
        # 主布局：顶部文件选择，下方左右分栏
        main_layout = QVBoxLayout()
        main_layout.setContentsMargins(12, 12, 12, 12)
        main_layout.setSpacing(12)
        
        # 文件选择（顶部）
        self.setup_file_selection(main_layout)
        
        # 创建左右分栏布局
        content_layout = QHBoxLayout()
        content_layout.setSpacing(12)
        
        # 左侧面板：参数和结果（固定宽度）
        left_panel = QWidget()
        left_panel.setMaximumWidth(380)
        left_panel.setMinimumWidth(350)
        left_layout = QVBoxLayout()
        left_layout.setContentsMargins(0, 0, 0, 0)
        left_layout.setSpacing(12)
        
        # 拟合范围设置 - 使用漂亮的滑块
        fit_group = QGroupBox("Fit Range")
        fit_layout = QVBoxLayout()
        fit_layout.addWidget(QLabel("Range (mm):"))
        self.fit_range_slider, self.fit_range_label, slider_container = self.create_fit_range_slider(
            min_val=5, max_val=50, default_val=15, step=1.0, unit="mm", is_int=True
        )
        fit_layout.addLayout(slider_container)
        fit_group.setLayout(fit_layout)
        left_layout.addWidget(fit_group)
        
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
            value_label.setStyleSheet("""
                font-weight: 600;
                font-size: 13px;
                color: #1e293b;
                padding: 4px 8px;
                background-color: #f8fafc;
                border-radius: 6px;
            """)
            self.result_labels[key] = value_label
            results_layout.addWidget(value_label, row, 1)
            row += 1
        
        results_group.setLayout(results_layout)
        left_layout.addWidget(results_group)
        
        # 控制按钮（左侧）
        controls_layout = QHBoxLayout()
        clear_btn = QPushButton("Clear Axes")
        clear_btn.clicked.connect(self.clear_all_plots)
        controls_layout.addWidget(clear_btn)
        
        # Positive Direction按钮
        positive_dir_btn = QPushButton("Positive Direction")
        positive_dir_btn.clicked.connect(self._on_positive_direction)
        controls_layout.addWidget(positive_dir_btn)
        left_layout.addLayout(controls_layout)
        
        # 自定义绘图和导出PPT按钮
        extra_controls_layout = QHBoxLayout()
        custom_plot_btn = QPushButton("Custom Plot")
        custom_plot_btn.setToolTip("Custom Plot (Not implemented yet)")
        custom_plot_btn.clicked.connect(self._on_custom_plot)
        extra_controls_layout.addWidget(custom_plot_btn)
        
        export_ppt_btn = QPushButton("Export to PPT")
        export_ppt_btn.setToolTip("Export to PPT (Not implemented yet)")
        export_ppt_btn.clicked.connect(self._on_export_ppt)
        extra_controls_layout.addWidget(export_ppt_btn)
        left_layout.addLayout(extra_controls_layout)
        
        # 参考车辆选择区域
        self.setup_reference_vehicles(left_layout)
        
        # 全局控制
        self.setup_global_controls(left_layout)
        
        left_layout.addStretch()
        left_panel.setLayout(left_layout)
        content_layout.addWidget(left_panel)
        
        # 右侧面板：图表（占据剩余空间）
        right_panel = QWidget()
        right_layout = QVBoxLayout()
        right_layout.setContentsMargins(0, 0, 0, 0)
        right_layout.setSpacing(12)
        
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
        
        right_layout.addWidget(self.plot_tabs)
        right_panel.setLayout(right_layout)
        content_layout.addWidget(right_panel, 1)  # 占据剩余空间
        
        main_layout.addLayout(content_layout, 1)
        self.setLayout(main_layout)
    
    def _on_fit_range_changed(self, value: int):
        """拟合范围改变 - 自动更新结果和图表"""
        self.fit_range = value
        if self.calculator:
            # 同时更新结果和图表
            self.process_data()
            self.update_plots()
    
    def process_data(self) -> Optional[Dict[str, Any]]:
        """处理数据"""
        if not self.calculator:
            return None
        
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
            self.result_labels['wheel_rate_left'].setText(f"{wheel_rate_result['left_rate_at_zero']:.2f}")
            self.result_labels['wheel_rate_right'].setText(f"{wheel_rate_result['right_rate_at_zero']:.2f}")
            
            # 返回结果数据
            return {
                'bump_steer': bump_steer_result,
                'bump_camber': bump_camber_result,
                'wheel_rate': wheel_rate_result,
            }
            
        except Exception as e:
            QMessageBox.critical(self, "Error", f"Failed to process data:\n{str(e)}")
            logger.error(f"数据处理失败: {e}", exc_info=True)
            return None
    
    def update_plots(self):
        """更新图表，支持多套结果对比"""
        # 清空所有图表
        self.bump_steer_widget.clear()
        self.bump_camber_widget.clear()
        self.wheel_rate_widget.clear()
        self.wheel_recession_widget.clear()
        self.track_change_widget.clear()
        
        # 如果没有历史记录，只显示当前结果
        if not self.results_history and self.calculator:
            try:
                # 显示当前结果
                plot_bump_steer(
                    self.bump_steer_widget.get_axes_left(),
                    self.bump_steer_widget.get_axes_right(),
                    self.calculator,
                    fit_range=self.fit_range,
                    curve_color=self.curve_color,
                    fit_color=self.fit_color,
                    compare_count=0
                )
                plot_bump_camber(
                    self.bump_camber_widget.get_axes_left(),
                    self.bump_camber_widget.get_axes_right(),
                    self.calculator,
                    fit_range=self.fit_range,
                    curve_color=self.curve_color,
                    fit_color=self.fit_color,
                    compare_count=0
                )
                plot_wheel_rate(
                    self.wheel_rate_widget.get_axes_left(),
                    self.wheel_rate_widget.get_axes_right(),
                    self.calculator,
                    curve_color=self.curve_color,
                    fit_color=self.fit_color,
                    compare_count=0
                )
                plot_wheel_recession(
                    self.wheel_recession_widget.get_axes_left(),
                    self.wheel_recession_widget.get_axes_right(),
                    self.calculator,
                    curve_color=self.curve_color,
                    fit_color=self.fit_color,
                    compare_count=0
                )
                plot_track_change(
                    self.track_change_widget.get_axes_left(),
                    self.track_change_widget.get_axes_right(),
                    self.calculator,
                    curve_color=self.curve_color,
                    fit_color=self.fit_color,
                    compare_count=0
                )
            except Exception as e:
                logger.error(f"图表更新失败: {e}", exc_info=True)
        else:
            # 显示所有历史记录（多套结果对比）
            try:
                for idx, result_entry in enumerate(self.results_history):
                    calculator = result_entry['calculator']
                    curve_color = result_entry.get('curve_color', self.color_palette[idx % len(self.color_palette)])
                    fit_color = result_entry.get('fit_color', self.fit_color)
                    
                    # 为每套结果使用不同的颜色
                    plot_bump_steer(
                        self.bump_steer_widget.get_axes_left(),
                        self.bump_steer_widget.get_axes_right(),
                        calculator,
                        fit_range=self.fit_range,
                        curve_color=curve_color,
                        fit_color=fit_color,
                        compare_count=idx
                    )
                    plot_bump_camber(
                        self.bump_camber_widget.get_axes_left(),
                        self.bump_camber_widget.get_axes_right(),
                        calculator,
                        fit_range=self.fit_range,
                        curve_color=curve_color,
                        fit_color=fit_color,
                        compare_count=idx
                    )
                    plot_wheel_rate(
                        self.wheel_rate_widget.get_axes_left(),
                        self.wheel_rate_widget.get_axes_right(),
                        calculator,
                        curve_color=curve_color,
                        fit_color=fit_color,
                        compare_count=idx
                    )
                    plot_wheel_recession(
                        self.wheel_recession_widget.get_axes_left(),
                        self.wheel_recession_widget.get_axes_right(),
                        calculator,
                        curve_color=curve_color,
                        fit_color=fit_color,
                        compare_count=idx
                    )
                    plot_track_change(
                        self.track_change_widget.get_axes_left(),
                        self.track_change_widget.get_axes_right(),
                        calculator,
                        curve_color=curve_color,
                        fit_color=fit_color,
                        compare_count=idx
                    )
            except Exception as e:
                logger.error(f"多套结果对比显示失败: {e}", exc_info=True)
        
        # 刷新所有图表
        self.bump_steer_widget.draw()
        self.bump_camber_widget.draw()
        self.wheel_rate_widget.draw()
        self.wheel_recession_widget.draw()
        self.track_change_widget.draw()
    
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
        main_layout.setContentsMargins(12, 12, 12, 12)
        main_layout.setSpacing(12)
        
        # 文件选择
        self.setup_file_selection(main_layout)
        
        # 拟合范围设置 - 使用漂亮的滑块
        fit_group = QGroupBox("Fit Range")
        fit_layout = QVBoxLayout()
        fit_layout.addWidget(QLabel("Range (deg):"))
        self.fit_range_slider, self.fit_range_label, slider_container = self.create_fit_range_slider(
            min_val=0.1, max_val=5.0, default_val=1.0, step=0.1, unit="deg", is_int=False
        )
        fit_layout.addLayout(slider_container)
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
            value_label.setStyleSheet("""
                font-weight: 600;
                font-size: 13px;
                color: #1e293b;
                padding: 4px 8px;
                background-color: #f8fafc;
                border-radius: 6px;
            """)
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
        
        # 使用公共方法设置控制按钮
        self.setup_control_buttons(main_layout)
        
        # 参考车辆选择区域（右侧）
        self.setup_reference_vehicles(main_layout)
        
        # 全局控制
        self.setup_global_controls(main_layout)
        
        self.setLayout(main_layout)
    
    def _on_fit_range_changed(self, value: float):
        """拟合范围改变 - 自动更新结果和图表"""
        self.fit_range = value
        if self.calculator:
            # 同时更新结果和图表
            self.process_data()
            self.update_plots()
    
    def process_data(self) -> Optional[Dict[str, Any]]:
        """处理数据"""
        if not self.calculator:
            return None
        
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
            self.result_labels['roll_rate_susp'].setText(f"{roll_rate_result['susp_roll_rate']:.2f}")
            self.result_labels['roll_rate_total'].setText(f"{roll_rate_result['total_roll_rate']:.2f}")
            
            # 计算Roll Center Height
            rch_result = self.calculator.calculate_roll_center_height()
            self.result_labels['roll_center_height'].setText(f"{rch_result['roll_center_height']:.2f}")
            
            # 返回结果数据
            return {
                'roll_steer': roll_steer_result,
                'roll_camber': roll_camber_result,
                'roll_rate': roll_rate_result,
                'roll_center_height': rch_result,
            }
            
        except Exception as e:
            QMessageBox.critical(self, "Error", f"Failed to process data:\n{str(e)}")
            logger.error(f"数据处理失败: {e}", exc_info=True)
            return None
    
    def update_plots(self):
        """更新图表，支持多套结果对比"""
        # 清空所有图表
        self.roll_steer_widget.clear()
        self.roll_camber_widget.clear()
        self.roll_camber_ground_widget.clear()
        self.roll_rate_widget.clear()
        self.roll_center_height_widget.clear()
        
        # 如果没有历史记录，只显示当前结果
        if not self.results_history and self.calculator:
            try:
                plot_roll_steer(
                    self.roll_steer_widget.get_axes_left(),
                    self.roll_steer_widget.get_axes_right(),
                    self.calculator,
                    fit_range=self.fit_range,
                    curve_color=self.curve_color,
                    fit_color=self.fit_color,
                    compare_count=0
                )
                plot_roll_camber(
                    self.roll_camber_widget.get_axes_left(),
                    self.roll_camber_widget.get_axes_right(),
                    self.calculator,
                    fit_range=self.fit_range,
                    curve_color=self.curve_color,
                    fit_color=self.fit_color,
                    compare_count=0
                )
                plot_roll_camber_relative_ground(
                    self.roll_camber_ground_widget.get_axes_left(),
                    self.roll_camber_ground_widget.get_axes_right(),
                    self.calculator,
                    fit_range=self.fit_range,
                    curve_color=self.curve_color,
                    fit_color=self.fit_color,
                    compare_count=0
                )
                plot_roll_rate(
                    self.roll_rate_widget.get_axes(),
                    self.calculator,
                    curve_color=self.curve_color
                )
                plot_roll_center_height(
                    self.roll_center_height_widget.get_axes(),
                    self.calculator,
                    curve_color=self.curve_color
                )
            except Exception as e:
                logger.error(f"图表更新失败: {e}", exc_info=True)
        else:
            # 显示所有历史记录（多套结果对比）
            try:
                for idx, result_entry in enumerate(self.results_history):
                    calculator = result_entry['calculator']
                    curve_color = result_entry.get('curve_color', self.color_palette[idx % len(self.color_palette)])
                    fit_color = result_entry.get('fit_color', self.fit_color)
                    
                    plot_roll_steer(
                        self.roll_steer_widget.get_axes_left(),
                        self.roll_steer_widget.get_axes_right(),
                        calculator,
                        fit_range=self.fit_range,
                        curve_color=curve_color,
                        fit_color=fit_color,
                        compare_count=idx
                    )
                    plot_roll_camber(
                        self.roll_camber_widget.get_axes_left(),
                        self.roll_camber_widget.get_axes_right(),
                        calculator,
                        fit_range=self.fit_range,
                        curve_color=curve_color,
                        fit_color=fit_color,
                        compare_count=idx
                    )
                    plot_roll_camber_relative_ground(
                        self.roll_camber_ground_widget.get_axes_left(),
                        self.roll_camber_ground_widget.get_axes_right(),
                        calculator,
                        fit_range=self.fit_range,
                        curve_color=curve_color,
                        fit_color=fit_color,
                        compare_count=idx
                    )
                    plot_roll_rate(
                        self.roll_rate_widget.get_axes(),
                        calculator,
                        curve_color=curve_color
                    )
                    plot_roll_center_height(
                        self.roll_center_height_widget.get_axes(),
                        calculator,
                        curve_color=curve_color
                    )
            except Exception as e:
                logger.error(f"多套结果对比显示失败: {e}", exc_info=True)
        
        # 刷新所有图表
        self.roll_steer_widget.draw()
        self.roll_camber_widget.draw()
        self.roll_camber_ground_widget.draw()
        self.roll_rate_widget.draw()
        self.roll_center_height_widget.draw()
    
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
        """设置UI界面 - 优化为左右分栏布局"""
        # 主布局：顶部文件选择，下方左右分栏
        main_layout = QVBoxLayout()
        main_layout.setContentsMargins(12, 12, 12, 12)
        main_layout.setSpacing(12)
        
        # 文件选择（顶部）
        self.setup_file_selection(main_layout)
        
        # 创建左右分栏布局
        content_layout = QHBoxLayout()
        content_layout.setSpacing(12)
        
        # 左侧面板：参数和结果（固定宽度）
        left_panel = QWidget()
        left_panel.setMaximumWidth(380)
        left_panel.setMinimumWidth(350)
        left_layout = QVBoxLayout()
        left_layout.setContentsMargins(0, 0, 0, 0)
        left_layout.setSpacing(12)
        
        # 拟合范围设置 - 使用漂亮的滑块
        fit_group = QGroupBox("Fit Range")
        fit_layout = QVBoxLayout()
        fit_layout.addWidget(QLabel("Range (kN):"))
        self.fit_range_slider, self.fit_range_label, slider_container = self.create_fit_range_slider(
            min_val=0.1, max_val=10.0, default_val=1.0, step=0.1, unit="kN", is_int=False
        )
        fit_layout.addLayout(slider_container)
        fit_group.setLayout(fit_layout)
        left_layout.addWidget(fit_group)
        
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
            value_label.setStyleSheet("""
                font-weight: 600;
                font-size: 13px;
                color: #1e293b;
                padding: 4px 8px;
                background-color: #f8fafc;
                border-radius: 6px;
            """)
            self.result_labels[key] = value_label
            results_layout.addWidget(value_label, row, 1)
            row += 1
        
        results_group.setLayout(results_layout)
        left_layout.addWidget(results_group)
        
        # 控制按钮
        controls_layout = QHBoxLayout()
        clear_btn = QPushButton("Clear Axes")
        clear_btn.clicked.connect(self.clear_all_plots)
        controls_layout.addWidget(clear_btn)
        left_layout.addLayout(controls_layout)
        
        # 全局控制
        self.setup_global_controls(left_layout)
        
        left_layout.addStretch()
        left_panel.setLayout(left_layout)
        content_layout.addWidget(left_panel)
        
        # 右侧面板：图表（占据剩余空间）
        right_panel = QWidget()
        right_layout = QVBoxLayout()
        right_layout.setContentsMargins(0, 0, 0, 0)
        right_layout.setSpacing(12)
        
        # 图表Tab组
        self.plot_tabs = QTabWidget()
        
        # Lateral Toe Compliance图表
        self.lateral_toe_widget = ComparisonPlotWidget()
        self.plot_tabs.addTab(self.lateral_toe_widget, "Lateral Toe Compliance")
        
        # Lateral Camber Compliance图表
        self.lateral_camber_widget = ComparisonPlotWidget()
        self.plot_tabs.addTab(self.lateral_camber_widget, "Lateral Camber Compliance")
        
        right_layout.addWidget(self.plot_tabs)
        right_panel.setLayout(right_layout)
        content_layout.addWidget(right_panel, 1)  # 占据剩余空间
        
        main_layout.addLayout(content_layout, 1)
        self.setLayout(main_layout)
    
    def _on_fit_range_changed(self, value: float):
        """拟合范围改变 - 自动更新结果和图表"""
        self.fit_range = value
        if self.calculator:
            # 同时更新结果和图表
            self.process_data()
            self.update_plots()
    
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
        """设置UI界面 - 优化为左右分栏布局"""
        # 主布局：顶部文件选择，下方左右分栏
        main_layout = QVBoxLayout()
        main_layout.setContentsMargins(12, 12, 12, 12)
        main_layout.setSpacing(12)
        
        # 文件选择（顶部）
        self.setup_file_selection(main_layout)
        
        # 创建左右分栏布局
        content_layout = QHBoxLayout()
        content_layout.setSpacing(12)
        
        # 左侧面板：参数和结果（固定宽度）
        left_panel = QWidget()
        left_panel.setMaximumWidth(380)
        left_panel.setMinimumWidth(350)
        left_layout = QVBoxLayout()
        left_layout.setContentsMargins(0, 0, 0, 0)
        left_layout.setSpacing(12)
        
        # 拟合范围设置 - 使用漂亮的滑块
        fit_group = QGroupBox("Fit Range")
        fit_layout = QVBoxLayout()
        fit_layout.addWidget(QLabel("Range (kN):"))
        self.fit_range_slider, self.fit_range_label, slider_container = self.create_fit_range_slider(
            min_val=0.1, max_val=10.0, default_val=1.0, step=0.1, unit="kN", is_int=False
        )
        fit_layout.addLayout(slider_container)
        fit_group.setLayout(fit_layout)
        left_layout.addWidget(fit_group)
        
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
            value_label.setStyleSheet("""
                font-weight: 600;
                font-size: 13px;
                color: #1e293b;
                padding: 4px 8px;
                background-color: #f8fafc;
                border-radius: 6px;
            """)
            self.result_labels[key] = value_label
            results_layout.addWidget(value_label, row, 1)
            row += 1
        
        results_group.setLayout(results_layout)
        left_layout.addWidget(results_group)
        
        # 控制按钮
        controls_layout = QHBoxLayout()
        clear_btn = QPushButton("Clear Axes")
        clear_btn.clicked.connect(self.clear_all_plots)
        controls_layout.addWidget(clear_btn)
        left_layout.addLayout(controls_layout)
        
        # 全局控制
        self.setup_global_controls(left_layout)
        
        left_layout.addStretch()
        left_panel.setLayout(left_layout)
        content_layout.addWidget(left_panel)
        
        # 右侧面板：图表（占据剩余空间）
        right_panel = QWidget()
        right_layout = QVBoxLayout()
        right_layout.setContentsMargins(0, 0, 0, 0)
        right_layout.setSpacing(12)
        
        # 图表Tab组
        self.plot_tabs = QTabWidget()
        
        # Braking Toe Compliance图表
        self.braking_toe_widget = ComparisonPlotWidget()
        self.plot_tabs.addTab(self.braking_toe_widget, "Braking Toe Compliance")
        
        right_layout.addWidget(self.plot_tabs)
        right_panel.setLayout(right_layout)
        content_layout.addWidget(right_panel, 1)  # 占据剩余空间
        
        main_layout.addLayout(content_layout, 1)
        self.setLayout(main_layout)
    
    def _on_fit_range_changed(self, value: float):
        """拟合范围改变 - 自动更新结果和图表"""
        self.fit_range = value
        if self.calculator:
            # 同时更新结果和图表
            self.process_data()
            self.update_plots()
    
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
        """设置UI界面 - 优化为左右分栏布局"""
        # 主布局：顶部文件选择，下方左右分栏
        main_layout = QVBoxLayout()
        main_layout.setContentsMargins(12, 12, 12, 12)
        main_layout.setSpacing(12)
        
        # 文件选择（顶部）
        self.setup_file_selection(main_layout)
        
        # 创建左右分栏布局
        content_layout = QHBoxLayout()
        content_layout.setSpacing(12)
        
        # 左侧面板：参数和结果（固定宽度）
        left_panel = QWidget()
        left_panel.setMaximumWidth(380)
        left_panel.setMinimumWidth(350)
        left_layout = QVBoxLayout()
        left_layout.setContentsMargins(0, 0, 0, 0)
        left_layout.setSpacing(12)
        
        # 拟合范围设置 - 使用漂亮的滑块
        fit_group = QGroupBox("Fit Range")
        fit_layout = QVBoxLayout()
        fit_layout.addWidget(QLabel("Range (kN):"))
        self.fit_range_slider, self.fit_range_label, slider_container = self.create_fit_range_slider(
            min_val=0.1, max_val=10.0, default_val=1.0, step=0.1, unit="kN", is_int=False
        )
        fit_layout.addLayout(slider_container)
        fit_group.setLayout(fit_layout)
        left_layout.addWidget(fit_group)
        
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
            value_label.setStyleSheet("""
                font-weight: 600;
                font-size: 13px;
                color: #1e293b;
                padding: 4px 8px;
                background-color: #f8fafc;
                border-radius: 6px;
            """)
            self.result_labels[key] = value_label
            results_layout.addWidget(value_label, row, 1)
            row += 1
        
        results_group.setLayout(results_layout)
        left_layout.addWidget(results_group)
        
        # 控制按钮
        controls_layout = QHBoxLayout()
        clear_btn = QPushButton("Clear Axes")
        clear_btn.clicked.connect(self.clear_all_plots)
        controls_layout.addWidget(clear_btn)
        left_layout.addLayout(controls_layout)
        
        # 全局控制
        self.setup_global_controls(left_layout)
        
        left_layout.addStretch()
        left_panel.setLayout(left_layout)
        content_layout.addWidget(left_panel)
        
        # 右侧面板：图表（占据剩余空间）
        right_panel = QWidget()
        right_layout = QVBoxLayout()
        right_layout.setContentsMargins(0, 0, 0, 0)
        right_layout.setSpacing(12)
        
        # 图表Tab组
        self.plot_tabs = QTabWidget()
        
        # Acceleration Toe Compliance图表
        self.acceleration_toe_widget = ComparisonPlotWidget()
        self.plot_tabs.addTab(self.acceleration_toe_widget, "Acceleration Toe Compliance")
        
        right_layout.addWidget(self.plot_tabs)
        right_panel.setLayout(right_layout)
        content_layout.addWidget(right_panel, 1)  # 占据剩余空间
        
        main_layout.addLayout(content_layout, 1)
        self.setLayout(main_layout)
    
    def _on_fit_range_changed(self, value: float):
        """拟合范围改变 - 自动更新结果和图表"""
        self.fit_range = value
        if self.calculator:
            # 同时更新结果和图表
            self.process_data()
            self.update_plots()
    
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
