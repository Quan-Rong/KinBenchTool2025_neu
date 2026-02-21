# UI功能比对报告 - Matlab vs Python

## 1. 主窗口按钮对比

### Matlab程序
- ✅ **QuitButton** (位置: 1207, 12) - 退出程序，带确认对话框
- ✅ **HelpButton** (位置: 1307, 12) - 显示帮助信息

### Python程序
- ✅ **Quit功能** - 通过菜单栏File->Exit实现
- ✅ **Help功能** - 通过菜单栏Help->About实现

**状态**: ✅ 已实现（但位置不同）

---

## 2. 每个测试Tab中的按钮对比

### 2.1 文件选择区域

#### Matlab程序
- ✅ **Browse按钮** (Button_browser_*) - 选择文件
- ✅ **GO按钮** (GOButton_*) - 执行处理
- ✅ **文件路径显示** (EditField_browser_*)

#### Python程序
- ✅ **Browse按钮** - 已实现
- ✅ **GO按钮** - 已实现
- ✅ **文件路径显示** - 已实现

**状态**: ✅ 已实现

---

### 2.2 参考车辆选择区域（重要缺失！）

#### Matlab程序
每个测试Tab都有以下StateButton组（位置在右侧，约1075-1165像素）：
- **VW UP!** (VWUPButton)
- **VW Golf** (VWGolfButton_2)
- **BYD Dolphin** (BYDDolphinButton)
- **TOYOTA Yaris** (TOYOTAYarisButton)
- **BMW 325i** (BMW325iButton)
- **VW ID.3** (VWID3Button)
- **FORD EDGE** (FORDEDGEButton)
- **Tesla Model 3** (TeslaModel3Button)
- **VW Passat** (VWPassatButton)
- **BYD Delphin** (BYDDelphinButton)

**功能**: 用于选择参考车辆进行对比（虽然功能未完全实现，但UI存在）

#### Python程序
- ❌ **完全缺失**

**状态**: ❌ **严重缺失，需要立即添加**

---

### 2.3 控制按钮区域

#### Matlab程序
每个测试Tab都有：
- ✅ **Clear Axes按钮** (BumpClearAxesButton, RollClearAxesButton等) - 清空图表
- ❌ **Positive Direction按钮** (PositivDirectionButton) - 正方向设置（功能未实现，但按钮存在）
- ❌ **自定义绘图按钮** (Button, Button_3等) - 带图标，自定义绘图（功能未实现）
- ❌ **导出PPT按钮** (Button_2, Button_4等) - 带图标，导出到PPT（功能未实现）

#### Python程序
- ✅ **Clear Axes按钮** - 已实现
- ❌ **Positive Direction按钮** - 缺失
- ❌ **自定义绘图按钮** - 缺失
- ❌ **导出PPT按钮** - 缺失

**状态**: ⚠️ **部分缺失**

---

## 3. 全局控制区域（Tab_KC_rear底部）

### Matlab程序
在Tab_KC_rear底部（位置约10-23像素高度）有以下按钮和控件：

1. **Save Results in PPT按钮** (位置: 15, 10) - 保存结果到PPT
2. **Save Results in EXCEL按钮** (位置: 154, 10) - 保存结果到Excel
3. **All KnC finished then output >>>>>> Chassis Synthesis Tool按钮** (位置: 326, 10) - 输出到Chassis Synthesis Tool
4. **to Compare Spinner** (位置: 752, 10) - 对比数量选择器
5. **Curve颜色选择器** (位置: 848, 10) - 曲线颜色
6. **Fitting颜色选择器** (位置: 934, 10) - 拟合线颜色
7. **Add Results按钮** (位置: 985, 10) - 添加结果
8. **Reset按钮** (位置: 1093, 10) - 重置

### Python程序
- ✅ **颜色选择器** (Curve和Fit) - 已实现，但在每个Tab中
- ✅ **对比数量Spinner** (Compare Count) - 已实现，但在每个Tab中
- ✅ **Reset按钮** - 已实现，但在每个Tab中
- ❌ **Save Results in PPT按钮** - 缺失
- ❌ **Save Results in EXCEL按钮** - 缺失
- ❌ **Add Results按钮** - 缺失
- ❌ **All KnC finished then output >>>>>> Chassis Synthesis Tool按钮** - 缺失

**状态**: ⚠️ **部分缺失，且位置不对（应该在主Tab组底部，而不是每个子Tab中）**

---

## 4. 多套结果对比功能（核心功能缺失！）

### Matlab程序
- ✅ 支持通过"to Compare" Spinner设置对比数量
- ✅ 可以加载多套数据，用不同颜色的曲线和拟合线同时显示
- ✅ 每次点击GO按钮，会根据compare_count在图表上叠加显示新的曲线
- ✅ 不同曲线使用不同颜色（通过颜色选择器设置）

### Python程序
- ⚠️ 有compare_count参数，但**没有实现多套数据的存储和叠加显示**
- ❌ **无法同时显示多套结果**
- ❌ **每次加载新数据会覆盖之前的图表**

**状态**: ❌ **核心功能缺失，这是最严重的问题**

