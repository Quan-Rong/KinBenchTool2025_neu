# 编码规范

## Python代码风格

### PEP 8

遵循 [PEP 8](https://www.python.org/dev/peps/pep-0008/) Python代码风格指南。

### 代码格式化

使用 **black** 进行代码格式化：

```bash
black Python_Target/src
```

配置：
- 行长度: 88字符
- 目标Python版本: 3.11+

### 类型提示

所有公共函数必须包含类型提示：

```python
def calculate_stiffness(
    data: np.ndarray,
    degree: int = 1
) -> float:
    """计算刚度值。"""
    pass
```

### 导入顺序

1. 标准库
2. 第三方库
3. 本地模块

每组之间空一行：

```python
import os
from pathlib import Path

import numpy as np
import matplotlib.pyplot as plt

from src.data import res_parser
from src.utils import math_utils
```

## 文档字符串

使用 **Google Style** 文档字符串：

```python
def parse_res_file(file_path: str) -> Dict[str, Any]:
    """解析.res文件并提取K&C参数数据。
    
    该函数读取Adams仿真结果文件，提取参数ID映射和quasiStatic数据段。
    
    Args:
        file_path: .res文件的完整路径
        
    Returns:
        包含以下键的字典：
        - 'param_ids': Dict[str, int] - 参数名到ID的映射
        - 'quasi_static_data': np.ndarray - 数据矩阵
        - 'file_info': Dict - 文件元信息
        
    Raises:
        FileNotFoundError: 文件不存在
        ValueError: 文件格式不正确
        
    Example:
        >>> data = parse_res_file('test.res')
        >>> param_ids = data['param_ids']
    """
    pass
```

## 命名规范

### 变量和函数

使用 `snake_case`:

```python
def calculate_bump_params():
    travel_data = np.array([...])
    param_data = extract_data(...)
```

### 类名

使用 `PascalCase`:

```python
class ResParser:
    pass

class KCCalculator:
    pass
```

### 常量

使用 `UPPER_SNAKE_CASE`:

```python
MAX_FILE_SIZE = 100 * 1024 * 1024  # 100MB
DEFAULT_CONFIG_PATH = "config/app_config.yaml"
```

### 私有成员

使用单下划线前缀:

```python
class MyClass:
    def __init__(self):
        self._private_var = None
    
    def _private_method(self):
        pass
```

## 代码组织

### 文件结构

```python
"""模块文档字符串。"""

# 标准库导入
import os
from typing import Dict, Any

# 第三方库导入
import numpy as np

# 本地模块导入
from src.utils import file_utils

# 常量
DEFAULT_VALUE = 42

# 类定义
class MyClass:
    pass

# 函数定义
def my_function():
    pass

# 主程序（如果适用）
if __name__ == "__main__":
    pass
```

### 函数长度

- 单个函数不超过50行
- 如果超过，考虑拆分为多个函数

### 类设计

- 单一职责原则
- 保持类的方法数量合理（< 20个方法）

## 错误处理

### 异常类型

使用合适的异常类型：

```python
if not os.path.exists(file_path):
    raise FileNotFoundError(f"文件不存在: {file_path}")

if data.shape[1] != EXPECTED_COLUMNS:
    raise ValueError(f"数据列数不正确: 期望{EXPECTED_COLUMNS}, 实际{data.shape[1]}")
```

### 错误信息

提供清晰的错误信息：

```python
# 好的
raise ValueError(f"参数ID {param_id} 超出范围 [0, {max_id}]")

# 不好的
raise ValueError("参数ID无效")
```

## 测试

### 测试文件命名

- 测试文件: `test_模块名.py`
- 测试类: `Test类名`
- 测试函数: `test_功能描述`

### 测试组织

```python
import pytest
import numpy as np
from src.data import res_parser

class TestResParser:
    def test_parse_valid_file(self):
        """测试解析有效文件。"""
        result = res_parser.parse_res_file("test.res")
        assert "param_ids" in result
        assert "quasi_static_data" in result
    
    def test_parse_invalid_file(self):
        """测试解析无效文件。"""
        with pytest.raises(FileNotFoundError):
            res_parser.parse_res_file("nonexistent.res")
```

## 代码审查清单

提交代码前检查：

- [ ] 代码符合PEP 8规范
- [ ] 有完整的类型提示
- [ ] 有详细的文档字符串
- [ ] 有单元测试且通过
- [ ] 无pylint警告
- [ ] 无mypy类型错误
- [ ] 更新了相关文档
- [ ] 更新了CHANGELOG
