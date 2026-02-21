@echo off
REM 激活 Python 3.14 虚拟环境的便捷脚本 (Windows CMD)
REM 使用方法: activate_env.bat

echo 正在激活 Python 3.14 虚拟环境...

if exist "venv\Scripts\activate.bat" (
    call venv\Scripts\activate.bat
    echo.
    echo 虚拟环境已激活！
    python --version
    echo.
    echo 提示: 使用 'deactivate' 命令可以退出虚拟环境
) else (
    echo 错误: 虚拟环境不存在！请先创建虚拟环境。
    echo 运行: py -3.14 -m venv venv
)
