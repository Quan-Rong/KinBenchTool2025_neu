"""数学工具模块

提供线性拟合、特征点定位等数学计算函数。
"""

import numpy as np
from typing import Tuple, Optional

from .logger import get_logger

logger = get_logger(__name__)


def linear_fit(x: np.ndarray, y: np.ndarray, degree: int = 1) -> Tuple[np.ndarray, np.ndarray]:
    """线性拟合（使用numpy.polyfit）
    
    Args:
        x: 自变量数组
        y: 因变量数组
        degree: 多项式次数，默认为1（线性拟合）
        
    Returns:
        (coefficients, fitted_values): 拟合系数数组和拟合值数组
        - coefficients: [a, b] 对于线性拟合，表示 y = ax + b
        - fitted_values: 拟合后的y值
        
    Raises:
        ValueError: 输入数组长度不匹配或为空
    """
    if len(x) != len(y):
        raise ValueError(f"x和y数组长度不匹配: {len(x)} vs {len(y)}")
    
    if len(x) == 0:
        raise ValueError("输入数组为空")
    
    if len(x) < degree + 1:
        raise ValueError(f"数据点数量({len(x)})不足以进行{degree}次拟合")
    
    try:
        # 使用numpy.polyfit进行拟合
        coefficients = np.polyfit(x, y, degree)
        
        # 计算拟合值
        fitted_values = np.polyval(coefficients, x)
        
        logger.debug(f"线性拟合完成: 系数={coefficients}, 数据点数={len(x)}")
        return coefficients, fitted_values
    except Exception as e:
        logger.error(f"线性拟合失败: {e}")
        raise


def find_zero_crossing(x: np.ndarray, y: np.ndarray, target: float = 0.0) -> Optional[int]:
    """查找y值最接近目标值的索引
    
    Args:
        x: 自变量数组
        y: 因变量数组
        target: 目标值，默认为0.0
        
    Returns:
        最接近目标值的索引，如果数组为空则返回None
    """
    if len(y) == 0:
        return None
    
    # 计算与目标值的差值
    diff = np.abs(y - target)
    # 找到最小差值的索引
    idx = np.argmin(diff)
    
    logger.debug(f"找到最接近{target}的点: 索引={idx}, 值={y[idx]}")
    return int(idx)


def find_value_index(x: np.ndarray, target: float) -> Optional[int]:
    """在x数组中查找最接近目标值的索引
    
    Args:
        x: 数组
        target: 目标值
        
    Returns:
        最接近目标值的索引，如果数组为空则返回None
    """
    if len(x) == 0:
        return None
    
    diff = np.abs(x - target)
    idx = np.argmin(diff)
    
    logger.debug(f"找到最接近{target}的点: 索引={idx}, 值={x[idx]}")
    return int(idx)


def calculate_slope(x: np.ndarray, y: np.ndarray, 
                   x_range: Optional[Tuple[float, float]] = None) -> float:
    """计算斜率（线性拟合的系数a）
    
    Args:
        x: 自变量数组
        y: 因变量数组
        x_range: 拟合区间 (min, max)，如果为None则使用全部数据
        
    Returns:
        斜率值
    """
    if x_range is not None:
        # 筛选区间内的数据
        mask = (x >= x_range[0]) & (x <= x_range[1])
        x_filtered = x[mask]
        y_filtered = y[mask]
        
        if len(x_filtered) < 2:
            logger.warning(f"区间内数据点不足，使用全部数据")
            x_filtered = x
            y_filtered = y
    else:
        x_filtered = x
        y_filtered = y
    
    coefficients, _ = linear_fit(x_filtered, y_filtered, degree=1)
    slope = coefficients[0]  # 线性拟合的第一个系数是斜率
    
    logger.debug(f"计算斜率: {slope}")
    return float(slope)
