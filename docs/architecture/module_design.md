# 模块设计文档

## 模块概览

本文档详细描述各个模块的设计和实现。

## 1. GUI模块 (`src/gui/`)

### 1.1 Main Window (`main_window.py`)

**职责**: 应用程序主窗口，管理所有UI组件

**主要类**:
- `MainWindow(QMainWindow)`: 主窗口类

**主要方法**:
- `__init__()`: 初始化UI和信号连接
- `setup_ui()`: 设置UI布局
- `connect_signals()`: 连接信号和槽
- `load_config()`: 加载配置
- `save_config()`: 保存配置

### 1.2 Vehicle Parameters (`vehicle_params.py`)

**职责**: 车辆参数输入和管理

**主要类**:
- `VehicleParamsPanel(QWidget)`: 车辆参数面板

**主要方法**:
- `get_vehicle_params()`: 获取车辆参数
- `set_vehicle_params()`: 设置车辆参数
- `validate_params()`: 验证参数有效性

### 1.3 K&C Tabs (`kc_tabs.py`)

**职责**: K&C分析Tab页面管理

**主要类**:
- `KCTabsWidget(QTabWidget)`: Tab容器
- `BumpTestTab(QWidget)`: Bump测试Tab
- `RollTestTab(QWidget)`: Roll测试Tab
- `StaticLoadTab(QWidget)`: 静态载荷测试Tab

### 1.4 Plot Widgets (`plot_widgets.py`)

**职责**: 图表显示组件

**主要类**:
- `PlotWidget(QWidget)`: 基础图表组件
- `MatplotlibWidget(QWidget)`: Matplotlib集成组件

## 2. 数据处理模块 (`src/data/`)

### 2.1 RES Parser (`res_parser.py`)

**职责**: 解析Adams仿真结果文件(.res)

**主要类**:
- `ResParser`: .res文件解析器

**主要方法**:
- `parse_file(file_path: str) -> Dict`: 解析文件
- `extract_param_ids() -> Dict[str, int]`: 提取参数ID映射
- `extract_quasi_static_data() -> np.ndarray`: 提取quasiStatic数据段

### 2.2 K&C Calculator (`kc_calculator.py`)

**职责**: K&C参数计算

**主要类**:
- `KCCalculator`: K&C计算器

**主要方法**:
- `calculate_bump_params()`: 计算Bump测试参数
- `calculate_roll_params()`: 计算Roll测试参数
- `calculate_static_load_params()`: 计算静态载荷参数
- `linear_fit()`: 线性拟合

### 2.3 Data Extractor (`data_extractor.py`)

**职责**: 从数据矩阵中提取特定参数

**主要类**:
- `DataExtractor`: 数据提取器

**主要方法**:
- `extract_param_data()`: 提取参数数据
- `extract_time_series()`: 提取时间序列数据

### 2.4 Unit Converter (`unit_converter.py`)

**职责**: 单位转换

**主要函数**:
- `deg_to_rad()`: 度转弧度
- `rad_to_deg()`: 弧度转度
- `mm_to_m()`: 毫米转米
- `m_to_mm()`: 米转毫米
- `convert()`: 通用转换函数

## 3. 绘图模块 (`src/plot/`)

### 3.1 Bump Plot (`bump_plot.py`)

**职责**: Bump测试图表绘制

**主要函数**:
- `plot_bump_test()`: 绘制Bump测试图表
- `plot_bump_comparison()`: 绘制对比图表

### 3.2 Roll Plot (`roll_plot.py`)

**职责**: Roll测试图表绘制

**主要函数**:
- `plot_roll_test()`: 绘制Roll测试图表

### 3.3 Static Load Plot (`static_load_plot.py`)

**职责**: 静态载荷测试图表绘制

**主要函数**:
- `plot_static_load()`: 绘制静态载荷测试图表

### 3.4 Plot Utils (`plot_utils.py`)

**职责**: 绘图工具函数

**主要函数**:
- `setup_plot_style()`: 设置绘图样式
- `save_plot()`: 保存图表
- `compare_plots()`: 对比图表一致性

## 4. 配置模块 (`src/config/`)

### 4.1 K&C Params (`kc_params.py`)

**职责**: K&C参数ID映射管理

**主要类**:
- `KCParamsConfig`: 参数配置管理

**主要方法**:
- `load_config()`: 加载配置
- `get_param_id()`: 获取参数ID
- `get_all_params()`: 获取所有参数

### 4.2 UI Config (`ui_config.py`)

**职责**: UI配置管理

**主要类**:
- `UIConfig`: UI配置管理

### 4.3 Plot Config (`plot_config.py`)

**职责**: 绘图样式配置

**主要类**:
- `PlotConfig`: 绘图配置

## 5. 工具模块 (`src/utils/`)

### 5.1 File Utils (`file_utils.py`)

**职责**: 文件操作工具

**主要函数**:
- `read_file_lines()`: 读取文件行
- `count_lines()`: 统计文件行数
- `find_files()`: 查找文件

### 5.2 Math Utils (`math_utils.py`)

**职责**: 数学计算工具

**主要函数**:
- `linear_fit()`: 线性拟合
- `interpolate()`: 插值
- `derivative()`: 求导

### 5.3 Validators (`validators.py`)

**职责**: 数据验证

**主要函数**:
- `validate_file_path()`: 验证文件路径
- `validate_numeric()`: 验证数值
- `validate_range()`: 验证范围

## 模块依赖关系

```
gui/
  ├── depends on → data/
  ├── depends on → plot/
  └── depends on → config/

plot/
  ├── depends on → data/
  └── depends on → config/

data/
  └── depends on → utils/

config/
  └── (no dependencies)
```
