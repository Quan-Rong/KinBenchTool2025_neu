# 故障排除指南

## 概述

本指南帮助您诊断和解决使用 KinBenchTool 时遇到的常见问题。

## 诊断步骤

### 1. 检查基本环境

#### Python 版本

```bash
python --version
```

**要求**: Python 3.11 或更高版本

**问题**: 如果版本过低，升级 Python 或使用 pyenv/conda 管理版本。

#### 依赖安装

```bash
pip list | grep -E "PyQt6|numpy|matplotlib|pandas"
```

**要求**: 所有依赖都已安装

**问题**: 如果缺少依赖，运行：
```bash
pip install -r requirements.txt
```

#### 虚拟环境

```bash
# 检查是否在虚拟环境中
which python  # Linux/Mac
where python  # Windows
```

**要求**: 建议在虚拟环境中运行

**问题**: 如果不在虚拟环境中，创建并激活：
```bash
python -m venv venv
source venv/bin/activate  # Linux/Mac
venv\Scripts\activate     # Windows
```

---

### 2. 检查程序启动

#### 启动命令

```bash
python main.py
```

**常见错误**:

1. **ModuleNotFoundError**:
   - 检查 Python 路径
   - 确认所有依赖已安装
   - 验证虚拟环境已激活

2. **ImportError**:
   - 检查模块路径
   - 确认 `__init__.py` 文件存在
   - 验证相对导入是否正确

3. **Qt 相关错误**:
   - 确认 PyQt6 已正确安装
   - 检查系统是否有 Qt 库
   - Linux 上可能需要安装系统 Qt 库

#### 日志检查

程序启动时会创建日志文件，检查日志：

```bash
# 查找日志文件
find . -name "*.log" -type f

# 查看最新日志
tail -f knc_tool.log
```

**常见日志错误**:
- `FileNotFoundError`: 文件路径错误
- `PermissionError`: 权限不足
- `MemoryError`: 内存不足

---

### 3. 检查文件加载

#### 文件路径

```python
# 测试文件是否存在
from pathlib import Path
file_path = Path("path/to/file.res")
print(f"文件存在: {file_path.exists()}")
print(f"文件大小: {file_path.stat().st_size} bytes")
```

**问题**: 
- 文件不存在 → 检查路径
- 文件大小为 0 → 文件可能损坏
- 路径包含特殊字符 → 使用引号或转义

#### 文件格式

检查文件前几行：

```bash
head -n 20 file.res
```

**要求**:
- 应包含 `param_id` 段
- 应包含 `"quasiStatic"` 标记

**问题**:
- 文件格式不正确 → 确认是有效的 .res 文件
- 编码问题 → 尝试转换编码（UTF-8）

#### 文件解析

如果文件加载失败，检查：

1. **文件大小**: 大文件可能需要更多时间
2. **内存**: 确保有足够内存
3. **文件完整性**: 文件可能损坏

---

### 4. 检查数据计算

#### 数据验证

```python
# 检查数据是否加载
print(f"参数ID数量: {len(param_ids)}")
print(f"数据形状: {data.shape}")
print(f"数据范围: {data.min()} - {data.max()}")
```

**问题**:
- 数据为空 → 检查文件解析
- 数据形状不正确 → 检查文件格式
- 数据范围异常 → 检查数据文件

#### 参数设置

```python
# 检查车辆参数
print(f"车辆参数: {vehicle_params}")
```

**要求**:
- 所有必需参数都已设置
- 参数值在合理范围内
- 单位正确

**问题**:
- 参数缺失 → 设置缺失参数
- 参数值异常 → 检查输入值
- 单位错误 → 确认单位转换

#### 计算错误

如果计算失败：

1. **检查输入数据**:
   ```python
   print(f"输入数据: {input_data}")
   print(f"数据有效性: {np.isfinite(input_data).all()}")
   ```

2. **检查数学运算**:
   - 避免除零错误
   - 检查数组维度
   - 验证索引范围

3. **查看详细错误**:
   - 检查日志文件
   - 查看异常堆栈跟踪

---

### 5. 检查图表绘制

#### Matplotlib 配置

```python
import matplotlib
print(f"Matplotlib 版本: {matplotlib.__version__}")
print(f"后端: {matplotlib.get_backend()}")
```

**问题**:
- 后端不支持 → 切换后端（如 'Qt5Agg'）
- 版本不兼容 → 升级 matplotlib

#### 图表显示

如果图表不显示：

