# GUI 模块 API 文档

## 概述

GUI 模块 (`src.gui`) 提供基于 PyQt6 的用户界面组件。

## 模块

### MainWindow

**位置**: `src.gui.main_window`

**描述**: 应用程序主窗口，整合所有 UI 组件。

#### 类定义

```python
class MainWindow(QMainWindow):
    """主窗口类
    
    应用程序的主窗口，包含菜单栏、状态栏、车辆参数面板和K&C分析Tab。
    """
```

#### 方法

##### `__init__(parent: Optional[QWidget] = None)`

初始化主窗口。

**参数**:
- `parent` (Optional[QWidget]): 父 Widget

##### `setup_ui()`

设置 UI 布局。

##### `setup_menu_bar()`

设置菜单栏。

##### `setup_status_bar()`

设置状态栏。

##### `connect_signals()`

连接信号和槽。

---

### VehicleParamsPanel

**位置**: `src.gui.vehicle_params`

**描述**: 车辆参数输入面板。

#### 类定义

```python
class VehicleParamsPanel(QWidget):
    """车辆参数面板
    
    用于输入和管理车辆基本参数。
    """
```

#### 方法

##### `__init__(parent: Optional[QWidget] = None)`

初始化车辆参数面板。

**参数**:
- `parent` (Optional[QWidget]): 父 Widget

##### `get_params() -> Dict[str, float]`

获取当前参数值。

**返回**:
- `Dict[str, float]`: 参数字典

##### `set_params(params: Dict[str, float])`

设置参数值。

**参数**:
- `params` (Dict[str, float]): 参数字典

##### `params_changed`

**信号**: 参数改变时发出。

---

### BaseTestTab

**位置**: `src.gui.kc_tabs`

**描述**: 测试 Tab 基类，提供通用功能。

#### 类定义

```python
class BaseTestTab(QWidget):
    """测试Tab基类
    
    提供文件选择、结果显示、图表管理等通用功能。
    """
```

#### 方法

##### `load_file(file_path: str)`

加载数据文件。

**参数**:
- `file_path` (str): 文件路径

##### `calculate()`

执行计算。

##### `plot()`

绘制图表。

##### `clear()`

清空数据和图表。

---

### StartInfoTab

**位置**: `src.gui.kc_tabs`

**描述**: 启动信息 Tab，显示程序信息和帮助。

#### 类定义

```python
class StartInfoTab(BaseTestTab):
    """启动信息Tab
    
    显示程序信息、使用说明等。
    """
```

---

### BumpTestTab

**位置**: `src.gui.kc_tabs`

**描述**: Bump 测试 Tab。

#### 类定义

```python
class BumpTestTab(BaseTestTab):
    """Bump测试Tab
    
    提供Bump测试工况的分析功能。
    """
```

#### 方法

##### `calculate_bump_steer()`

计算 Bump Steer。

##### `calculate_bump_camber()`

计算 Bump Camber。

##### `calculate_wheel_rate()`

计算 Wheel Rate。

---

### RollTestTab

**位置**: `src.gui.kc_tabs`

**描述**: Roll 测试 Tab。

#### 类定义

```python
class RollTestTab(BaseTestTab):
    """Roll测试Tab
    
    提供Roll测试工况的分析功能。
    """
```

---

### StaticLoadLateralTab

**位置**: `src.gui.kc_tabs`

**描述**: Static Load Lateral 测试 Tab。

#### 类定义

```python
class StaticLoadLateralTab(BaseTestTab):
    """Static Load Lateral测试Tab
    
    提供侧向力测试的分析功能。
    """
```

---

### StaticLoadBrakingTab

**位置**: `src.gui.kc_tabs`

**描述**: Static Load Braking 测试 Tab。

#### 类定义

```python
class StaticLoadBrakingTab(BaseTestTab):
    """Static Load Braking测试Tab
    
    提供制动力测试的分析功能。
    """
```

---

### StaticLoadAccelerationTab

**位置**: `src.gui.kc_tabs`

**描述**: Static Load Acceleration 测试 Tab。

#### 类定义

```python
class StaticLoadAccelerationTab(BaseTestTab):
    """Static Load Acceleration测试Tab
    
    提供加速力测试的分析功能。
    """
```

---

### MatplotlibWidget

**位置**: `src.gui.plot_widgets`

**描述**: Matplotlib 图表 Widget，用于在 PyQt6 中显示图表。

#### 类定义

```python
class MatplotlibWidget(QWidget):
    """Matplotlib图表Widget
    
    在PyQt6中嵌入matplotlib图表。
    """
```

#### 方法

##### `__init__(parent: Optional[QWidget] = None)`

初始化 Widget。

**参数**:
- `parent` (Optional[QWidget]): 父 Widget

##### `get_figure() -> Figure`

获取 matplotlib Figure 对象。

**返回**:
- `Figure`: matplotlib Figure 对象

##### `get_axes() -> Axes`

获取 matplotlib Axes 对象。

**返回**:
- `Axes`: matplotlib Axes 对象

##### `clear()`

清空图表。

##### `refresh()`

刷新图表显示。

##### `save_figure(file_path: str, dpi: int = 300)`

保存图表。

**参数**:
- `file_path` (str): 保存路径
- `dpi` (int): 分辨率，默认 300

---

### ComparisonPlotWidget

**位置**: `src.gui.plot_widgets`

**描述**: 对比图表 Widget，支持多组数据对比。

#### 类定义

```python
class ComparisonPlotWidget(MatplotlibWidget):
    """对比图表Widget
    
    支持多组数据的对比显示。
    """
```

#### 方法

##### `add_comparison(data: Dict[str, np.ndarray], label: str, color: Optional[str] = None)`

添加对比数据。

**参数**:
- `data` (Dict[str, np.ndarray]): 数据字典
- `label` (str): 数据标签
- `color` (Optional[str]): 颜色，如果为 None 则自动分配

##### `set_max_comparisons(max_count: int)`

设置最大对比数量。

**参数**:
- `max_count` (int): 最大数量

##### `clear_comparisons()`

清空所有对比数据。

---

## 使用示例

### 创建主窗口

```python
from PyQt6.QtWidgets import QApplication
from src.gui import MainWindow

app = QApplication([])
window = MainWindow()
window.show()
app.exec()
```

### 使用车辆参数面板

```python
from src.gui import VehicleParamsPanel

panel = VehicleParamsPanel()

# 获取参数
params = panel.get_params()

# 设置参数
panel.set_params({
    "half_load": 500.0,
    "max_load": 1000.0,
    "wheel_base": 2.7
})

# 监听参数变化
panel.params_changed.connect(on_params_changed)
```

### 使用图表 Widget

```python
from src.gui import MatplotlibWidget
import matplotlib.pyplot as plt

widget = MatplotlibWidget()
ax = widget.get_axes()

# 绘制数据
ax.plot(x_data, y_data)
widget.refresh()
```

---

## 信号和槽

### VehicleParamsPanel 信号

- `params_changed`: 参数改变时发出

### BaseTestTab 信号

- `file_loaded`: 文件加载完成时发出
- `calculation_complete`: 计算完成时发出
- `plot_updated`: 图表更新时发出

---

## 样式定制

主窗口支持样式定制，可以通过 `setup_style()` 方法设置：

```python
window.setup_style()
```

样式包括：
- 窗口主题
- 按钮样式
- 输入框样式
- 图表样式

---

## 异常处理

GUI 模块会自动处理以下异常：

- 文件加载错误
- 数据解析错误
- 计算错误
- 绘图错误

错误信息会显示在状态栏和消息框中。
