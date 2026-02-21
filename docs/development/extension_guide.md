# 扩展指南

## 概述

本指南说明如何扩展 KinBenchTool 的功能，包括添加新的测试工况、计算函数、绘图函数等。

## 添加新的测试工况

### 步骤 1: 创建 Tab 类

在 `src/gui/kc_tabs.py` 中创建新的 Tab 类：

```python
class NewTestTab(BaseTestTab):
    """新测试工况Tab
    
    提供新测试工况的分析功能。
    """
    
    def __init__(self, parent: Optional[QWidget] = None):
        super().__init__(parent)
        self.setup_ui()
    
    def setup_ui(self):
        """设置UI"""
        # 添加特定的UI组件
        pass
    
    def calculate(self):
        """执行计算"""
        # 调用计算函数
        from ..data.kc_calculator import KCCalculator
        calculator = KCCalculator(self.extractor, self.vehicle_params)
        result = calculator.calculate_new_test()
        self.display_result(result)
    
    def plot(self):
        """绘制图表"""
        from ..plot.new_test_plot import plot_new_test
        data = self.prepare_plot_data()
        plot_new_test(data, ax=self.plot_widget.get_axes())
        self.plot_widget.refresh()
```

### 步骤 2: 添加计算函数

在 `src/data/kc_calculator.py` 中添加计算函数：

```python
def calculate_new_test(self) -> Dict[str, float]:
    """计算新测试工况
    
    Returns:
        Dict[str, float]: 计算结果字典
    """
    # 提取数据
    param1 = self.extractor.extract_by_name("param1")
    param2 = self.extractor.extract_by_name("param2")
    
    # 执行计算
    result = self._calculate_new_test_internal(param1, param2)
    
    return result

def _calculate_new_test_internal(self, param1, param2):
    """内部计算函数"""
    # 实现具体计算逻辑
    pass
```

### 步骤 3: 添加绘图函数

在 `src/plot/` 中创建新的绘图模块或添加到现有模块：

```python
def plot_new_test(data: Dict[str, np.ndarray], ax: Optional[Axes] = None) -> Axes:
    """绘制新测试工况图表
    
    Args:
        data: 数据字典
        ax: 坐标轴对象
        
    Returns:
        Axes: 坐标轴对象
    """
    from .plot_utils import setup_matplotlib_style, create_figure
    
    if ax is None:
        fig, ax = create_figure()
    
    # 设置样式
    setup_matplotlib_style()
    
    # 绘制数据
    ax.plot(data["x"], data["y"], label="New Test")
    
    # 配置坐标轴
    ax.set_xlabel("X Label")
    ax.set_ylabel("Y Label")
    ax.set_title("New Test Plot")
    ax.legend()
    ax.grid(True)
    
    return ax
```

### 步骤 4: 注册 Tab

在 `src/gui/main_window.py` 中注册新的 Tab：

```python
def setup_ui(self):
    # ... 现有代码 ...
    
    # 添加新Tab
    new_tab = NewTestTab()
    self.tab_widget.addTab(new_tab, "New Test")
```

---

## 添加新的计算参数

### 步骤 1: 定义参数ID

在配置文件中定义参数ID（如果使用配置文件）：

```yaml
# config/kc_params.yaml
new_param:
  left: 1234
  right: 1235
```

或在代码中直接定义：

```python
NEW_PARAM_ID_LEFT = 1234
NEW_PARAM_ID_RIGHT = 1235
```

### 步骤 2: 添加提取函数

在 `src/data/data_extractor.py` 中添加提取函数（如果需要）：

```python
def extract_new_param(self, side: str = "left") -> Optional[np.ndarray]:
    """提取新参数
    
    Args:
        side: "left" 或 "right"
        
    Returns:
        Optional[np.ndarray]: 数据数组
    """
    param_id = NEW_PARAM_ID_LEFT if side == "left" else NEW_PARAM_ID_RIGHT
    return self.extract_column(param_id)
```

### 步骤 3: 添加计算函数

在 `src/data/kc_calculator.py` 中添加计算函数：

```python
def calculate_new_param(self) -> Dict[str, float]:
    """计算新参数
    
    Returns:
        Dict[str, float]: 计算结果
    """
    left_data = self.extractor.extract_new_param("left")
    right_data = self.extractor.extract_new_param("right")
    
    # 执行计算
    result = {
        "left": self._calculate_single_side(left_data),
        "right": self._calculate_single_side(right_data),
        "average": (left_result + right_result) / 2
    }
    
    return result
```

---

## 添加新的绘图类型

### 步骤 1: 创建绘图函数

在相应的绘图模块中创建函数：

```python
def plot_new_type(data: Dict[str, np.ndarray], ax: Optional[Axes] = None) -> Axes:
    """绘制新类型图表
    
    Args:
        data: 数据字典
        ax: 坐标轴对象
        
    Returns:
        Axes: 坐标轴对象
    """
    from .plot_utils import setup_matplotlib_style
    
    if ax is None:
        fig, ax = plt.subplots(figsize=(10, 6))
    
    setup_matplotlib_style()
    
    # 绘制逻辑
    ax.plot(data["x"], data["y"], marker="o", label="Data")
    
    # 配置
    ax.set_xlabel("X Axis")
    ax.set_ylabel("Y Axis")
    ax.legend()
    ax.grid(True)
    
    return ax
```

### 步骤 2: 确保样式一致

使用 `plot_utils.setup_matplotlib_style()` 确保样式与 MATLAB 版本一致：

