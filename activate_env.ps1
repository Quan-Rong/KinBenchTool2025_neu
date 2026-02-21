# 激活 Python 3.14 虚拟环境的便捷脚本
# 使用方法: .\activate_env.ps1

Write-Host "正在激活 Python 3.14 虚拟环境..." -ForegroundColor Green

# 检查虚拟环境是否存在
if (Test-Path ".\venv\Scripts\Activate.ps1") {
    # 激活虚拟环境
    & ".\venv\Scripts\Activate.ps1"
    
    # 验证 Python 版本
    Write-Host "`n虚拟环境已激活！" -ForegroundColor Green
    Write-Host "Python 版本: " -NoNewline
    python --version
    
    Write-Host "`n提示: 使用 'deactivate' 命令可以退出虚拟环境" -ForegroundColor Yellow
} else {
    Write-Host "错误: 虚拟环境不存在！请先创建虚拟环境。" -ForegroundColor Red
    Write-Host "运行: py -3.14 -m venv venv" -ForegroundColor Yellow
}
