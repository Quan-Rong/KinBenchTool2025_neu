# Tools 工具文件夹

本文件夹包含项目重构过程中使用的辅助工具。

## matlab_to_python_plot_converter.py

MATLAB到Python绘图命令转换脚本。

### 功能

自动将MATLAB绘图命令转换为Python/matplotlib等效代码，支持：

1. **plot()** - 绘图函数
   - DisplayName (转换为 label)
   - Color (支持RGB数组和颜色名称)
   - LineWidth (转换为 linewidth)
   - Marker 和 MarkerSize
   - MarkerIndices (转换为 markevery)

2. **xlabel() / ylabel()** - 坐标轴标签
   - 文本内容
   - HorizontalAlignment
   - FontWeight

3. **title()** - 标题
   - 文本内容
   - HorizontalAlignment
   - FontWeight

4. **text()** - 文本标注
   - 位置 (x, y)
   - Units='normalized' (转换为 transform=ax.transAxes)
   - FontSize, FontName, FontWeight
   - Color
   - HorizontalAlignment, VerticalAlignment
   - Rotation

5. **legend()** - 图例
   - 'show' 参数
   - Location (通过 set() 设置)

6. **set()** - 轴属性设置
   - XGrid, YGrid (转换为 grid())
   - XMinorTick, YMinorTick (转换为 AutoMinorLocator)

7. **box()** - 边框显示

8. **axis font size** - 轴字体大小
   - YAxis.FontSize, XAxis.FontSize

### 使用方法

```bash
# 基本用法
python Tools/matlab_to_python_plot_converter.py MATLAB_Source/KinBenchTool_Bump_Plot.m

# 指定输出文件
python Tools/matlab_to_python_plot_converter.py MATLAB_Source/KinBenchTool_Bump_Plot.m output_plot.py
```

### 注意事项

⚠️ **这是自动化转换工具，转换后需要人工检查和调整：**

1. **导入语句**
   - 需要添加 `import matplotlib.pyplot as plt`
   - 需要添加 `from matplotlib.ticker import AutoMinorLocator`
   - 其他必要的导入

2. **轴变量名称**
   - MATLAB使用 `app.UIAxesLeft_R_B_toe` 这样的格式
   - PyQt6中可能需要调整为对应的matplotlib FigureCanvas对象
   - 例如：`self.ax_left_toe` 或 `self.ui.ax_left_toe`

3. **颜色格式**
   - MATLAB RGB数组 `[0, 0, 1]` 在Python中需要转换为元组或列表
   - 颜色名称字符串需要保持一致

4. **字体名称**
   - 'Times New Roman' 在Python中需要正确引用
   - 确保系统中安装了该字体

5. **坐标变换**
   - Units='normalized' 需要转换为 `transform=ax.transAxes`
   - 确保正确导入 `matplotlib.transforms`

6. **字符串拼接**
   - MATLAB的 `['y =' num2str(...) '*x+' ...]` 需要转换为Python的f-string或format

### 转换示例

**MATLAB代码：**
```matlab
plot(app.UIAxesLeft_R_B_toe, x_data, y_data, 'DisplayName', 'Result', 'Color', app.ColorPicker_curve.Value, 'LineWidth', 1.5);
ylabel(app.UIAxesLeft_R_B_toe, 'toe angle variation [°]', 'HorizontalAlignment', 'center', 'FontWeight', 'bold');
text(0.5, 0.6, 'y = 0.001*x+0.5', 'Units', 'normalized', 'FontSize', 10, 'Parent', app.UIAxesLeft_R_B_toe);
```

**转换后的Python代码：**
```python
app.UIAxesLeft_R_B_toe.plot(x_data, y_data, label='Result', color=app.ColorPicker_curve.Value, linewidth=1.5)
app.UIAxesLeft_R_B_toe.set_ylabel('toe angle variation [°]', fontweight='bold', ha='center')
app.UIAxesLeft_R_B_toe.text(0.5, 0.6, 'y = 0.001*x+0.5', transform=app.UIAxesLeft_R_B_toe.transAxes, fontsize=10)
```

### 工作流程建议

1. **批量转换所有绘图文件**
   ```bash
   python Tools/matlab_to_python_plot_converter.py MATLAB_Source/KinBenchTool_Bump_Plot.m Python_Target/src/plot/bump_plot_converted.py
   python Tools/matlab_to_python_plot_converter.py MATLAB_Source/KinBenchTool_Roll_Plot.m Python_Target/src/plot/roll_plot_converted.py
   python Tools/matlab_to_python_plot_converter.py MATLAB_Source/KinBenchTool_StaticLoad_Plot.m Python_Target/src/plot/static_load_plot_converted.py
   ```

2. **人工检查和调整**
   - 检查导入语句
   - 调整轴变量名称
   - 修正颜色和字体格式
   - 测试绘图结果

3. **与MATLAB版本对比**
   - 运行Python版本
   - 与MATLAB版本生成的图表对比
   - 确保1:1一致性

### 已知限制

- 不支持所有MATLAB绘图功能（仅支持常用功能）
- 复杂的字符串拼接可能需要手动调整
- 某些MATLAB特有的参数可能需要手动转换
- 多行plot命令的续行符处理可能不完美

### 改进建议

如果发现转换不准确的地方，可以：
1. 修改转换脚本添加新的转换规则
2. 手动调整转换后的代码
3. 记录常见问题，更新转换脚本
