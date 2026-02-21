"""数学工具模块单元测试。"""

import pytest
import numpy as np
from Python_Target.src.utils.math_utils import (
    linear_fit, find_zero_crossing, find_value_index, calculate_slope
)


class TestLinearFit:
    """线性拟合测试。"""
    
    def test_perfect_line(self):
        """测试完美直线拟合。"""
        x = np.array([0, 1, 2, 3, 4])
        y = np.array([0, 2, 4, 6, 8])  # y = 2x
        coeffs, fitted = linear_fit(x, y, degree=1)
        
        # 斜率应该是2，截距应该是0
        assert np.isclose(coeffs[0], 2.0, rtol=1e-10)
        assert np.isclose(coeffs[1], 0.0, rtol=1e-10)
        # 拟合值应该与原始值完全一致
        assert np.allclose(fitted, y, rtol=1e-10)
    
    def test_line_with_intercept(self):
        """测试带截距的直线拟合。"""
        x = np.array([0, 1, 2, 3, 4])
        y = np.array([1, 3, 5, 7, 9])  # y = 2x + 1
        coeffs, fitted = linear_fit(x, y, degree=1)
        
        assert np.isclose(coeffs[0], 2.0, rtol=1e-10)
        assert np.isclose(coeffs[1], 1.0, rtol=1e-10)
        assert np.allclose(fitted, y, rtol=1e-10)
    
    def test_noisy_data(self):
        """测试带噪声的数据拟合。"""
        x = np.linspace(0, 10, 100)
        y_true = 2 * x + 1
        noise = np.random.normal(0, 0.1, len(x))
        y = y_true + noise
        
        coeffs, fitted = linear_fit(x, y, degree=1)
        
        # 斜率应该接近2
        assert np.isclose(coeffs[0], 2.0, rtol=0.1)
        # 截距应该接近1
        assert np.isclose(coeffs[1], 1.0, rtol=0.1)
    
    def test_length_mismatch(self):
        """测试数组长度不匹配。"""
        x = np.array([0, 1, 2])
        y = np.array([0, 1])
        with pytest.raises(ValueError, match="长度不匹配"):
            linear_fit(x, y)
    
    def test_empty_array(self):
        """测试空数组。"""
        x = np.array([])
        y = np.array([])
        with pytest.raises(ValueError, match="输入数组为空"):
            linear_fit(x, y)
    
    def test_insufficient_data(self):
        """测试数据点不足。"""
        x = np.array([0])
        y = np.array([1])
        with pytest.raises(ValueError, match="数据点数量"):
            linear_fit(x, y, degree=1)


class TestFindZeroCrossing:
    """查找零交叉点测试。"""
    
    def test_find_zero(self):
        """测试查找零值。"""
        x = np.array([0, 1, 2, 3, 4])
        y = np.array([-2, -1, 0, 1, 2])
        idx = find_zero_crossing(x, y, target=0.0)
        assert idx == 2
        assert y[idx] == 0.0
    
    def test_find_closest_to_zero(self):
        """测试查找最接近零的值。"""
        x = np.array([0, 1, 2, 3, 4])
        y = np.array([-2, -1, 0.1, 1, 2])
        idx = find_zero_crossing(x, y, target=0.0)
        assert idx == 2  # 0.1最接近0
        assert y[idx] == 0.1
    
    def test_find_target_value(self):
        """测试查找目标值。"""
        x = np.array([0, 1, 2, 3, 4])
        y = np.array([0, 1, 2, 3, 4])
        idx = find_zero_crossing(x, y, target=2.0)
        assert idx == 2
        assert y[idx] == 2.0
    
    def test_empty_array(self):
        """测试空数组。"""
        x = np.array([])
        y = np.array([])
        idx = find_zero_crossing(x, y, target=0.0)
        assert idx is None


class TestFindValueIndex:
    """查找值索引测试。"""
    
    def test_find_exact_value(self):
        """测试查找精确值。"""
        x = np.array([0, 1, 2, 3, 4])
        idx = find_value_index(x, target=2.0)
        assert idx == 2
        assert x[idx] == 2.0
    
    def test_find_closest_value(self):
        """测试查找最接近的值。"""
        x = np.array([0, 1, 2, 3, 4])
        idx = find_value_index(x, target=2.3)
        assert idx == 2  # 2最接近2.3
        assert x[idx] == 2.0
    
    def test_find_at_boundary(self):
        """测试边界值。"""
        x = np.array([0, 1, 2, 3, 4])
        idx = find_value_index(x, target=0.0)
        assert idx == 0
        idx = find_value_index(x, target=4.0)
        assert idx == 4
    
    def test_empty_array(self):
        """测试空数组。"""
        x = np.array([])
        idx = find_value_index(x, target=0.0)
        assert idx is None


class TestCalculateSlope:
    """计算斜率测试。"""
    
    def test_simple_slope(self):
        """测试简单斜率计算。"""
        x = np.array([0, 1, 2, 3, 4])
        y = np.array([0, 2, 4, 6, 8])  # y = 2x
        slope = calculate_slope(x, y)
        assert np.isclose(slope, 2.0, rtol=1e-10)
    
    def test_slope_with_range(self):
        """测试指定区间的斜率计算。"""
        x = np.array([0, 1, 2, 3, 4, 5, 6])
        y = np.array([0, 2, 4, 6, 8, 10, 12])  # y = 2x
        slope = calculate_slope(x, y, x_range=(1, 3))
        assert np.isclose(slope, 2.0, rtol=1e-10)
    
    def test_slope_with_intercept(self):
        """测试带截距的斜率计算。"""
        x = np.array([0, 1, 2, 3, 4])
        y = np.array([1, 3, 5, 7, 9])  # y = 2x + 1
        slope = calculate_slope(x, y)
        assert np.isclose(slope, 2.0, rtol=1e-10)
    
    def test_slope_outside_range(self):
        """测试范围外的数据。"""
        x = np.array([0, 1, 2, 3, 4])
        y = np.array([0, 2, 4, 6, 8])
        # 范围外没有数据点，应该使用全部数据
        slope = calculate_slope(x, y, x_range=(10, 20))
        assert np.isclose(slope, 2.0, rtol=1e-10)
