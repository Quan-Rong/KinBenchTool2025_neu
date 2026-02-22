# API 文档索引

## 概述

本文档提供了 KinBenchTool 2025 的完整 API 参考。

## 模块文档

### 数据处理模块

- [数据处理模块 API](data_module.md)
  - `ResParser`: .res 文件解析器
  - `DataExtractor`: 数据提取器
  - `KCCalculator`: K&C 计算器
  - `UnitConverter`: 单位转换工具

### 绘图模块

- [绘图模块 API](plot_module.md)
  - `plot_utils`: 绘图工具函数
  - `bump_plot`: Bump 测试绘图
  - `roll_plot`: Roll 测试绘图
  - `static_load_plot`: Static Load 测试绘图

### GUI 模块

- [GUI 模块 API](gui_module.md)
  - `MainWindow`: 主窗口
  - `VehicleParamsPanel`: 车辆参数面板
  - `BaseTestTab`: 测试 Tab 基类
  - `MatplotlibWidget`: Matplotlib 图表 Widget

### 工具模块

- [工具模块 API](utils_module.md)
  - `exceptions`: 异常类
  - `logger`: 日志工具
  - `file_utils`: 文件工具
  - `math_utils`: 数学工具
  - `plot_validator`: 图表验证器

## 快速参考

### 导入示例

```python
# 数据处理
from src.data import ResParser, DataExtractor, KCCalculator

# 绘图
from src.plot import plot_bump_steer, plot_roll_steer

# GUI
from src.gui import MainWindow, VehicleParamsPanel

# 工具
from src.utils import KnCToolError, get_logger
```

### 基本工作流程

```python
# 1. 解析文件
parser = ResParser("file.res")
param_ids, data = parser.parse()

# 2. 提取数据
extractor = DataExtractor(data, param_ids)
column = extractor.extract_by_name("toe_angle_left")

# 3. 计算
calculator = KCCalculator(extractor)
result = calculator.calculate_bump_steer()

# 4. 绘图
plot_bump_steer(data)
```

## 版本信息

- **当前版本**: 0.2.0
- **API 版本**: 1.0
- **最后更新**: 2025-01-27

## 相关文档

- [用户手册](../user_guide/user_manual.md)
- [开发指南](../development/setup.md)
- [架构文档](../architecture/system_overview.md)

## 反馈

如有问题或建议，请：
- 查看 [常见问题](../user_guide/user_manual.md#常见问题)
- 提交 Issue
- 联系开发团队
