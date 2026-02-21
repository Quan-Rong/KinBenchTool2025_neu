# Cursor 中永久使用 Python 3.14 配置说明

## ✅ 已完成的配置

我已经为你创建了以下配置文件，使 Cursor 永久使用 Python 3.14：

### 1. `.vscode/settings.json`
这是 Cursor（基于 VS Code）的工作区配置文件，包含：
- **Python 解释器路径**：自动指向虚拟环境中的 Python 3.14
- **自动激活虚拟环境**：在终端中自动激活虚拟环境
- **代码格式化**：配置 Black 格式化工具
- **代码检查**：启用 Pylance、Pylint、MyPy
- **测试框架**：配置 pytest

### 2. `.python-version`
指定项目使用的 Python 版本为 3.14

### 3. `.vscode/extensions.json`
推荐安装的 Python 相关扩展

## 🚀 如何使用

### 方法 1：自动生效（推荐）
1. **重新加载 Cursor**：关闭并重新打开 Cursor，或按 `Ctrl+Shift+P` 输入 "Reload Window"
2. **验证配置**：
   - 打开任意 `.py` 文件
   - 查看右下角状态栏，应该显示 Python 版本为 3.14.x
   - 或按 `Ctrl+Shift+P` 输入 "Python: Select Interpreter"，应该看到虚拟环境的 Python 3.14

### 方法 2：手动选择解释器
如果自动配置未生效：
1. 按 `Ctrl+Shift+P`
2. 输入 "Python: Select Interpreter"
3. 选择：`.\Python_Target\venv\Scripts\python.exe` (Python 3.14.x)

## 📋 配置详情

### Python 解释器路径
- **虚拟环境路径**：`${workspaceFolder}/Python_Target/venv/Scripts/python.exe`
- **系统 Python 3.14**（备选）：`C:\Users\quanr\AppData\Local\Python\pythoncore-3.14-64\python.exe`

### 自动激活虚拟环境
配置了以下设置：
```json
"python.terminal.activateEnvironment": true,
"python.terminal.activateEnvInCurrentTerminal": true
```
这意味着：
- 在 Cursor 的集成终端中，虚拟环境会自动激活
- 无需手动运行 `activate_env.ps1`

## 🔍 验证配置是否生效

### 检查 1：状态栏
打开 Python 文件后，查看 Cursor 右下角状态栏，应该显示：
```
🐍 Python 3.14.x ('venv': venv) ...
```

### 检查 2：终端
在 Cursor 的集成终端中运行：
```powershell
python --version
# 应该显示：Python 3.14.3

where.exe python
# 第一个路径应该是：...\Python_Target\venv\Scripts\python.exe
```

### 检查 3：命令面板
按 `Ctrl+Shift+P`，输入 "Python: Select Interpreter"，应该看到虚拟环境的 Python 3.14 被选中。

## ⚠️ 注意事项

1. **首次使用**：如果虚拟环境不存在，需要先创建：
   ```powershell
   py -3.14 -m venv Python_Target\venv
   ```

2. **多工作区**：如果打开多个工作区，每个工作区都会使用自己的配置

3. **扩展安装**：确保安装了 Python 扩展（Cursor 通常会提示安装）

4. **路径问题**：如果虚拟环境路径改变，需要更新 `.vscode/settings.json` 中的路径

## 🛠️ 故障排除

### 问题 1：仍然显示 Python 3.6.8
**解决方案**：
1. 按 `Ctrl+Shift+P` → "Python: Select Interpreter"
2. 手动选择虚拟环境的 Python 3.14
3. 重新加载窗口：`Ctrl+Shift+P` → "Developer: Reload Window"

### 问题 2：虚拟环境未自动激活
**解决方案**：
1. 检查 `.vscode/settings.json` 中的 `python.terminal.activateEnvironment` 是否为 `true`
2. 重启 Cursor
3. 手动激活：运行 `.\activate_env.ps1`

### 问题 3：找不到解释器
**解决方案**：
1. 确认虚拟环境存在：`Test-Path "Python_Target\venv\Scripts\python.exe"`
2. 如果不存在，创建虚拟环境：
   ```powershell
   py -3.14 -m venv Python_Target\venv
   ```
3. 安装依赖：
   ```powershell
   .\Python_Target\venv\Scripts\Activate.ps1
   pip install -r requirements.txt
   ```

## 📝 配置文件位置

- `.vscode/settings.json` - Cursor/VS Code 工作区设置
- `.python-version` - Python 版本标识文件
- `.vscode/extensions.json` - 推荐扩展列表

这些配置文件已经提交到项目，团队成员打开项目时会自动使用相同的配置。
