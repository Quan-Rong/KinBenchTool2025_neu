"""Pytest配置和共享fixtures。"""

import pytest
import numpy as np
from pathlib import Path
import tempfile
import os


@pytest.fixture
def temp_dir():
    """创建临时目录。"""
    with tempfile.TemporaryDirectory() as tmpdir:
        yield Path(tmpdir)


@pytest.fixture
def sample_res_file_content():
    """示例.res文件内容。"""
    return """header
some header information
end

param_id
  toe_angle_left = 1234
  toe_angle_right = 1235
  camber_angle_left = 1236
  camber_angle_right = 1237
end

quasiStatic
  0.0  1.0  2.0  3.0  4.0
  0.1  1.1  2.1  3.1  4.1
  0.2  1.2  2.2  3.2  4.2
end
"""


@pytest.fixture
def sample_res_file(temp_dir, sample_res_file_content):
    """创建示例.res文件。"""
    file_path = temp_dir / "test.res"
    file_path.write_text(sample_res_file_content, encoding="utf-8")
    return str(file_path)


@pytest.fixture
def sample_data_matrix():
    """创建示例数据矩阵。"""
    return np.random.rand(100, 2751)


@pytest.fixture
def sample_param_ids():
    """示例参数ID映射。"""
    return {
        "toe_angle_left": 1234,
        "toe_angle_right": 1235,
        "camber_angle_left": 1236,
        "camber_angle_right": 1237,
    }


@pytest.fixture
def sample_travel_data():
    """示例行程数据。"""
    return np.linspace(0, 100, 100)  # 0到100mm，100个点


@pytest.fixture
def sample_param_data():
    """示例参数数据。"""
    return np.linspace(0, 5, 100)  # 0到5度，100个点
