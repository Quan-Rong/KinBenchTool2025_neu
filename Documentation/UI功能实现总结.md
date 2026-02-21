# UI功能实现总结

## ✅ 已完成的核心功能

### 1. 多套结果对比功能（核心功能）

**实现位置：**
- `BaseTestTab`类：添加了`results_history`列表和`color_palette`
- `BumpTestTab`：完整实现了多套结果对比
- `RollTestTab`：完整实现了多套结果对比

**功能说明：**
- 当`compare_count > 0`时，每次点击GO按钮会存储当前结果到历史记录
- 如果历史记录已满，会移除最旧的结果
- 更新图表时会遍历所有历史记录，用不同颜色叠加显示
- 每套结果使用`color_palette`中的不同颜色

**使用方法：**
1. 设置"Compare Count"为想要对比的数量（1-10）
2. 依次加载不同的.res文件并点击GO
3. 图表会自动叠加显示所有结果，每套使用不同颜色

---

### 2. 参考车辆选择按钮组

**实现位置：**
- `BaseTestTab`类：添加了`setup_reference_vehicles`公共方法

**功能说明：**
- 创建了10个参考车辆StateButton（与Matlab程序一致）
- 使用`QButtonGroup`管理互斥选择
- 按钮可选中，但实际数据加载功能尚未实现（占位实现）

**参考车辆列表：**
- VW UP!
- VW Golf
- BYD Dolphin
- TOYOTA Yaris
- BMW 325i
- VW ID.3
- FORD EDGE
- Tesla Model 3
- VW Passat
- BYD Delphin

---

### 3. 控制按钮（每个测试Tab）

**实现位置：**
- `BaseTestTab`类：添加了`setup_control_buttons`公共方法

**已添加的按钮：**
- ✅ **Clear Axes** - 清空图表（功能已实现）
- ✅ **Positive Direction** - 正方向设置（UI存在，功能占位）
- ✅ **Custom Plot** - 自定义绘图（UI存在，功能占位）
- ✅ **Export to PPT** - 导出到PPT（UI存在，功能占位）

**使用方法：**
- 所有测试Tab都会自动显示这些按钮
- 未实现功能的按钮会显示"功能尚未实现"消息

---

## ⏳ 待完成的工作

### 1. 其他测试Tab的修改

**需要修改的Tab：**
- `StaticLoadLateralTab`
- `StaticLoadBrakingTab`
- `StaticLoadAccelerationTab`

**需要修改的内容：**
1. 修改`process_data`方法，返回结果数据字典
2. 修改`update_plots`方法，支持多套结果对比（参考BumpTestTab和RollTestTab的实现）
3. 在`setup_ui`中调用`setup_control_buttons`和`setup_reference_vehicles`（如果还没有调用）

**修改示例：**

```python
# 1. 修改process_data方法
def process_data(self) -> Optional[Dict[str, Any]]:
    if not self.calculator:
        return None
    try:
        # ... 计算逻辑 ...
        # 返回结果数据
        return {
            'result_key': result_data,
        }
    except Exception as e:
        # ... 错误处理 ...
        return None

# 2. 修改update_plots方法（参考BumpTestTab的实现）
def update_plots(self):
    # 清空所有图表
    self.widget.clear()
    
    # 如果没有历史记录，只显示当前结果
    if not self.results_history and self.calculator:
        # 绘制当前结果
        plot_function(...)
    else:
        # 显示所有历史记录（多套结果对比）
        for idx, result_entry in enumerate(self.results_history):
            calculator = result_entry['calculator']
            curve_color = result_entry.get('curve_color', self.color_palette[idx % len(self.color_palette)])
            # 绘制每套结果
            plot_function(..., curve_color=curve_color, compare_count=idx)
    
    # 刷新图表
    self.widget.draw()
```

---

### 2. 全局保存按钮

**需要添加的按钮：**
- **Save Results in PPT** - 保存结果到PPT
- **Save Results in EXCEL** - 保存结果到Excel
- **Add Results** - 添加结果
- **All KnC finished then output >>>>>> Chassis Synthesis Tool** - 输出到Chassis Synthesis Tool

**实现位置：**
- 应该在主窗口（`MainWindow`）或主Tab组底部添加
- 不应该在每个子Tab中重复

