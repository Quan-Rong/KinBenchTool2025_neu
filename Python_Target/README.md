# KnC Bewertung Tool - Python重构版本

## 项目状态

**当前阶段**: 阶段二完成 - 数据解析模块 ✅

**完成日期**: 2025-01-27

## 已完成模块

### ✅ 阶段一：基础架构（已完成）

- [x] 项目目录结构
- [x] 依赖管理（requirements.txt）
- [x] 版本管理系统
- [x] 代码质量工具配置

### ✅ 阶段二：数据解析模块（已完成）

#### 1. 文件工具模块 (`src/utils/file_utils.py`)
- ✅ 跨平台文件行数统计（Windows/Linux兼容）
- ✅ 文件读取工具（支持大文件生成器模式）
- ✅ 错误处理

#### 2. 数据解析模块 (`src/data/res_parser.py`)
- ✅ .res文件解析器
- ✅ K&C参数ID提取（支持30+个参数）
- ✅ quasiStatic数据段解析
- ✅ 数据矩阵构建（n_steps × 2751）

#### 3. 数据提取模块 (`src/data/data_extractor.py`)
- ✅ 根据参数名称提取数据
- ✅ 根据参数ID提取数据
- ✅ 批量提取多个参数
- ✅ 数据筛选功能

#### 4. 单位转换模块 (`src/data/unit_converter.py`)
- ✅ 角度转换（弧度↔度）
- ✅ 长度转换（毫米↔米）
- ✅ 批量转换函数

#### 5. 数学工具模块 (`src/utils/math_utils.py`)
- ✅ 线性拟合（numpy.polyfit）
- ✅ 特征点定位（零交叉点、目标值查找）
- ✅ 斜率计算

#### 6. 配置模块 (`src/config/config_loader.py`)
- ✅ 配置文件加载（YAML）
- ✅ 应用配置管理
- ✅ K&C参数配置管理

#### 7. 配置文件
- ✅ `config/kc_params.yaml` - K&C参数ID映射
- ✅ `config/app_config.yaml` - 应用默认配置

## 项目结构

```
Python_Target/
├── src/
│   ├── main.py                    # 主程序入口
│   ├── data/                       # 数据处理模块
│   │   ├── __init__.py
│   │   ├── res_parser.py          # .res文件解析器
│   │   ├── data_extractor.py      # 数据提取
│   │   └── unit_converter.py      # 单位转换
│   ├── plot/                      # 绘图模块（待开发）
│   │   └── __init__.py
│   ├── gui/                       # GUI模块（待开发）
│   │   └── __init__.py
│   ├── config/                    # 配置模块
│   │   ├── __init__.py
│   │   └── config_loader.py       # 配置加载器
│   └── utils/                     # 工具模块
│       ├── __init__.py
│       ├── file_utils.py          # 文件工具
│       ├── math_utils.py          # 数学工具
│       ├── exceptions.py          # 异常定义
│       ├── logger.py              # 日志系统
│       └── plot_validator.py      # 图表验证
├── config/                        # 配置文件
│   ├── kc_params.yaml            # K&C参数配置
│   └── app_config.yaml           # 应用配置
├── resources/                     # 资源文件
│   ├── images/
│   └── icons/
├── tests/                         # 测试文件
└── test_parser.py                 # 解析器测试脚本
```

## 使用方法

### 1. 安装依赖

```bash
pip install -r requirements.txt
```

### 2. 测试数据解析

```bash
python Python_Target/test_parser.py
```

### 3. 运行主程序

```bash
python Python_Target/src/main.py
```

## 使用示例

### 解析.res文件

```python
from src.data.res_parser import ResParser
from src.data.data_extractor import DataExtractor

# 创建解析器
parser = ResParser("path/to/file.res")

# 解析文件
param_ids, quasi_static_data = parser.parse()

# 创建数据提取器
extractor = DataExtractor(parser)

# 提取toe_angle数据（自动转换为度）
toe_angle = extractor.extract_by_name('toe_angle', convert_angle=True)

# 提取多个参数
data = extractor.extract_multiple(
    ['toe_angle', 'camber_angle'],
    convert_angle=True
)
```

### 单位转换

```python
from src.data.unit_converter import rad_to_deg, mm_to_m

# 角度转换
angle_deg = rad_to_deg(1.57)  # 约90度

# 长度转换
length_m = mm_to_m(1000)  # 1米
```

### 线性拟合

```python
from src.utils.math_utils import linear_fit
import numpy as np

x = np.array([0, 1, 2, 3, 4])
y = np.array([0, 2, 4, 6, 8])

# 线性拟合
coefficients, fitted_values = linear_fit(x, y)
# coefficients = [2.0, 0.0]  # y = 2x + 0
```

## 下一步计划

### 阶段三：K&C计算模块（待开始）
- [ ] 基础计算函数
- [ ] Bump测试计算
- [ ] Roll测试计算
- [ ] Static Load计算

### 阶段四：绘图模块（待开始）
- [ ] 绘图工具函数
- [ ] Bump测试绘图
- [ ] Roll测试绘图
- [ ] Static Load绘图

### 阶段五：GUI界面（待开始）
- [ ] 主窗口
- [ ] 车辆参数面板
- [ ] K&C分析Tab

## 技术栈

- **Python**: 3.8+
- **NumPy**: 数值计算
- **Pandas**: 数据处理
- **Matplotlib**: 绘图
- **PyQt6**: GUI框架
- **PyYAML**: 配置文件

## 开发规范

- 遵循PEP 8编码规范
- 使用类型提示
- 完善的文档字符串
- 单元测试覆盖

## 许可证

（待定）
