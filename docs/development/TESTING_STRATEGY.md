# 测试策略文档

## 测试目标

- **功能正确性**: 确保所有功能按预期工作
- **代码质量**: 提高代码可靠性和可维护性
- **回归防护**: 防止新代码破坏现有功能
- **文档作用**: 测试作为可执行的文档

## 测试覆盖率目标

- **单元测试**: > 80%
- **集成测试**: 覆盖主要数据流
- **端到端测试**: 覆盖核心用户场景

## 测试金字塔

```
        /\
       /  \      E2E测试 (5%)
      /____\
     /      \    集成测试 (15%)
    /________\
   /          \  单元测试 (80%)
  /____________\
```

### 单元测试 (80%)

**目标**: 测试单个函数或方法

**特点**:
- 快速执行
- 隔离依赖
- 覆盖所有边界情况

**示例**:
- 测试数据解析函数
- 测试单位转换函数
- 测试数学计算函数

### 集成测试 (15%)

**目标**: 测试模块间交互

**特点**:
- 测试真实数据流
- 验证模块接口
- 使用真实文件（小文件）

**示例**:
- 测试文件解析到数据提取的完整流程
- 测试数据计算到图表生成的流程

### 端到端测试 (5%)

**目标**: 测试完整用户场景

**特点**:
- 模拟真实使用场景
- 测试GUI交互
- 验证最终输出

**示例**:
- 测试完整的Bump测试分析流程
- 测试文件加载到结果显示的完整流程

## 测试类型详细说明

### 1. 单元测试

#### 数据解析测试

```python
def test_parse_param_ids():
    """测试参数ID提取。"""
    content = "param_id\n  toe_angle_left = 1234\nend"
    result = extract_param_ids(content)
    assert result['toe_angle_left'] == 1234
```

#### 计算测试

```python
def test_linear_fit():
    """测试线性拟合。"""
    x = np.array([0, 1, 2, 3])
    y = np.array([0, 2, 4, 6])
    coeffs = linear_fit(x, y, degree=1)
    assert np.isclose(coeffs[0], 2.0)  # 斜率
    assert np.isclose(coeffs[1], 0.0)  # 截距
```

#### 单位转换测试

```python
def test_deg_to_rad():
    """测试度转弧度。"""
    result = deg_to_rad(180)
    assert np.isclose(result, np.pi)
```

### 2. 集成测试

#### 数据处理流程测试

```python
def test_data_processing_pipeline(sample_res_file):
    """测试数据处理完整流程。"""
    # 1. 解析文件
    data = parse_res_file(sample_res_file)
    
    # 2. 提取参数
    param_id = data['param_ids']['toe_angle_left']
    param_data = extract_param_data(
        data['quasi_static_data'], 
        param_id
    )
    
    # 3. 计算
    result = calculate_bump_params(travel_data, param_data)
    
    # 4. 验证
    assert 'stiffness' in result
    assert result['stiffness'] > 0
```

### 3. 端到端测试

#### 完整分析流程测试

```python
def test_bump_analysis_workflow():
    """测试Bump测试完整分析流程。"""
    # 1. 启动应用（模拟）
    app = create_test_app()
    
    # 2. 加载文件
    app.load_file("test.res")
    
    # 3. 选择参数
    app.select_parameter("toe_angle_left")
    
    # 4. 执行分析
    result = app.run_bump_analysis()
    
    # 5. 验证结果
    assert result is not None
    assert 'chart' in result
    assert 'stiffness' in result
```

## 测试数据管理

### 小数据使用Fixtures

```python
@pytest.fixture
def sample_data():
    return np.array([1, 2, 3, 4, 5])
```

### 大数据使用文件

大型测试数据放在 `tests/test_data/` 目录，但不应提交到Git。

### Mock外部依赖

```python
def test_file_reading(mocker):
    mock_open = mocker.patch('builtins.open')
    # 测试代码
```

## 性能测试

### 基准测试

```python
def test_parse_performance(benchmark):
    """测试解析性能。"""
    result = benchmark(parse_res_file, "large_file.res")
    assert result is not None
```

### 性能要求

- 文件解析: < 10秒（100MB文件）
- 数据计算: < 1秒（1000个数据点）
- 图表生成: < 2秒

## 图表一致性测试

### 数据点对比

```python
def test_plot_data_consistency():
    """测试图表数据点一致性。"""
    matlab_data = load_matlab_plot_data("reference.mat")
    python_data = generate_plot_data()
    
    assert np.allclose(matlab_data, python_data, rtol=1e-6)
```

### 视觉对比

```python
def test_plot_visual_consistency():
    """测试图表视觉一致性。"""
    matlab_figure = load_matlab_figure("reference.png")
    python_figure = generate_plot()
    
    similarity = compare_images(matlab_figure, python_figure)
    assert similarity > 0.95  # 95%相似度
```

## 测试标记

### 标记类型

- `@pytest.mark.unit`: 单元测试
- `@pytest.mark.integration`: 集成测试
- `@pytest.mark.e2e`: 端到端测试
- `@pytest.mark.slow`: 慢速测试
- `@pytest.mark.skip`: 跳过测试

### 使用示例

```python
@pytest.mark.unit
def test_simple_function():
    pass

@pytest.mark.integration
@pytest.mark.slow
def test_complex_workflow():
    pass
```

## 测试执行策略

### 开发时

```bash
# 运行相关测试
pytest tests/unit/test_res_parser.py

# 运行并查看覆盖率
pytest --cov=Python_Target/src --cov-report=term-missing
```

### 提交前

```bash
# 运行所有测试
pytest

# 运行快速测试（跳过慢速测试）
pytest -m "not slow"
```

### CI/CD

```bash
# 运行所有测试，包括慢速测试
pytest --cov=Python_Target/src --cov-report=xml

# 检查覆盖率阈值
pytest --cov=Python_Target/src --cov-fail-under=80
```

## 测试维护

### 测试更新时机

- 功能变更时更新相关测试
- Bug修复时添加回归测试
- 重构时更新测试以反映新接口

### 测试审查

- 确保测试覆盖所有边界情况
- 确保测试独立且可重复
- 确保测试名称清晰描述测试内容

## 测试最佳实践

1. **AAA模式**: Arrange-Act-Assert
2. **测试隔离**: 每个测试独立
3. **描述性命名**: 测试名称清晰描述测试内容
4. **一个断言一个概念**: 每个测试验证一个概念
5. **避免测试实现细节**: 测试行为，不测试实现
6. **使用Fixtures**: 共享测试数据和设置
7. **Mock外部依赖**: 隔离被测试代码
8. **测试边界**: 正常情况、边界情况、错误情况
