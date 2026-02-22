"""数学工具模块

提供线性拟合、特征点定位等数学计算函数。
"""

import numpy as np
from typing import Tuple, Optional

from .logger import get_logger

logger = get_logger(__name__)


def linear_fit(x: np.ndarray, y: np.ndarray, degree: int = 1, 
              return_r_squared: bool = False) -> Tuple[np.ndarray, np.ndarray, Optional[float]]:
    """线性拟合（使用numpy.polyfit）
    
    Args:
        x: 自变量数组
        y: 因变量数组
        degree: 多项式次数，默认为1（线性拟合）
        return_r_squared: 是否返回R²值，默认False
        
    Returns:
        如果return_r_squared=False: (coefficients, fitted_values)
        如果return_r_squared=True: (coefficients, fitted_values, r_squared)
        - coefficients: [a, b] 对于线性拟合，表示 y = ax + b
        - fitted_values: 拟合后的y值
        - r_squared: R²值（决定系数），表示拟合质量，范围[0, 1]，越接近1越好
        
    Raises:
        ValueError: 输入数组长度不匹配或为空
    """
    if len(x) != len(y):
        raise ValueError(f"x和y数组长度不匹配: {len(x)} vs {len(y)}")
    
    if len(x) == 0:
        raise ValueError("输入数组为空")
    
    if len(x) < degree + 1:
        raise ValueError(f"数据点数量({len(x)})不足以进行{degree}次拟合")
    
    # 检查数据中是否有无效值
    if np.any(np.isnan(x)) or np.any(np.isnan(y)):
        logger.warning("数据中包含NaN值，尝试清理")
        valid_mask = ~(np.isnan(x) | np.isnan(y))
        x = x[valid_mask]
        y = y[valid_mask]
        if len(x) < degree + 1:
            raise ValueError(f"清理后数据点数量({len(x)})不足以进行{degree}次拟合")
    
    if np.any(np.isinf(x)) or np.any(np.isinf(y)):
        logger.warning("数据中包含Inf值，尝试清理")
        valid_mask = ~(np.isinf(x) | np.isinf(y))
        x = x[valid_mask]
        y = y[valid_mask]
        if len(x) < degree + 1:
            raise ValueError(f"清理后数据点数量({len(x)})不足以进行{degree}次拟合")
    
    try:
        # 使用numpy.polyfit进行拟合
        coefficients = np.polyfit(x, y, degree)
        
        # 计算拟合值
        fitted_values = np.polyval(coefficients, x)
        
        # 计算R²值（如果需要）
        r_squared = None
        if return_r_squared:
            ss_res = np.sum((y - fitted_values) ** 2)
            ss_tot = np.sum((y - np.mean(y)) ** 2)
            if ss_tot == 0:
                r_squared = 1.0  # 如果总平方和为0，说明所有值都相同，R²=1
            else:
                r_squared = float(1 - (ss_res / ss_tot))
            logger.debug(f"线性拟合完成: 系数={coefficients}, R²={r_squared:.4f}, 数据点数={len(x)}")
        else:
            logger.debug(f"线性拟合完成: 系数={coefficients}, 数据点数={len(x)}")
        
        if return_r_squared:
            return coefficients, fitted_values, r_squared
        else:
            return coefficients, fitted_values
    except np.linalg.LinAlgError as e:
        # SVD不收敛或其他线性代数错误
        logger.warning(f"线性拟合SVD不收敛: {e}，数据点数={len(x)}，尝试使用伪逆方法")
        try:
            # 尝试使用伪逆方法作为备选
            if degree == 1:
                # 对于线性拟合，使用最小二乘法的显式解
                A = np.vstack([x, np.ones(len(x))]).T
                coefficients = np.linalg.lstsq(A, y, rcond=None)[0]
                # polyfit返回的系数顺序是 [a, b] 对于 y = ax + b
                # 但lstsq返回的是 [a, b]，需要反转以匹配polyfit的格式
                coefficients = coefficients[::-1]
            else:
                # 对于高次拟合，使用Vandermonde矩阵
                A = np.vander(x, degree + 1)
                coefficients = np.linalg.lstsq(A, y, rcond=None)[0]
                coefficients = coefficients[::-1]
            
            fitted_values = np.polyval(coefficients, x)
            
            # 计算R²值（如果需要）
            r_squared = None
            if return_r_squared:
                ss_res = np.sum((y - fitted_values) ** 2)
                ss_tot = np.sum((y - np.mean(y)) ** 2)
                if ss_tot == 0:
                    r_squared = 1.0
                else:
                    r_squared = float(1 - (ss_res / ss_tot))
                logger.debug(f"使用备选方法完成拟合: 系数={coefficients}, R²={r_squared:.4f}")
            else:
                logger.debug(f"使用备选方法完成拟合: 系数={coefficients}")
            
            if return_r_squared:
                return coefficients, fitted_values, r_squared
            else:
                return coefficients, fitted_values
        except Exception as e2:
            logger.error(f"备选拟合方法也失败: {e2}")
            raise ValueError(f"线性拟合失败: 原始错误={e}, 备选方法错误={e2}")
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