**实现方法：**
1. 在`MainWindow.setup_ui`中，在主Tab组底部添加按钮区域
2. 或者创建一个全局控制面板，放在主窗口底部

---

### 3. 全局控制区域位置调整

**当前问题：**
- 颜色选择器、对比数量Spinner、Reset按钮在每个子Tab中重复
- 应该移到主Tab组底部，作为全局控制

**解决方案：**
1. 从`BaseTestTab.setup_global_controls`中移除这些控件
2. 在主窗口底部创建全局控制面板
3. 所有Tab共享这些全局控制

---

### 4. 额外Tab

**需要添加：**
- Front Suspension Tab
- Batch All Front Suspension Tab
- Batch All Rear Suspension Tab
- Variant and Coordinate Sys. Tab

**优先级：** 低（可以后续实现）

---

### 5. 界面样式匹配

**需要调整：**
- 窗口大小：1557 x 832（与Matlab一致）
- 窗口不可调整大小
- 字体：Times New Roman
- 背景色和按钮样式
- 布局细节

**优先级：** 中（重要但非紧急）

---

## 📝 代码修改指南

### 如何为新Tab添加多套结果对比功能

1. **修改`process_data`方法：**
   ```python
   def process_data(self) -> Optional[Dict[str, Any]]:
       # ... 计算逻辑 ...
       return {'result_key': result_data}  # 返回结果字典
   ```

2. **修改`update_plots`方法：**
   ```python
   def update_plots(self):
       # 清空图表
       self.widget.clear()
       
       # 显示当前结果或多套结果对比
       if not self.results_history and self.calculator:
           # 单套结果
           plot_function(..., compare_count=0)
       else:
           # 多套结果对比
           for idx, result_entry in enumerate(self.results_history):
               calculator = result_entry['calculator']
               curve_color = result_entry.get('curve_color', 
                   self.color_palette[idx % len(self.color_palette)])
               plot_function(..., curve_color=curve_color, compare_count=idx)
       
       self.widget.draw()
   ```

3. **确保`setup_ui`中调用了公共方法：**
   ```python
   def setup_ui(self):
       # ... 其他UI设置 ...
       
       # 控制按钮
       self.setup_control_buttons(main_layout)
       
       # 参考车辆选择
       self.setup_reference_vehicles(main_layout)
       
       # 全局控制
       self.setup_global_controls(main_layout)
   ```

---

## 🎯 下一步计划

### 优先级1（立即完成）
1. ✅ 多套结果对比功能 - **已完成**
2. ✅ 参考车辆选择按钮组 - **已完成**
3. ✅ 控制按钮 - **已完成**
4. ⏳ 修改其他Static Load Tab - **进行中**
5. ⏳ 在主窗口添加全局保存按钮 - **待实现**

### 优先级2（重要）
6. ⏳ 调整全局控制区域位置
7. ⏳ 完善所有Tab的多套结果对比功能

### 优先级3（扩展）
8. ⏳ 添加额外Tab
9. ⏳ 完全匹配界面样式

---

## 📌 注意事项

1. **多套结果对比功能**：需要确保所有绘图函数都支持`compare_count`参数，用于控制文本位置
2. **参考车辆功能**：虽然UI已添加，但实际数据加载和对比功能尚未实现（这是未来的工作）
3. **按钮占位实现**：所有未实现功能的按钮都有占位回调，显示"功能未实现"消息
4. **代码复用**：参考车辆按钮组和控制按钮的创建已提取为基类方法，减少重复代码

---

## 🔧 技术细节

### 多套结果存储结构
```python
result_entry = {
    'calculator': self.calculator,      # 计算器对象
    'extractor': self.extractor,        # 数据提取器
    'parser': self.parser,              # 文件解析器
    'file_path': file_path,             # 文件路径
    'result_data': result_data,         # 计算结果
    'curve_color': self.curve_color,    # 曲线颜色
    'fit_color': self.fit_color,        # 拟合线颜色
}
```

### 颜色调色板
```python
self.color_palette = [
    '#1f77b4', '#ff7f0e', '#2ca02c', '#d62728', '#9467bd',
    '#8c564b', '#e377c2', '#7f7f7f', '#bcbd22', '#17becf'
]  # 10种不同颜色用于对比
```
