# 安装缺失的依赖库
Write-Host "正在安装依赖库..." -ForegroundColor Green

$venvPython = "Python_Target\venv\Scripts\python.exe"

if (Test-Path $venvPython) {
    Write-Host "使用虚拟环境: $venvPython" -ForegroundColor Yellow
    & $venvPython -m pip install openpyxl python-pptx --upgrade
    Write-Host "`n验证安装..." -ForegroundColor Yellow
    & $venvPython -c "import openpyxl; import pptx; print('✓ openpyxl version:', openpyxl.__version__); print('✓ python-pptx installed successfully')"
} else {
    Write-Host "错误: 虚拟环境未找到！" -ForegroundColor Red
    Write-Host "请先创建虚拟环境或使用系统Python" -ForegroundColor Yellow
    python -m pip install openpyxl python-pptx --upgrade
}

Write-Host "`n完成！" -ForegroundColor Green
