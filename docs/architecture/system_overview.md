# 系统概览

## 项目简介

KnC_Bewertung是一个用于K&C（Kinematics & Compliance）参数分析和可视化的工具。本项目将MATLAB App完整重构为Python应用程序，实现1:1功能复刻。

## 系统架构

```
┌─────────────────────────────────────────────────────────┐
│                    GUI Layer (PyQt6)                    │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐ │
│  │ Main Window  │  │ Vehicle Params│  │  K&C Tabs    │ │
│  └──────────────┘  └──────────────┘  └──────────────┘ │
└─────────────────────────────────────────────────────────┘
                          │
┌─────────────────────────────────────────────────────────┐
│                  Business Logic Layer                    │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐ │
│  │ Data Parser  │  │ K&C Calculator│  │ Plot Engine  │ │
│  └──────────────┘  └──────────────┘  └──────────────┘ │
└─────────────────────────────────────────────────────────┘
                          │
┌─────────────────────────────────────────────────────────┐
│                    Data Layer                            │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐ │
│  │ .res Files   │  │ Config Files │  │ Resources    │ │
│  └──────────────┘  └──────────────┘  └──────────────┘ │
└─────────────────────────────────────────────────────────┘
```

## 核心模块

### 1. GUI模块 (`src/gui/`)
- **main_window.py**: 主窗口，应用程序入口
- **vehicle_params.py**: 车辆参数输入面板
- **kc_tabs.py**: K&C分析Tab页面
- **plot_widgets.py**: 图表显示组件

### 2. 数据处理模块 (`src/data/`)
- **res_parser.py**: .res文件解析器
- **kc_calculator.py**: K&C参数计算
- **data_extractor.py**: 数据提取工具
- **unit_converter.py**: 单位转换

### 3. 绘图模块 (`src/plot/`)
- **bump_plot.py**: Bump测试绘图
- **roll_plot.py**: Roll测试绘图
- **static_load_plot.py**: 静态载荷测试绘图
- **plot_utils.py**: 绘图工具函数

### 4. 配置模块 (`src/config/`)
- **kc_params.py**: K&C参数ID映射
- **ui_config.py**: UI配置
- **plot_config.py**: 绘图样式配置

### 5. 工具模块 (`src/utils/`)
- **file_utils.py**: 文件操作工具
- **math_utils.py**: 数学计算工具
- **validators.py**: 数据验证工具

## 数据流

```
.res文件
  ↓
res_parser.py (解析)
  ↓
数据矩阵 (numpy array)
  ↓
data_extractor.py (提取参数)
  ↓
kc_calculator.py (计算)
  ↓
计算结果
  ↓
plot_*.py (绘图)
  ↓
图表显示 (GUI)
```

## 技术栈

- **GUI**: PyQt6
- **数据处理**: NumPy, Pandas
- **绘图**: Matplotlib
- **配置**: YAML
- **测试**: pytest
- **代码质量**: black, pylint, mypy

## 设计原则

1. **模块化**: 每个模块职责单一，低耦合高内聚
2. **可测试**: 所有业务逻辑可独立测试
3. **可扩展**: 易于添加新功能和新测试工况
4. **一致性**: 与MATLAB版本功能1:1对应，图表完全一致
