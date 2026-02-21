# 数据流图

## 整体数据流

```
┌─────────────────┐
│   .res Files    │
│  (Adams Results)│
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  ResParser      │
│  (解析文件)      │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  Data Matrix    │
│  (numpy array)  │
│  Shape: (n,2751)│
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ DataExtractor   │
│ (提取参数数据)   │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Parameter Data  │
│ (特定参数数组)   │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ KCCalculator    │
│ (计算K&C参数)    │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Calculated      │
│ Results         │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Plot Engine     │
│ (生成图表)       │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ GUI Display     │
│ (显示图表)       │
└─────────────────┘
```

## 详细数据流

### 1. 文件解析流程

```
.res File
  │
  ├─→ Read File Line by Line
  │     │
  │     ├─→ Find "param_id" Section
  │     │     └─→ Extract Parameter ID Mapping
  │     │           └─→ Dict[str, int]
  │     │
  │     └─→ Find "quasiStatic" Section
  │           └─→ Extract Data Matrix
  │                 └─→ np.ndarray (n_steps, 2751)
  │
  └─→ Return Parsed Data
        └─→ {
              'param_ids': Dict[str, int],
              'quasi_static_data': np.ndarray,
              'file_info': Dict
            }
```

### 2. 参数提取流程

```
Data Matrix (n, 2751)
  │
  ├─→ Get Parameter ID from Config
  │     └─→ param_id = config.get_param_id('toe_angle_left')
  │
  ├─→ Extract Column Data
  │     └─→ param_data = data_matrix[:, param_id]
  │
  └─→ Apply Unit Conversion
        └─→ converted_data = unit_converter.convert(param_data, 'rad', 'deg')
```

### 3. 计算流程

```
Parameter Data
  │
  ├─→ Bump Test Calculation
  │     ├─→ Extract Travel Data
  │     ├─→ Extract Parameter Data
  │     ├─→ Linear Fit
  │     └─→ Calculate Stiffness
  │
  ├─→ Roll Test Calculation
  │     ├─→ Extract Roll Angle
  │     ├─→ Extract Parameter Data
  │     └─→ Calculate Roll Rate
  │
  └─→ Static Load Calculation
        ├─→ Extract Force Data
        ├─→ Extract Parameter Data
        └─→ Calculate Compliance
```

### 4. 绘图流程

```
Calculated Results
  │
  ├─→ Setup Plot Style
  │     └─→ Load from plot_config.yaml
  │
  ├─→ Create Figure
  │     └─→ matplotlib.figure.Figure
  │
  ├─→ Plot Data
  │     ├─→ Plot Lines
  │     ├─→ Add Markers
  │     ├─→ Set Labels
  │     └─→ Add Legend
  │
  └─→ Display/Save
        ├─→ Show in GUI
        └─→ Save to File (optional)
```

## 数据格式

### 输入数据格式

**.res文件结构**:
```
...
param_id
  toe_angle_left = 1234
  toe_angle_right = 1235
  ...
end

quasiStatic
  0.0  value1 value2 ... value2751
  0.1  value1 value2 ... value2751
  ...
end
```

### 中间数据格式

**参数ID映射**:
```python
{
    'toe_angle_left': 1234,
    'toe_angle_right': 1235,
    ...
}
```

**数据矩阵**:
```python
np.ndarray, shape=(n_steps, 2751)
# 每行是一个时间步的数据
# 每列是一个参数的数值
```

### 输出数据格式

**计算结果**:
```python
{
    'stiffness': float,
    'compliance': float,
    'roll_rate': float,
    'fitted_data': np.ndarray,
    ...
}
```

## 数据验证点

1. **文件解析后**: 验证数据矩阵形状和参数ID完整性
2. **参数提取后**: 验证数据范围和有效性
3. **计算后**: 验证计算结果合理性
4. **绘图前**: 验证数据完整性
