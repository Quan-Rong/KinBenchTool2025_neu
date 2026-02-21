# 性能基准测试

## 性能目标

### 文件处理
- **小文件 (< 10MB)**: < 2秒
- **中等文件 (10-100MB)**: < 10秒
- **大文件 (> 100MB)**: < 30秒

### 数据计算
- **线性拟合 (1000点)**: < 0.1秒
- **参数提取**: < 0.5秒
- **完整K&C计算**: < 2秒

### 图表生成
- **单个图表**: < 1秒
- **多个图表 (5个)**: < 5秒

### 内存使用
- **峰值内存**: < 2GB（处理100MB文件）

## 性能测试

使用pytest-benchmark进行性能测试：

```python
def test_parse_performance(benchmark):
    result = benchmark(parse_res_file, "large_file.res")
    assert result is not None
```

## 性能监控

在关键函数中添加性能日志：

```python
import time
from src.utils.logger import default_logger

def parse_file(file_path):
    start_time = time.time()
    # ... 处理代码 ...
    elapsed = time.time() - start_time
    default_logger.info(f"文件解析耗时: {elapsed:.2f}秒")
```
