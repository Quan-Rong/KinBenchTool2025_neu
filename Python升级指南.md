# Python 升级指南

## 当前状态
- **当前版本**: Python 3.6.8
- **项目要求**: Python 3.11 或更高版本
- **推荐版本**: Python 3.11 或 3.12

## 升级方法

### 方法一：从 Python.org 下载安装（推荐）

1. **下载 Python 3.11 或 3.12**
   - 访问：https://www.python.org/downloads/
   - 下载最新稳定版本（推荐 3.11.9 或 3.12.x）

2. **安装步骤**
   - 运行下载的安装程序
   - ✅ **重要**：勾选 "Add Python to PATH"
   - 选择 "Install Now" 或 "Customize installation"
   - 如果选择自定义安装，确保勾选：
     - ✅ pip
     - ✅ tcl/tk and IDLE
     - ✅ Python test suite
     - ✅ py launcher
     - ✅ for all users (可选)

3. **验证安装**
   ```powershell
   python --version
   # 应该显示 Python 3.11.x 或 3.12.x
   
   pip --version
   # 应该显示 pip 版本
   ```

### 方法二：从 Microsoft Store 安装

1. 打开 Microsoft Store
2. 搜索 "Python 3.11" 或 "Python 3.12"
3. 点击安装
4. 安装完成后验证：
   ```powershell
   python --version
   ```

### 方法三：使用 pyenv-win（适合需要多版本管理的用户）

1. **安装 pyenv-win**
   ```powershell
   # 使用 PowerShell (以管理员身份运行)
   Invoke-WebRequest -UseBasicParsing -Uri "https://raw.githubusercontent.com/pyenv-win/pyenv-win/master/pyenv-win/install-pyenv-win.ps1" -OutFile "./install-pyenv-win.ps1"
   & "./install-pyenv-win.ps1"
   ```

2. **安装 Python 3.11**
   ```powershell
   pyenv install 3.11.9
   pyenv global 3.11.9
   ```

3. **验证**
   ```powershell
   python --version
   ```

## 升级后操作

### 1. 重新安装项目依赖

```powershell
# 进入项目目录
cd C:\CAE\Cursor_Test\KinBenchTool2025_neu

# 升级 pip
python -m pip install --upgrade pip

# 安装项目依赖
pip install -r requirements.txt
```

### 2. 重新创建虚拟环境（如果使用）

```powershell
# 删除旧的虚拟环境（如果存在）
Remove-Item -Recurse -Force venv

# 创建新的虚拟环境
python -m venv venv

# 激活虚拟环境
.\venv\Scripts\Activate.ps1

# 安装依赖
pip install -r requirements.txt
```

### 3. 验证项目运行

```powershell
# 测试导入
python -c "import PyQt6; import numpy; import matplotlib; print('所有依赖安装成功！')"

# 运行程序
python Python_Target/src/main.py
```

## 常见问题

### Q1: 安装后 `python` 命令仍然显示旧版本？

**解决方案**：
1. 检查 PATH 环境变量：
   ```powershell
   $env:PATH -split ';' | Select-String python
   ```
2. 确保新 Python 的路径在旧版本之前
3. 或者使用完整路径：
   ```powershell
   C:\Users\YourName\AppData\Local\Programs\Python\Python311\python.exe --version
   ```

### Q2: 多个 Python 版本共存？

**解决方案**：
- 使用 `py` launcher（如果已安装）：
  ```powershell
  py -3.11 --version
  py -3.11 Python_Target/src/main.py
  ```
- 或者使用完整路径调用特定版本

### Q3: 安装依赖时出错？

**解决方案**：
```powershell
# 升级 pip 和 setuptools
python -m pip install --upgrade pip setuptools wheel

# 清理缓存后重新安装
pip cache purge
pip install -r requirements.txt
```

### Q4: PyQt6 安装失败？

**解决方案**：
```powershell
# 确保 Python 版本 >= 3.11
python --version

# 升级 pip
python -m pip install --upgrade pip

# 安装 PyQt6
pip install PyQt6
```

## 验证清单

升级完成后，请确认：

- [ ] `python --version` 显示 3.11.x 或更高
- [ ] `pip --version` 正常工作
- [ ] 可以导入 PyQt6: `python -c "import PyQt6"`
- [ ] 可以导入 numpy: `python -c "import numpy"`
- [ ] 可以导入 matplotlib: `python -c "import matplotlib"`
- [ ] 项目可以正常启动: `python Python_Target/src/main.py`

## 需要帮助？

如果遇到问题，请检查：
1. Python 版本是否正确
2. PATH 环境变量是否正确配置
3. 依赖是否全部安装成功
4. 查看错误日志获取详细信息
