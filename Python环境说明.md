# Python 3.14 环境配置说明

## ✅ 环境配置完成

项目已成功配置为使用 **Python 3.14.3**。

## 📍 虚拟环境位置

虚拟环境位于：`C:\CAE\Cursor_Test\KinBenchTool2025_neu\venv`

## 🚀 使用方法

### 激活虚拟环境

在 PowerShell 中运行：

```powershell
.\venv\Scripts\Activate.ps1
```

激活后，提示符前会显示 `(venv)`，表示虚拟环境已激活。

### 验证环境

```powershell
# 检查 Python 版本
python --version
# 应该显示：Python 3.14.3

# 验证依赖
python -c "import numpy, pandas, matplotlib, PyQt6, yaml, PIL, imageio; print('All dependencies OK!')"
```

### 运行项目

```powershell
# 确保虚拟环境已激活
.\venv\Scripts\Activate.ps1

# 运行主程序
python main.py
```

### 停用虚拟环境

```powershell
deactivate
```

## 📦 已安装的依赖

- **numpy**: 2.4.2
- **pandas**: 2.3.3
- **matplotlib**: 3.10.8
- **PyQt6**: 6.10.2
- **PyYAML**: 6.0.3
- **Pillow**: 12.1.1
- **imageio**: 2.37.2

## ⚙️ 配置更新

以下配置文件已更新以支持 Python 3.14：

- `pyproject.toml`: 
  - `target-version` 更新为 `['py314']`
  - `python_version` 更新为 `"3.14"`
- `requirements.txt`:
  - `numpy` 更新为 `>=2.0.0`（支持 Python 3.14）
  - `Pillow` 更新为 `>=12.0.0`（支持 Python 3.14）

## 🔧 常见问题

### 问题：激活脚本无法执行

如果遇到执行策略错误，运行：

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### 问题：Python 命令仍指向旧版本

确保虚拟环境已激活。激活后，`python` 命令会自动指向虚拟环境中的 Python 3.14。

### 问题：需要重新安装依赖

```powershell
.\venv\Scripts\Activate.ps1
pip install -r requirements.txt
```

## 📝 注意事项

- 虚拟环境已创建在项目根目录的 `venv` 文件夹中
- 建议将 `venv` 添加到 `.gitignore`（如果还没有）
- 每次打开新的终端窗口时，需要重新激活虚拟环境
- 使用 `py -3.14` 命令也可以直接调用 Python 3.14（无需激活虚拟环境）

## 🎯 快速开始

```powershell
# 1. 进入项目目录
cd C:\CAE\Cursor_Test\KinBenchTool2025_neu

# 2. 激活虚拟环境
.\venv\Scripts\Activate.ps1

# 3. 运行项目
python Python_Target/src/main.py
```

---

**配置完成时间**: 2026-02-03  
**Python 版本**: 3.14.3  
**虚拟环境路径**: `.\venv`
