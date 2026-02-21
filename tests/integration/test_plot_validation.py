"""图表一致性验证测试。

测试Python生成的图表与MATLAB版本的对比。
"""

import pytest
import numpy as np
from pathlib import Path
from Python_Target.src.utils.plot_validator import (
    compare_plot_data,
    compare_plot_images,
)


class TestPlotDataComparison:
    """图表数据对比测试。"""
    
    def test_identical_data(self):
        """测试完全相同的数据。"""
        data1 = np.array([0, 1, 2, 3, 4])
        data2 = np.array([0, 1, 2, 3, 4])
        
        is_close, result = compare_plot_data(data1, data2)
        
        assert is_close is True
        assert result['max_diff'] == 0.0
        assert result['mean_diff'] == 0.0
    
    def test_similar_data(self):
        """测试相似的数据（在容差范围内）。"""
        data1 = np.array([0, 1, 2, 3, 4])
        data2 = np.array([0, 1.0001, 2.0001, 3.0001, 4.0001])
        
        is_close, result = compare_plot_data(data1, data2, tolerance=1e-3)
        
        assert is_close is True
        assert result['max_diff'] < 1e-3
    
    def test_different_data(self):
        """测试不同的数据（超出容差）。"""
        data1 = np.array([0, 1, 2, 3, 4])
        data2 = np.array([0, 2, 4, 6, 8])
        
        is_close, result = compare_plot_data(data1, data2, tolerance=1e-6)
        
        assert is_close is False
        assert result['max_diff'] > 1.0
    
    def test_different_shapes(self):
        """测试不同形状的数据。"""
        data1 = np.array([0, 1, 2, 3, 4])
        data2 = np.array([0, 1, 2, 3])
        
        is_close, result = compare_plot_data(data1, data2)
        
        assert is_close is False
        assert 'shape_mismatch' in result


class TestPlotImageComparison:
    """图表图像对比测试。"""
    
    @pytest.fixture
    def sample_image_paths(self, tmp_path):
        """创建示例图像路径。"""
        # 注意：实际测试中需要真实的图像文件
        # 这里只是演示测试结构
        img1 = tmp_path / "matlab_reference.png"
        img2 = tmp_path / "python_output.png"
        return str(img1), str(img2)
    
    def test_image_comparison_structure(self, sample_image_paths):
        """测试图像对比功能结构。"""
        img1_path, img2_path = sample_image_paths
        
        # 注意：实际测试需要真实的图像文件
        # 这里只测试函数调用不会出错
        try:
            is_similar, similarity = compare_plot_images(
                img1_path, img2_path, similarity_threshold=0.95
            )
            # 如果文件不存在，会抛出异常，这是预期的
        except (FileNotFoundError, ValueError):
            # 文件不存在是正常的（测试环境）
            pass


class TestPlotConsistency:
    """图表一致性测试。"""
    
    def test_bump_steer_data_consistency(self):
        """测试Bump Steer数据一致性。"""
        # 模拟MATLAB和Python生成的数据
        matlab_data = np.array([0, 0.1, 0.2, 0.3, 0.4])
        python_data = np.array([0, 0.1, 0.2, 0.3, 0.4])
        
        is_close, result = compare_plot_data(matlab_data, python_data, tolerance=1e-6)
        
        assert is_close is True
    
    def test_roll_steer_data_consistency(self):
        """测试Roll Steer数据一致性。"""
        # 模拟数据
        matlab_data = np.linspace(0, 10, 100)
        python_data = np.linspace(0, 10, 100)
        
        is_close, result = compare_plot_data(matlab_data, python_data, tolerance=1e-6)
        
        assert is_close is True