```python
from .plot_utils import setup_matplotlib_style

setup_matplotlib_style()  # 在绘图前调用
```

### 步骤 3: 验证图表一致性

使用验证工具验证图表：

```python
from ..utils.plot_validator import PlotValidator

validator = PlotValidator(
    matlab_reference_dir="matlab_plots",
    python_output_dir="python_plots"
)

is_valid = validator.compare_images("new_type_matlab.png", "new_type_python.png")
assert is_valid, "图表不一致"
```

---

## 添加新的单位转换

### 步骤 1: 添加转换函数

在 `src/data/unit_converter.py` 中添加转换函数：

```python
def convert_new_unit(value: Union[float, np.ndarray], 
                     from_unit: str, 
                     to_unit: str) -> Union[float, np.ndarray]:
    """转换新单位
    
    Args:
        value: 要转换的值
        from_unit: 源单位
        to_unit: 目标单位
        
    Returns:
        转换后的值
    """
    # 定义转换因子
    conversion_factors = {
        ("unit1", "unit2"): 2.0,
        ("unit2", "unit1"): 0.5,
    }
    
    factor = conversion_factors.get((from_unit, to_unit))
    if factor is None:
        raise ValueError(f"不支持的转换: {from_unit} -> {to_unit}")
    
    return value * factor
```

### 步骤 2: 添加批量转换函数

```python
def convert_new_unit_array(data: np.ndarray, 
                           from_unit: str, 
                           to_unit: str) -> np.ndarray:
    """批量转换新单位数组
    
    Args:
        data: 数据数组
        from_unit: 源单位
        to_unit: 目标单位
        
    Returns:
        转换后的数组
    """
    return convert_new_unit(data, from_unit, to_unit)
```

---

## 添加新的异常类型

### 步骤 1: 定义异常类

在 `src/utils/exceptions.py` 中定义：

```python
class NewError(KnCToolError):
    """新错误类型
    
    用于描述新类型的错误。
    """
    pass
```

### 步骤 2: 使用异常

在代码中使用新异常：

```python
from ..utils.exceptions import NewError

if condition:
    raise NewError("错误描述")
```

---

## 添加新的工具函数

### 步骤 1: 选择模块

根据功能选择合适的模块：
- `file_utils.py`: 文件相关工具
- `math_utils.py`: 数学相关工具
- 其他工具模块

### 步骤 2: 实现函数

```python
def new_utility_function(param1: Type1, param2: Type2) -> ReturnType:
    """新工具函数
    
    Args:
        param1: 参数1描述
        param2: 参数2描述
        
    Returns:
        返回值描述
        
    Raises:
        ValueError: 什么情况下抛出
    """
    # 实现逻辑
    pass
```

### 步骤 3: 添加测试

在 `tests/` 中添加测试：

```python
def test_new_utility_function():
    """测试新工具函数"""
    result = new_utility_function(param1, param2)
    assert result == expected_result
```

---

## 代码规范

### 文档字符串

所有公共函数和类必须有文档字符串：

```python
def function_name(param: Type) -> ReturnType:
    """函数简短描述
    
    详细描述（如果需要）。
    
    Args:
        param: 参数描述
        
    Returns:
        返回值描述
        
    Raises:
        ValueError: 异常描述
    """
    pass
```

### 类型提示

使用类型提示：

```python
from typing import Optional, Dict, List, Tuple
import numpy as np

def function(param1: str, 
             param2: Optional[int] = None) -> Dict[str, np.ndarray]:
    pass
```

### 错误处理

使用自定义异常：

```python
from ..utils.exceptions import DataValidationError

if not is_valid(data):
    raise DataValidationError("数据无效")
```

---

## 测试要求

### 单元测试

为新功能添加单元测试：

```python
def test_new_function():
    """测试新函数"""
    # 准备测试数据
    test_data = create_test_data()
    
    # 执行函数
    result = new_function(test_data)
    
    # 验证结果
    assert result is not None
    assert isinstance(result, expected_type)
```

### 集成测试

添加集成测试验证功能集成：

```python
def test_new_feature_integration():
    """测试新功能集成"""
    # 测试完整流程
    pass
```

---

## 提交代码

### 1. 创建功能分支

```bash
git checkout develop
git pull origin develop
git checkout -b feature/new-feature
```

### 2. 编写代码和测试

- 实现功能
- 编写测试
- 更新文档

### 3. 运行测试

```bash
pytest tests/
```

### 4. 代码检查

```bash
black Python_Target/src
pylint Python_Target/src
mypy Python_Target/src
```

### 5. 提交

```bash
git add .
git commit -m "feat: 添加新功能"
git push origin feature/new-feature
```

### 6. 创建 Pull Request

在 GitHub 上创建 Pull Request，等待代码审查。

---

## 示例：完整扩展流程

### 示例：添加新的测试工况

1. **创建 Tab 类** (`src/gui/kc_tabs.py`)
2. **添加计算函数** (`src/data/kc_calculator.py`)
3. **添加绘图函数** (`src/plot/new_test_plot.py`)
4. **注册 Tab** (`src/gui/main_window.py`)
5. **添加测试** (`tests/test_new_test.py`)
6. **更新文档** (`docs/user_guide/user_manual.md`)

---

## 参考资源

- [编码规范](coding_standards.md)
- [测试指南](testing_guide.md)
- [API 文档](../api/README.md)
- [贡献指南](contribution.md)

---

**最后更新**: 2025-01-27
