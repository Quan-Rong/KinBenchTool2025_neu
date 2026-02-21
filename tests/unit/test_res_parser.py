"""数据解析模块单元测试。"""

import pytest
import numpy as np
from pathlib import Path
from Python_Target.src.data.res_parser import ResParser
from Python_Target.src.utils.exceptions import FileError, ParseError


class TestResParser:
    """ResParser测试类。"""
    
    def test_file_not_found(self, temp_dir):
        """测试文件不存在的情况。"""
        non_existent_file = temp_dir / "nonexistent.res"
        with pytest.raises(FileError, match="文件不存在"):
            ResParser(str(non_existent_file))
    
    def test_parse_param_ids(self, sample_res_file):
        """测试参数ID提取。"""
        parser = ResParser(sample_res_file)
        param_ids, _ = parser.parse()
        
        # 验证提取的参数ID
        assert 'toe_angle' in param_ids
        assert param_ids['toe_angle'] == [1234, 1235]  # left, right
        assert 'camber_angle' in param_ids
        assert param_ids['camber_angle'] == [1236, 1237]  # left, right
    
    def test_parse_quasistatic_data(self, sample_res_file):
        """测试quasiStatic数据解析。"""
        parser = ResParser(sample_res_file)
        _, quasi_static_data = parser.parse()
        
        # 验证数据矩阵形状
        assert quasi_static_data is not None
        assert isinstance(quasi_static_data, np.ndarray)
        assert quasi_static_data.ndim == 2
        # 列数应该是2751（或根据实际数据调整）
        assert quasi_static_data.shape[1] > 0
    
    def test_parse_complete(self, sample_res_file):
        """测试完整解析流程。"""
        parser = ResParser(sample_res_file)
        param_ids, quasi_static_data = parser.parse()
        
        # 验证返回类型
        assert isinstance(param_ids, dict)
        assert isinstance(quasi_static_data, np.ndarray)
        
        # 验证数据有效性
        assert len(param_ids) > 0
        assert quasi_static_data.size > 0


@pytest.fixture
def complex_res_file(temp_dir):
    """创建更复杂的.res文件用于测试。"""
    content = """header
some header information
end

param_id
  toe_angle_left = 1234
  toe_angle_right = 1235
  camber_angle_left = 1236
  camber_angle_right = 1237
  wheel_travel_base = 2001
  wheel_travel_track = 2002
end

quasiStatic
  0.0  1.0  2.0  3.0  4.0  5.0
  0.1  1.1  2.1  3.1  4.1  5.1
  0.2  1.2  2.2  3.2  4.2  5.2
end
"""
    file_path = temp_dir / "complex_test.res"
    file_path.write_text(content, encoding="utf-8")
    return str(file_path)


class TestResParserComplex:
    """ResParser复杂场景测试。"""
    
    def test_multiple_params(self, complex_res_file):
        """测试多个参数提取。"""
        parser = ResParser(complex_res_file)
        param_ids, _ = parser.parse()
        
        assert 'toe_angle' in param_ids
        assert 'camber_angle' in param_ids
        assert 'wheel_travel_base' in param_ids
        assert 'wheel_travel_track' in param_ids
    
    def test_data_parsing(self, complex_res_file):
        """测试数据解析。"""
        parser = ResParser(complex_res_file)
        _, quasi_static_data = parser.parse()
        
        # 验证数据内容
        assert quasi_static_data.shape[0] == 3  # 3行数据
        # 验证第一行数据
        assert np.isclose(quasi_static_data[0, 0], 0.0)
        assert np.isclose(quasi_static_data[0, 1], 1.0)
