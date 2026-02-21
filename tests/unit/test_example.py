"""示例单元测试文件。

此文件作为测试文件的模板，展示如何编写单元测试。
实际开发中应删除此文件，创建真实的测试文件。
"""

import pytest
import numpy as np


def test_example():
    """示例测试函数。"""
    assert 1 + 1 == 2


def test_array_operations():
    """测试数组操作。"""
    arr = np.array([1, 2, 3])
    result = arr * 2
    expected = np.array([2, 4, 6])
    assert np.array_equal(result, expected)


class TestExampleClass:
    """示例测试类。"""

    def test_method(self):
        """测试方法。"""
        assert True

    def test_with_fixture(self, sample_data_matrix):
        """使用fixture的测试。"""
        assert sample_data_matrix.shape == (100, 2751)
