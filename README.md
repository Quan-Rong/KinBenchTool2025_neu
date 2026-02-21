# KinBenchTool 2025

[![Python Version](https://img.shields.io/badge/python-3.11+-blue.svg)](https://www.python.org/downloads/)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![Status](https://img.shields.io/badge/status-active-success.svg)]()

KinBenchTool 2025 - K&C (Kinematics & Compliance) 分析工具

## 项目简介

本项目是将MATLAB App `KnC_Bewertung_alpha20250127` 完整重构为Python应用程序的成果。实现了1:1功能复刻，确保所有功能保留，绘制的图表与MATLAB版本完全一致。

### 主要特性

- ✅ **完整功能迁移**: 所有MATLAB功能均已实现
- ✅ **图表一致性**: 与MATLAB版本完全一致的图表样式
- ✅ **现代化界面**: 基于PyQt6的现代化GUI
- ✅ **高性能**: 优化的数据处理和计算性能
- ✅ **完整测试**: 单元测试、集成测试、性能测试
- ✅ **完善文档**: API文档、用户手册、开发指南

## 项目结构

```
KinBenchTool2025_neu/
├── Python_Target/          # Python目标代码
│   └── src/                # 源代码
│       ├── data/          # 数据处理模块
│       ├── plot/          # 绘图模块
│       ├── gui/            # GUI模块
│       └── utils/            # 工具模块
├── MATLAB_Source/          # MATLAB源代码（参考）
├── docs/                   # 项目文档
│   ├── api/               # API文档
│   ├── user_guide/        # 用户文档
│   ├── development/       # 开发文档
│   └── architecture/     # 架构文档
├── tests/                  # 测试文件
│   ├── unit/              # 单元测试
│   ├── integration/       # 集成测试
│   └── performance/       # 性能测试
├── Resources/              # 资源文件（图标、图片等）
├── scripts/                # 工具脚本
└── Documentation/         # 项目文档（中文）
```

## 快速开始

### 环境要求

- Python 3.11+
- Git

### 安装

```bash
# 克隆仓库
git clone https://github.com/Quan-Rong/KinBenchTool2025_neu.git
cd KinBenchTool2025_neu

# 创建虚拟环境
python -m venv venv

# 激活虚拟环境
# Windows
venv\Scripts\activate
# Linux/Mac
source venv/bin/activate

# 安装依赖
pip install -r requirements.txt
pip install -r requirements-dev.txt
```

### 运行程序

```bash
# 运行主程序
python Python_Target/src/main.py

# 或作为模块运行
python -m Python_Target.src.main
```

### 开发

```bash
# 运行所有测试
pytest

# 运行特定测试
pytest tests/unit/

# 代码格式化
black Python_Target/src

# 代码检查
pylint Python_Target/src

# 类型检查
mypy Python_Target/src
```

## 分支策略

- `main`: 生产分支
- `develop`: 开发分支
- `feature/*`: 功能分支
- `bugfix/*`: 修复分支
- `release/*`: 发布分支

详细工作流程请参考 [GIT_WORKFLOW.md](GIT_WORKFLOW.md)

## 功能模块

### 数据处理
- **ResParser**: Adams .res文件解析器
- **DataExtractor**: 数据提取器
- **KCCalculator**: K&C参数计算器
- **UnitConverter**: 单位转换工具

### 测试工况
- **Bump测试**: 轮跳测试分析
- **Roll测试**: 侧倾测试分析
- **Static Load Lateral**: 侧向力测试
- **Static Load Braking**: 制动力测试
- **Static Load Acceleration**: 加速力测试

### 图表绘制
- 与MATLAB版本完全一致的图表样式
- 支持多种图表类型
- 图表导出功能
- 多数据对比功能

## 文档

### 用户文档
- [快速开始](docs/user_guide/quick_start.md) - 快速上手指南
- [用户手册](docs/user_guide/user_manual.md) - 完整用户手册
- [常见问题](docs/user_guide/faq.md) - FAQ
- [故障排除](docs/user_guide/troubleshooting.md) - 故障排除指南

### 开发文档
- [开发环境搭建](docs/development/setup.md) - 环境配置
- [编码规范](docs/development/coding_standards.md) - 代码规范
- [测试指南](docs/development/testing_guide.md) - 测试说明
- [扩展指南](docs/development/extension_guide.md) - 功能扩展
- [发布指南](docs/development/release_guide.md) - 版本发布
- [贡献指南](docs/development/contribution.md) - 贡献代码

### API文档
- [API文档索引](docs/api/README.md) - API文档总览
- [数据处理模块](docs/api/data_module.md) - 数据处理API
- [绘图模块](docs/api/plot_module.md) - 绘图API
- [GUI模块](docs/api/gui_module.md) - GUI API
- [工具模块](docs/api/utils_module.md) - 工具API

### 架构文档
- [系统概览](docs/architecture/system_overview.md) - 系统架构
- [模块设计](docs/architecture/module_design.md) - 模块设计
- [数据流](docs/architecture/data_flow.md) - 数据流图

## 技术栈

- **Python**: 3.11+
- **GUI框架**: PyQt6
- **数据处理**: NumPy, Pandas
- **绘图**: Matplotlib
- **测试**: Pytest
- **代码质量**: Black, Pylint, MyPy

## 项目状态

✅ **阶段一完成**: 基础架构搭建  
✅ **阶段二完成**: 数据解析模块  
✅ **阶段三完成**: K&C计算模块  
✅ **阶段四完成**: 绘图模块  
✅ **阶段五完成**: GUI界面  
✅ **阶段六完成**: 功能集成  
✅ **阶段七完成**: 测试与优化  
✅ **阶段八完成**: 文档与发布  

**项目进度**: 100% - 核心功能已完成，准备发布

## 版本信息

- **当前版本**: 0.1.1
- **发布日期**: 2025-01-27
- **查看变更**: [CHANGELOG.md](CHANGELOG.md)

## 许可证

[待添加]

## 贡献

欢迎贡献！请查看 [贡献指南](docs/development/contribution.md)

## 联系方式

- 📧 技术支持: [待添加]
- 🐛 问题反馈: [GitHub Issues](https://github.com/Quan-Rong/KinBenchTool2025_neu/issues)
- 📖 完整文档: [文档目录](docs/)

---

**最后更新**: 2025-01-27  
**当前版本**: 0.1.1
