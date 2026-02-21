# 绘图模块 API 文档

## 概述

绘图模块 (`src.plot`) 提供各种 K&C 测试工况的图表绘制功能，确保与 MATLAB 版本完全一致。

## 模块

### plot_utils

**位置**: `src.plot.plot_utils`

**描述**: 绘图工具函数，提供统一的图表样式配置。

#### 函数

##### `setup_matplotlib_style()`

设置 matplotlib 样式以匹配 MATLAB 版本。

**功能**:
- 设置字体为 Times New Roman
- 配置颜色方案
- 设置网格样式
- 配置坐标轴格式

##### `create_figure(figsize: Tuple[float, float] = (10, 6)) -> Tuple[Figure, Axes]`

创建标准化的图表。

**参数**:
- `figsize` (Tuple[float, float]): 图表尺寸，默认 (10, 6)

**返回**:
- `Tuple[Figure, Axes]`: (图表对象, 坐标轴对象)

##### `configure_axes(ax: Axes, xlabel: str, ylabel: str, title: str = "")`

配置坐标轴。

**参数**:
- `ax` (Axes): matplotlib 坐标轴对象
- `xlabel` (str): X轴标签
- `ylabel` (str): Y轴标签
- `title` (str): 图表标题

---

### bump_plot

**位置**: `src.plot.bump_plot`

**描述**: Bump 测试绘图函数。

#### 函数

##### `plot_bump_steer(data: Dict[str, np.ndarray], ax: Optional[Axes] = None) -> Axes`

绘制 Bump Steer 图。

**参数**:
- `data` (Dict[str, np.ndarray]): 数据字典，包含左右轮数据
- `ax` (Optional[Axes]): 坐标轴对象，如果为 None 则创建新的

**返回**:
- `Axes`: 坐标轴对象

##### `plot_bump_camber(data: Dict[str, np.ndarray], ax: Optional[Axes] = None) -> Axes`

绘制 Bump Camber 图。

**参数**:
- `data` (Dict[str, np.ndarray]): 数据字典
- `ax` (Optional[Axes]): 坐标轴对象

**返回**:
- `Axes`: 坐标轴对象

##### `plot_wheel_rate(data: Dict[str, np.ndarray], ax: Optional[Axes] = None) -> Axes`

绘制 Wheel Rate 图。

**参数**:
- `data` (Dict[str, np.ndarray]): 数据字典
- `ax` (Optional[Axes]): 坐标轴对象

**返回**:
- `Axes`: 坐标轴对象

##### `plot_wheel_recession(data: Dict[str, np.ndarray], ax: Optional[Axes] = None) -> Axes`

绘制 Wheel Recession 图。

**参数**:
- `data` (Dict[str, np.ndarray]): 数据字典
- `ax` (Optional[Axes]): 坐标轴对象

**返回**:
- `Axes`: 坐标轴对象

##### `plot_track_change(data: Dict[str, np.ndarray], ax: Optional[Axes] = None) -> Axes`

绘制 Track Change 图。

**参数**:
- `data` (Dict[str, np.ndarray]): 数据字典
- `ax` (Optional[Axes]): 坐标轴对象

**返回**:
- `Axes`: 坐标轴对象

##### `plot_castor_angle(data: Dict[str, np.ndarray], ax: Optional[Axes] = None) -> Axes`

绘制 Castor Angle 图。

**参数**:
- `data` (Dict[str, np.ndarray]): 数据字典
- `ax` (Optional[Axes]): 坐标轴对象

**返回**:
- `Axes`: 坐标轴对象

##### `plot_svsa_angle(data: Dict[str, np.ndarray], ax: Optional[Axes] = None) -> Axes`

绘制 SVSA Angle 图。

**参数**:
- `data` (Dict[str, np.ndarray]): 数据字典
- `ax` (Optional[Axes]): 坐标轴对象

**返回**:
- `Axes`: 坐标轴对象

##### `plot_svsa_length(data: Dict[str, np.ndarray], ax: Optional[Axes] = None) -> Axes`

绘制 SVSA Length 图。

**参数**:
- `data` (Dict[str, np.ndarray]): 数据字典
- `ax` (Optional[Axes]): 坐标轴对象

**返回**:
- `Axes`: 坐标轴对象

---

### roll_plot

**位置**: `src.plot.roll_plot`

**描述**: Roll 测试绘图函数。

#### 函数

##### `plot_roll_steer(data: Dict[str, np.ndarray], ax: Optional[Axes] = None) -> Axes`

绘制 Roll Steer 图。

**参数**:
- `data` (Dict[str, np.ndarray]): 数据字典
- `ax` (Optional[Axes]): 坐标轴对象

**返回**:
- `Axes`: 坐标轴对象

##### `plot_roll_camber(data: Dict[str, np.ndarray], ax: Optional[Axes] = None) -> Axes`

绘制 Roll Camber 图。

**参数**:
- `data` (Dict[str, np.ndarray]): 数据字典
- `ax` (Optional[Axes]): 坐标轴对象

**返回**:
- `Axes`: 坐标轴对象

