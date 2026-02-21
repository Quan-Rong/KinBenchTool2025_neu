# API设计文档

## API设计原则

1. **清晰性**: 函数名和参数名清晰表达意图
2. **一致性**: 相似的函数使用相似的命名和参数顺序
3. **类型提示**: 所有公共API必须有完整的类型提示
4. **文档**: 所有公共API必须有详细的文档字符串
5. **错误处理**: 明确的异常类型和错误信息

## 核心API

### 数据处理API

#### `res_parser.parse_res_file()`

```python
def parse_res_file(file_path: str) -> Dict[str, Any]:
    """解析.res文件并提取K&C参数数据。
    
    Args:
        file_path: .res文件的完整路径
        
    Returns:
        包含以下键的字典：
        - 'param_ids': Dict[str, int] - 参数名到ID的映射
        - 'quasi_static_data': np.ndarray - 数据矩阵，形状为(n_steps, 2751)
        - 'file_info': Dict - 文件元信息
        
    Raises:
        FileNotFoundError: 文件不存在
        ValueError: 文件格式不正确
        IOError: 文件读取失败
    """
```

#### `data_extractor.extract_param_data()`

```python
def extract_param_data(
    data_matrix: np.ndarray,
    param_id: int,
    start_idx: Optional[int] = None,
    end_idx: Optional[int] = None
) -> np.ndarray:
    """从数据矩阵中提取特定参数的数据。
    
    Args:
        data_matrix: 数据矩阵，形状为(n_steps, 2751)
        param_id: 参数ID
        start_idx: 起始索引（可选）
        end_idx: 结束索引（可选）
        
    Returns:
        参数数据数组，形状为(n_steps,)或(end_idx-start_idx,)
        
    Raises:
        IndexError: 参数ID超出范围
        ValueError: 索引无效
    """
```

#### `kc_calculator.calculate_bump_params()`

```python
def calculate_bump_params(
    travel_data: np.ndarray,
    param_data: np.ndarray,
    fit_degree: int = 1
) -> Dict[str, Any]:
    """计算Bump测试的K&C参数。
    
    Args:
        travel_data: 行程数据
        param_data: 参数数据
        fit_degree: 拟合多项式次数，默认为1（线性拟合）
        
    Returns:
        包含以下键的字典：
        - 'stiffness': float - 刚度值
        - 'fitted_data': np.ndarray - 拟合后的数据
        - 'fit_coefficients': np.ndarray - 拟合系数
        - 'r_squared': float - R²值
        
    Raises:
        ValueError: 数据长度不匹配或数据无效
    """
```

### 绘图API

#### `bump_plot.plot_bump_test()`

```python
def plot_bump_test(
    travel_data: np.ndarray,
    param_data: np.ndarray,
    fitted_data: Optional[np.ndarray] = None,
    title: str = "Bump Test",
    xlabel: str = "Travel [mm]",
    ylabel: str = "Parameter",
    save_path: Optional[str] = None
) -> matplotlib.figure.Figure:
    """绘制Bump测试图表。
    
    Args:
        travel_data: 行程数据
        param_data: 参数数据
        fitted_data: 拟合数据（可选）
        title: 图表标题
        xlabel: X轴标签
        ylabel: Y轴标签
        save_path: 保存路径（可选）
        
    Returns:
        matplotlib Figure对象
        
    Raises:
        ValueError: 数据长度不匹配
    """
```

### 配置API

#### `kc_params.get_param_id()`

```python
def get_param_id(param_name: str) -> int:
    """获取参数ID。
    
    Args:
        param_name: 参数名称，如'toe_angle_left'
        
    Returns:
        参数ID
        
    Raises:
        KeyError: 参数名不存在
    """
```

### 工具API

#### `unit_converter.convert()`

```python
def convert(
    value: Union[float, np.ndarray],
    from_unit: str,
    to_unit: str
) -> Union[float, np.ndarray]:
    """单位转换。
    
    Args:
        value: 要转换的值（标量或数组）
        from_unit: 源单位，如'rad', 'deg', 'mm', 'm'
        to_unit: 目标单位
        
    Returns:
        转换后的值（类型与输入相同）
        
    Raises:
        ValueError: 不支持的单位转换
    """
```

## API版本管理

- 使用语义化版本（SemVer）
- 主要版本变更表示不兼容的API变更
- 次要版本变更表示向后兼容的功能新增
- 补丁版本变更表示向后兼容的问题修复

## 向后兼容性

- 公共API的变更必须保持向后兼容
- 废弃的API必须标记为`@deprecated`并保留至少一个主要版本
- 重大变更必须通过主要版本号升级
