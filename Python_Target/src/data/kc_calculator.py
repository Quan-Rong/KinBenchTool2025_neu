"""K&C计算模块

提供各种K&C测试工况的计算函数，包括Bump、Roll、Static Load等。
"""

from typing import Dict, Tuple, Optional, List
import numpy as np

from .data_extractor import DataExtractor
from .unit_converter import convert_angle_array, convert_length_array
from ..utils.math_utils import linear_fit, find_zero_crossing, find_value_index, calculate_slope
from ..utils.logger import get_logger

logger = get_logger(__name__)


class KCCalculator:
    """K&C计算器
    
    提供各种K&C测试工况的计算功能。
    """
    
    def __init__(self, data_extractor: DataExtractor, vehicle_params: Optional[Dict[str, float]] = None):
        """初始化K&C计算器
        
        Args:
            data_extractor: DataExtractor实例，用于提取数据
            vehicle_params: 车辆参数字典，包含half_load, max_load, wheel_base等
        """
        self.extractor = data_extractor
        self.vehicle_params = vehicle_params or {}
    
    def set_vehicle_params(self, vehicle_params: Dict[str, float]):
        """设置车辆参数
        
        Args:
            vehicle_params: 车辆参数字典
        """
        self.vehicle_params = vehicle_params
        logger.debug(f"车辆参数已更新: {vehicle_params}")
    
    def get_vehicle_param(self, key: str, default: float = 0.0) -> float:
        """获取车辆参数
        
        Args:
            key: 参数键名
            default: 默认值
            
        Returns:
            参数值
        """
        return self.vehicle_params.get(key, default)
    
    # ==================== Bump测试计算 ====================
    
    def calculate_bump_steer(self, 
                             fit_range: int = 15,
                             zero_position_idx: Optional[int] = None) -> Dict[str, float]:
        """计算Bump Steer（轮跳转向）
        
        Args:
            fit_range: 拟合区间范围（mm），默认15mm
            zero_position_idx: 零位置索引，如果为None则自动查找
            
        Returns:
            包含左右轮Bump Steer斜率的字典
            {
                'left_slope': 左轮斜率 (deg/m),
                'right_slope': 右轮斜率 (deg/m),
                'average_slope': 平均斜率 (deg/m),
                'left_coeffs': [a, b] 左轮拟合系数,
                'right_coeffs': [a, b] 右轮拟合系数
            }
        """
        logger.debug("计算Bump Steer")
        
        # 提取数据
        wheel_travel_left = self.extractor.extract_by_name('wheel_travel', convert_length=True)
        wheel_travel_right = self.extractor.extract_by_name('wheel_travel', convert_length=True)
        toe_angle_left = self.extractor.extract_by_name('toe_angle', convert_angle=True)
        toe_angle_right = self.extractor.extract_by_name('toe_angle', convert_angle=True)
        
        # 如果wheel_travel是多维的，取垂直方向（通常是第二列）
        if wheel_travel_left.ndim > 1:
            wheel_travel_left = wheel_travel_left[:, 1] if wheel_travel_left.shape[1] > 1 else wheel_travel_left[:, 0]
        if wheel_travel_right.ndim > 1:
            wheel_travel_right = wheel_travel_right[:, 1] if wheel_travel_right.shape[1] > 1 else wheel_travel_right[:, 0]
        
        # 如果toe_angle是多维的，取第一列（左轮）
        if toe_angle_left.ndim > 1:
            toe_angle_left = toe_angle_left[:, 0]
        if toe_angle_right.ndim > 1:
            toe_angle_right = toe_angle_right[:, 1] if toe_angle_right.shape[1] > 1 else toe_angle_right[:, 0]
        
        # 转换单位：m -> mm（用于计算斜率）
        wheel_travel_left_mm = wheel_travel_left * 1000
        wheel_travel_right_mm = wheel_travel_right * 1000
        
        # 查找零位置
        if zero_position_idx is None:
            zero_idx_left = find_zero_crossing(wheel_travel_left_mm, wheel_travel_left_mm)
            zero_idx_right = find_zero_crossing(wheel_travel_right_mm, wheel_travel_right_mm)
            zero_idx = (zero_idx_left + zero_idx_right) // 2 if zero_idx_left and zero_idx_right else len(wheel_travel_left) // 2
        else:
            zero_idx = zero_position_idx
        
        # 确定拟合区间
        fit_start = max(0, zero_idx - fit_range)
        fit_end = min(len(wheel_travel_left), zero_idx + fit_range + 1)
        
        # 左轮拟合
        x_left = wheel_travel_left_mm[fit_start:fit_end]
        y_left = toe_angle_left[fit_start:fit_end]
        coeffs_left, _ = linear_fit(x_left, y_left, degree=1)
        
        # 右轮拟合
        x_right = wheel_travel_right_mm[fit_start:fit_end]
        y_right = toe_angle_right[fit_start:fit_end]
        coeffs_right, _ = linear_fit(x_right, y_right, degree=1)
        
        # 计算斜率（deg/m = deg/mm * 1000）
        slope_left = coeffs_left[0] * 1000  # deg/m
        slope_right = coeffs_right[0] * 1000  # deg/m
        slope_avg = (slope_left + slope_right) / 2
        
        logger.debug(f"Bump Steer: 左={slope_left:.2f}, 右={slope_right:.2f}, 平均={slope_avg:.2f} deg/m")
        
        return {
            'left_slope': slope_left,
            'right_slope': slope_right,
            'average_slope': slope_avg,
            'left_coeffs': coeffs_left.tolist(),
            'right_coeffs': coeffs_right.tolist(),
            'zero_position_idx': zero_idx,
            'fit_range': fit_range
        }
    
    def calculate_bump_camber(self,
                             fit_range: int = 15,
                             zero_position_idx: Optional[int] = None) -> Dict[str, float]:
        """计算Bump Camber（轮跳外倾）
        
        Args:
            fit_range: 拟合区间范围（mm），默认15mm
            zero_position_idx: 零位置索引
            
        Returns:
            包含左右轮Bump Camber斜率的字典
        """
        logger.debug("计算Bump Camber")
        
        # 提取数据
        wheel_travel_left = self.extractor.extract_by_name('wheel_travel', convert_length=True)
        wheel_travel_right = self.extractor.extract_by_name('wheel_travel', convert_length=True)
        camber_left = self.extractor.extract_by_name('camber_angle', convert_angle=True)
        camber_right = self.extractor.extract_by_name('camber_angle', convert_angle=True)
        
        # 处理多维数据
        if wheel_travel_left.ndim > 1:
            wheel_travel_left = wheel_travel_left[:, 1] if wheel_travel_left.shape[1] > 1 else wheel_travel_left[:, 0]
        if wheel_travel_right.ndim > 1:
            wheel_travel_right = wheel_travel_right[:, 1] if wheel_travel_right.shape[1] > 1 else wheel_travel_right[:, 0]
        
        if camber_left.ndim > 1:
            camber_left = camber_left[:, 0]
        if camber_right.ndim > 1:
            camber_right = camber_right[:, 1] if camber_right.shape[1] > 1 else camber_right[:, 0]
        
        # 转换单位
        wheel_travel_left_mm = wheel_travel_left * 1000
        wheel_travel_right_mm = wheel_travel_right * 1000
        
        # 查找零位置
        if zero_position_idx is None:
            zero_idx_left = find_zero_crossing(wheel_travel_left_mm, wheel_travel_left_mm)
            zero_idx_right = find_zero_crossing(wheel_travel_right_mm, wheel_travel_right_mm)
            zero_idx = (zero_idx_left + zero_idx_right) // 2 if zero_idx_left and zero_idx_right else len(wheel_travel_left) // 2
        else:
            zero_idx = zero_position_idx
        
        # 确定拟合区间
        fit_start = max(0, zero_idx - fit_range)
        fit_end = min(len(wheel_travel_left), zero_idx + fit_range + 1)
        
        # 左轮拟合
        x_left = wheel_travel_left_mm[fit_start:fit_end]
        y_left = camber_left[fit_start:fit_end]
        coeffs_left, _ = linear_fit(x_left, y_left, degree=1)
        
        # 右轮拟合
        x_right = wheel_travel_right_mm[fit_start:fit_end]
        y_right = camber_right[fit_start:fit_end]
        coeffs_right, _ = linear_fit(x_right, y_right, degree=1)
        
        # 计算斜率（deg/m）
        slope_left = coeffs_left[0] * 1000
        slope_right = coeffs_right[0] * 1000
        slope_avg = (slope_left + slope_right) / 2
        
        logger.debug(f"Bump Camber: 左={slope_left:.2f}, 右={slope_right:.2f}, 平均={slope_avg:.2f} deg/m")
        
        return {
            'left_slope': slope_left,
            'right_slope': slope_right,
            'average_slope': slope_avg,
            'left_coeffs': coeffs_left.tolist(),
            'right_coeffs': coeffs_right.tolist(),
            'zero_position_idx': zero_idx,
            'fit_range': fit_range
        }
    
    def calculate_wheel_rate(self,
                            fit_range: int = 15,
                            zero_position_idx: Optional[int] = None) -> Dict[str, float]:
        """计算Wheel Rate（车轮刚度）
        
        Args:
            fit_range: 拟合区间范围（mm），默认15mm
            zero_position_idx: 零位置索引
            
        Returns:
            包含左右轮Wheel Rate的字典
        """
        logger.debug("计算Wheel Rate")
        
        # 提取数据
        wheel_travel_left = self.extractor.extract_by_name('wheel_travel', convert_length=True)
        wheel_travel_right = self.extractor.extract_by_name('wheel_travel', convert_length=True)
        wheel_rate_left = self.extractor.extract_by_name('wheel_rate')
        wheel_rate_right = self.extractor.extract_by_name('wheel_rate')
        
        # 处理多维数据
        if wheel_travel_left.ndim > 1:
            wheel_travel_left = wheel_travel_left[:, 1] if wheel_travel_left.shape[1] > 1 else wheel_travel_left[:, 0]
        if wheel_travel_right.ndim > 1:
            wheel_travel_right = wheel_travel_right[:, 1] if wheel_travel_right.shape[1] > 1 else wheel_travel_right[:, 0]
        
        if wheel_rate_left.ndim > 1:
            wheel_rate_left = wheel_rate_left[:, 0]
        if wheel_rate_right.ndim > 1:
            wheel_rate_right = wheel_rate_right[:, 1] if wheel_rate_right.shape[1] > 1 else wheel_rate_right[:, 0]
        
        # 转换单位
        wheel_travel_left_mm = wheel_travel_left * 1000
        wheel_travel_right_mm = wheel_travel_right * 1000
        
        # 查找零位置
        if zero_position_idx is None:
            zero_idx_left = find_zero_crossing(wheel_travel_left_mm, wheel_travel_left_mm)
            zero_idx_right = find_zero_crossing(wheel_travel_right_mm, wheel_travel_right_mm)
            zero_idx = (zero_idx_left + zero_idx_right) // 2 if zero_idx_left and zero_idx_right else len(wheel_travel_left) // 2
        else:
            zero_idx = zero_position_idx
        
        # 确定拟合区间
        fit_start = max(0, zero_idx - fit_range)
        fit_end = min(len(wheel_travel_left), zero_idx + fit_range + 1)
        
        # 左轮拟合
        x_left = wheel_travel_left_mm[fit_start:fit_end]
        y_left = wheel_rate_left[fit_start:fit_end]
        coeffs_left, _ = linear_fit(x_left, y_left, degree=1)
        
        # 右轮拟合
        x_right = wheel_travel_right_mm[fit_start:fit_end]
        y_right = wheel_rate_right[fit_start:fit_end]
        coeffs_right, _ = linear_fit(x_right, y_right, degree=1)
        
        # Wheel Rate斜率（N/mm/mm）
        slope_left = coeffs_left[0]
        slope_right = coeffs_right[0]
        slope_avg = (slope_left + slope_right) / 2
        
        # 零位置的Wheel Rate值（N/mm）
        rate_left = wheel_rate_left[zero_idx]
        rate_right = wheel_rate_right[zero_idx]
        rate_avg = (rate_left + rate_right) / 2
        
        logger.debug(f"Wheel Rate: 左斜率={slope_left:.2f}, 右斜率={slope_right:.2f}, 平均斜率={slope_avg:.2f} N/mm/mm")
        logger.debug(f"Wheel Rate@WC: 左={rate_left:.2f}, 右={rate_right:.2f}, 平均={rate_avg:.2f} N/mm")
        
        return {
            'left_slope': slope_left,
            'right_slope': slope_right,
            'average_slope': slope_avg,
            'left_rate_at_zero': rate_left,
            'right_rate_at_zero': rate_right,
            'average_rate_at_zero': rate_avg,
            'left_coeffs': coeffs_left.tolist(),
            'right_coeffs': coeffs_right.tolist(),
            'zero_position_idx': zero_idx,
            'fit_range': fit_range
        }
    
    def calculate_wheel_recession(self,
                                  fit_range: int = 15,
                                  zero_position_idx: Optional[int] = None) -> Dict[str, float]:
        """计算Wheel Recession（轮心后移）
        
        Args:
            fit_range: 拟合区间范围（mm），默认15mm
            zero_position_idx: 零位置索引
            
        Returns:
            包含左右轮Wheel Recession斜率的字典
        """
        logger.debug("计算Wheel Recession")
        
        # 提取数据
        wheel_travel_left = self.extractor.extract_by_name('wheel_travel', convert_length=True)
        wheel_travel_right = self.extractor.extract_by_name('wheel_travel', convert_length=True)
        wheel_travel_base_left = self.extractor.extract_by_name('wheel_travel_base', convert_length=True)
        wheel_travel_base_right = self.extractor.extract_by_name('wheel_travel_base', convert_length=True)
        
        # 处理多维数据
        if wheel_travel_left.ndim > 1:
            wheel_travel_left = wheel_travel_left[:, 1] if wheel_travel_left.shape[1] > 1 else wheel_travel_left[:, 0]
        if wheel_travel_right.ndim > 1:
            wheel_travel_right = wheel_travel_right[:, 1] if wheel_travel_right.shape[1] > 1 else wheel_travel_right[:, 0]
        
        if wheel_travel_base_left.ndim > 1:
            wheel_travel_base_left = wheel_travel_base_left[:, 0]
        if wheel_travel_base_right.ndim > 1:
            wheel_travel_base_right = wheel_travel_base_right[:, 1] if wheel_travel_base_right.shape[1] > 1 else wheel_travel_base_right[:, 0]
        
        # 转换单位
        wheel_travel_left_mm = wheel_travel_left * 1000
        wheel_travel_right_mm = wheel_travel_right * 1000
        wheel_travel_base_left_mm = wheel_travel_base_left * 1000
        wheel_travel_base_right_mm = wheel_travel_base_right * 1000
        
        # 查找零位置
        if zero_position_idx is None:
            zero_idx_left = find_zero_crossing(wheel_travel_left_mm, wheel_travel_left_mm)
            zero_idx_right = find_zero_crossing(wheel_travel_right_mm, wheel_travel_right_mm)
            zero_idx = (zero_idx_left + zero_idx_right) // 2 if zero_idx_left and zero_idx_right else len(wheel_travel_left) // 2
        else:
            zero_idx = zero_position_idx
        
        # 确定拟合区间
        fit_start = max(0, zero_idx - fit_range)
        fit_end = min(len(wheel_travel_left), zero_idx + fit_range + 1)
        
        # 左轮拟合
        x_left = wheel_travel_left_mm[fit_start:fit_end]
        y_left = wheel_travel_base_left_mm[fit_start:fit_end]
        coeffs_left, _ = linear_fit(x_left, y_left, degree=1)
        
        # 右轮拟合
        x_right = wheel_travel_right_mm[fit_start:fit_end]
        y_right = wheel_travel_base_right_mm[fit_start:fit_end]
        coeffs_right, _ = linear_fit(x_right, y_right, degree=1)
        
        # 计算斜率（mm/m = mm/mm * 1000）
        slope_left = coeffs_left[0] * 1000
        slope_right = coeffs_right[0] * 1000
        slope_avg = (slope_left + slope_right) / 2
        
        logger.debug(f"Wheel Recession: 左={slope_left:.2f}, 右={slope_right:.2f}, 平均={slope_avg:.2f} mm/m")
        
        return {
            'left_slope': slope_left,
            'right_slope': slope_right,
            'average_slope': slope_avg,
            'left_coeffs': coeffs_left.tolist(),
            'right_coeffs': coeffs_right.tolist(),
            'zero_position_idx': zero_idx,
            'fit_range': fit_range
        }
    
    def calculate_track_change(self,
                               fit_range: int = 15,
                               zero_position_idx: Optional[int] = None) -> Dict[str, float]:
        """计算Track Change（轮距变化）
        
        Args:
            fit_range: 拟合区间范围（mm），默认15mm
            zero_position_idx: 零位置索引
            
        Returns:
            包含左右轮Track Change斜率的字典
        """
        logger.debug("计算Track Change")
        
        # 提取数据
        wheel_travel_left = self.extractor.extract_by_name('wheel_travel', convert_length=True)
        wheel_travel_right = self.extractor.extract_by_name('wheel_travel', convert_length=True)
        wheel_travel_track_left = self.extractor.extract_by_name('wheel_travel_track', convert_length=True)
        wheel_travel_track_right = self.extractor.extract_by_name('wheel_travel_track', convert_length=True)
        
        # 处理多维数据
        if wheel_travel_left.ndim > 1:
            wheel_travel_left = wheel_travel_left[:, 1] if wheel_travel_left.shape[1] > 1 else wheel_travel_left[:, 0]
        if wheel_travel_right.ndim > 1:
            wheel_travel_right = wheel_travel_right[:, 1] if wheel_travel_right.shape[1] > 1 else wheel_travel_right[:, 0]
        
        if wheel_travel_track_left.ndim > 1:
            wheel_travel_track_left = wheel_travel_track_left[:, 0]
        if wheel_travel_track_right.ndim > 1:
            wheel_travel_track_right = wheel_travel_track_right[:, 1] if wheel_travel_track_right.shape[1] > 1 else wheel_travel_track_right[:, 0]
        
        # 转换单位
        wheel_travel_left_mm = wheel_travel_left * 1000
        wheel_travel_right_mm = wheel_travel_right * 1000
        wheel_travel_track_left_mm = wheel_travel_track_left * 1000
        wheel_travel_track_right_mm = wheel_travel_track_right * 1000
        
        # 查找零位置
        if zero_position_idx is None:
            zero_idx_left = find_zero_crossing(wheel_travel_left_mm, wheel_travel_left_mm)
            zero_idx_right = find_zero_crossing(wheel_travel_right_mm, wheel_travel_right_mm)
            zero_idx = (zero_idx_left + zero_idx_right) // 2 if zero_idx_left and zero_idx_right else len(wheel_travel_left) // 2
        else:
            zero_idx = zero_position_idx
        
        # 确定拟合区间
        fit_start = max(0, zero_idx - fit_range)
        fit_end = min(len(wheel_travel_left), zero_idx + fit_range + 1)
        
        # 左轮拟合
        x_left = wheel_travel_left_mm[fit_start:fit_end]
        y_left = wheel_travel_track_left_mm[fit_start:fit_end]
        coeffs_left, _ = linear_fit(x_left, y_left, degree=1)
        
        # 右轮拟合
        x_right = wheel_travel_right_mm[fit_start:fit_end]
        y_right = wheel_travel_track_right_mm[fit_start:fit_end]
        coeffs_right, _ = linear_fit(x_right, y_right, degree=1)
        
        # 计算斜率（mm/m）
        slope_left = coeffs_left[0] * 1000
        slope_right = coeffs_right[0] * 1000
        slope_avg = (slope_left + slope_right) / 2
        
        logger.debug(f"Track Change: 左={slope_left:.2f}, 右={slope_right:.2f}, 平均={slope_avg:.2f} mm/m")
        
        return {
            'left_slope': slope_left,
            'right_slope': slope_right,
            'average_slope': slope_avg,
            'left_coeffs': coeffs_left.tolist(),
            'right_coeffs': coeffs_right.tolist(),
            'zero_position_idx': zero_idx,
            'fit_range': fit_range
        }
    
    def calculate_toe_at_50mm(self,
                              bump_50mm_idx: Optional[int] = None,
                              rebound_50mm_idx: Optional[int] = None) -> Dict[str, float]:
        """计算50mm轮跳时的toe角
        
        Args:
            bump_50mm_idx: bump 50mm位置的索引
            rebound_50mm_idx: rebound 50mm位置的索引
            
        Returns:
            包含50mm轮跳时toe角的字典
        """
        logger.debug("计算50mm轮跳时的toe角")
        
        toe_left = self.extractor.extract_by_name('toe_angle', convert_angle=True)
        toe_right = self.extractor.extract_by_name('toe_angle', convert_angle=True)
        
        # 处理多维数据
        if toe_left.ndim > 1:
            toe_left = toe_left[:, 0]
        if toe_right.ndim > 1:
            toe_right = toe_right[:, 1] if toe_right.shape[1] > 1 else toe_right[:, 0]
        
        result = {}
        
        if bump_50mm_idx is not None and bump_50mm_idx < len(toe_left):
            result['bump_50mm_left'] = toe_left[bump_50mm_idx]
            result['bump_50mm_right'] = toe_right[bump_50mm_idx]
        
        if rebound_50mm_idx is not None and rebound_50mm_idx < len(toe_left):
            result['rebound_50mm_left'] = toe_left[rebound_50mm_idx]
            result['rebound_50mm_right'] = toe_right[rebound_50mm_idx]
        
        return result
    
    def calculate_2g_wheel_travel_and_rate(self,
                                           target_load: float = 2.0,
                                           half_load: Optional[float] = None) -> Dict[str, float]:
        """计算2g载荷时的轮跳行程和车轮刚度
        
        Args:
            target_load: 目标载荷（g），默认2.0
            half_load: 半载质量（kg），如果为None则从vehicle_params获取
            
        Returns:
            包含2g载荷时轮跳行程和车轮刚度的字典
        """
        logger.debug(f"计算{target_load}g载荷时的轮跳行程和车轮刚度")
        
        # 获取半载质量
        if half_load is None:
            half_load = self.get_vehicle_param('half_load', 0.0)
        
        wheel_travel_left = self.extractor.extract_by_name('wheel_travel', convert_length=True)
        wheel_travel_right = self.extractor.extract_by_name('wheel_travel', convert_length=True)
        wheel_load_left = self.extractor.extract_by_name('wheel_load_vertical_force')
        wheel_load_right = self.extractor.extract_by_name('wheel_load_vertical_force')
        
        # 处理多维数据
        if wheel_travel_left.ndim > 1:
            wheel_travel_left = wheel_travel_left[:, 1] if wheel_travel_left.shape[1] > 1 else wheel_travel_left[:, 0]
        if wheel_travel_right.ndim > 1:
            wheel_travel_right = wheel_travel_right[:, 1] if wheel_travel_right.shape[1] > 1 else wheel_travel_right[:, 0]
        
        if wheel_load_left.ndim > 1:
            wheel_load_left = wheel_load_left[:, 0]
        if wheel_load_right.ndim > 1:
            wheel_load_right = wheel_load_right[:, 1] if wheel_load_right.shape[1] > 1 else wheel_load_right[:, 0]
        
        # 计算目标载荷（N）
        target_force = target_load * 9.81 * half_load / 2  # 单轮载荷
        
        # 查找最接近目标载荷的索引
        load_combined = (wheel_load_left + wheel_load_right) / 2
        idx_2g = find_value_index(load_combined, target_force)
        
        if idx_2g is None:
            logger.warning(f"未找到{target_load}g载荷位置")
            return {}
        
        # 获取轮跳行程（mm）
        travel_2g = wheel_travel_left[idx_2g] * 1000  # m -> mm
        
        # 获取车轮刚度（N/mm）
        wheel_rate_left = self.extractor.extract_by_name('wheel_rate')
        wheel_rate_right = self.extractor.extract_by_name('wheel_rate')
        
        if wheel_rate_left.ndim > 1:
            wheel_rate_left = wheel_rate_left[:, 0]
        if wheel_rate_right.ndim > 1:
            wheel_rate_right = wheel_rate_right[:, 1] if wheel_rate_right.shape[1] > 1 else wheel_rate_right[:, 0]
        
        rate_2g = (wheel_rate_left[idx_2g] + wheel_rate_right[idx_2g]) / 2
        
        logger.debug(f"{target_load}g载荷: 轮跳行程={travel_2g:.2f}mm, 车轮刚度={rate_2g:.2f}N/mm")
        
        return {
            'wheel_travel_2g': travel_2g,
            'wheel_rate_2g': rate_2g,
            'target_load': target_load,
            'index': idx_2g
        }
    
    # ==================== Roll测试计算 ====================
    
    def calculate_roll_steer(self,
                             fit_range: float = 1.0,
                             zero_position_idx: Optional[int] = None) -> Dict[str, float]:
        """计算Roll Steer（侧倾转向）
        
        Args:
            fit_range: 拟合区间范围（度），默认1.0度
            zero_position_idx: 零位置索引
            
        Returns:
            包含左右轮Roll Steer系数的字典
        """
        logger.debug("计算Roll Steer")
        
        # 提取数据
        roll_angle = self.extractor.extract_by_name('roll_angle', convert_angle=True)
        toe_left = self.extractor.extract_by_name('toe_angle', convert_angle=True)
        toe_right = self.extractor.extract_by_name('toe_angle', convert_angle=True)
        
        # 处理多维数据（roll_angle通常是WC和CP两列）
        if roll_angle.ndim > 1:
            roll_angle_wc = roll_angle[:, 0]  # @WC roll angle
        else:
            roll_angle_wc = roll_angle
        
        if toe_left.ndim > 1:
            toe_left = toe_left[:, 0]
        if toe_right.ndim > 1:
            toe_right = toe_right[:, 1] if toe_right.shape[1] > 1 else toe_right[:, 0]
        
        # 查找零位置
        if zero_position_idx is None:
            zero_idx = find_zero_crossing(roll_angle_wc, roll_angle_wc)
            if zero_idx is None:
                zero_idx = len(roll_angle_wc) // 2
        else:
            zero_idx = zero_position_idx
        
        # 确定拟合区间（转换为索引范围，假设每度对应10个数据点）
        fit_range_idx = int(fit_range * 10)
        fit_start = max(0, zero_idx - fit_range_idx)
        fit_end = min(len(roll_angle_wc), zero_idx + fit_range_idx + 1)
        
        # 左轮拟合
        x_left = roll_angle_wc[fit_start:fit_end]
        y_left = toe_left[fit_start:fit_end]
        coeffs_left, _ = linear_fit(x_left, y_left, degree=1)
        
        # 右轮拟合
        x_right = roll_angle_wc[fit_start:fit_end]
        y_right = toe_right[fit_start:fit_end]
        coeffs_right, _ = linear_fit(x_right, y_right, degree=1)
        
        # Roll Steer系数（deg/deg）
        # 注意：右轮需要取负值（MATLAB代码中：*-1）
        slope_left = coeffs_left[0]
        slope_right = -coeffs_right[0]  # 右轮取负
        slope_avg = (slope_left + slope_right) / 2
        
        logger.debug(f"Roll Steer: 左={slope_left:.3f}, 右={slope_right:.3f}, 平均={slope_avg:.3f} deg/deg")
        
        return {
            'left_slope': slope_left,
            'right_slope': slope_right,
            'average_slope': slope_avg,
            'left_coeffs': coeffs_left.tolist(),
            'right_coeffs': coeffs_right.tolist(),
            'zero_position_idx': zero_idx,
            'fit_range': fit_range
        }
    
    def calculate_roll_camber(self,
                             fit_range: float = 1.0,
                             zero_position_idx: Optional[int] = None) -> Dict[str, float]:
        """计算Roll Camber（侧倾外倾）
        
        Args:
            fit_range: 拟合区间范围（度），默认1.0度
            zero_position_idx: 零位置索引
            
        Returns:
            包含左右轮Roll Camber系数的字典
        """
        logger.debug("计算Roll Camber")
        
        # 提取数据
        roll_angle = self.extractor.extract_by_name('roll_angle', convert_angle=True)
        camber_left = self.extractor.extract_by_name('camber_angle', convert_angle=True)
        camber_right = self.extractor.extract_by_name('camber_angle', convert_angle=True)
        
        # 处理多维数据
        if roll_angle.ndim > 1:
            roll_angle_wc = roll_angle[:, 0]
        else:
            roll_angle_wc = roll_angle
        
        if camber_left.ndim > 1:
            camber_left = camber_left[:, 0]
        if camber_right.ndim > 1:
            camber_right = camber_right[:, 1] if camber_right.shape[1] > 1 else camber_right[:, 0]
        
        # 查找零位置
        if zero_position_idx is None:
            zero_idx = find_zero_crossing(roll_angle_wc, roll_angle_wc)
            if zero_idx is None:
                zero_idx = len(roll_angle_wc) // 2
        else:
            zero_idx = zero_position_idx
        
        # 确定拟合区间
        fit_range_idx = int(fit_range * 10)
        fit_start = max(0, zero_idx - fit_range_idx)
        fit_end = min(len(roll_angle_wc), zero_idx + fit_range_idx + 1)
        
        # 左轮拟合
        x_left = roll_angle_wc[fit_start:fit_end]
        y_left = camber_left[fit_start:fit_end]
        coeffs_left, _ = linear_fit(x_left, y_left, degree=1)
        
        # 右轮拟合
        x_right = roll_angle_wc[fit_start:fit_end]
        y_right = camber_right[fit_start:fit_end]
        coeffs_right, _ = linear_fit(x_right, y_right, degree=1)
        
        # Roll Camber系数（deg/deg）
        slope_left = coeffs_left[0]
        slope_right = -coeffs_right[0]  # 右轮取负
        slope_avg = (slope_left + slope_right) / 2
        
        logger.debug(f"Roll Camber: 左={slope_left:.3f}, 右={slope_right:.3f}, 平均={slope_avg:.3f} deg/deg")
        
        return {
            'left_slope': slope_left,
            'right_slope': slope_right,
            'average_slope': slope_avg,
            'left_coeffs': coeffs_left.tolist(),
            'right_coeffs': coeffs_right.tolist(),
            'zero_position_idx': zero_idx,
            'fit_range': fit_range
        }
    
    def calculate_roll_camber_relative_ground(self,
                                             fit_range: float = 1.0,
                                             zero_position_idx: Optional[int] = None) -> Dict[str, float]:
        """计算Roll Camber Relative Ground（相对地面外倾）
        
        camber_relative_ground = camber + roll_angle_CP
        
        Args:
            fit_range: 拟合区间范围（度），默认1.0度
            zero_position_idx: 零位置索引
            
        Returns:
            包含左右轮Roll Camber Relative Ground系数的字典
        """
        logger.debug("计算Roll Camber Relative Ground")
        
        # 提取数据
        roll_angle = self.extractor.extract_by_name('roll_angle', convert_angle=True)
        camber_left = self.extractor.extract_by_name('camber_angle', convert_angle=True)
        camber_right = self.extractor.extract_by_name('camber_angle', convert_angle=True)
        
        # 处理多维数据
        if roll_angle.ndim > 1:
            roll_angle_cp = roll_angle[:, 1]  # @CP roll angle
        else:
            roll_angle_cp = roll_angle
        
        if camber_left.ndim > 1:
            camber_left = camber_left[:, 0]
        if camber_right.ndim > 1:
            camber_right = camber_right[:, 1] if camber_right.shape[1] > 1 else camber_right[:, 0]
        
        # 计算相对地面外倾角
        camber_ground_left = camber_left + roll_angle_cp
        camber_ground_right = camber_right - roll_angle_cp  # 右轮取负
        
        # 查找零位置
        if zero_position_idx is None:
            zero_idx = find_zero_crossing(roll_angle_cp, roll_angle_cp)
            if zero_idx is None:
                zero_idx = len(roll_angle_cp) // 2
        else:
            zero_idx = zero_position_idx
        
        # 确定拟合区间
        fit_range_idx = int(fit_range * 10)
        fit_start = max(0, zero_idx - fit_range_idx)
        fit_end = min(len(roll_angle_cp), zero_idx + fit_range_idx + 1)
        
        # 左轮拟合
        x_left = roll_angle_cp[fit_start:fit_end]
        y_left = camber_ground_left[fit_start:fit_end]
        coeffs_left, _ = linear_fit(x_left, y_left, degree=1)
        
        # 右轮拟合
        x_right = roll_angle_cp[fit_start:fit_end]
        y_right = camber_ground_right[fit_start:fit_end]
        coeffs_right, _ = linear_fit(x_right, y_right, degree=1)
        
        # Roll Camber Relative Ground系数（deg/deg）
        slope_left = coeffs_left[0]
        slope_right = -coeffs_right[0]  # 右轮取负
        slope_avg = (slope_left + slope_right) / 2
        
        logger.debug(f"Roll Camber Relative Ground: 左={slope_left:.3f}, 右={slope_right:.3f}, 平均={slope_avg:.3f} deg/deg")
        
        return {
            'left_slope': slope_left,
            'right_slope': slope_right,
            'average_slope': slope_avg,
            'left_coeffs': coeffs_left.tolist(),
            'right_coeffs': coeffs_right.tolist(),
            'zero_position_idx': zero_idx,
            'fit_range': fit_range
        }
    
    def calculate_roll_rate(self) -> Dict[str, float]:
        """计算Roll Rate（侧倾刚度）
        
        Returns:
            包含悬架侧倾刚度和总侧倾刚度的字典
        """
        logger.debug("计算Roll Rate")
        
        # 提取数据
        susp_roll_rate = self.extractor.extract_by_name('susp_roll_rate')
        total_roll_rate = self.extractor.extract_by_name('total_roll_rate')
        
        # 如果是多维的，取第一列
        if susp_roll_rate.ndim > 1:
            susp_roll_rate = susp_roll_rate[:, 0]
        if total_roll_rate.ndim > 1:
            total_roll_rate = total_roll_rate[:, 0]
        
        # 单位转换：从 mm/deg 转换为 Nm/deg
        # 注意：MATLAB代码中有单位转换，这里需要根据实际情况调整
        # 假设数据已经是正确的单位，或者需要乘以某个转换系数
        
        # 取零位置的值（通常是中间位置）
        zero_idx = len(susp_roll_rate) // 2
        
        susp_rate = susp_roll_rate[zero_idx]
        total_rate = total_roll_rate[zero_idx]
        
        logger.debug(f"Roll Rate: 悬架={susp_rate:.2f}, 总={total_rate:.2f} Nm/deg")
        
        return {
            'susp_roll_rate': susp_rate,
            'total_roll_rate': total_rate,
            'zero_position_idx': zero_idx
        }
    
    def calculate_roll_center_height(self) -> Dict[str, float]:
        """计算Roll Center Height（侧倾中心高度）
        
        Returns:
            包含侧倾中心高度的字典
        """
        logger.debug("计算Roll Center Height")
        
        # 提取数据
        roll_center_location = self.extractor.extract_by_name('roll_center_location', convert_length=True)
        
        # 处理多维数据（通常是lateral和vertical两列）
        if roll_center_location.ndim > 1:
            roll_center_height = roll_center_location[:, 1]  # vertical
        else:
            roll_center_height = roll_center_location
        
        # 转换单位：m -> mm
        roll_center_height_mm = roll_center_height * 1000
        
        # 取零位置的值
        zero_idx = len(roll_center_height_mm) // 2
        height = roll_center_height_mm[zero_idx]
        
        logger.debug(f"Roll Center Height: {height:.2f} mm")
        
        return {
            'roll_center_height': height,
            'zero_position_idx': zero_idx
        }
    
    # ==================== Static Load Lateral计算 ====================
    
    def calculate_lateral_toe_compliance(self,
                                        fit_range: float = 1.0) -> Dict[str, float]:
        """计算Lateral Toe Compliance（侧向力前束柔度）
        
        Args:
            fit_range: 拟合区间范围（kN），默认1.0kN
            
        Returns:
            包含左右轮Lateral Toe Compliance的字典
        """
        logger.debug("计算Lateral Toe Compliance")
        
        # 提取数据
        lateral_force_left = self.extractor.extract_by_name('wheel_load_lateral')
        lateral_force_right = self.extractor.extract_by_name('wheel_load_lateral')
        toe_left = self.extractor.extract_by_name('toe_angle', convert_angle=True)
        toe_right = self.extractor.extract_by_name('toe_angle', convert_angle=True)
        
        # 处理多维数据
        if lateral_force_left.ndim > 1:
            lateral_force_left = lateral_force_left[:, 0]
        if lateral_force_right.ndim > 1:
            lateral_force_right = lateral_force_right[:, 1] if lateral_force_right.shape[1] > 1 else lateral_force_right[:, 0]
        
        if toe_left.ndim > 1:
            toe_left = toe_left[:, 0]
        if toe_right.ndim > 1:
            toe_right = toe_right[:, 1] if toe_right.shape[1] > 1 else toe_right[:, 0]
        
        # 转换单位：N -> kN
        lateral_force_left_kn = lateral_force_left / 1000
        lateral_force_right_kn = lateral_force_right / 1000
        
        # 查找零位置
        zero_idx = find_zero_crossing(lateral_force_left_kn, lateral_force_left_kn)
        if zero_idx is None:
            zero_idx = len(lateral_force_left_kn) // 2
        
        # 确定拟合区间
        fit_range_idx = int(fit_range * 10)  # 假设每kN对应10个数据点
        fit_start = max(0, zero_idx - fit_range_idx)
        fit_end = min(len(lateral_force_left_kn), zero_idx + fit_range_idx + 1)
        
        # 左轮拟合
        x_left = lateral_force_left_kn[fit_start:fit_end]
        y_left = toe_left[fit_start:fit_end]
        coeffs_left, _ = linear_fit(x_left, y_left, degree=1)
        
        # 右轮拟合
        x_right = lateral_force_right_kn[fit_start:fit_end]
        y_right = toe_right[fit_start:fit_end]
        coeffs_right, _ = linear_fit(x_right, y_right, degree=1)
        
        # Lateral Toe Compliance（deg/kN）
        slope_left = coeffs_left[0]
        slope_right = coeffs_right[0]
        slope_avg = (slope_left + slope_right) / 2
        
        logger.debug(f"Lateral Toe Compliance: 左={slope_left:.3f}, 右={slope_right:.3f}, 平均={slope_avg:.3f} deg/kN")
        
        return {
            'left_slope': slope_left,
            'right_slope': slope_right,
            'average_slope': slope_avg,
            'left_coeffs': coeffs_left.tolist(),
            'right_coeffs': coeffs_right.tolist(),
            'zero_position_idx': zero_idx,
            'fit_range': fit_range
        }
    
    def calculate_lateral_camber_compliance(self,
                                            fit_range: float = 1.0) -> Dict[str, float]:
        """计算Lateral Camber Compliance（侧向力外倾柔度）
        
        Args:
            fit_range: 拟合区间范围（kN），默认1.0kN
            
        Returns:
            包含左右轮Lateral Camber Compliance的字典
        """
        logger.debug("计算Lateral Camber Compliance")
        
        # 提取数据
        lateral_force_left = self.extractor.extract_by_name('wheel_load_lateral')
        lateral_force_right = self.extractor.extract_by_name('wheel_load_lateral')
        camber_left = self.extractor.extract_by_name('camber_angle', convert_angle=True)
        camber_right = self.extractor.extract_by_name('camber_angle', convert_angle=True)
        
        # 处理多维数据
        if lateral_force_left.ndim > 1:
            lateral_force_left = lateral_force_left[:, 0]
        if lateral_force_right.ndim > 1:
            lateral_force_right = lateral_force_right[:, 1] if lateral_force_right.shape[1] > 1 else lateral_force_right[:, 0]
        
        if camber_left.ndim > 1:
            camber_left = camber_left[:, 0]
        if camber_right.ndim > 1:
            camber_right = camber_right[:, 1] if camber_right.shape[1] > 1 else camber_right[:, 0]
        
        # 转换单位：N -> kN
        lateral_force_left_kn = lateral_force_left / 1000
        lateral_force_right_kn = lateral_force_right / 1000
        
        # 查找零位置
        zero_idx = find_zero_crossing(lateral_force_left_kn, lateral_force_left_kn)
        if zero_idx is None:
            zero_idx = len(lateral_force_left_kn) // 2
        
        # 确定拟合区间
        fit_range_idx = int(fit_range * 10)
        fit_start = max(0, zero_idx - fit_range_idx)
        fit_end = min(len(lateral_force_left_kn), zero_idx + fit_range_idx + 1)
        
        # 左轮拟合
        x_left = lateral_force_left_kn[fit_start:fit_end]
        y_left = camber_left[fit_start:fit_end]
        coeffs_left, _ = linear_fit(x_left, y_left, degree=1)
        
        # 右轮拟合
        x_right = lateral_force_right_kn[fit_start:fit_end]
        y_right = camber_right[fit_start:fit_end]
        coeffs_right, _ = linear_fit(x_right, y_right, degree=1)
        
        # Lateral Camber Compliance（deg/kN）
        slope_left = coeffs_left[0]
        slope_right = coeffs_right[0]
        slope_avg = (slope_left + slope_right) / 2
        
        logger.debug(f"Lateral Camber Compliance: 左={slope_left:.3f}, 右={slope_right:.3f}, 平均={slope_avg:.3f} deg/kN")
        
        return {
            'left_slope': slope_left,
            'right_slope': slope_right,
            'average_slope': slope_avg,
            'left_coeffs': coeffs_left.tolist(),
            'right_coeffs': coeffs_right.tolist(),
            'zero_position_idx': zero_idx,
            'fit_range': fit_range
        }
    
    # ==================== Static Load Braking计算 ====================
    
    def calculate_braking_toe_compliance(self,
                                         fit_range: float = 1.0) -> Dict[str, float]:
        """计算Braking Toe Compliance（制动力前束柔度）
        
        Args:
            fit_range: 拟合区间范围（kN），默认1.0kN
            
        Returns:
            包含左右轮Braking Toe Compliance的字典
        """
        logger.debug("计算Braking Toe Compliance")
        
        # 提取数据（制动力通常是braking_left和braking_right）
        braking_force = self.extractor.extract_by_name('wheel_load_longitudinal')
        toe_left = self.extractor.extract_by_name('toe_angle', convert_angle=True)
        toe_right = self.extractor.extract_by_name('toe_angle', convert_angle=True)
        
        # 处理多维数据（braking通常是4列：brak_left, brak_right, driv_left, driv_right）
        if braking_force.ndim > 1:
            braking_force_left = braking_force[:, 0]  # brak_left
            braking_force_right = braking_force[:, 1]  # brak_right
        else:
            braking_force_left = braking_force
            braking_force_right = braking_force
        
        if toe_left.ndim > 1:
            toe_left = toe_left[:, 0]
        if toe_right.ndim > 1:
            toe_right = toe_right[:, 1] if toe_right.shape[1] > 1 else toe_right[:, 0]
        
        # 转换单位：N -> kN
        braking_force_left_kn = braking_force_left / 1000
        braking_force_right_kn = braking_force_right / 1000
        
        # 查找零位置
        zero_idx = find_zero_crossing(braking_force_left_kn, braking_force_left_kn)
        if zero_idx is None:
            zero_idx = len(braking_force_left_kn) // 2
        
        # 确定拟合区间
        fit_range_idx = int(fit_range * 10)
        fit_start = max(0, zero_idx - fit_range_idx)
        fit_end = min(len(braking_force_left_kn), zero_idx + fit_range_idx + 1)
        
        # 左轮拟合
        x_left = braking_force_left_kn[fit_start:fit_end]
        y_left = toe_left[fit_start:fit_end]
        coeffs_left, _ = linear_fit(x_left, y_left, degree=1)
        
        # 右轮拟合
        x_right = braking_force_right_kn[fit_start:fit_end]
        y_right = toe_right[fit_start:fit_end]
        coeffs_right, _ = linear_fit(x_right, y_right, degree=1)
        
        # Braking Toe Compliance（deg/kN）
        slope_left = coeffs_left[0]
        slope_right = coeffs_right[0]
        slope_avg = (slope_left + slope_right) / 2
        
        logger.debug(f"Braking Toe Compliance: 左={slope_left:.3f}, 右={slope_right:.3f}, 平均={slope_avg:.3f} deg/kN")
        
        return {
            'left_slope': slope_left,
            'right_slope': slope_right,
            'average_slope': slope_avg,
            'left_coeffs': coeffs_left.tolist(),
            'right_coeffs': coeffs_right.tolist(),
            'zero_position_idx': zero_idx,
            'fit_range': fit_range
        }
    
    def calculate_anti_dive(self) -> Dict[str, float]:
        """计算Anti-dive（抗点头率）
        
        Returns:
            包含左右轮Anti-dive的字典
        """
        logger.debug("计算Anti-dive")
        
        # 提取数据
        anti_dive = self.extractor.extract_by_name('anti_dive')
        
        # 处理多维数据
        if anti_dive.ndim > 1:
            anti_dive_left = anti_dive[:, 0]
            anti_dive_right = anti_dive[:, 1] if anti_dive.shape[1] > 1 else anti_dive[:, 0]
        else:
            anti_dive_left = anti_dive
            anti_dive_right = anti_dive
        
        # 取零位置的值
        zero_idx = len(anti_dive_left) // 2
        anti_dive_left_val = anti_dive_left[zero_idx]
        anti_dive_right_val = anti_dive_right[zero_idx]
        anti_dive_avg = (anti_dive_left_val + anti_dive_right_val) / 2
        
        logger.debug(f"Anti-dive: 左={anti_dive_left_val:.2f}%, 右={anti_dive_right_val:.2f}%, 平均={anti_dive_avg:.2f}%")
        
        return {
            'left': anti_dive_left_val,
            'right': anti_dive_right_val,
            'average': anti_dive_avg,
            'zero_position_idx': zero_idx
        }
    
    # ==================== Static Load Acceleration计算 ====================
    
    def calculate_acceleration_toe_compliance(self,
                                             fit_range: float = 1.0) -> Dict[str, float]:
        """计算Acceleration Toe Compliance（加速力前束柔度）
        
        Args:
            fit_range: 拟合区间范围（kN），默认1.0kN
            
        Returns:
            包含左右轮Acceleration Toe Compliance的字典
        """
        logger.debug("计算Acceleration Toe Compliance")
        
        # 提取数据（加速力通常是driv_left和driv_right）
        acceleration_force = self.extractor.extract_by_name('wheel_load_longitudinal')
        toe_left = self.extractor.extract_by_name('toe_angle', convert_angle=True)
        toe_right = self.extractor.extract_by_name('toe_angle', convert_angle=True)
        
        # 处理多维数据
        if acceleration_force.ndim > 1:
            acceleration_force_left = acceleration_force[:, 2]  # driv_left
            acceleration_force_right = acceleration_force[:, 3]  # driv_right
        else:
            acceleration_force_left = acceleration_force
            acceleration_force_right = acceleration_force
        
        if toe_left.ndim > 1:
            toe_left = toe_left[:, 0]
        if toe_right.ndim > 1:
            toe_right = toe_right[:, 1] if toe_right.shape[1] > 1 else toe_right[:, 0]
        
        # 转换单位：N -> kN
        acceleration_force_left_kn = acceleration_force_left / 1000
        acceleration_force_right_kn = acceleration_force_right / 1000
        
        # 查找零位置
        zero_idx = find_zero_crossing(acceleration_force_left_kn, acceleration_force_left_kn)
        if zero_idx is None:
            zero_idx = len(acceleration_force_left_kn) // 2
        
        # 确定拟合区间
        fit_range_idx = int(fit_range * 10)
        fit_start = max(0, zero_idx - fit_range_idx)
        fit_end = min(len(acceleration_force_left_kn), zero_idx + fit_range_idx + 1)
        
        # 左轮拟合
        x_left = acceleration_force_left_kn[fit_start:fit_end]
        y_left = toe_left[fit_start:fit_end]
        coeffs_left, _ = linear_fit(x_left, y_left, degree=1)
        
        # 右轮拟合
        x_right = acceleration_force_right_kn[fit_start:fit_end]
        y_right = toe_right[fit_start:fit_end]
        coeffs_right, _ = linear_fit(x_right, y_right, degree=1)
        
        # Acceleration Toe Compliance（deg/kN）
        slope_left = coeffs_left[0]
        slope_right = coeffs_right[0]
        slope_avg = (slope_left + slope_right) / 2
        
        logger.debug(f"Acceleration Toe Compliance: 左={slope_left:.3f}, 右={slope_right:.3f}, 平均={slope_avg:.3f} deg/kN")
        
        return {
            'left_slope': slope_left,
            'right_slope': slope_right,
            'average_slope': slope_avg,
            'left_coeffs': coeffs_left.tolist(),
            'right_coeffs': coeffs_right.tolist(),
            'zero_position_idx': zero_idx,
            'fit_range': fit_range
        }
    
    def calculate_anti_squat(self) -> Dict[str, float]:
        """计算Anti-squat（抗下蹲率）
        
        Returns:
            包含左右轮Anti-squat的字典
        """
        logger.debug("计算Anti-squat")
        
        # 提取数据
        anti_squat = self.extractor.extract_by_name('anti_squat_acceleration')
        
        # 处理多维数据
        if anti_squat.ndim > 1:
            anti_squat_left = anti_squat[:, 0]
            anti_squat_right = anti_squat[:, 1] if anti_squat.shape[1] > 1 else anti_squat[:, 0]
        else:
            anti_squat_left = anti_squat
            anti_squat_right = anti_squat
        
        # 取零位置的值
        zero_idx = len(anti_squat_left) // 2
        anti_squat_left_val = anti_squat_left[zero_idx]
        anti_squat_right_val = anti_squat_right[zero_idx]
        anti_squat_avg = (anti_squat_left_val + anti_squat_right_val) / 2
        
        logger.debug(f"Anti-squat: 左={anti_squat_left_val:.2f}%, 右={anti_squat_right_val:.2f}%, 平均={anti_squat_avg:.2f}%")
        
        return {
            'left': anti_squat_left_val,
            'right': anti_squat_right_val,
            'average': anti_squat_avg,
            'zero_position_idx': zero_idx
        }