1. **检查数据**:
   ```python
   print(f"数据形状: {data.shape}")
   print(f"数据有效性: {np.isfinite(data).all()}")
   ```

2. **检查坐标轴**:
   ```python
   print(f"X范围: {ax.get_xlim()}")
   print(f"Y范围: {ax.get_ylim()}")
   ```

3. **检查样式**:
   - 确认样式已正确设置
   - 检查字体是否可用

#### 图表导出

如果导出失败：

1. **检查文件权限**:
   - 确认有写入权限
   - 检查磁盘空间

2. **检查格式支持**:
   - 确认格式受支持（PNG, PDF, SVG）
   - 检查后端是否支持该格式

---

## 常见错误和解决方案

### 错误 1: `FileNotFoundError: [Errno 2] No such file or directory`

**原因**: 文件路径不正确或文件不存在

**解决方案**:
1. 检查文件路径是否正确
2. 使用绝对路径
3. 确认文件确实存在

```python
from pathlib import Path
file_path = Path("file.res").resolve()
if not file_path.exists():
    print(f"文件不存在: {file_path}")
```

### 错误 2: `MemoryError`

**原因**: 内存不足

**解决方案**:
1. 关闭其他程序释放内存
2. 使用生成器读取大文件
3. 处理数据时分批处理

### 错误 3: `ValueError: cannot convert float NaN to integer`

**原因**: 数据中包含 NaN 值

**解决方案**:
1. 检查数据有效性
2. 过滤 NaN 值
3. 使用 `np.nan_to_num()` 处理

```python
data = np.nan_to_num(data, nan=0.0)
```

### 错误 4: `IndexError: index out of range`

**原因**: 数组索引超出范围

**解决方案**:
1. 检查数组长度
2. 验证索引值
3. 使用边界检查

```python
if 0 <= index < len(array):
    value = array[index]
```

### 错误 5: `ZeroDivisionError: division by zero`

**原因**: 除零错误

**解决方案**:
1. 检查除数是否为零
2. 使用条件判断
3. 处理边界情况

```python
if divisor != 0:
    result = dividend / divisor
else:
    result = 0  # 或其他默认值
```

### 错误 6: Qt 相关错误

**原因**: PyQt6 安装或配置问题

**解决方案**:

**Windows**:
```bash
pip uninstall PyQt6
pip install PyQt6
```

**Linux**:
```bash
sudo apt-get install python3-pyqt6  # Ubuntu/Debian
sudo dnf install python3-qt6       # Fedora
```

**macOS**:
```bash
brew install pyqt6
```

---

## 性能问题

### 问题 1: 程序启动慢

**可能原因**:
- 导入模块过多
- 初始化操作耗时

**解决方案**:
1. 使用延迟导入
2. 优化初始化代码
3. 使用缓存

### 问题 2: 文件加载慢

**可能原因**:
- 文件太大
- 解析算法效率低

**解决方案**:
1. 使用生成器读取
2. 优化解析算法
3. 添加进度提示

### 问题 3: 计算慢

**可能原因**:
- 数据量大
- 算法复杂度高

**解决方案**:
1. 使用 NumPy 向量化
2. 优化算法
3. 使用多线程（如果适用）

### 问题 4: 图表绘制慢

**可能原因**:
- 数据点太多
- 图表更新频繁

**解决方案**:
1. 数据采样
2. 减少更新频率
3. 使用更快的后端

---

## 调试技巧

### 1. 启用详细日志

```python
from src.utils.logger import setup_logger
setup_logger(level=logging.DEBUG)
```

### 2. 使用调试器

```python
import pdb
pdb.set_trace()  # 设置断点
```

### 3. 打印中间结果

```python
print(f"中间结果: {intermediate_result}")
print(f"数据类型: {type(data)}")
print(f"数据形状: {data.shape}")
```

### 4. 验证数据

```python
assert data is not None, "数据不能为空"
assert len(data) > 0, "数据长度必须大于0"
assert np.isfinite(data).all(), "数据必须都是有限值"
```

---

## 获取帮助

如果以上方法都无法解决问题：

1. **收集信息**:
   - 错误消息
   - 日志文件
   - 系统信息
   - 重现步骤

2. **查看文档**:
   - [用户手册](user_manual.md)
   - [API 文档](../api/README.md)
   - [常见问题](faq.md)

3. **寻求支持**:
   - 提交 Issue
   - 联系技术支持
   - 查看社区讨论

---

**最后更新**: 2025-01-27
