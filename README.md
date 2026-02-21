# KinBenchTool2025_neu

KinBenchTool 2025 - 新版开发项目

## 项目简介

本项目是从MATLAB迁移到Python的KinBenchTool工具的新版本。

## 项目结构

```
KinBenchTool2025_neu/
├── Python_Target/      # Python目标代码
├── MATLAB_Source/      # MATLAB源代码（参考）
├── docs/               # 项目文档
├── tests/              # 测试文件
├── Resources/          # 资源文件（图标、图片等）
└── scripts/            # 工具脚本
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

### 开发

```bash
# 运行测试
pytest

# 代码格式化
black Python_Target/src

# 代码检查
pylint Python_Target/src
```

## 分支策略

- `main`: 生产分支
- `develop`: 开发分支
- `feature/*`: 功能分支
- `bugfix/*`: 修复分支
- `release/*`: 发布分支

详细工作流程请参考 [GIT_WORKFLOW.md](GIT_WORKFLOW.md)

## 文档

- [开发环境搭建](docs/development/setup.md)
- [编码规范](docs/development/coding_standards.md)
- [测试指南](docs/development/testing_guide.md)
- [用户手册](docs/user_guide/user_manual.md)

## 许可证

[待添加]

## 贡献

欢迎贡献！请查看 [贡献指南](docs/development/contribution.md)
