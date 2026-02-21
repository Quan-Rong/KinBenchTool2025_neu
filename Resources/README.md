# Resources 资源文件夹

本文件夹包含项目使用的所有资源文件，包括图片、图标、Logo等。

## 文件夹结构

```
Resources/
├── images/          # 通用图片文件
├── icons/           # 图标文件
└── logos/           # Logo文件
```

## 文件说明

### images/ - 通用图片

包含项目中使用的各种图片文件：
- `kc_pic_02.png`, `kc_pic_03.png` - K&C相关图片
- `image.png` - 其他图片
- `sin_plot.png` - 示例图表
- 其他图片文件

### icons/ - 图标文件

包含应用程序使用的图标：
- `Icon_plot_custerm.png` - 自定义绘图图标
- `icon_to_ppt.png` - 导出到PPT图标

### logos/ - Logo文件

包含公司/项目Logo：
- `Gestamp_Logo.png` - Gestamp公司Logo
- `gestamp-logo.png` - Gestamp Logo（小写版本）
- `gestamp_logo_small1.png` - Gestamp Logo（小尺寸）
- `matlab-logo.png`, `matlab_logo.png` - MATLAB Logo

## 使用说明

### 在Python代码中使用资源文件

```python
import os
from pathlib import Path

# 获取资源文件路径
RESOURCES_DIR = Path(__file__).parent.parent / "Resources"

# 加载图片
logo_path = RESOURCES_DIR / "logos" / "Gestamp_Logo.png"
icon_path = RESOURCES_DIR / "icons" / "Icon_plot_custerm.png"

# 在PyQt6中使用
from PyQt6.QtGui import QPixmap, QIcon

# 加载图片
pixmap = QPixmap(str(logo_path))
icon = QIcon(str(icon_path))
```

### 在matplotlib中使用

```python
from matplotlib.image import imread
import matplotlib.pyplot as plt

# 加载图片
logo = imread(str(RESOURCES_DIR / "logos" / "Gestamp_Logo.png"))

# 在图表中添加Logo
fig, ax = plt.subplots()
ax.imshow(logo, extent=[...], aspect='auto', alpha=0.5)
```

## 文件来源

所有资源文件均从 `Archive/` 文件夹整理而来，确保：
- 保留所有必要的图片资源
- 便于查找和使用
- 不影响原有功能

## 注意事项

1. **不要删除这些文件** - 它们是程序运行所需的资源
2. **保持文件夹结构** - 便于管理和查找
3. **添加新资源时** - 请按照类型放入相应文件夹
4. **版本控制** - 建议将资源文件纳入版本控制（如果文件不太大）

## 文件列表

### images/
- kc_pic_02.png
- kc_pic_03.png
- image.png
- sin_plot.png
- (其他图片文件)

### icons/
- Icon_plot_custerm.png
- icon_to_ppt.png

### logos/
- Gestamp_Logo.png
- gestamp-logo.png
- gestamp_logo_small1.png
- matlab-logo.png
- matlab_logo.png