##### `plot_roll_camber_relative_ground(data: Dict[str, np.ndarray], ax: Optional[Axes] = None) -> Axes`

绘制 Roll Camber Relative Ground 图。

**参数**:
- `data` (Dict[str, np.ndarray]): 数据字典
- `ax` (Optional[Axes]): 坐标轴对象

**返回**:
- `Axes`: 坐标轴对象

##### `plot_roll_rate(data: Dict[str, np.ndarray], ax: Optional[Axes] = None) -> Axes`

绘制 Roll Rate 图。

**参数**:
- `data` (Dict[str, np.ndarray]): 数据字典
- `ax` (Optional[Axes]): 坐标轴对象

**返回**:
- `Axes`: 坐标轴对象

##### `plot_roll_center_height(data: Dict[str, np.ndarray], ax: Optional[Axes] = None) -> Axes`

绘制 Roll Center Height 图。

**参数**:
- `data` (Dict[str, np.ndarray]): 数据字典
- `ax` (Optional[Axes]): 坐标轴对象

**返回**:
- `Axes`: 坐标轴对象

---

### static_load_plot

**位置**: `src.plot.static_load_plot`

**描述**: Static Load 测试绘图函数。

#### 函数

##### `plot_lateral_toe_compliance(data: Dict[str, np.ndarray], ax: Optional[Axes] = None) -> Axes`

绘制 Lateral Toe Compliance 图。

**参数**:
- `data` (Dict[str, np.ndarray]): 数据字典
- `ax` (Optional[Axes]): 坐标轴对象

**返回**:
- `Axes`: 坐标轴对象

##### `plot_lateral_camber_compliance(data: Dict[str, np.ndarray], ax: Optional[Axes] = None) -> Axes`

绘制 Lateral Camber Compliance 图。

**参数**:
- `data` (Dict[str, np.ndarray]): 数据字典
- `ax` (Optional[Axes]): 坐标轴对象

**返回**:
- `Axes`: 坐标轴对象

##### `plot_braking_toe_compliance(data: Dict[str, np.ndarray], ax: Optional[Axes] = None) -> Axes`

绘制 Braking Toe Compliance 图。

**参数**:
- `data` (Dict[str, np.ndarray]): 数据字典
- `ax` (Optional[Axes]): 坐标轴对象

**返回**:
- `Axes`: 坐标轴对象

##### `plot_braking_camber_compliance(data: Dict[str, np.ndarray], ax: Optional[Axes] = None) -> Axes`

绘制 Braking Camber Compliance 图。

**参数**:
- `data` (Dict[str, np.ndarray]): 数据字典
- `ax` (Optional[Axes]): 坐标轴对象

**返回**:
- `Axes`: 坐标轴对象

##### `plot_anti_dive(data: Dict[str, np.ndarray], ax: Optional[Axes] = None) -> Axes`

绘制 Anti-dive 图。

**参数**:
- `data` (Dict[str, np.ndarray]): 数据字典
- `ax` (Optional[Axes]): 坐标轴对象

**返回**:
- `Axes`: 坐标轴对象

##### `plot_acceleration_toe_compliance(data: Dict[str, np.ndarray], ax: Optional[Axes] = None) -> Axes`

绘制 Acceleration Toe Compliance 图。

**参数**:
- `data` (Dict[str, np.ndarray]): 数据字典
- `ax` (Optional[Axes]): 坐标轴对象

**返回**:
- `Axes`: 坐标轴对象

##### `plot_anti_squat(data: Dict[str, np.ndarray], ax: Optional[Axes] = None) -> Axes`

绘制 Anti-squat 图。

**参数**:
- `data` (Dict[str, np.ndarray]): 数据字典
- `ax` (Optional[Axes]): 坐标轴对象

**返回**:
- `Axes`: 坐标轴对象

---

## 使用示例

### 基本绘图

```python
import matplotlib.pyplot as plt
from src.plot import plot_bump_steer, setup_matplotlib_style

# 设置样式
setup_matplotlib_style()

# 准备数据
data = {
    "left": left_data_array,
    "right": right_data_array,
    "travel": travel_array
}

# 绘制图表
fig, ax = plt.subplots()
plot_bump_steer(data, ax=ax)
plt.show()
```

### 批量绘图

```python
from src.plot.bump_plot import (
    plot_bump_steer, plot_bump_camber, plot_wheel_rate
)

fig, axes = plt.subplots(1, 3, figsize=(18, 6))

plot_bump_steer(data, ax=axes[0])
plot_bump_camber(data, ax=axes[1])
plot_wheel_rate(data, ax=axes[2])

plt.tight_layout()
plt.show()
```

---

## 图表一致性

所有绘图函数都经过验证，确保与 MATLAB 版本完全一致：

- ✅ 字体：Times New Roman
- ✅ 颜色方案：与 MATLAB 一致
- ✅ 线型：与 MATLAB 一致
- ✅ 坐标轴格式：与 MATLAB 一致
- ✅ 图例位置：与 MATLAB 一致

---

## 异常

绘图模块可能抛出以下异常：

- `PlotGenerationError`: 图表生成错误
