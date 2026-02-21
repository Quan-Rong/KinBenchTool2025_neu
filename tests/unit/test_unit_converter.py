"""单位转换模块单元测试。"""

import pytest
import numpy as np
from Python_Target.src.data.unit_converter import (
    rad_to_deg, deg_to_rad, mm_to_m, m_to_mm,
    convert_angle_array, convert_length_array
)


class TestRadToDeg:
    """弧度转角度测试。"""
    
    def test_single_value(self):
        """测试单个值转换。"""
        assert np.isclose(rad_to_deg(np.pi), 180.0)
        assert np.isclose(rad_to_deg(np.pi / 2), 90.0)
        assert np.isclose(rad_to_deg(0), 0.0)
    
    def test_array(self):
        """测试数组转换。"""
        rad_array = np.array([0, np.pi / 2, np.pi, 3 * np.pi / 2, 2 * np.pi])
        deg_array = rad_to_deg(rad_array)
        expected = np.array([0, 90, 180, 270, 360])
        assert np.allclose(deg_array, expected)
    
    def test_negative_values(self):
        """测试负值转换。"""
        assert np.isclose(rad_to_deg(-np.pi), -180.0)
        assert np.isclose(rad_to_deg(-np.pi / 2), -90.0)


class TestDegToRad:
    """角度转弧度测试。"""
    
    def test_single_value(self):
        """测试单个值转换。"""
        assert np.isclose(deg_to_rad(180.0), np.pi)
        assert np.isclose(deg_to_rad(90.0), np.pi / 2)
        assert np.isclose(deg_to_rad(0), 0.0)
    
    def test_array(self):
        """测试数组转换。"""
        deg_array = np.array([0, 90, 180, 270, 360])
        rad_array = deg_to_rad(deg_array)
        expected = np.array([0, np.pi / 2, np.pi, 3 * np.pi / 2, 2 * np.pi])
        assert np.allclose(rad_array, expected)
    
    def test_round_trip(self):
        """测试往返转换。"""
        original = np.array([0, 45, 90, 135, 180])
        converted = deg_to_rad(original)
        back = rad_to_deg(converted)
        assert np.allclose(original, back)


class TestMmToM:
    """毫米转米测试。"""
    
    def test_single_value(self):
        """测试单个值转换。"""
        assert mm_to_m(1000) == 1.0
        assert mm_to_m(500) == 0.5
        assert mm_to_m(0) == 0.0
    
    def test_array(self):
        """测试数组转换。"""
        mm_array = np.array([0, 500, 1000, 1500, 2000])
        m_array = mm_to_m(mm_array)
        expected = np.array([0, 0.5, 1.0, 1.5, 2.0])
        assert np.allclose(m_array, expected)
    
    def test_negative_values(self):
        """测试负值转换。"""
        assert mm_to_m(-1000) == -1.0


class TestMToMm:
    """米转毫米测试。"""
    
    def test_single_value(self):
        """测试单个值转换。"""
        assert m_to_mm(1.0) == 1000.0
        assert m_to_mm(0.5) == 500.0
        assert m_to_mm(0) == 0.0
    
    def test_array(self):
        """测试数组转换。"""
        m_array = np.array([0, 0.5, 1.0, 1.5, 2.0])
        mm_array = m_to_mm(m_array)
        expected = np.array([0, 500, 1000, 1500, 2000])
        assert np.allclose(mm_array, expected)
    
    def test_round_trip(self):
        """测试往返转换。"""
        original = np.array([0, 0.5, 1.0, 1.5, 2.0])
        converted = m_to_mm(original)
        back = mm_to_m(converted)
        assert np.allclose(original, back)


class TestConvertAngleArray:
    """角度数组批量转换测试。"""
    
    def test_rad_to_deg(self):
        """测试弧度转角度。"""
        rad_data = np.array([0, np.pi / 2, np.pi])
        deg_data = convert_angle_array(rad_data, from_unit='rad', to_unit='deg')
        expected = np.array([0, 90, 180])
        assert np.allclose(deg_data, expected)
    
    def test_deg_to_rad(self):
        """测试角度转弧度。"""
        deg_data = np.array([0, 90, 180])
        rad_data = convert_angle_array(deg_data, from_unit='deg', to_unit='rad')
        expected = np.array([0, np.pi / 2, np.pi])
        assert np.allclose(rad_data, expected)
    
    def test_same_unit(self):
        """测试相同单位（不转换）。"""
        data = np.array([0, 90, 180])
        result = convert_angle_array(data, from_unit='deg', to_unit='deg')
        assert np.array_equal(result, data)
        assert result is not data  # 应该是副本
    
    def test_invalid_conversion(self):
        """测试无效的单位转换。"""
        data = np.array([0, 90, 180])
        with pytest.raises(ValueError, match="不支持的单位转换"):
            convert_angle_array(data, from_unit='rad', to_unit='m')


class TestConvertLengthArray:
    """长度数组批量转换测试。"""
    
    def test_mm_to_m(self):
        """测试毫米转米。"""
        mm_data = np.array([0, 500, 1000, 1500])
        m_data = convert_length_array(mm_data, from_unit='mm', to_unit='m')
        expected = np.array([0, 0.5, 1.0, 1.5])
        assert np.allclose(m_data, expected)
    
    def test_m_to_mm(self):
        """测试米转毫米。"""
        m_data = np.array([0, 0.5, 1.0, 1.5])
        mm_data = convert_length_array(m_data, from_unit='m', to_unit='mm')
        expected = np.array([0, 500, 1000, 1500])
        assert np.allclose(mm_data, expected)
    
    def test_same_unit(self):
        """测试相同单位（不转换）。"""
        data = np.array([0, 500, 1000])
        result = convert_length_array(data, from_unit='mm', to_unit='mm')
        assert np.array_equal(result, data)
        assert result is not data  # 应该是副本
    
    def test_invalid_conversion(self):
        """测试无效的单位转换。"""
        data = np.array([0, 500, 1000])
        with pytest.raises(ValueError, match="不支持的单位转换"):
            convert_length_array(data, from_unit='mm', to_unit='deg")
