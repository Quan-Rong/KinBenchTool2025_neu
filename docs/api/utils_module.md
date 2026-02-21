# 工具模块 API 文档

## 概述

工具模块 (`src.utils`) 提供通用工具函数和异常处理。

## 模块

### exceptions

**位置**: `src.utils.exceptions`

**描述**: 自定义异常类。

#### 异常类层次结构

```
KnCToolError (基类)
├── FileError
│   └── FileParseError
├── DataValidationError
├── CalculationError
├── PlotGenerationError
└── ConfigurationError
```

#### KnCToolError

**基类**: `Exception`

**描述**: 所有自定义异常的基类。

#### FileError

**基类**: `KnCToolError`

**描述**: 文件操作错误。

#### FileParseError

**基类**: `FileError`

**描述**: 文件解析错误。

#### DataValidationError

**基类**: `KnCToolError`

**描述**: 数据验证错误。

#### CalculationError

**基类**: `KnCToolError`

**描述**: 计算错误。

#### PlotGenerationError

**基类**: `KnCToolError`

**描述**: 图表生成错误。

#### ConfigurationError

**基类**: `KnCToolError`

**描述**: 配置错误。

---

### logger

**位置**: `src.utils.logger`

**描述**: 日志工具。

#### 函数

##### `setup_logger(name: str = "knc_tool", log_file: Optional[str] = None, level: int = logging.INFO) -> logging.Logger`

设置日志系统。

**参数**:
- `name` (str): 日志名称，默认 "knc_tool"
- `log_file` (Optional[str]): 日志文件路径，如果为 None 则只输出到控制台
- `level` (int): 日志级别，默认 logging.INFO

**返回**:
- `logging.Logger`: Logger 对象

##### `get_logger(name: str) -> logging.Logger`

获取 Logger 对象。

**参数**:
- `name` (str): Logger 名称

**返回**:
- `logging.Logger`: Logger 对象

---

### file_utils

**位置**: `src.utils.file_utils`

**描述**: 文件工具函数。

#### 函数

##### `count_lines(file_path: str) -> int`

统计文件行数。

**参数**:
- `file_path` (str): 文件路径

**返回**:
- `int`: 行数

**异常**:
- `FileError`: 文件不存在或无法读取时抛出

##### `read_file_generator(file_path: str) -> Generator[str, None, None]`

生成器方式读取文件（逐行）。

**参数**:
- `file_path` (str): 文件路径

**返回**:
- `Generator[str, None, None]`: 行生成器

**异常**:
- `FileError`: 文件不存在或无法读取时抛出

**示例**:
```python
for line in read_file_generator("file.txt"):
    process(line)
```

##### `validate_file_path(file_path: str, required_extensions: Optional[List[str]] = None) -> bool`

验证文件路径。

**参数**:
- `file_path` (str): 文件路径
- `required_extensions` (Optional[List[str]]): 要求的扩展名列表

**返回**:
- `bool`: 是否有效

---

### math_utils

**位置**: `src.utils.math_utils`

**描述**: 数学工具函数。

#### 函数

##### `linear_fit(x: np.ndarray, y: np.ndarray, degree: int = 1) -> Tuple[np.ndarray, np.ndarray]`

线性拟合。

**参数**:
- `x` (np.ndarray): X 数据
- `y` (np.ndarray): Y 数据
- `degree` (int): 多项式次数，默认 1

**返回**:
- `Tuple[np.ndarray, np.ndarray]`: (系数数组, 拟合值数组)

**示例**:
```python
coeffs, fitted = linear_fit(x_data, y_data)
slope = coeffs[0]  # 斜率
intercept = coeffs[1]  # 截距
```

##### `find_zero_crossing(x: np.ndarray, y: np.ndarray) -> Optional[float]`

查找零交叉点。

**参数**:
- `x` (np.ndarray): X 数据
- `y` (np.ndarray): Y 数据

**返回**:
- `Optional[float]`: 零交叉点的 X 值，如果不存在则返回 None

