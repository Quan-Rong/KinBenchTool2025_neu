"""车辆参数面板模块

提供车辆参数输入和管理功能。
"""

from typing import Dict, Optional
from PyQt6.QtWidgets import (QWidget, QVBoxLayout, QHBoxLayout, QLabel, 
                            QDoubleSpinBox, QGroupBox, QGridLayout)
from PyQt6.QtCore import Qt, pyqtSignal
from PyQt6.QtGui import QFont

from ..utils.logger import get_logger

logger = get_logger(__name__)


class VehicleParamsPanel(QWidget):
    """车辆参数面板
    
    用于输入和管理车辆参数，包括质量、尺寸、重心等。
    """
    
    # 参数改变信号
    params_changed = pyqtSignal(dict)
    
    def __init__(self, parent: Optional[QWidget] = None):
        """初始化车辆参数面板
        
        Args:
            parent: 父Widget
        """
        super().__init__(parent)
        self.setup_ui()
        
    def setup_ui(self):
        """设置UI界面"""
        layout = QVBoxLayout()
        layout.setContentsMargins(10, 10, 10, 10)
        layout.setSpacing(10)
        
        # 创建参数组
        params_group = QGroupBox("Vehicle Parameters")
        params_group.setFont(QFont("Arial", 10, QFont.Weight.Bold))
        params_layout = QGridLayout()
        params_layout.setSpacing(8)
        params_layout.setColumnStretch(1, 1)
        
        # 定义参数列表
        self.param_widgets = {}
        params_def = [
            ('half_load', 'Half Load', 'kg', 0.0, 10000.0, 1500.0),
            ('max_load', 'Max Load', 'kg', 0.0, 10000.0, 2000.0),
            ('unsprung_mass', 'Unsprung Mass', 'kg', 0.0, 1000.0, 100.0),
            ('wheel_base', 'Wheel Base', 'mm', 0.0, 5000.0, 2700.0),
            ('track_front', 'Track Front', 'mm', 0.0, 3000.0, 1550.0),
            ('track_rear', 'Track Rear', 'mm', 0.0, 3000.0, 1550.0),
            ('cog_height', 'COG Height', 'mm', 0.0, 2000.0, 500.0),
            ('cog_x', 'COG in x', 'mm', -5000.0, 5000.0, 0.0),
            ('roll_angle', 'Roll Angle', 'deg', -10.0, 10.0, 0.0),
            ('tire', 'Tire', 'mm', 0.0, 1000.0, 0.0),
        ]
        
        row = 0
        for key, label, unit, min_val, max_val, default_val in params_def:
            # 标签
            param_label = QLabel(f"{label}:")
            param_label.setMinimumWidth(120)
            params_layout.addWidget(param_label, row, 0)
            
            # 输入框
            spinbox = QDoubleSpinBox()
            spinbox.setMinimum(min_val)
            spinbox.setMaximum(max_val)
            spinbox.setValue(default_val)
            spinbox.setDecimals(2)
            spinbox.setSuffix(f" {unit}")
            spinbox.valueChanged.connect(self._on_param_changed)
            params_layout.addWidget(spinbox, row, 1)
            
            self.param_widgets[key] = spinbox
            row += 1
        
        params_group.setLayout(params_layout)
        layout.addWidget(params_group)
        
        # 添加弹性空间
        layout.addStretch()
        
        self.setLayout(layout)
        
    def _on_param_changed(self):
        """参数改变时的回调"""
        params = self.get_vehicle_params()
        self.params_changed.emit(params)
        
    def get_vehicle_params(self) -> Dict[str, float]:
        """获取车辆参数
        
        Returns:
            包含所有车辆参数的字典
        """
        params = {}
        for key, widget in self.param_widgets.items():
            params[key] = widget.value()
        return params
    
    def set_vehicle_params(self, params: Dict[str, float]):
        """设置车辆参数
        
        Args:
            params: 包含车辆参数的字典
        """
        for key, value in params.items():
            if key in self.param_widgets:
                self.param_widgets[key].setValue(value)
    
    def validate_params(self) -> bool:
        """验证参数有效性
        
        Returns:
            如果所有参数有效返回True，否则返回False
        """
        params = self.get_vehicle_params()
        
        # 检查必要的参数
        required_params = ['half_load', 'max_load', 'wheel_base', 
                          'track_front', 'track_rear']
        for param in required_params:
            if param not in params or params[param] <= 0:
                logger.warning(f"参数 {param} 无效")
                return False
                
        return True
    
    def reset_to_defaults(self):
        """重置为默认值"""
        defaults = {
            'half_load': 1500.0,
            'max_load': 2000.0,
            'unsprung_mass': 100.0,
            'wheel_base': 2700.0,
            'track_front': 1550.0,
            'track_rear': 1550.0,
            'cog_height': 500.0,
            'cog_x': 0.0,
            'roll_angle': 0.0,
            'tire': 0.0,
        }
        self.set_vehicle_params(defaults)
