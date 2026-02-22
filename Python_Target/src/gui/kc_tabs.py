"""K&C分析Tab模块

提供各种K&C测试工况的Tab界面，包括Bump、Roll、Static Load等。
"""

from typing import Optional, Dict, Any
from pathlib import Path
from PyQt6.QtWidgets import (QWidget, QVBoxLayout, QHBoxLayout, QLabel, 
                            QPushButton, QLineEdit, QTabWidget, QGroupBox,
                            QGridLayout, QDoubleSpinBox, QSpinBox, QColorDialog,
                            QMessageBox, QFileDialog, QTextEdit, QScrollArea,
                            QProgressDialog, QButtonGroup, QSlider, QComboBox, QCheckBox, QSizePolicy)
from PyQt6.QtCore import Qt, pyqtSignal, QThread, pyqtSlot
from PyQt6.QtGui import QFont, QColor, QPixmap

from .plot_widgets import ComparisonPlotWidget, MatplotlibWidget
from ..data import ResParser, DataExtractor, KCCalculator
from ..plot import (
    plot_bump_steer, plot_bump_camber, plot_wheel_rate,
    plot_wheel_recession, plot_track_change,
    plot_bump_caster, plot_bump_side_swing_arm_angle,
    plot_bump_side_swing_arm_length, plot_bump_wheel_load,
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
        self.curve_color = '#000000'  # 默认黑色（主文件载入后）
        self.fit_color = '#ff0000'    # 默认红色（拟合线）
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
        file_layout.setSpacing(12)
        
        self.file_path_edit = QLineEdit()
        self.file_path_edit.setPlaceholderText("Select .res file...")
        self.file_path_edit.setReadOnly(True)
        self.file_path_edit.setMinimumHeight(24)
        self.file_path_edit.setMaximumHeight(28)
        
        browse_btn = QPushButton("Browse...")
        browse_btn.clicked.connect(self._browse_file)
        browse_btn.setStyleSheet("""
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
                min-width: 70px;
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
                padding: 4px 16px;
                border-radius: 6px;
                font-weight: 700;
                font-size: 11px;
                min-width: 60px;
                min-height: 24px;
                max-height: 28px;
            }
            QPushButton:hover {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 #34d399, stop:1 #10b981);
            }
            QPushButton:pressed {
                background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                    stop:0 #059669, stop:1 #047857);
            }
        """)
        go_btn.clicked.connect(self._load_and_process_file)
        
        file_label = QLabel("File:")
        file_label.setMinimumWidth(50)
        file_label.setStyleSheet("color: #475569; font-weight: 500; padding: 4px 0px;")
        file_layout.addWidget(file_label)
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
        value_label.setMinimumWidth(90)
        value_label.setMinimumHeight(24)
        value_label.setMaximumHeight(28)
        value_label.setAlignment(Qt.AlignmentFlag.AlignCenter)
        value_label.setStyleSheet("""
            QLabel {
                background-color: #f8fafc;
                border: 1px solid #e2e8f0;
                border-radius: 6px;
                padding: 4px 10px;
                font-weight: 600;
                font-size: 11px;
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
    
    def setup_collapsible_results_panel(self, layout: QVBoxLayout, result_fields: list, default_visible: int = 6):
        """设置可折叠的结果面板
        
        Args:
            layout: 父布局对象
            result_fields: 结果字段列表，格式为 [(key, label), ...]
            default_visible: 默认显示的结果项数量，默认6个
        """
        results_group = QGroupBox("Results")
        results_layout = QVBoxLayout()
        results_layout.setSpacing(10)
        results_layout.setContentsMargins(12, 16, 12, 12)
        
        # 创建网格布局用于结果项
        grid_layout = QGridLayout()
        grid_layout.setSpacing(10)
        grid_layout.setColumnStretch(0, 0)
        grid_layout.setColumnStretch(1, 1)
        
        self.result_labels = {}
        self.result_rows = []  # 存储每个结果项的行容器，用于控制显示/隐藏
        
        row = 0
        for key, label in result_fields:
            # 创建结果项容器（用于控制显示/隐藏）
            result_row_container = QWidget()
            result_row_layout = QGridLayout()
            result_row_layout.setContentsMargins(0, 0, 0, 0)
            result_row_layout.setSpacing(10)
            result_row_layout.setColumnStretch(0, 0)
            result_row_layout.setColumnStretch(1, 1)
            
            result_label = QLabel(f"{label}:")
            result_label.setStyleSheet("color: #475569; font-weight: 500; padding: 4px 0px;")
            result_row_layout.addWidget(result_label, 0, 0)
            
            value_label = QLabel("--")
            value_label.setStyleSheet("""
                font-weight: 600;
                font-size: 11px;
                color: #1e293b;
                padding: 4px 10px;
                background-color: #f8fafc;
                border-radius: 6px;
                min-height: 24px;
                max-height: 28px;
            """)
            self.result_labels[key] = value_label
            result_row_layout.addWidget(value_label, 0, 1)
            
            result_row_container.setLayout(result_row_layout)
            grid_layout.addWidget(result_row_container, row, 0, 1, 2)
            
            # 默认只显示前 default_visible 个
            if row >= default_visible:
                result_row_container.setVisible(False)
            
            self.result_rows.append(result_row_container)
            row += 1
        
        results_layout.addLayout(grid_layout)
        
        # 如果有超过默认显示数量的结果项，添加展开/折叠按钮
        if len(result_fields) > default_visible:
            # 展开/折叠按钮容器 - 细长按钮，宽度与panel一致，高度很小
            expand_container = QWidget()
            expand_layout = QHBoxLayout()
            expand_layout.setContentsMargins(0, 0, 0, 0)
            expand_layout.setSpacing(0)
            
            self.expand_results_btn = QPushButton("▼")
            self.expand_results_btn.setCheckable(False)
            # 设置按钮为细长形状：高度很小（16px），宽度自动填充
            self.expand_results_btn.setFixedHeight(16)
            self.expand_results_btn.setSizePolicy(QSizePolicy.Policy.Expanding, QSizePolicy.Policy.Fixed)
            self.expand_results_btn.setStyleSheet("""
                QPushButton {
                    background-color: #f1f5f9;
                    border: 1px solid #cbd5e1;
                    border-radius: 2px;
                    color: #475569;
                    font-size: 8px;
                    font-weight: 600;
                    padding: 0px;
                }
                QPushButton:hover {
                    background-color: #e2e8f0;
                    border-color: #94a3b8;
                }
                QPushButton:pressed {
                    background-color: #cbd5e1;
                }
            """)
            
            # 使用 lambda 时，需要捕获 default_visible 的值
            def make_toggle_handler(dv):
                return lambda: self._toggle_results_expansion(dv)
            self.expand_results_btn.clicked.connect(make_toggle_handler(default_visible))
            expand_layout.addWidget(self.expand_results_btn)
            expand_container.setLayout(expand_layout)
            results_layout.addWidget(expand_container)
        else:
            self.expand_results_btn = None
        
        results_group.setLayout(results_layout)
        layout.addWidget(results_group)
    
    def _toggle_results_expansion(self, default_visible: int):
        """切换结果面板的展开/折叠状态"""
        if not hasattr(self, 'result_rows') or not self.result_rows:
            return
        
        # 检查当前状态：如果第 default_visible 个（索引从0开始）是隐藏的，则展开；否则折叠
        is_expanded = self.result_rows[default_visible].isVisible() if default_visible < len(self.result_rows) else False
        
        if is_expanded:
            # 折叠：隐藏第 default_visible 个及之后的所有结果项
            for i in range(default_visible, len(self.result_rows)):
                self.result_rows[i].setVisible(False)
            if self.expand_results_btn:
                self.expand_results_btn.setText("▼")
        else:
            # 展开：显示所有结果项
            for i in range(default_visible, len(self.result_rows)):
                self.result_rows[i].setVisible(True)
            if self.expand_results_btn:
                self.expand_results_btn.setText("▲")
    
    def setup_comparison_files(self, layout: QVBoxLayout):
        """设置多文件导入比较功能
        
        Args:
            layout: 布局对象
        """
        compare_group = QGroupBox("Compare Results")
        compare_layout = QVBoxLayout()
        compare_layout.setSpacing(10)
        
        # 存储比较文件的控件
        self.compare_file_widgets = []
        
        # 定义不同比较结果的线形和标记样式
        self.compare_styles = [
            {'linestyle': '--', 'marker': 's'},  # 虚线 + 空心方形
            {'linestyle': '-.', 'marker': '^'},  # 点划线 + 空心三角形
            {'linestyle': ':', 'marker': 'D'},   # 点线 + 空心菱形
        ]
        
        # 创建三个文件选择行
        for i in range(3):
            row_layout = QHBoxLayout()
            row_layout.setSpacing(8)
            
            # 复选框
            checkbox = QCheckBox()
            checkbox.setChecked(False)
            # 使用lambda捕获正确的索引
            def make_checkbox_handler(idx):
                return lambda state: self._on_compare_checkbox_changed(idx, state)
            checkbox.stateChanged.connect(make_checkbox_handler(i))
            row_layout.addWidget(checkbox)
            
            # 文件路径输入框
            file_edit = QLineEdit()
            file_edit.setPlaceholderText(f"Select comparison file {i+1}...")
            file_edit.setReadOnly(True)
            file_edit.setMinimumHeight(24)
            file_edit.setMaximumHeight(28)
            file_edit.setEnabled(False)
            row_layout.addWidget(file_edit, 1)
            
            # 浏览按钮
            browse_btn = QPushButton("Browse...")
            browse_btn.setEnabled(False)
            def make_browse_handler(idx):
                return lambda checked: self._browse_compare_file(idx)
            browse_btn.clicked.connect(make_browse_handler(i))
            browse_btn.setStyleSheet("""
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
                    min-width: 70px;
                }
                QPushButton:hover:enabled {
                    background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                        stop:0 #e2e8f0, stop:1 #cbd5e1);
                    border-color: #94a3b8;
                }
                QPushButton:pressed:enabled {
                    background: #cbd5e1;
                }
                QPushButton:disabled {
                    background-color: #f1f5f9;
                    color: #94a3b8;
                    border-color: #e2e8f0;
                }
            """)
            row_layout.addWidget(browse_btn)
            
            # 加号按钮
            add_btn = QPushButton("+")
            add_btn.setEnabled(False)
            def make_add_handler(idx):
                return lambda checked: self._add_compare_result(idx)
            add_btn.clicked.connect(make_add_handler(i))
            add_btn.setStyleSheet("""
                QPushButton {
                    background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                        stop:0 #10b981, stop:1 #059669);
                    color: white;
                    border: none;
                    padding: 4px 12px;
                    border-radius: 6px;
                    font-weight: 700;
                    font-size: 14px;
                    min-height: 24px;
                    max-height: 28px;
                    min-width: 32px;
                    max-width: 32px;
                }
                QPushButton:hover:enabled {
                    background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                        stop:0 #34d399, stop:1 #10b981);
                }
                QPushButton:pressed:enabled {
                    background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
                        stop:0 #059669, stop:1 #047857);
                }
                QPushButton:disabled {
                    background-color: #cbd5e1;
                    color: #94a3b8;
                }
            """)
            row_layout.addWidget(add_btn)
            
            # 存储控件引用
            self.compare_file_widgets.append({
                'checkbox': checkbox,
                'file_edit': file_edit,
                'browse_btn': browse_btn,
                'add_btn': add_btn,
                'file_path': None,
                'loaded': False
            })
            
            compare_layout.addLayout(row_layout)
        
        compare_group.setLayout(compare_layout)
        layout.addWidget(compare_group)
    
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
            from ..utils.error_handler import ErrorHandler
            ErrorHandler.show_warning(self, "错误", "请选择一个有效的.res文件！", language='zh')
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
            
        except FileNotFoundError as e:
            from ..utils.error_handler import ErrorHandler
            ErrorHandler.handle_exception(self, e, context=f"加载文件: {file_path}", language='zh')
        except PermissionError as e:
            from ..utils.error_handler import ErrorHandler
            ErrorHandler.handle_exception(self, e, context=f"访问文件: {file_path}", language='zh')
        except Exception as e:
            from ..utils.error_handler import ErrorHandler
            ErrorHandler.handle_exception(self, e, context=f"处理文件: {file_path}", language='zh')
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
    
    def _on_compare_checkbox_changed(self, index: int, state: int):
        """比较文件复选框状态改变"""
        widget = self.compare_file_widgets[index]
        enabled = (state == Qt.CheckState.Checked.value)
        widget['file_edit'].setEnabled(enabled)
        widget['browse_btn'].setEnabled(enabled)
        widget['add_btn'].setEnabled(enabled and widget['file_path'] is not None)
    
    def _browse_compare_file(self, index: int):
        """浏览比较文件"""
        file_path, _ = QFileDialog.getOpenFileName(
            self, f"Select comparison file {index+1}", "", "RES Files (*.res);;All Files (*)")
        if file_path:
            widget = self.compare_file_widgets[index]
            widget['file_path'] = file_path
            widget['file_edit'].setText(file_path)
            widget['add_btn'].setEnabled(True)
    
    def _add_compare_result(self, index: int):
        """添加比较结果到图表"""
        widget = self.compare_file_widgets[index]
        file_path = widget['file_path']
        
        if not file_path or not Path(file_path).exists():
            from ..utils.error_handler import ErrorHandler
            ErrorHandler.show_warning(self, "错误", "请选择一个有效的.res文件！", language='zh')
            return
        
        # 创建进度对话框
        progress = QProgressDialog(f"Loading comparison file {index+1}...", "Cancel", 0, 0, self)
        progress.setWindowModality(Qt.WindowModality.WindowModal)
        progress.setMinimumDuration(0)
        progress.setValue(0)
        progress.show()
        
        try:
            self.setCursor(Qt.CursorShape.WaitCursor)
            progress.setLabelText("Parsing file...")
            
            # 解析文件
            parser = ResParser(file_path)
            parser.parse()
            
            progress.setLabelText("Creating data extractor...")
            # 创建提取器和计算器
            extractor = DataExtractor(parser)
            vehicle_params = self.get_vehicle_params()
            calculator = KCCalculator(extractor, vehicle_params)
            
            progress.setLabelText("Processing data...")
            
            # 处理数据（需要子类实现process_data_for_comparison方法）
            result_data = self.process_data_for_comparison(calculator)
            
            # 存储比较结果
            widget['parser'] = parser
            widget['extractor'] = extractor
            widget['calculator'] = calculator
            widget['result_data'] = result_data
            widget['loaded'] = True
            
            # 更新图表
            self.update_plots()
            
            progress.setLabelText("Complete!")
            self.status_message.emit(f"Comparison file {index+1} loaded: {Path(file_path).name}", 3000)
            
        except Exception as e:
            from ..utils.error_handler import ErrorHandler
            ErrorHandler.handle_exception(self, e, context=f"加载对比文件: {file_path}", language='zh')
        finally:
            progress.close()
            self.setCursor(Qt.CursorShape.ArrowCursor)
    
    def process_data_for_comparison(self, calculator: KCCalculator) -> Optional[Dict[str, Any]]:
        """处理比较数据（子类需要重写）
        
        Args:
            calculator: K&C计算器
            
        Returns:
            处理后的结果数据字典
        """
        # 默认实现：调用process_data，但使用传入的calculator
        # 子类应该重写此方法以处理特定类型的测试数据
        return None
    
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
        """设置参考车辆选择下拉菜单（公共方法）
        
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
        
        # 使用水平布局，让"Ref. Vehicle"标签和下拉菜单左右排列
        ref_layout = QHBoxLayout()
        
        # 创建"Ref. Vehicle"标签
        ref_label = QLabel("Ref. Vehicle:")
        ref_label.setStyleSheet("""
            QLabel {
                color: #475569;
                font-weight: 500;
                font-size: 11px;
            }
        """)
        ref_layout.addWidget(ref_label)
        
        # 创建下拉菜单
        if not hasattr(self, 'ref_vehicle_combo'):
            self.ref_vehicle_combo = QComboBox()
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
                    font-size: 11px;
                    min-width: 90px;
                    max-width: 110px;
                    min-height: 22px;
                    max-height: 24px;
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
                    width: 20px;
                }
                QComboBox::down-arrow {
                    image: none;
                    border-left: 4px solid transparent;
                    border-right: 4px solid transparent;
                    border-top: 5px solid #64748b;
                    width: 0;
                    height: 0;
                    margin-right: 6px;
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
                    padding: 4px 8px;
                    border-radius: 4px;
                    min-height: 18px;
                    font-size: 11px;
                }
                QComboBox QAbstractItemView::item:hover {
                    background-color: #f1f5f9;
                }
                QComboBox QAbstractItemView::item:selected {
                    background-color: #6366f1;
                    color: white;
                }
            """)
            self.ref_vehicle_combo.currentTextChanged.connect(self._on_ref_vehicle_selected)
        
        ref_layout.addWidget(self.ref_vehicle_combo)
        ref_layout.addStretch()  # 添加弹性空间
        layout.addLayout(ref_layout)
    
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
                padding: 4px 12px;
                border-radius: 6px;
                font-weight: 600;
                font-size: 11px;
                min-height: 24px;
                max-height: 28px;
                min-width: 80px;
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
                padding: 4px 12px;
                border-radius: 6px;
                font-weight: 600;
                font-size: 11px;
                min-height: 24px;
                max-height: 28px;
                min-width: 100px;
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
                padding: 4px 12px;
                border-radius: 6px;
                font-weight: 600;
                font-size: 11px;
                min-height: 24px;
                max-height: 28px;
                min-width: 90px;
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
                padding: 4px 12px;
                border-radius: 6px;
                font-weight: 600;
                font-size: 11px;
                min-height: 24px;
                max-height: 28px;
                min-width: 100px;
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
        if vehicle:  # 只有当选择了有效车辆时才记录
            logger.info(f"参考车辆选择: {vehicle} (功能未实现)")
            # TODO: 实现参考车辆数据加载和对比功能
    
    def _on_positive_direction(self):
        """Positive Direction按钮回调（功能未实现，但UI存在）"""
        from ..utils.error_handler import ErrorHandler
        ErrorHandler.show_info(self, "提示", "Positive Direction功能尚未实现")
        logger.info("Positive Direction按钮点击（功能未实现）")
    
    def _on_custom_plot(self):
        """自定义绘图按钮回调（功能未实现，但UI存在）"""
        from ..utils.error_handler import ErrorHandler
        ErrorHandler.show_info(self, "提示", "Custom Plot功能尚未实现")
        logger.info("Custom Plot按钮点击（功能未实现）")
    
    def _on_export_ppt(self):
        """导出PPT按钮回调（功能未实现，但UI存在）"""
        from ..utils.error_handler import ErrorHandler
        ErrorHandler.show_info(self, "提示", "Export to PPT功能尚未实现")
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
        # 主布局 - 左右两部分
        main_layout = QHBoxLayout()
        main_layout.setContentsMargins(24, 24, 24, 24)
        main_layout.setSpacing(20)
        
        # 左侧：README 内容
        left_widget = QWidget()
        left_layout = QVBoxLayout()
        left_layout.setContentsMargins(0, 0, 0, 0)
        left_layout.setSpacing(0)
        
        # 读取 README 文件
        readme_content = self._load_readme()
        
        # README 文本显示 - Monokai 样式
        readme_text = QTextEdit()
        readme_text.setReadOnly(True)
        readme_text.setStyleSheet("""
            QTextEdit {
                background-color: #272822;
                border: 2px solid #49483e;
                border-radius: 12px;
                padding: 16px;
                font-size: 11px;
                line-height: 1.6;
                color: #F8F8F2;
                font-family: 'Consolas', 'Monaco', 'Courier New', monospace;
            }
        """)
        # 尝试使用 setMarkdown（PyQt6 支持），否则使用 HTML 转换
        try:
            readme_text.setMarkdown(readme_content)
            # 为 Markdown 渲染添加 Monokai 样式
            readme_text.document().setDefaultStyleSheet(self._get_monokai_css())
        except AttributeError:
            # 如果不支持 setMarkdown，使用 HTML 转换
            readme_html = self._markdown_to_html(readme_content)
            readme_text.setHtml(readme_html)
        
        left_layout.addWidget(readme_text)
        left_widget.setLayout(left_layout)
        
        # 右侧：图片和作者信息
        right_widget = QWidget()
        right_layout = QVBoxLayout()
        right_layout.setContentsMargins(0, 0, 0, 0)
        right_layout.setSpacing(20)
        
        # 获取资源路径
        try:
            from pathlib import Path
            resources_dir = Path(__file__).parent.parent.parent.parent / "Resources"
            
            # 猴子图片
            monkey_image_path = resources_dir / "images" / "pngtree-monkey-gangster-head-vector-illustration-png-image_3020168.jpg"
            if monkey_image_path.exists():
                monkey_image = QLabel()
                pixmap = QPixmap(str(monkey_image_path))
                # 缩放图片到合适大小（保持宽高比，最大宽度300px）
                scaled_pixmap = pixmap.scaled(300, 300, Qt.AspectRatioMode.KeepAspectRatio, Qt.TransformationMode.SmoothTransformation)
                monkey_image.setPixmap(scaled_pixmap)
                monkey_image.setAlignment(Qt.AlignmentFlag.AlignCenter)
                monkey_image.setStyleSheet("""
                    QLabel {
                        background-color: #ffffff;
                        border: 2px solid #e2e8f0;
                        border-radius: 12px;
                        padding: 16px;
                    }
                """)
                right_layout.addWidget(monkey_image)
            else:
                logger.warning(f"图片文件不存在: {monkey_image_path}")
        except Exception as e:
            logger.warning(f"无法加载图片: {e}")
        
        # 作者信息
        author_widget = QWidget()
        author_widget.setStyleSheet("""
            QWidget {
                background-color: #ffffff;
                border: 2px solid #e2e8f0;
                border-radius: 12px;
                padding: 16px;
            }
        """)
        author_layout = QVBoxLayout()
        author_layout.setContentsMargins(16, 16, 16, 16)
        author_layout.setSpacing(12)
        
        # 作者标题
        author_title = QLabel("Author Information")
        author_title.setFont(QFont("Segoe UI", 14, QFont.Weight.Bold))
        author_title.setStyleSheet("color: #1e293b;")
        author_layout.addWidget(author_title)
        
        # 作者名字
        author_name = QLabel("Quan Rong")
        author_name.setFont(QFont("Segoe UI", 12, QFont.Weight.Normal))
        author_name.setStyleSheet("color: #334155;")
        author_layout.addWidget(author_name)
        
        # 作者邮箱
        author_email = QLabel("quan.rong@de.gestamp.com")
        author_email.setFont(QFont("Segoe UI", 11, QFont.Weight.Normal))
        author_email.setStyleSheet("color: #475569;")
        author_layout.addWidget(author_email)
        
        author_layout.addStretch()
        author_widget.setLayout(author_layout)
        right_layout.addWidget(author_widget)
        
        right_widget.setLayout(right_layout)
        
        # 添加到主布局
        main_layout.addWidget(left_widget, 2)  # 左侧占2/3
        main_layout.addWidget(right_widget, 1)  # 右侧占1/3
        
        self.setLayout(main_layout)
    
    def _load_readme(self) -> str:
        """加载 README 文件内容"""
        try:
            from pathlib import Path
            # 尝试读取项目根目录的 README.md
            readme_path = Path(__file__).parent.parent.parent.parent / "README.md"
            if readme_path.exists():
                with open(readme_path, 'r', encoding='utf-8') as f:
                    return f.read()
            else:
                logger.warning(f"README 文件不存在: {readme_path}")
                return "# KinBench Tool\n\nREADME 文件未找到。"
        except Exception as e:
            logger.error(f"读取 README 文件失败: {e}")
            return "# KinBench Tool\n\n读取 README 文件时出错。"
    
    def _get_monokai_css(self) -> str:
        """获取 Monokai 主题的 CSS 样式"""
        return """
            body {
                background-color: #272822;
                color: #F8F8F2;
                font-family: 'Consolas', 'Monaco', 'Courier New', monospace;
                font-size: 11px;
                line-height: 1.6;
            }
            h1 {
                color: #F92672;
                font-size: 1.8em;
                font-weight: bold;
                margin-top: 0.8em;
                margin-bottom: 0.4em;
            }
            h2 {
                color: #A6E22E;
                font-size: 1.5em;
                font-weight: bold;
                margin-top: 0.8em;
                margin-bottom: 0.4em;
            }
            h3 {
                color: #66D9EF;
                font-size: 1.3em;
                font-weight: bold;
                margin-top: 0.6em;
                margin-bottom: 0.3em;
            }
            h4 {
                color: #AE81FF;
                font-size: 1.1em;
                font-weight: bold;
                margin-top: 0.6em;
                margin-bottom: 0.3em;
            }
            p {
                color: #F8F8F2;
                margin: 0.5em 0;
            }
            code {
                background-color: #3E3D32;
                color: #F92672;
                padding: 2px 4px;
                border-radius: 3px;
                font-family: 'Consolas', 'Monaco', 'Courier New', monospace;
            }
            pre {
                background-color: #3E3D32;
                border: 1px solid #49483e;
                border-radius: 6px;
                padding: 12px;
                overflow-x: auto;
                margin: 1em 0;
            }
            pre code {
                background-color: transparent;
                color: #F8F8F2;
                padding: 0;
            }
            a {
                color: #66D9EF;
                text-decoration: none;
            }
            a:hover {
                color: #AE81FF;
                text-decoration: underline;
            }
            ul, ol {
                color: #F8F8F2;
                margin: 0.5em 0;
                padding-left: 2em;
            }
            li {
                margin: 0.3em 0;
            }
            strong, b {
                color: #F92672;
                font-weight: bold;
            }
            em, i {
                color: #AE81FF;
                font-style: italic;
            }
            blockquote {
                border-left: 3px solid #49483e;
                padding-left: 1em;
                margin: 1em 0;
                color: #75715E;
            }
        """
    
    def _markdown_to_html(self, markdown_text: str) -> str:
        """将 Markdown 文本转换为简单的 HTML（基础处理，带 Monokai 样式）"""
        import re
        
        html = markdown_text
        
        # 转义 HTML 特殊字符
        html = html.replace('&', '&amp;').replace('<', '&lt;').replace('>', '&gt;')
        
        # 处理代码块（在转义之前处理，但需要先转义）
        # 先恢复代码块中的内容
        code_blocks = []
        def save_code_block(match):
            code_blocks.append(match.group(0))
            return f'__CODE_BLOCK_{len(code_blocks)-1}__'
        
        html = re.sub(r'```[\w]*\n(.*?)```', save_code_block, html, flags=re.DOTALL)
        
        # 处理标题（在行首）
        lines = html.split('\n')
        processed_lines = []
        for line in lines:
            if line.strip().startswith('#### '):
                processed_lines.append(f'<h4>{line.strip()[5:]}</h4>')
            elif line.strip().startswith('### '):
                processed_lines.append(f'<h3>{line.strip()[4:]}</h3>')
            elif line.strip().startswith('## '):
                processed_lines.append(f'<h2>{line.strip()[3:]}</h2>')
            elif line.strip().startswith('# '):
                processed_lines.append(f'<h1>{line.strip()[2:]}</h1>')
            else:
                processed_lines.append(line)
        
        html = '\n'.join(processed_lines)
        
        # 恢复代码块
        for i, code_block in enumerate(code_blocks):
            # 提取代码内容
            code_content = re.search(r'```[\w]*\n(.*?)```', code_block, flags=re.DOTALL)
            if code_content:
                code_text = code_content.group(1)
                html = html.replace(f'__CODE_BLOCK_{i}__', f'<pre><code>{code_text}</code></pre>')
        
        # 处理行内代码
        html = re.sub(r'`([^`]+)`', r'<code>\1</code>', html)
        
        # 处理粗体
        html = re.sub(r'\*\*([^\*]+)\*\*', r'<b>\1</b>', html)
        html = re.sub(r'__([^_]+)__', r'<b>\1</b>', html)
        
        # 处理链接
        html = re.sub(r'\[([^\]]+)\]\(([^\)]+)\)', r'<a href="\2">\1</a>', html)
        
        # 处理列表
        lines = html.split('\n')
        result_lines = []
        in_ul = False
        in_ol = False
        
        for line in lines:
            stripped = line.strip()
            # 无序列表
            if stripped.startswith('- ') or stripped.startswith('* '):
                if not in_ul and not in_ol:
                    if in_ol:
                        result_lines.append('</ol>')
                        in_ol = False
                    result_lines.append('<ul>')
                    in_ul = True
                content = stripped[2:]
                result_lines.append(f'<li>{content}</li>')
            # 有序列表
            elif re.match(r'^\d+\.\s+', stripped):
                if not in_ol and not in_ul:
                    if in_ul:
                        result_lines.append('</ul>')
                        in_ul = False
                    result_lines.append('<ol>')
                    in_ol = True
                content = re.sub(r'^\d+\.\s+', '', stripped)
                result_lines.append(f'<li>{content}</li>')
            else:
                if in_ul:
                    result_lines.append('</ul>')
                    in_ul = False
                if in_ol:
                    result_lines.append('</ol>')
                    in_ol = False
                if stripped and not stripped.startswith('<'):
                    result_lines.append(f'<p>{stripped}</p>')
                elif stripped:
                    result_lines.append(stripped)
        
        if in_ul:
            result_lines.append('</ul>')
        if in_ol:
            result_lines.append('</ol>')
        
        html = '\n'.join(result_lines)
        
        # 添加 Monokai 样式的 CSS
        monokai_css = self._get_monokai_css()
        html = f'<html><head><style>{monokai_css}</style></head><body>{html}</body></html>'
        
        return html


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
        main_layout.setContentsMargins(16, 16, 16, 16)
        main_layout.setSpacing(14)
        
        # 文件选择（顶部）
        self.setup_file_selection(main_layout)
        
        # 创建左右分栏布局
        content_layout = QHBoxLayout()
        content_layout.setSpacing(16)
        
        # 左侧面板：参数和结果（固定宽度，优化比例）
        left_panel = QWidget()
        left_panel.setMaximumWidth(400)
        left_panel.setMinimumWidth(360)
        left_layout = QVBoxLayout()
        left_layout.setContentsMargins(0, 0, 0, 0)
        left_layout.setSpacing(14)
        
        # 拟合范围设置 - 使用漂亮的滑块
        fit_group = QGroupBox("Fit Range")
        fit_layout = QVBoxLayout()
        fit_layout.setSpacing(10)
        range_label = QLabel("Range (mm):")
        range_label.setStyleSheet("color: #475569; font-weight: 500; padding: 4px 0px;")
        fit_layout.addWidget(range_label)
        self.fit_range_slider, self.fit_range_label, slider_container = self.create_fit_range_slider(
            min_val=5, max_val=50, default_val=15, step=1.0, unit="mm", is_int=True
        )
        fit_layout.addLayout(slider_container)
        fit_group.setLayout(fit_layout)
        left_layout.addWidget(fit_group)
        
        # 结果面板（可折叠）
        result_fields = [
            ('bump_steer_left', 'Bump Steer Left (deg/m)'),
            ('bump_steer_right', 'Bump Steer Right (deg/m)'),
            ('bump_steer_avg', 'Bump Steer Avg (deg/m)'),
            ('bump_camber_left', 'Bump Camber Left (deg/m)'),
            ('bump_camber_right', 'Bump Camber Right (deg/m)'),
            ('bump_camber_avg', 'Bump Camber Avg (deg/m)'),
            ('wheel_rate_left', 'Wheel Rate Left (N/mm)'),
            ('wheel_rate_right', 'Wheel Rate Right (N/mm)'),
            ('wheel_rate_slope', 'Wheel Rate Slope (N/mm/mm)'),
            ('wheel_recession_avg', 'Wheel Recession Avg (mm/m)'),
            ('track_change_avg', 'Track Change Avg (mm/m)'),
            ('caster_at_zero_avg', 'Caster@WC Avg (deg)'),
            ('swa_angle_at_zero_avg', 'SVSA Angle@WC Avg (deg)'),
            ('swa_length_at_zero_avg', 'SVSA Length@WC Avg (mm)'),
            ('wheel_rate_wc_avg', 'Wheel Rate@WC Avg (N/mm)'),
            ('toe_bump_50mm', 'Toe@Bump 50mm (deg)'),
            ('toe_rebound_50mm', 'Toe@Rebound 50mm (deg)'),
            ('wheel_travel_2g', 'Wheel Travel@2g HL (mm)'),
            ('wheel_rate_2g', 'Wheel Rate@2g HL (N/mm)'),
        ]
        self.setup_collapsible_results_panel(left_layout, result_fields, default_visible=6)
        
        # 多文件导入比较功能
        self.setup_comparison_files(left_layout)
        
        left_layout.addStretch()
        left_panel.setLayout(left_layout)
        content_layout.addWidget(left_panel)
        
        # 右侧面板：图表（占据剩余空间）
        right_panel = QWidget()
        right_layout = QVBoxLayout()
        right_layout.setContentsMargins(0, 0, 0, 0)
        right_layout.setSpacing(14)
        
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
        
        # Caster Angle图表
        self.caster_widget = ComparisonPlotWidget()
        self.plot_tabs.addTab(self.caster_widget, "Caster Angle")
        
        # Side Swing Arm Angle图表
        self.swa_angle_widget = ComparisonPlotWidget()
        self.plot_tabs.addTab(self.swa_angle_widget, "SVSA Angle")
        
        # Side Swing Arm Length图表
        self.swa_length_widget = ComparisonPlotWidget()
        self.plot_tabs.addTab(self.swa_length_widget, "SVSA Length")
        
        # Wheel Load图表
        self.wheel_load_widget = ComparisonPlotWidget()
        self.plot_tabs.addTab(self.wheel_load_widget, "Wheel Load")
        
        # 连接样本点显示按钮的replot信号
        for w in (self.bump_steer_widget, self.bump_camber_widget, self.wheel_rate_widget,
                  self.wheel_recession_widget, self.track_change_widget, self.caster_widget,
                  self.swa_angle_widget, self.swa_length_widget, self.wheel_load_widget):
            w.replot_requested.connect(self.update_plots)
        
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
            wheel_rate_result = self.calculator.calculate_wheel_rate(fit_range=30)  # 固定30mm
            self.result_labels['wheel_rate_left'].setText(f"{wheel_rate_result['left_rate_at_zero']:.2f}")
            self.result_labels['wheel_rate_right'].setText(f"{wheel_rate_result['right_rate_at_zero']:.2f}")
            self.result_labels['wheel_rate_slope'].setText(f"{wheel_rate_result['average_slope']:.2f}")
            
            # 计算Wheel Recession
            wheel_recession_result = self.calculator.calculate_wheel_recession(fit_range=self.fit_range)
            self.result_labels['wheel_recession_avg'].setText(f"{wheel_recession_result['average_slope']:.2f}")
            
            # 计算Track Change
            track_change_result = self.calculator.calculate_track_change(fit_range=self.fit_range)
            self.result_labels['track_change_avg'].setText(f"{track_change_result['average_slope']:.2f}")
            
            # 计算Caster
            caster_result = self.calculator.calculate_bump_caster(fit_range=self.fit_range)
            self.result_labels['caster_at_zero_avg'].setText(f"{caster_result['average_at_zero']:.2f}")
            
            # 计算Side Swing Arm Angle
            swa_angle_result = self.calculator.calculate_bump_side_swing_arm_angle(fit_range=self.fit_range)
            self.result_labels['swa_angle_at_zero_avg'].setText(f"{swa_angle_result['average_at_zero']:.3f}")
            
            # 计算Side Swing Arm Length
            swa_length_result = self.calculator.calculate_bump_side_swing_arm_length(fit_range=self.fit_range)
            self.result_labels['swa_length_at_zero_avg'].setText(f"{swa_length_result['average_at_zero']:.3f}")
            
            # 计算Wheel Load (Wheel Rate from load)
            wheel_load_result = self.calculator.calculate_bump_wheel_load(fit_range=self.fit_range)
            self.result_labels['wheel_rate_wc_avg'].setText(f"{wheel_load_result['average_rate']:.2f}")
            
            # 计算Toe at 50mm - 需要找到50mm位置的索引
            wheel_travel_left = self.calculator.extractor.extract_by_name('wheel_travel', convert_length=True)
            if wheel_travel_left.ndim > 1:
                wheel_travel_left = wheel_travel_left[:, 1] if wheel_travel_left.shape[1] > 1 else wheel_travel_left[:, 0]
            wheel_travel_left_mm = wheel_travel_left * 1000
            
            # 查找零位置
            zero_idx = bump_steer_result.get('zero_position_idx', len(wheel_travel_left) // 2)
            
            # 根据实际数据查找50mm位置
            # 查找bump 50mm位置（零位置+50mm）
            target_bump_50mm = wheel_travel_left_mm[zero_idx] + 50
            bump_50mm_idx = None
            for i in range(zero_idx, len(wheel_travel_left_mm)):
                if wheel_travel_left_mm[i] >= target_bump_50mm:
                    bump_50mm_idx = i
                    break
            if bump_50mm_idx is None:
                bump_50mm_idx = len(wheel_travel_left_mm) - 1
            
            # 查找rebound 50mm位置（零位置-50mm）
            target_rebound_50mm = wheel_travel_left_mm[zero_idx] - 50
            rebound_50mm_idx = None
            for i in range(zero_idx, -1, -1):
                if wheel_travel_left_mm[i] <= target_rebound_50mm:
                    rebound_50mm_idx = i
                    break
            if rebound_50mm_idx is None:
                rebound_50mm_idx = 0
            
            toe_at_50mm_result = self.calculator.calculate_toe_at_50mm(
                bump_50mm_idx=bump_50mm_idx,
                rebound_50mm_idx=rebound_50mm_idx
            )
            if 'bump_50mm_left' in toe_at_50mm_result:
                toe_bump_50 = (toe_at_50mm_result.get('bump_50mm_left', 0) + 
                              toe_at_50mm_result.get('bump_50mm_right', 0)) / 2
                self.result_labels['toe_bump_50mm'].setText(f"{toe_bump_50:.3f}")
            if 'rebound_50mm_left' in toe_at_50mm_result:
                toe_rebound_50 = (toe_at_50mm_result.get('rebound_50mm_left', 0) + 
                                 toe_at_50mm_result.get('rebound_50mm_right', 0)) / 2
                self.result_labels['toe_rebound_50mm'].setText(f"{toe_rebound_50:.3f}")
            
            # 计算2g载荷时的轮跳行程和wheel rate
            travel_2g_result = self.calculator.calculate_2g_wheel_travel_and_rate(target_load=2.0)
            if 'wheel_travel_2g' in travel_2g_result:
                self.result_labels['wheel_travel_2g'].setText(f"{travel_2g_result['wheel_travel_2g']:.2f}")
            if 'wheel_rate_2g' in travel_2g_result:
                self.result_labels['wheel_rate_2g'].setText(f"{travel_2g_result['wheel_rate_2g']:.2f}")
            
            # 返回结果数据
            return {
                'bump_steer': bump_steer_result,
                'bump_camber': bump_camber_result,
                'wheel_rate': wheel_rate_result,
                'wheel_recession': wheel_recession_result,
                'track_change': track_change_result,
                'caster': caster_result,
                'swa_angle': swa_angle_result,
                'swa_length': swa_length_result,
                'wheel_load': wheel_load_result,
                'toe_at_50mm': toe_at_50mm_result,
                'travel_2g': travel_2g_result,
            }
            
        except Exception as e:
            from ..utils.error_handler import ErrorHandler
            ErrorHandler.handle_exception(self, e, context="处理数据", language='zh')
            return None
    
    def update_plots(self):
        """更新图表，支持多套结果对比"""
        # 清空所有图表
        self.bump_steer_widget.clear()
        self.bump_camber_widget.clear()
        self.wheel_rate_widget.clear()
        self.wheel_recession_widget.clear()
        self.track_change_widget.clear()
        self.caster_widget.clear()
        self.swa_angle_widget.clear()
        self.swa_length_widget.clear()
        self.wheel_load_widget.clear()
        
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
                    compare_count=0,
                    show_sample_points_left=self.bump_steer_widget.show_sample_points_left,
                    show_sample_points_right=self.bump_steer_widget.show_sample_points_right
                )
                plot_bump_camber(
                    self.bump_camber_widget.get_axes_left(),
                    self.bump_camber_widget.get_axes_right(),
                    self.calculator,
                    fit_range=self.fit_range,
                    curve_color=self.curve_color,
                    fit_color=self.fit_color,
                    compare_count=0,
                    show_sample_points_left=self.bump_camber_widget.show_sample_points_left,
                    show_sample_points_right=self.bump_camber_widget.show_sample_points_right
                )
                plot_wheel_rate(
                    self.wheel_rate_widget.get_axes_left(),
                    self.wheel_rate_widget.get_axes_right(),
                    self.calculator,
                    curve_color=self.curve_color,
                    fit_color=self.fit_color,
                    compare_count=0,
                    show_sample_points_left=self.wheel_rate_widget.show_sample_points_left,
                    show_sample_points_right=self.wheel_rate_widget.show_sample_points_right
                )
                plot_wheel_recession(
                    self.wheel_recession_widget.get_axes_left(),
                    self.wheel_recession_widget.get_axes_right(),
                    self.calculator,
                    fit_range=self.fit_range,
                    curve_color=self.curve_color,
                    fit_color=self.fit_color,
                    compare_count=0,
                    show_sample_points_left=self.wheel_recession_widget.show_sample_points_left,
                    show_sample_points_right=self.wheel_recession_widget.show_sample_points_right
                )
                plot_track_change(
                    self.track_change_widget.get_axes_left(),
                    self.track_change_widget.get_axes_right(),
                    self.calculator,
                    fit_range=self.fit_range,
                    curve_color=self.curve_color,
                    fit_color=self.fit_color,
                    compare_count=0,
                    show_sample_points_left=self.track_change_widget.show_sample_points_left,
                    show_sample_points_right=self.track_change_widget.show_sample_points_right
                )
                plot_bump_caster(
                    self.caster_widget.get_axes_left(),
                    self.caster_widget.get_axes_right(),
                    self.calculator,
                    fit_range=self.fit_range,
                    curve_color=self.curve_color,
                    fit_color=self.fit_color,
                    compare_count=0,
                    show_sample_points_left=self.caster_widget.show_sample_points_left,
                    show_sample_points_right=self.caster_widget.show_sample_points_right
                )
                plot_bump_side_swing_arm_angle(
                    self.swa_angle_widget.get_axes_left(),
                    self.swa_angle_widget.get_axes_right(),
                    self.calculator,
                    fit_range=self.fit_range,
                    curve_color=self.curve_color,
                    fit_color=self.fit_color,
                    compare_count=0,
                    show_sample_points_left=self.swa_angle_widget.show_sample_points_left,
                    show_sample_points_right=self.swa_angle_widget.show_sample_points_right
                )
                plot_bump_side_swing_arm_length(
                    self.swa_length_widget.get_axes_left(),
                    self.swa_length_widget.get_axes_right(),
                    self.calculator,
                    fit_range=self.fit_range,
                    curve_color=self.curve_color,
                    fit_color=self.fit_color,
                    compare_count=0,
                    show_sample_points_left=self.swa_length_widget.show_sample_points_left,
                    show_sample_points_right=self.swa_length_widget.show_sample_points_right
                )
                plot_bump_wheel_load(
                    self.wheel_load_widget.get_axes_left(),
                    self.wheel_load_widget.get_axes_right(),
                    self.calculator,
                    fit_range=self.fit_range,
                    curve_color=self.curve_color,
                    fit_color=self.fit_color,
                    compare_count=0,
                    show_sample_points_left=self.wheel_load_widget.show_sample_points_left,
                    show_sample_points_right=self.wheel_load_widget.show_sample_points_right
                )
            except Exception as e:
                logger.error(f"图表更新失败: {e}", exc_info=True)
        
        # 显示比较结果（如果有）
        if hasattr(self, 'compare_file_widgets'):
            for idx, widget in enumerate(self.compare_file_widgets):
                if widget['loaded'] and widget['calculator']:
                    try:
                        calculator = widget['calculator']
                        style = self.compare_styles[idx % len(self.compare_styles)]
                        
                        # 使用不同的线形和标记绘制比较结果
                        plot_bump_steer(
                            self.bump_steer_widget.get_axes_left(),
                            self.bump_steer_widget.get_axes_right(),
                            calculator,
                            fit_range=self.fit_range,
                            curve_color=None,
                            fit_color=None,
                            compare_count=idx + 1,
                            show_sample_points_left=self.bump_steer_widget.show_sample_points_left,
                            show_sample_points_right=self.bump_steer_widget.show_sample_points_right
                        )
                        plot_bump_camber(
                            self.bump_camber_widget.get_axes_left(),
                            self.bump_camber_widget.get_axes_right(),
                            calculator,
                            fit_range=self.fit_range,
                            curve_color=None,
                            fit_color=None,
                            compare_count=idx + 1,
                            show_sample_points_left=self.bump_camber_widget.show_sample_points_left,
                            show_sample_points_right=self.bump_camber_widget.show_sample_points_right
                        )
                        plot_wheel_rate(
                            self.wheel_rate_widget.get_axes_left(),
                            self.wheel_rate_widget.get_axes_right(),
                            calculator,
                            curve_color=None,
                            fit_color=None,
                            compare_count=idx + 1,
                            show_sample_points_left=self.wheel_rate_widget.show_sample_points_left,
                            show_sample_points_right=self.wheel_rate_widget.show_sample_points_right
                        )
                        plot_wheel_recession(
                            self.wheel_recession_widget.get_axes_left(),
                            self.wheel_recession_widget.get_axes_right(),
                            calculator,
                            fit_range=self.fit_range,
                            curve_color=None,
                            fit_color=None,
                            compare_count=idx + 1,
                            show_sample_points_left=self.wheel_recession_widget.show_sample_points_left,
                            show_sample_points_right=self.wheel_recession_widget.show_sample_points_right
                        )
                        plot_track_change(
                            self.track_change_widget.get_axes_left(),
                            self.track_change_widget.get_axes_right(),
                            calculator,
                            fit_range=self.fit_range,
                            curve_color=None,
                            fit_color=None,
                            compare_count=idx + 1,
                            show_sample_points_left=self.track_change_widget.show_sample_points_left,
                            show_sample_points_right=self.track_change_widget.show_sample_points_right
                        )
                        plot_bump_caster(
                            self.caster_widget.get_axes_left(),
                            self.caster_widget.get_axes_right(),
                            calculator,
                            fit_range=self.fit_range,
                            curve_color=None,
                            fit_color=None,
                            compare_count=idx + 1,
                            show_sample_points_left=self.caster_widget.show_sample_points_left,
                            show_sample_points_right=self.caster_widget.show_sample_points_right
                        )
                        plot_bump_side_swing_arm_angle(
                            self.swa_angle_widget.get_axes_left(),
                            self.swa_angle_widget.get_axes_right(),
                            calculator,
                            fit_range=self.fit_range,
                            curve_color=None,
                            fit_color=None,
                            compare_count=idx + 1,
                            show_sample_points_left=self.swa_angle_widget.show_sample_points_left,
                            show_sample_points_right=self.swa_angle_widget.show_sample_points_right
                        )
                        plot_bump_side_swing_arm_length(
                            self.swa_length_widget.get_axes_left(),
                            self.swa_length_widget.get_axes_right(),
                            calculator,
                            fit_range=self.fit_range,
                            curve_color=None,
                            fit_color=None,
                            compare_count=idx + 1,
                            show_sample_points_left=self.swa_length_widget.show_sample_points_left,
                            show_sample_points_right=self.swa_length_widget.show_sample_points_right
                        )
                        plot_bump_wheel_load(
                            self.wheel_load_widget.get_axes_left(),
                            self.wheel_load_widget.get_axes_right(),
                            calculator,
                            fit_range=self.fit_range,
                            curve_color=None,
                            fit_color=None,
                            compare_count=idx + 1,
                            show_sample_points_left=self.wheel_load_widget.show_sample_points_left,
                            show_sample_points_right=self.wheel_load_widget.show_sample_points_right
                        )
                    except Exception as e:
                        logger.error(f"比较结果 {idx+1} 显示失败: {e}", exc_info=True)
        
        # 刷新所有图表
        self.bump_steer_widget.draw()
        self.bump_camber_widget.draw()
        self.wheel_rate_widget.draw()
        self.wheel_recession_widget.draw()
        self.track_change_widget.draw()
        self.caster_widget.draw()
        self.swa_angle_widget.draw()
        self.swa_length_widget.draw()
        self.wheel_load_widget.draw()
        
        # 有数据时启用样本点按钮
        has_data = bool(self.results_history or self.calculator or
                       (hasattr(self, 'compare_file_widgets') and
                        any(w.get('loaded') for w in self.compare_file_widgets)))
        for w in (self.bump_steer_widget, self.bump_camber_widget, self.wheel_rate_widget,
                  self.wheel_recession_widget, self.track_change_widget, self.caster_widget,
                  self.swa_angle_widget, self.swa_length_widget, self.wheel_load_widget):
            w.set_sample_points_button_enabled(has_data)
    
    def process_data_for_comparison(self, calculator: KCCalculator) -> Optional[Dict[str, Any]]:
        """处理比较数据"""
        try:
            # 计算所有Bump相关的结果
            bump_steer_result = calculator.calculate_bump_steer(fit_range=self.fit_range)
            bump_camber_result = calculator.calculate_bump_camber(fit_range=self.fit_range)
            wheel_rate_result = calculator.calculate_wheel_rate(fit_range=30)
            wheel_recession_result = calculator.calculate_wheel_recession(fit_range=self.fit_range)
            track_change_result = calculator.calculate_track_change(fit_range=self.fit_range)
            caster_result = calculator.calculate_bump_caster(fit_range=self.fit_range)
            swa_angle_result = calculator.calculate_bump_side_swing_arm_angle(fit_range=self.fit_range)
            swa_length_result = calculator.calculate_bump_side_swing_arm_length(fit_range=self.fit_range)
            wheel_load_result = calculator.calculate_bump_wheel_load(fit_range=self.fit_range)
            
            return {
                'bump_steer': bump_steer_result,
                'bump_camber': bump_camber_result,
                'wheel_rate': wheel_rate_result,
                'wheel_recession': wheel_recession_result,
                'track_change': track_change_result,
                'caster': caster_result,
                'swa_angle': swa_angle_result,
                'swa_length': swa_length_result,
                'wheel_load': wheel_load_result,
            }
        except Exception as e:
            logger.error(f"比较数据处理失败: {e}", exc_info=True)
            return None
    
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
        """设置UI界面 - 优化为左右分栏布局"""
        # 主布局：顶部文件选择，下方左右分栏
        main_layout = QVBoxLayout()
        main_layout.setContentsMargins(16, 16, 16, 16)
        main_layout.setSpacing(14)
        
        # 文件选择（顶部）
        self.setup_file_selection(main_layout)
        
        # 创建左右分栏布局
        content_layout = QHBoxLayout()
        content_layout.setSpacing(16)
        
        # 左侧面板：参数和结果（固定宽度，优化比例）
        left_panel = QWidget()
        left_panel.setMaximumWidth(400)
        left_panel.setMinimumWidth(360)
        left_layout = QVBoxLayout()
        left_layout.setContentsMargins(0, 0, 0, 0)
        left_layout.setSpacing(14)
        
        # 拟合范围设置 - 使用漂亮的滑块
        fit_group = QGroupBox("Fit Range")
        fit_layout = QVBoxLayout()
        fit_layout.setSpacing(10)
        range_label = QLabel("Range (deg):")
        range_label.setStyleSheet("color: #475569; font-weight: 500; padding: 4px 0px;")
        fit_layout.addWidget(range_label)
        self.fit_range_slider, self.fit_range_label, slider_container = self.create_fit_range_slider(
            min_val=0.1, max_val=5.0, default_val=1.0, step=0.1, unit="deg", is_int=False
        )
        fit_layout.addLayout(slider_container)
        fit_group.setLayout(fit_layout)
        left_layout.addWidget(fit_group)
        
        # 结果面板（可折叠）
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
        self.setup_collapsible_results_panel(left_layout, result_fields, default_visible=6)
        
        # 多文件导入比较功能
        self.setup_comparison_files(left_layout)
        
        left_layout.addStretch()
        left_panel.setLayout(left_layout)
        content_layout.addWidget(left_panel)
        
        # 右侧面板：图表（占据剩余空间）
        right_panel = QWidget()
        right_layout = QVBoxLayout()
        right_layout.setContentsMargins(0, 0, 0, 0)
        right_layout.setSpacing(14)
        
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
        
        # 连接样本点显示按钮的replot信号
        for w in (self.roll_steer_widget, self.roll_camber_widget, self.roll_camber_ground_widget):
            w.replot_requested.connect(self.update_plots)
        
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
            from ..utils.error_handler import ErrorHandler
            ErrorHandler.handle_exception(self, e, context="处理数据", language='zh')
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
                    compare_count=0,
                    show_sample_points_left=self.roll_steer_widget.show_sample_points_left,
                    show_sample_points_right=self.roll_steer_widget.show_sample_points_right
                )
                plot_roll_camber(
                    self.roll_camber_widget.get_axes_left(),
                    self.roll_camber_widget.get_axes_right(),
                    self.calculator,
                    fit_range=self.fit_range,
                    curve_color=self.curve_color,
                    fit_color=self.fit_color,
                    compare_count=0,
                    show_sample_points_left=self.roll_camber_widget.show_sample_points_left,
                    show_sample_points_right=self.roll_camber_widget.show_sample_points_right
                )
                plot_roll_camber_relative_ground(
                    self.roll_camber_ground_widget.get_axes_left(),
                    self.roll_camber_ground_widget.get_axes_right(),
                    self.calculator,
                    fit_range=self.fit_range,
                    curve_color=self.curve_color,
                    fit_color=self.fit_color,
                    compare_count=0,
                    show_sample_points_left=self.roll_camber_ground_widget.show_sample_points_left,
                    show_sample_points_right=self.roll_camber_ground_widget.show_sample_points_right
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
                        compare_count=idx,
                        show_sample_points_left=self.roll_steer_widget.show_sample_points_left,
                        show_sample_points_right=self.roll_steer_widget.show_sample_points_right
                    )
                    plot_roll_camber(
                        self.roll_camber_widget.get_axes_left(),
                        self.roll_camber_widget.get_axes_right(),
                        calculator,
                        fit_range=self.fit_range,
                        curve_color=curve_color,
                        fit_color=fit_color,
                        compare_count=idx,
                        show_sample_points_left=self.roll_camber_widget.show_sample_points_left,
                        show_sample_points_right=self.roll_camber_widget.show_sample_points_right
                    )
                    plot_roll_camber_relative_ground(
                        self.roll_camber_ground_widget.get_axes_left(),
                        self.roll_camber_ground_widget.get_axes_right(),
                        calculator,
                        fit_range=self.fit_range,
                        curve_color=curve_color,
                        fit_color=fit_color,
                        compare_count=idx,
                        show_sample_points_left=self.roll_camber_ground_widget.show_sample_points_left,
                        show_sample_points_right=self.roll_camber_ground_widget.show_sample_points_right
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
        
        # 有数据时启用样本点按钮（仅对有拟合的图表）
        has_data = bool(self.results_history or self.calculator)
        for w in (self.roll_steer_widget, self.roll_camber_widget, self.roll_camber_ground_widget):
            w.set_sample_points_button_enabled(has_data)
    
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
        main_layout.setContentsMargins(16, 16, 16, 16)
        main_layout.setSpacing(14)
        
        # 文件选择（顶部）
        self.setup_file_selection(main_layout)
        
        # 创建左右分栏布局
        content_layout = QHBoxLayout()
        content_layout.setSpacing(16)
        
        # 左侧面板：参数和结果（固定宽度，优化比例）
        left_panel = QWidget()
        left_panel.setMaximumWidth(400)
        left_panel.setMinimumWidth(360)
        left_layout = QVBoxLayout()
        left_layout.setContentsMargins(0, 0, 0, 0)
        left_layout.setSpacing(14)
        
        # 拟合范围设置 - 使用漂亮的滑块
        fit_group = QGroupBox("Fit Range")
        fit_layout = QVBoxLayout()
        fit_layout.setSpacing(10)
        range_label = QLabel("Range (kN):")
        range_label.setStyleSheet("color: #475569; font-weight: 500; padding: 4px 0px;")
        fit_layout.addWidget(range_label)
        self.fit_range_slider, self.fit_range_label, slider_container = self.create_fit_range_slider(
            min_val=0.1, max_val=10.0, default_val=1.0, step=0.1, unit="kN", is_int=False
        )
        fit_layout.addLayout(slider_container)
        fit_group.setLayout(fit_layout)
        left_layout.addWidget(fit_group)
        
        # 结果面板（可折叠）
        result_fields = [
            ('lateral_toe_left', 'Lateral Toe Left (deg/kN)'),
            ('lateral_toe_right', 'Lateral Toe Right (deg/kN)'),
            ('lateral_toe_avg', 'Lateral Toe Avg (deg/kN)'),
            ('lateral_camber_left', 'Lateral Camber Left (deg/kN)'),
            ('lateral_camber_right', 'Lateral Camber Right (deg/kN)'),
            ('lateral_camber_avg', 'Lateral Camber Avg (deg/kN)'),
        ]
        self.setup_collapsible_results_panel(left_layout, result_fields, default_visible=6)
        
        # 多文件导入比较功能
        self.setup_comparison_files(left_layout)
        
        left_layout.addStretch()
        left_panel.setLayout(left_layout)
        content_layout.addWidget(left_panel)
        
        # 右侧面板：图表（占据剩余空间）
        right_panel = QWidget()
        right_layout = QVBoxLayout()
        right_layout.setContentsMargins(0, 0, 0, 0)
        right_layout.setSpacing(14)
        
        # 图表Tab组
        self.plot_tabs = QTabWidget()
        
        # Lateral Toe Compliance图表
        self.lateral_toe_widget = ComparisonPlotWidget()
        self.plot_tabs.addTab(self.lateral_toe_widget, "Lateral Toe Compliance")
        
        # Lateral Camber Compliance图表
        self.lateral_camber_widget = ComparisonPlotWidget()
        self.plot_tabs.addTab(self.lateral_camber_widget, "Lateral Camber Compliance")
        
        # 连接样本点显示按钮的replot信号
        for w in (self.lateral_toe_widget, self.lateral_camber_widget):
            w.replot_requested.connect(self.update_plots)
        
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
            from ..utils.error_handler import ErrorHandler
            ErrorHandler.handle_exception(self, e, context="处理数据", language='zh')
    
    def update_plots(self):
        """更新图表"""
        if not self.calculator:
            for w in (self.lateral_toe_widget, self.lateral_camber_widget):
                w.set_sample_points_button_enabled(False)
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
                compare_count=self.compare_count,
                show_sample_points_left=self.lateral_toe_widget.show_sample_points_left,
                show_sample_points_right=self.lateral_toe_widget.show_sample_points_right
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
                compare_count=self.compare_count,
                show_sample_points_left=self.lateral_camber_widget.show_sample_points_left,
                show_sample_points_right=self.lateral_camber_widget.show_sample_points_right
            )
            self.lateral_camber_widget.draw()
            
            # 有数据时启用样本点按钮
            for w in (self.lateral_toe_widget, self.lateral_camber_widget):
                w.set_sample_points_button_enabled(True)
            
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
        main_layout.setContentsMargins(16, 16, 16, 16)
        main_layout.setSpacing(14)
        
        # 文件选择（顶部）
        self.setup_file_selection(main_layout)
        
        # 创建左右分栏布局
        content_layout = QHBoxLayout()
        content_layout.setSpacing(16)
        
        # 左侧面板：参数和结果（固定宽度，优化比例）
        left_panel = QWidget()
        left_panel.setMaximumWidth(400)
        left_panel.setMinimumWidth(360)
        left_layout = QVBoxLayout()
        left_layout.setContentsMargins(0, 0, 0, 0)
        left_layout.setSpacing(14)
        
        # 拟合范围设置 - 使用漂亮的滑块
        fit_group = QGroupBox("Fit Range")
        fit_layout = QVBoxLayout()
        fit_layout.setSpacing(10)
        range_label = QLabel("Range (kN):")
        range_label.setStyleSheet("color: #475569; font-weight: 500; padding: 4px 0px;")
        fit_layout.addWidget(range_label)
        self.fit_range_slider, self.fit_range_label, slider_container = self.create_fit_range_slider(
            min_val=0.1, max_val=10.0, default_val=1.0, step=0.1, unit="kN", is_int=False
        )
        fit_layout.addLayout(slider_container)
        fit_group.setLayout(fit_layout)
        left_layout.addWidget(fit_group)
        
        # 结果面板（可折叠）
        result_fields = [
            ('braking_toe_left', 'Braking Toe Left (deg/kN)'),
            ('braking_toe_right', 'Braking Toe Right (deg/kN)'),
            ('braking_toe_avg', 'Braking Toe Avg (deg/kN)'),
        ]
        self.setup_collapsible_results_panel(left_layout, result_fields, default_visible=6)
        
        # 多文件导入比较功能
        self.setup_comparison_files(left_layout)
        
        left_layout.addStretch()
        left_panel.setLayout(left_layout)
        content_layout.addWidget(left_panel)
        
        # 右侧面板：图表（占据剩余空间）
        right_panel = QWidget()
        right_layout = QVBoxLayout()
        right_layout.setContentsMargins(0, 0, 0, 0)
        right_layout.setSpacing(14)
        
        # 图表Tab组
        self.plot_tabs = QTabWidget()
        
        # Braking Toe Compliance图表
        self.braking_toe_widget = ComparisonPlotWidget()
        self.plot_tabs.addTab(self.braking_toe_widget, "Braking Toe Compliance")
        
        self.braking_toe_widget.replot_requested.connect(self.update_plots)
        
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
            from ..utils.error_handler import ErrorHandler
            ErrorHandler.handle_exception(self, e, context="处理数据", language='zh')
    
    def update_plots(self):
        """更新图表"""
        if not self.calculator:
            self.braking_toe_widget.set_sample_points_button_enabled(False)
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
                compare_count=self.compare_count,
                show_sample_points_left=self.braking_toe_widget.show_sample_points_left,
                show_sample_points_right=self.braking_toe_widget.show_sample_points_right
            )
            self.braking_toe_widget.draw()
            self.braking_toe_widget.set_sample_points_button_enabled(True)
            
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
        main_layout.setContentsMargins(16, 16, 16, 16)
        main_layout.setSpacing(14)
        
        # 文件选择（顶部）
        self.setup_file_selection(main_layout)
        
        # 创建左右分栏布局
        content_layout = QHBoxLayout()
        content_layout.setSpacing(16)
        
        # 左侧面板：参数和结果（固定宽度，优化比例）
        left_panel = QWidget()
        left_panel.setMaximumWidth(400)
        left_panel.setMinimumWidth(360)
        left_layout = QVBoxLayout()
        left_layout.setContentsMargins(0, 0, 0, 0)
        left_layout.setSpacing(14)
        
        # 拟合范围设置 - 使用漂亮的滑块
        fit_group = QGroupBox("Fit Range")
        fit_layout = QVBoxLayout()
        fit_layout.setSpacing(10)
        range_label = QLabel("Range (kN):")
        range_label.setStyleSheet("color: #475569; font-weight: 500; padding: 4px 0px;")
        fit_layout.addWidget(range_label)
        self.fit_range_slider, self.fit_range_label, slider_container = self.create_fit_range_slider(
            min_val=0.1, max_val=10.0, default_val=1.0, step=0.1, unit="kN", is_int=False
        )
        fit_layout.addLayout(slider_container)
        fit_group.setLayout(fit_layout)
        left_layout.addWidget(fit_group)
        
        # 结果面板（可折叠）
        result_fields = [
            ('acceleration_toe_left', 'Acceleration Toe Left (deg/kN)'),
            ('acceleration_toe_right', 'Acceleration Toe Right (deg/kN)'),
            ('acceleration_toe_avg', 'Acceleration Toe Avg (deg/kN)'),
        ]
        self.setup_collapsible_results_panel(left_layout, result_fields, default_visible=6)
        
        # 多文件导入比较功能
        self.setup_comparison_files(left_layout)
        
        left_layout.addStretch()
        left_panel.setLayout(left_layout)
        content_layout.addWidget(left_panel)
        
        # 右侧面板：图表（占据剩余空间）
        right_panel = QWidget()
        right_layout = QVBoxLayout()
        right_layout.setContentsMargins(0, 0, 0, 0)
        right_layout.setSpacing(14)
        
        # 图表Tab组
        self.plot_tabs = QTabWidget()
        
        # Acceleration Toe Compliance图表
        self.acceleration_toe_widget = ComparisonPlotWidget()
        self.plot_tabs.addTab(self.acceleration_toe_widget, "Acceleration Toe Compliance")
        
        self.acceleration_toe_widget.replot_requested.connect(self.update_plots)
        
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
            from ..utils.error_handler import ErrorHandler
            ErrorHandler.handle_exception(self, e, context="处理数据", language='zh')
    
    def update_plots(self):
        """更新图表"""
        if not self.calculator:
            self.acceleration_toe_widget.set_sample_points_button_enabled(False)
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
                compare_count=self.compare_count,
                show_sample_points_left=self.acceleration_toe_widget.show_sample_points_left,
                show_sample_points_right=self.acceleration_toe_widget.show_sample_points_right
            )
            self.acceleration_toe_widget.draw()
            self.acceleration_toe_widget.set_sample_points_button_enabled(True)
            
        except Exception as e:
            logger.error(f"图表更新失败: {e}", exc_info=True)
    
    def clear_all_plots(self):
        """清空所有图表"""
        self.acceleration_toe_widget.clear()
    
    def clear_results(self):
        """清空结果面板"""
        for label in self.result_labels.values():
            label.setText("--")