---

## 5. 额外的Tab

### Matlab程序
除了基本的测试Tab外，还有：
1. **Front Suspension Tab** (Tab_KC_front) - 前悬架分析
2. **Batch All Front Suspension Tab** - 批量处理前悬架
3. **Batch All Rear Suspension Tab** - 批量处理后悬架
4. **Variant and Coordinate Sys. Tab** - 变型和坐标系设置

### Python程序
- ❌ 所有额外Tab都缺失

**状态**: ❌ **缺失**

---

## 6. 界面样式对比

### Matlab程序
- 窗口大小: 1557 x 832
- 窗口不可调整大小 (Resize = 'off')
- 背景色: 灰色系 (#f0f0f0, 0.9412 0.9412 0.9412)
- 字体: Times New Roman
- 按钮样式: 标准MATLAB App Designer样式
- 布局: 左侧车辆参数面板（固定宽度），右侧Tab组

### Python程序
- 窗口大小: 最小1400 x 800（可调整）
- 背景色: #f5f5f5（类似但可能不完全相同）
- 字体: 默认系统字体
- 按钮样式: 自定义绿色主题（与Matlab不同）
- 布局: 类似但细节不同

**状态**: ⚠️ **样式不完全一致**

---

## 7. 缺失功能优先级

### 🔴 高优先级（核心功能）
1. **多套结果对比功能** - 必须实现，这是核心功能
2. **参考车辆选择按钮** - 虽然功能未实现，但UI必须存在
3. **全局保存按钮** - Save Results in EXCEL/PPT, Add Results

### 🟡 中优先级（重要功能）
4. **Positive Direction按钮** - 虽然功能未实现，但UI必须存在
5. **自定义绘图和导出PPT按钮** - 虽然功能未实现，但UI必须存在
6. **全局控制区域位置调整** - 应该在主Tab组底部，而不是每个子Tab

### 🟢 低优先级（扩展功能）
7. **Front Suspension Tab**
8. **Batch处理Tabs**
9. **Variant and Coordinate Sys. Tab**
10. **界面样式完全匹配**

---

## 8. 实现计划

### 阶段1: 核心功能（必须立即实现）
1. 实现多套结果对比功能
   - 修改数据存储结构，支持存储多套计算结果
   - 修改绘图函数，支持叠加显示多套曲线
   - 每次GO按钮点击时，根据compare_count决定是覆盖还是叠加

2. 添加参考车辆选择按钮组
   - 在每个测试Tab右侧添加StateButton组
   - 暂时不实现功能，但UI必须存在

3. 添加全局保存按钮
   - 在主窗口底部或主Tab组底部添加按钮
   - 实现占位逻辑（暂时显示"功能未实现"消息）

### 阶段2: 重要功能
4. 添加Positive Direction按钮
5. 添加自定义绘图和导出PPT按钮
6. 调整全局控制区域位置

### 阶段3: 扩展功能
7. 添加额外Tab
8. 完全匹配界面样式

---

## 9. 技术实现要点

### 9.1 多套结果对比实现
```python
# 需要修改的数据结构
class BaseTestTab:
    def __init__(self):
        self.results_history = []  # 存储多套结果
        self.max_compare_count = 10  # 最大对比数量
        
    def _load_and_process_file(self):
        # 处理新数据
        new_result = self.process_data()
        
        # 根据compare_count决定存储策略
        if len(self.results_history) < self.compare_count:
            self.results_history.append(new_result)
        else:
            # 替换最旧的结果
            self.results_history.pop(0)
            self.results_history.append(new_result)
        
        # 更新图表，显示所有存储的结果
        self.update_plots_with_history()
```

### 9.2 参考车辆按钮组
```python
# 参考车辆列表
REFERENCE_VEHICLES = [
    "VW UP!",
    "VW Golf",
    "BYD Dolphin",
    "TOYOTA Yaris",
    "BMW 325i",
    "VW ID.3",
    "FORD EDGE",
    "Tesla Model 3",
    "VW Passat",
    "BYD Delphin"
]

# 使用QButtonGroup管理互斥选择
```

### 9.3 全局控制区域
- 应该放在主窗口底部或主Tab组（Tab_KC_rear）底部
- 不应该在每个子Tab中重复
- 使用QHBoxLayout水平排列所有按钮

---

## 10. 总结

**严重缺失的功能：**
1. ❌ 多套结果对比功能（核心功能）
2. ❌ 参考车辆选择按钮组
3. ❌ 全局保存按钮（EXCEL/PPT/Add Results）
4. ❌ Positive Direction按钮
5. ❌ 自定义绘图和导出PPT按钮
6. ❌ 额外Tab（Front Suspension, Batch等）

**需要调整的功能：**
1. ⚠️ 全局控制区域位置（应该在主Tab组底部）
2. ⚠️ 界面样式匹配（字体、颜色、布局）

**已实现但需要改进的功能：**
1. ✅ 颜色选择器（位置需要调整）
2. ✅ 对比数量Spinner（需要实际实现多套对比逻辑）
3. ✅ Reset按钮（位置需要调整）
