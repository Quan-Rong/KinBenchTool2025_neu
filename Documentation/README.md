# KnC_Bewertung MATLAB to Python 重构项目

## 项目概述

本项目旨在将MATLAB App `KnC_Bewertung_alpha20250127` 完整重构为Python应用程序，实现1:1功能复刻，确保所有功能保留，绘制的Plot完全一致。

## 项目状态

✅ **第一阶段完成**: 程序分析、文件整理、文档编写

### 已完成工作

1. ✅ **程序功能分析**
   - 详细分析了程序的所有功能模块
   - 理解了数据流和处理逻辑
   - 识别了所有K&C参数和测试工况

2. ✅ **文件归类整理**
   - 创建了清晰的文件夹结构
   - 将文件归类到相应文件夹
   - 保留了必要的数据文件

3. ✅ **文档编写**
   - 功能分析文档
   - 程序说明文档
   - 详细重构计划
   - 文件归类说明

## 文档结构

### Documentation/
- `README.md` - 本文件，项目总览
- `功能分析文档.md` - 详细的功能分析，包含所有模块说明
- `程序说明文档.md` - 程序使用说明和技术文档
- `重构计划.md` - 详细的分模块、分步骤重构计划（18周计划）
- `文件归类说明.md` - 文件归类情况说明

## 文件夹结构

```
KinBenchTool2025_neu/
├── MATLAB_Source/          # MATLAB源代码（重构参考）
├── NRAC_G023_Results/      # Adams仿真结果数据（保留）
├── Documentation/          # 所有文档
├── Resources/             # 资源文件（图片、图标、Logo）
│   ├── images/            # 通用图片
│   ├── icons/             # 图标文件
│   └── logos/             # Logo文件
├── Tools/                 # 辅助工具
│   └── matlab_to_python_plot_converter.py  # MATLAB绘图命令转换工具
├── Archive/               # 归档文件（历史版本等）
└── Python_Target/         # Python重构版本（待创建）
```

## 核心文件

### MATLAB源代码
- `MATLAB_Source/KnC_Bewertung_alpha20250127_exported.m` - 主程序（10630行）
- `MATLAB_Source/KinBenchTool_*.m` - 绘图函数文件
- `MATLAB_Source/countlines.pl` - Perl辅助脚本

### 测试数据
- `NRAC_G023_Results/*.res` - Adams仿真结果文件（5个文件）

## 程序功能

### 主要测试工况
1. **Bump测试** (parallel_travel) - 轮跳测试
2. **Roll测试** (opposite_travel/roll_angle) - 侧倾测试
3. **Static Load Lateral** - 侧向力测试
4. **Static Load Braking** - 制动力测试
5. **Static Load Acceleration** - 加速力测试

### 核心功能
- .res文件解析和K&C参数提取
- 数据计算和线性拟合
- 多类型图表绘制
- 性能指标计算

## 重构计划概览

### 8个阶段，18周计划

1. **阶段一**: 基础架构搭建（Week 1-2）
2. **阶段二**: 数据解析模块（Week 3-4）
3. **阶段三**: K&C计算模块（Week 5-6）
4. **阶段四**: 绘图模块（Week 7-9）
5. **阶段五**: GUI界面（Week 10-12）
6. **阶段六**: 功能集成（Week 13-14）
7. **阶段七**: 测试与优化（Week 15-16）
8. **阶段八**: 文档与发布（Week 17-18）

详细计划请查看 `重构计划.md`

## 技术栈

### Python技术选型
- **GUI**: PyQt6 (更现代的UI框架，支持更好的样式和主题)
- **数据处理**: NumPy, Pandas
- **绘图**: Matplotlib
- **配置**: YAML

### 辅助工具
- **绘图转换工具**: `Tools/matlab_to_python_plot_converter.py` - 自动将MATLAB绘图命令转换为Python/matplotlib代码，确保1:1转换精度

## 下一步行动

1. 阅读 `功能分析文档.md` 了解程序功能
2. 阅读 `重构计划.md` 了解详细计划
3. 开始阶段一：基础架构搭建
4. 在 `Python_Target/` 中创建项目结构

## 重要提示

1. **NRAC_G023_Results文件夹必须保留** - 这是程序的核心数据源
2. **MATLAB_Source文件夹是重构的主要参考** - 需要仔细分析
3. **所有未实现的功能按钮需要保留** - 供后期添加功能
4. **图表必须与MATLAB版本完全一致** - 这是重构的关键要求

## 联系方式

如有问题，请参考文档或提出讨论。

---

**项目开始日期**: 2025-01-27  
**当前阶段**: 第一阶段完成，准备开始重构开发
