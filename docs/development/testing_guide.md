# 测试指南

## 测试框架

使用 **pytest** 作为测试框架。

## 测试结构

```
tests/
├── conftest.py           # pytest配置和fixtures
├── test_data/            # 测试数据
│   └── .gitkeep
├── unit/                 # 单元测试
│   ├── test_res_parser.py
│   ├── test_kc_calculator.py
│   └── test_unit_converter.py
├── integration/          # 集成测试
│   ├── test_data_flow.py
│   └── test_plot_generation.py
└── e2e/                  # 端到端测试
    └── test_full_workflow.py
```

## 测试类型

### 单元测试

测试单个函数或方法的功能。

**示例**:
```python
def test_extract_param_data():
    """测试参数数据提取。"""
    data_matrix = np.array([[1, 2, 3], [4, 5, 6]])
    result = extract_param_data(data_matrix, param_id=1)
    assert np.array_equal(result, [2, 5])
```

### 集成测试

测试多个模块的交互。

**示例**:
```python
def test_data_processing_pipeline():
    """测试数据处理完整流程。"""
    # 解析文件
    data = parse_res_file("test.res")
    # 提取参数
    param_data = extract_param_data(data['quasi_static_data'], param_id=1234)
    # 计算
    result = calculate_bump_params(travel_data, param_data)
    # 验证
    assert 'stiffness' in result
```

### 端到端测试

测试完整的用户场景。

**示例**:
```python
def test_bump_test_analysis():
    """测试Bump测试完整分析流程。"""
    # 加载文件
    # 选择参数
    # 计算
    # 绘图
    # 验证结果
```

## 测试覆盖率

目标覆盖率: **> 80%**

查看覆盖率:
```bash
pytest --cov=Python_Target/src --cov-report=html
```

## 测试数据管理

### 使用Fixtures

```python
# conftest.py
import pytest
import numpy as np

@pytest.fixture
def sample_res_file(tmp_path):
    """创建示例.res文件。"""
    file_path = tmp_path / "test.res"
    content = """
param_id
  toe_angle_left = 1234
end
quasiStatic
  0.0  1.0  2.0  3.0
end
"""
    file_path.write_text(content)
    return str(file_path)

@pytest.fixture
def sample_data_matrix():
    """创建示例数据矩阵。"""
    return np.random.rand(100, 2751)
```

### 使用测试数据文件

大型测试数据放在 `tests/test_data/` 目录。

## 运行测试

### 运行所有测试

```bash
pytest
```

### 运行特定测试

```bash
pytest tests/unit/test_res_parser.py
pytest tests/unit/test_res_parser.py::test_parse_file
```

### 运行并查看覆盖率

```bash
pytest --cov=Python_Target/src --cov-report=term-missing
```

### 运行标记的测试

```bash
# 只运行单元测试
pytest -m unit

# 跳过慢速测试
pytest -m "not slow"
```

## 测试标记

使用pytest标记组织测试：

```python
import pytest

@pytest.mark.unit
def test_simple_function():
    pass

@pytest.mark.integration
@pytest.mark.slow
def test_complex_workflow():
    pass
```

## Mock和Stub

### 使用pytest-mock

```python
def test_file_reading(mocker):
    """测试文件读取，使用mock。"""
    mock_open = mocker.patch('builtins.open', mocker.mock_open(read_data='test'))
    result = read_file('test.txt')
    mock_open.assert_called_once_with('test.txt', 'r')
```

## 性能测试

使用pytest-benchmark进行性能测试：

```python
def test_parse_performance(benchmark):
    """测试解析性能。"""
    result = benchmark(parse_res_file, "large_file.res")
    assert result is not None
```

## 最佳实践

1. **测试隔离**: 每个测试应该独立，不依赖其他测试
2. **测试命名**: 使用描述性的测试名称
3. **AAA模式**: Arrange-Act-Assert
4. **测试边界**: 测试正常情况、边界情况和错误情况
5. **避免测试实现细节**: 测试行为，不测试实现

## 持续集成

测试应该在CI中自动运行。确保：
- 所有测试通过
- 覆盖率达标
- 代码质量检查通过
