"""数据验证模块

提供数据质量检查、范围验证、异常值检测等功能。
"""

import numpy as np
from typing import Dict, List, Tuple, Optional, Any
from ..utils.logger import get_logger
from ..utils.exceptions import DataValidationError

logger = get_logger(__name__)


class DataValidator:
    """数据验证器
    
    提供数据质量检查、范围验证、异常值检测等功能。
    """
    
    # 默认数据范围限制
    DEFAULT_RANGES = {
        'wheel_travel': (-150.0, 150.0),  # mm
        'angle': (-90.0, 90.0),  # deg
        'force': (-50.0, 50.0),  # kN
        'torque': (-500.0, 500.0),  # Nm
        'camber_angle': (-10.0, 10.0),  # deg
        'toe_angle': (-10.0, 10.0),  # deg
    }
    
    def __init__(self, custom_ranges: Optional[Dict[str, Tuple[float, float]]] = None):
        """初始化数据验证器
        
        Args:
            custom_ranges: 自定义数据范围字典，格式为 {参数名: (最小值, 最大值)}
        """
        self.ranges = self.DEFAULT_RANGES.copy()
        if custom_ranges:
            self.ranges.update(custom_ranges)
        logger.debug(f"数据验证器初始化，范围限制: {self.ranges}")
    
    def validate_range(self, data: np.ndarray, param_name: str, 
                      custom_range: Optional[Tuple[float, float]] = None) -> Dict[str, Any]:
        """验证数据范围
        
        Args:
            data: 数据数组
            param_name: 参数名称
            custom_range: 自定义范围 (min, max)，如果为None则使用默认范围
            
        Returns:
            验证结果字典，包含：
            - valid: 是否通过验证
            - out_of_range_count: 超出范围的数据点数量
            - out_of_range_indices: 超出范围的数据点索引
            - min_value: 数据最小值
            - max_value: 数据最大值
            - range_limit: 使用的范围限制
            - warnings: 警告信息列表
        """
        result = {
            'valid': True,
            'out_of_range_count': 0,
            'out_of_range_indices': [],
            'min_value': float(np.min(data)) if len(data) > 0 else None,
            'max_value': float(np.max(data)) if len(data) > 0 else None,
            'range_limit': None,
            'warnings': []
        }
        
        if len(data) == 0:
            result['valid'] = False
            result['warnings'].append(f"{param_name}: 数据为空")
            return result
        
        # 确定范围限制
        if custom_range:
            range_limit = custom_range
        elif param_name in self.ranges:
            range_limit = self.ranges[param_name]
        else:
            # 如果没有找到对应的范围，使用数据的±3倍标准差作为范围
            mean = np.mean(data)
            std = np.std(data)
            range_limit = (mean - 3 * std, mean + 3 * std)
            result['warnings'].append(f"{param_name}: 使用自动计算的范围 {range_limit}")
        
        result['range_limit'] = range_limit
        min_val, max_val = range_limit
        
        # 检查超出范围的数据点
        out_of_range_mask = (data < min_val) | (data > max_val)
        out_of_range_indices = np.where(out_of_range_mask)[0].tolist()
        out_of_range_count = len(out_of_range_indices)
        
        result['out_of_range_count'] = out_of_range_count
        result['out_of_range_indices'] = out_of_range_indices
        
        if out_of_range_count > 0:
            result['valid'] = False
            percentage = (out_of_range_count / len(data)) * 100
            result['warnings'].append(
                f"{param_name}: {out_of_range_count}个数据点({percentage:.1f}%)超出范围 "
                f"[{min_val:.2f}, {max_val:.2f}]"
            )
            logger.warning(f"{param_name}: {out_of_range_count}个数据点超出范围")
        else:
            logger.debug(f"{param_name}: 数据范围验证通过 [{result['min_value']:.2f}, {result['max_value']:.2f}]")
        
        return result
    
    def detect_outliers(self, data: np.ndarray, method: str = 'iqr', 
                       threshold: float = 3.0) -> Dict[str, Any]:
        """检测异常值
        
        Args:
            data: 数据数组
            method: 检测方法，'iqr'（四分位距）或'zscore'（Z分数）
            threshold: 阈值，对于iqr方法表示IQR倍数，对于zscore表示标准差倍数
            
        Returns:
            检测结果字典，包含：
            - outlier_count: 异常值数量
            - outlier_indices: 异常值索引
            - outlier_values: 异常值
            - method: 使用的检测方法
            - threshold: 使用的阈值
        """
        result = {
            'outlier_count': 0,
            'outlier_indices': [],
            'outlier_values': [],
            'method': method,
            'threshold': threshold
        }
        
        if len(data) == 0:
            return result
        
        # 移除NaN和Inf值
        valid_mask = np.isfinite(data)
        if not np.all(valid_mask):
            logger.warning(f"数据中包含{np.sum(~valid_mask)}个无效值（NaN或Inf）")
            data = data[valid_mask]
        
        if len(data) < 4:
            logger.warning("数据点太少，无法进行异常值检测")
            return result
        
        if method == 'iqr':
            # 使用四分位距方法
            q1 = np.percentile(data, 25)
            q3 = np.percentile(data, 75)
            iqr = q3 - q1
            lower_bound = q1 - threshold * iqr
            upper_bound = q3 + threshold * iqr
            
            outlier_mask = (data < lower_bound) | (data > upper_bound)
        elif method == 'zscore':
            # 使用Z分数方法
            mean = np.mean(data)
            std = np.std(data)
            if std == 0:
                return result
            z_scores = np.abs((data - mean) / std)
            outlier_mask = z_scores > threshold
        else:
            raise ValueError(f"未知的异常值检测方法: {method}")
        
        outlier_indices = np.where(outlier_mask)[0]
        result['outlier_count'] = len(outlier_indices)
        result['outlier_indices'] = outlier_indices.tolist()
        result['outlier_values'] = data[outlier_indices].tolist()
        
        if result['outlier_count'] > 0:
            logger.warning(f"检测到{result['outlier_count']}个异常值（方法={method}, 阈值={threshold}）")
        
        return result
    
    def check_data_consistency(self, left_data: np.ndarray, right_data: np.ndarray,
                              tolerance: float = 0.1, check_symmetry: bool = True) -> Dict[str, Any]:
        """检查数据一致性（左右轮数据）
        
        Args:
            left_data: 左轮数据
            right_data: 右轮数据
            tolerance: 容差（相对误差）
            check_symmetry: 是否检查对称性（右轮数据应该是左轮数据的负值）
            
        Returns:
            一致性检查结果字典
        """
        result = {
            'consistent': True,
            'length_match': False,
            'symmetry_match': False,
            'mean_diff': None,
            'max_diff': None,
            'warnings': []
        }
        
        # 检查长度
        if len(left_data) != len(right_data):
            result['consistent'] = False
            result['warnings'].append(
                f"左右轮数据长度不匹配: 左={len(left_data)}, 右={len(right_data)}"
            )
            return result
        
        result['length_match'] = True
        
        if len(left_data) == 0:
            result['warnings'].append("数据为空")
            return result
        
        # 检查对称性（如果启用）
        if check_symmetry:
            # 对于某些参数（如轮跳），左右轮应该相同
            # 对于其他参数（如角度），左右轮可能对称
            diff = np.abs(left_data - right_data)
            mean_diff = np.mean(diff)
            max_diff = np.max(diff)
            
            result['mean_diff'] = float(mean_diff)
            result['max_diff'] = float(max_diff)
            
            # 检查是否在容差范围内
            relative_diff = mean_diff / (np.abs(np.mean(left_data)) + 1e-10)
            if relative_diff > tolerance:
                result['consistent'] = False
                result['warnings'].append(
                    f"左右轮数据差异较大: 平均差异={mean_diff:.4f}, "
                    f"最大差异={max_diff:.4f}, 相对差异={relative_diff:.2%}"
                )
            else:
                result['symmetry_match'] = True
                logger.debug(f"左右轮数据一致性检查通过: 平均差异={mean_diff:.4f}")
        
        return result
    
    def validate_data_quality(self, data: np.ndarray, param_name: str = "unknown") -> Dict[str, Any]:
        """综合数据质量验证
        
        Args:
            data: 数据数组
            param_name: 参数名称
            
        Returns:
            质量验证结果字典，包含所有检查结果
        """
        result = {
            'param_name': param_name,
            'valid': True,
            'data_length': len(data),
            'has_nan': False,
            'has_inf': False,
            'has_duplicates': False,
            'range_check': None,
            'outlier_check': None,
            'warnings': [],
            'errors': []
        }
        
        if len(data) == 0:
            result['valid'] = False
            result['errors'].append(f"{param_name}: 数据为空")
            return result
        
        # 检查NaN和Inf
        nan_count = np.sum(np.isnan(data))
        inf_count = np.sum(np.isinf(data))
        
        if nan_count > 0:
            result['has_nan'] = True
            result['valid'] = False
            result['errors'].append(f"{param_name}: 包含{nan_count}个NaN值")
            logger.warning(f"{param_name}: 包含{nan_count}个NaN值")
        
        if inf_count > 0:
            result['has_inf'] = True
            result['valid'] = False
            result['errors'].append(f"{param_name}: 包含{inf_count}个Inf值")
            logger.warning(f"{param_name}: 包含{inf_count}个Inf值")
        
        # 检查重复值
        unique_count = len(np.unique(data))
        if unique_count < len(data) * 0.5:  # 如果唯一值少于50%，可能有问题
            result['has_duplicates'] = True
            result['warnings'].append(
                f"{param_name}: 数据中重复值较多（唯一值={unique_count}/{len(data)}）"
            )
        
        # 范围验证
        result['range_check'] = self.validate_range(data, param_name)
        if not result['range_check']['valid']:
            result['valid'] = False
            result['warnings'].extend(result['range_check']['warnings'])
        
        # 异常值检测
        result['outlier_check'] = self.detect_outliers(data, method='iqr', threshold=3.0)
        if result['outlier_check']['outlier_count'] > len(data) * 0.1:  # 如果异常值超过10%
            result['warnings'].append(
                f"{param_name}: 检测到{result['outlier_check']['outlier_count']}个异常值 "
                f"({result['outlier_check']['outlier_count']/len(data)*100:.1f}%)"
            )
        
        return result
    
    def validate_fit_quality(self, x: np.ndarray, y: np.ndarray, 
                            fitted_y: np.ndarray) -> Dict[str, Any]:
        """验证拟合质量
        
        Args:
            x: 自变量数组
            y: 实际值数组
            fitted_y: 拟合值数组
            
        Returns:
            拟合质量结果字典，包含R²值、残差等信息
        """
        result = {
            'r_squared': None,
            'rmse': None,
            'mean_absolute_error': None,
            'quality': 'unknown',
            'warnings': []
        }
        
        if len(y) == 0 or len(fitted_y) == 0:
            result['warnings'].append("数据为空，无法计算拟合质量")
            return result
        
        if len(y) != len(fitted_y):
            result['warnings'].append("实际值和拟合值长度不匹配")
            return result
        
        # 计算残差
        residuals = y - fitted_y
        
        # 计算R²值
        ss_res = np.sum(residuals ** 2)
        ss_tot = np.sum((y - np.mean(y)) ** 2)
        
        if ss_tot == 0:
            result['r_squared'] = 1.0  # 如果总平方和为0，说明所有值都相同，R²=1
        else:
            r_squared = 1 - (ss_res / ss_tot)
            result['r_squared'] = float(r_squared)
        
        # 计算RMSE（均方根误差）
        rmse = np.sqrt(np.mean(residuals ** 2))
        result['rmse'] = float(rmse)
        
        # 计算平均绝对误差
        mae = np.mean(np.abs(residuals))
        result['mean_absolute_error'] = float(mae)
        
        # 评估拟合质量
        if result['r_squared'] is not None:
            if result['r_squared'] >= 0.99:
                result['quality'] = 'excellent'
            elif result['r_squared'] >= 0.95:
                result['quality'] = 'good'
            elif result['r_squared'] >= 0.90:
                result['quality'] = 'fair'
            elif result['r_squared'] >= 0.80:
                result['quality'] = 'poor'
            else:
                result['quality'] = 'very_poor'
                result['warnings'].append(
                    f"拟合质量较差: R²={result['r_squared']:.4f} < 0.80"
                )
        
        logger.debug(
            f"拟合质量: R²={result['r_squared']:.4f}, "
            f"RMSE={result['rmse']:.4f}, 质量={result['quality']}"
        )
        
        return result
