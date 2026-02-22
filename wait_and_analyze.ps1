# 等待程序关闭并分析问题的脚本

Write-Host "正在监控程序运行..." -ForegroundColor Green
Write-Host "程序窗口: KinBench Tool - K&C Analysis" -ForegroundColor Yellow
Write-Host "请在使用完程序后关闭窗口，脚本将自动分析问题。" -ForegroundColor Yellow
Write-Host ""

# 获取最新的日志文件
$logDir = "monitor_logs"
$latestLog = Get-ChildItem $logDir -Filter "monitor_*.txt" | Sort-Object LastWriteTime -Descending | Select-Object -First 1
$latestSummary = Get-ChildItem $logDir -Filter "error_summary_*.txt" | Sort-Object LastWriteTime -Descending | Select-Object -First 1

if ($latestLog) {
    Write-Host "当前监控日志: $($latestLog.Name)" -ForegroundColor Cyan
}

# 等待程序关闭
$processName = "python"
$windowTitle = "KinBench Tool"

while ($true) {
    $process = Get-Process | Where-Object { 
        $_.ProcessName -eq $processName -and 
        $_.MainWindowTitle -like "*$windowTitle*" 
    }
    
    if (-not $process) {
        Write-Host "`n程序已关闭，开始分析问题..." -ForegroundColor Green
        break
    }
    
    Start-Sleep -Seconds 2
}

# 等待日志文件写入完成
Start-Sleep -Seconds 2

# 获取最新的日志文件
$finalLog = Get-ChildItem $logDir -Filter "monitor_*.txt" | Sort-Object LastWriteTime -Descending | Select-Object -First 1
$finalSummary = Get-ChildItem $logDir -Filter "error_summary_*.txt" | Sort-Object LastWriteTime -Descending | Select-Object -First 1

Write-Host "`n" + "="*80 -ForegroundColor Cyan
Write-Host "问题分析报告" -ForegroundColor Cyan
Write-Host "="*80 -ForegroundColor Cyan

if ($finalSummary) {
    Write-Host "`n错误摘要文件: $($finalSummary.Name)" -ForegroundColor Yellow
    Write-Host "`n内容:" -ForegroundColor Yellow
    Get-Content $finalSummary.FullName -Encoding UTF8
}

if ($finalLog) {
    Write-Host "`n完整日志文件: $($finalLog.Name)" -ForegroundColor Yellow
    Write-Host "`n最后50行日志:" -ForegroundColor Yellow
    Get-Content $finalLog.FullName -Tail 50 -Encoding UTF8
}

Write-Host "`n" + "="*80 -ForegroundColor Cyan
