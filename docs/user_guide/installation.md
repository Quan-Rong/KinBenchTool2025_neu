# 安装指南

## 系统要求

- Python 3.11 或更高版本
- Windows 10/11 或 Linux
- 至少 2GB 可用磁盘空间

## 安装步骤

### 1. 克隆或下载项目

```bash
git clone <repository-url>
cd KinBenchTool2025_neu
```

### 2. 创建虚拟环境（推荐）

**使用 venv (Windows)**:
```bash
python -m venv venv
venv\Scripts\activate
```

**使用 venv (Linux/Mac)**:
```bash
python3 -m venv venv
source venv/bin/activate
```

**使用 conda**:
```bash
conda create -n knc_tool python=3.11
conda activate knc_tool
```

### 3. 安装依赖

**安装核心依赖**:
```bash
pip install -r requirements.txt
```

**安装开发依赖（开发人员）**:
```bash
pip install -r requirements-dev.txt
```

### 4. 验证安装

```bash
python -c "import PyQt6; import numpy; import matplotlib; print('安装成功！')"
```

## 常见问题

### Q: 安装PyQt6失败？

**A**: 确保Python版本为3.11或更高，并尝试：
```bash
pip install --upgrade pip
pip install PyQt6
```

### Q: 在Linux上缺少系统依赖？

**A**: 安装Qt6系统库：
```bash
# Ubuntu/Debian
sudo apt-get install python3-pyqt6

# Fedora
sudo dnf install python3-qt6
```

### Q: 虚拟环境激活失败？

**A**: 检查Python版本和虚拟环境路径：
```bash
python --version
which python  # Linux/Mac
where python  # Windows
```

## 下一步

安装完成后，请查看 [快速开始指南](quick_start.md)。
