# 开发环境搭建

## 前置要求

- Python 3.11+
- Git
- 代码编辑器（推荐VS Code或PyCharm）

## 步骤

### 1. 克隆仓库

```bash
git clone <repository-url>
cd KinBenchTool2025_neu
```

### 2. 创建虚拟环境

```bash
python -m venv venv
# Windows
venv\Scripts\activate
# Linux/Mac
source venv/bin/activate
```

### 3. 安装开发依赖

```bash
pip install -r requirements-dev.txt
```

### 4. 安装pre-commit hooks

```bash
pre-commit install
```

### 5. 配置IDE

#### VS Code

安装推荐扩展：
- Python
- Pylance
- Black Formatter
- Pylint

创建 `.vscode/settings.json`:
```json
{
    "python.formatting.provider": "black",
    "python.linting.enabled": true,
    "python.linting.pylintEnabled": true,
    "editor.formatOnSave": true
}
```

#### PyCharm

1. File -> Settings -> Tools -> Black
2. 启用Black格式化
3. 配置Pylint和mypy

### 6. 验证设置

```bash
# 运行测试
pytest

# 检查代码格式
black --check Python_Target/src

# 运行lint
pylint Python_Target/src

# 类型检查
mypy Python_Target/src
```

## 项目结构

```
KinBenchTool2025_neu/
├── Python_Target/
│   └── src/          # 源代码
├── tests/            # 测试文件
├── docs/             # 文档
├── scripts/          # 工具脚本
├── requirements.txt  # 核心依赖
└── requirements-dev.txt  # 开发依赖
```

## 开发工作流

1. 创建功能分支: `git checkout -b feature/功能名`
2. 编写代码和测试
3. 运行测试: `pytest`
4. 格式化代码: `black Python_Target/src`
5. 提交代码: `git commit -m "feat: 描述"`
6. 推送到远程: `git push origin feature/功能名`

## 下一步

查看 [编码规范](coding_standards.md) 和 [测试指南](testing_guide.md)。
