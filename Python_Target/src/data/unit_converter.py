"""单位转换模块

提供角度、长度、刚度等单位的转换函数。
"""

import numpy as np
from typing import Union

from ..utils.logger import get_logger

logger = get_logger(__name__)

# 转换常数
RAD_TO_DEG = 180.0 / np.pi
DEG_TO_RAD = np.pi / 180.0
MM_TO_M = 1.0 / 1000.0
M_TO_MM = 1000.0


def rad_to_deg(rad: Union[float, np.ndarray]) -> Union[float, np.ndarray]:
    """弧度转角度
    
    Args:
        rad: 弧度值或数组
        
    Returns:
        角度值或数组
    """
    return rad * RAD_TO_DEG


def deg_to_rad(deg: Union[float, np.ndarray]) -> Union[float, np.ndarray]:
    """角度转弧度
    
    Args:
        deg: 角度值或数组
        
    Returns:
        弧度值或数组
    """
    return deg * DEG_TO_RAD


def mm_to_m(mm: Union[float, np.ndarray]) -> Union[float, np.ndarray]:
    """毫米转米
    
    Args:
        mm: 毫米值或数组
        
    Returns:
        米值或数组
    """
    return mm * MM_TO_M


def m_to_mm(m: Union[float, np.ndarray]) -> Union[float, np.ndarray]:
    """米转毫米
    
    Args:
        m: 米值或数组
        
    Returns:
        毫米值或数组
    """
    return m * M_TO_MM


def convert_angle_array(data: np.ndarray, from_unit: str = 'rad', 
                       to_unit: str = 'deg') -> np.ndarray:
    """批量转换角度数组
    
    Args:
        data: 角度数据数组
        from_unit: 源单位 ('rad' 或 'deg')
        to_unit: 目标单位 ('rad' 或 'deg')
        
    Returns:
        转换后的数组
    """
    if from_unit == to_unit:
        return data.copy()
    
    if from_unit == 'rad' and to_unit == 'deg':
        return rad_to_deg(data)
    elif from_unit == 'deg' and to_unit == 'rad':
        return deg_to_rad(data)
    else:
        raise ValueError(f"不支持的单位转换: {from_unit} -> {to_unit}")


def convert_length_array(data: np.ndarray, from_unit: str = 'mm', 
                        to_unit: str = 'm') -> np.ndarray:
    """批量转换长度数组
    
    Args:
        data: 长度数据数组
        from_unit: 源单位 ('mm' 或 'm')
        to_unit: 目标单位 ('mm' 或 'm')
        
    Returns:
        转换后的数组
    """
    if from_unit == to_unit:
        return data.copy()
    
    if from_unit == 'mm' and to_unit == 'm':
        return mm_to_m(data)
    elif from_unit == 'm' and to_unit == 'mm':
        return m_to_mm(data)
    else:
        raise ValueError(f"不支持的单位转换: {from_unit} -> {to_unit}")
