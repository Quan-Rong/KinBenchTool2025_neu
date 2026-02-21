"""文件读取性能测试。"""

import pytest
import time
import numpy as np
from pathlib import Path
import tempfile
from Python_Target.src.utils.file_utils import count_lines, read_file_generator, read_file_lines


class TestFileReadingPerformance:
    """文件读取性能测试。"""
    
    @pytest.fixture
    def large_test_file(self, tmp_path):
        """创建大型测试文件。"""
        file_path = tmp_path / "large_test.res"
        # 创建10000行的文件
        with open(file_path, 'w', encoding='utf-8') as f:
            for i in range(10000):
                f.write(f"Line {i}: " + " ".join([str(j) for j in range(10)]) + "\n")
        return str(file_path)
    
    def test_count_lines_performance(self, large_test_file):
        """测试行数统计性能。"""
        start_time = time.time()
        line_count = count_lines(large_test_file)
        elapsed_time = time.time() - start_time
        
        assert line_count == 10000
        # 应该在1秒内完成（对于10000行）
        assert elapsed_time < 1.0, f"行数统计耗时过长: {elapsed_time:.2f}秒"
    
    def test_generator_reading_performance(self, large_test_file):
        """测试生成器方式读取性能。"""
        start_time = time.time()
        line_count = 0
        for line in read_file_generator(large_test_file):
            line_count += 1
        elapsed_time = time.time() - start_time
        
        assert line_count == 10000
        # 应该在1秒内完成
        assert elapsed_time < 1.0, f"生成器读取耗时过长: {elapsed_time:.2f}秒"
    
    def test_memory_efficiency(self, large_test_file):
        """测试内存效率（生成器vs列表）。"""
        import sys
        
        # 生成器方式
        gen_size = sys.getsizeof(read_file_generator(large_test_file))
        
        # 列表方式（仅测试，不实际读取全部）
        # 注意：这里只是演示，实际测试中应该避免读取全部文件
        
        # 生成器应该占用更少内存
        assert gen_size < 1000  # 生成器对象本身很小


class TestDataProcessingPerformance:
    """数据处理性能测试。"""
    
    def test_array_operations(self):
        """测试数组操作性能。"""
        # 创建大型数组
        data = np.random.rand(1000, 2751)
        
        start_time = time.time()
        # 执行一些常见操作
        result = data * 2
        result = result + 1
        result = np.mean(result, axis=0)
        elapsed_time = time.time() - start_time
        
        # 应该在0.1秒内完成
        assert elapsed_time < 0.1, f"数组操作耗时过长: {elapsed_time:.2f}秒"
    
    def test_linear_fit_performance(self):
        """测试线性拟合性能。"""
        from Python_Target.src.utils.math_utils import linear_fit
        
        # 创建测试数据
        x = np.linspace(0, 100, 1000)
        y = 2 * x + 1 + np.random.normal(0, 0.1, len(x))
        
        start_time = time.time()
        coeffs, fitted = linear_fit(x, y, degree=1)
        elapsed_time = time.time() - start_time
        
        # 应该在0.01秒内完成
        assert elapsed_time < 0.01, f"线性拟合耗时过长: {elapsed_time:.2f}秒"
