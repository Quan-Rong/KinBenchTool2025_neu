"""K&C计算模块单元测试。"""

import pytest
import numpy as np
from unittest.mock import Mock, MagicMock
from Python_Target.src.data.kc_calculator import KCCalculator
from Python_Target.src.data.data_extractor import DataExtractor


@pytest.fixture
def mock_extractor():
    """创建模拟的DataExtractor。"""
    extractor = Mock(spec=DataExtractor)
    return extractor


@pytest.fixture
def sample_vehicle_params():
    """示例车辆参数。"""
    return {
        'half_load': 5000.0,  # N
        'max_load': 10000.0,  # N
        'wheel_base': 2.5,  # m
    }


@pytest.fixture
def calculator(mock_extractor, sample_vehicle_params):
    """创建KCCalculator实例。"""
    return KCCalculator(mock_extractor, sample_vehicle_params)


class TestKCCalculatorInit:
    """KCCalculator初始化测试。"""
    
    def test_init_with_params(self, mock_extractor, sample_vehicle_params):
        """测试带参数初始化。"""
        calc = KCCalculator(mock_extractor, sample_vehicle_params)
        assert calc.extractor == mock_extractor
        assert calc.vehicle_params == sample_vehicle_params
    
    def test_init_without_params(self, mock_extractor):
        """测试不带参数初始化。"""
        calc = KCCalculator(mock_extractor)
        assert calc.extractor == mock_extractor
        assert calc.vehicle_params == {}


class TestVehicleParams:
    """车辆参数管理测试。"""
    
    def test_set_vehicle_params(self, calculator):
        """测试设置车辆参数。"""
        new_params = {'half_load': 6000.0, 'max_load': 12000.0}
        calculator.set_vehicle_params(new_params)
        assert calculator.vehicle_params == new_params
    
    def test_get_vehicle_param(self, calculator):
        """测试获取车辆参数。"""
        assert calculator.get_vehicle_param('half_load') == 5000.0
        assert calculator.get_vehicle_param('max_load') == 10000.0
        assert calculator.get_vehicle_param('nonexistent', default=0.0) == 0.0


class TestBumpSteer:
    """Bump Steer计算测试。"""
    
    def test_calculate_bump_steer(self, calculator):
        """测试Bump Steer计算。"""
        # 模拟数据提取
        n_points = 100
        wheel_travel = np.linspace(-50, 50, n_points) / 1000  # m
        toe_angle = np.linspace(-2, 2, n_points) * np.pi / 180  # rad
        
        calculator.extractor.extract_by_name = Mock(side_effect=lambda name, **kwargs: {
            'wheel_travel': wheel_travel,
            'toe_angle': toe_angle
        }.get(name, np.zeros(n_points)))
        
        result = calculator.calculate_bump_steer(fit_range=15)
        
        # 验证返回结果结构
        assert 'left_slope' in result
        assert 'right_slope' in result
        assert 'average_slope' in result
        assert 'left_coeffs' in result
        assert 'right_coeffs' in result
        assert 'zero_position_idx' in result
        assert 'fit_range' in result
        
        # 验证斜率计算
        assert isinstance(result['left_slope'], (int, float))
        assert isinstance(result['right_slope'], (int, float))
        assert isinstance(result['average_slope'], (int, float))


class TestBumpCamber:
    """Bump Camber计算测试。"""
    
    def test_calculate_bump_camber(self, calculator):
        """测试Bump Camber计算。"""
        n_points = 100
        wheel_travel = np.linspace(-50, 50, n_points) / 1000  # m
        camber_angle = np.linspace(-1, 1, n_points) * np.pi / 180  # rad
        
        calculator.extractor.extract_by_name = Mock(side_effect=lambda name, **kwargs: {
            'wheel_travel': wheel_travel,
            'camber_angle': camber_angle
        }.get(name, np.zeros(n_points)))
        
        result = calculator.calculate_bump_camber(fit_range=15)
        
        # 验证返回结果结构
        assert 'left_slope' in result
        assert 'right_slope' in result
        assert 'average_slope' in result
        assert 'zero_position_idx' in result


class TestWheelRate:
    """Wheel Rate计算测试。"""
    
    def test_calculate_wheel_rate(self, calculator):
        """测试Wheel Rate计算。"""
        n_points = 100
        wheel_travel = np.linspace(-50, 50, n_points) / 1000  # m
        wheel_rate = np.linspace(100, 200, n_points)  # N/mm
        
        calculator.extractor.extract_by_name = Mock(side_effect=lambda name, **kwargs: {
            'wheel_travel': wheel_travel,
            'wheel_rate': wheel_rate
        }.get(name, np.zeros(n_points)))
        
        result = calculator.calculate_wheel_rate(fit_range=15)
        
        # 验证返回结果结构
        assert 'left_slope' in result
        assert 'right_slope' in result
        assert 'average_slope' in result
        assert 'left_rate_at_zero' in result
        assert 'right_rate_at_zero' in result
        assert 'average_rate_at_zero' in result


class TestRollSteer:
    """Roll Steer计算测试。"""
    
    def test_calculate_roll_steer(self, calculator):
        """测试Roll Steer计算。"""
        n_points = 100
        roll_angle = np.linspace(-10, 10, n_points) * np.pi / 180  # rad
        toe_angle = np.linspace(-1, 1, n_points) * np.pi / 180  # rad
        
        calculator.extractor.extract_by_name = Mock(side_effect=lambda name, **kwargs: {
            'roll_angle': roll_angle,
            'toe_angle': toe_angle
        }.get(name, np.zeros(n_points)))
        
        result = calculator.calculate_roll_steer(fit_range=5)
        
        # 验证返回结果结构
        assert 'left_slope' in result
        assert 'right_slope' in result
        assert 'average_slope' in result