##### `find_value_index(array: np.ndarray, value: float, tolerance: float = 1e-6) -> Optional[int]`

查找数组中指定值的索引。

**参数**:
- `array` (np.ndarray): 数组
- `value` (float): 目标值
- `tolerance` (float): 容差，默认 1e-6

**返回**:
- `Optional[int]`: 索引，如果未找到则返回 None

##### `calculate_slope(x: np.ndarray, y: np.ndarray, start_idx: Optional[int] = None, end_idx: Optional[int] = None) -> float`

计算斜率。

**参数**:
- `x` (np.ndarray): X 数据
- `y` (np.ndarray): Y 数据
- `start_idx` (Optional[int]): 起始索引
- `end_idx` (Optional[int]): 结束索引

**返回**:
- `float`: 斜率值

---

### plot_validator

**位置**: `src.utils.plot_validator`

**描述**: 图表一致性验证工具。

#### 类定义

```python
class PlotValidator:
    """图表验证器
    
    用于验证Python生成的图表与MATLAB版本的一致性。
    """
```

#### 方法

##### `__init__(matlab_reference_dir: str, python_output_dir: str)`

初始化验证器。

**参数**:
- `matlab_reference_dir` (str): MATLAB 参考图表目录
- `python_output_dir` (str): Python 输出图表目录

##### `compare_data(matlab_file: str, python_file: str, tolerance: float = 1e-6) -> bool`

对比数据文件。

**参数**:
- `matlab_file` (str): MATLAB 数据文件路径
- `python_file` (str): Python 数据文件路径
- `tolerance` (float): 容差

**返回**:
- `bool`: 是否一致

##### `compare_images(matlab_image: str, python_image: str, threshold: float = 0.95) -> bool`

对比图像文件。

**参数**:
- `matlab_image` (str): MATLAB 图像路径
- `python_image` (str): Python 图像路径
- `threshold` (float): 相似度阈值

**返回**:
- `bool`: 是否一致

##### `validate_all() -> Dict[str, bool]`

验证所有图表。

**返回**:
- `Dict[str, bool]`: 验证结果字典

---

## 使用示例

### 异常处理

```python
from src.utils.exceptions import FileError, ParseError

try:
    parser = ResParser("file.res")
    data = parser.parse()
except FileError as e:
    print(f"文件错误: {e}")
except ParseError as e:
    print(f"解析错误: {e}")
```

### 日志使用

```python
from src.utils.logger import setup_logger, get_logger

# 设置日志
setup_logger(log_file="app.log")

# 获取Logger
logger = get_logger(__name__)

# 使用
logger.info("信息")
logger.warning("警告")
logger.error("错误")
```

### 文件工具

```python
from src.utils.file_utils import count_lines, read_file_generator

# 统计行数
line_count = count_lines("file.res")
print(f"文件有 {line_count} 行")

# 逐行读取
for line in read_file_generator("file.res"):
    process(line)
```

### 数学工具

```python
from src.utils.math_utils import linear_fit, find_zero_crossing

# 线性拟合
coeffs, fitted = linear_fit(x_data, y_data)

# 查找零交叉点
zero_x = find_zero_crossing(x_data, y_data)
```

### 图表验证

```python
from src.utils.plot_validator import PlotValidator

validator = PlotValidator(
    matlab_reference_dir="matlab_plots",
    python_output_dir="python_plots"
)

results = validator.validate_all()
for plot_name, is_valid in results.items():
    print(f"{plot_name}: {'✓' if is_valid else '✗'}")
```

---

## 最佳实践

### 异常处理

- 使用具体的异常类型而不是通用的 `Exception`
- 在适当的地方捕获和处理异常
- 提供有意义的错误消息

### 日志

- 使用适当的日志级别
- 不要在循环中记录过多日志
- 敏感信息不要记录到日志

### 文件操作

- 使用生成器读取大文件
- 始终验证文件路径
- 处理文件不存在的情况

### 数学计算

- 注意数值精度问题
- 使用适当的容差进行比较
- 处理边界情况（如空数组）
