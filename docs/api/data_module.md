# 数据处理模块 API 文档

## 概述

数据处理模块 (`src.data`) 提供 Adams .res 文件解析、数据提取、单位转换和 K&C 计算功能。

## 模块

### ResParser

**位置**: `src.data.res_parser`

**描述**: Adams .res 文件解析器，用于提取 K&C 参数 ID 和 quasiStatic 数据。

#### 类定义

```python
class ResParser:
    """Adams .res文件解析器
    
    功能：
    1. 提取K&C参数的ID号
    2. 解析quasiStatic数据段
    3. 构建数据矩阵（n行 x 2751列）
    """
```

#### 方法

##### `__init__(file_path: str)`

初始化解析器。

**参数**:
- `file_path` (str): .res 文件路径

**异常**:
- `FileError`: 文件不存在时抛出

**示例**:
```python
parser = ResParser("path/to/file.res")
```

##### `parse() -> Tuple[Dict[str, any], np.ndarray]`

解析 .res 文件。

**返回**:
- `Tuple[Dict[str, any], np.ndarray]`: (参数ID字典, quasiStatic数据矩阵)

**异常**:
- `ParseError`: 解析失败时抛出

**示例**:
```python
param_ids, data = parser.parse()
```

##### `get_param_id(param_name: str) -> Optional[int]`

获取参数ID。

**参数**:
- `param_name` (str): 参数名称（如 "toe_angle_left"）

**返回**:
- `Optional[int]`: 参数ID，如果不存在则返回 None

##### `get_data() -> Optional[np.ndarray]`

获取解析后的数据矩阵。

**返回**:
- `Optional[np.ndarray]`: 数据矩阵（n行 x 2751列），如果未解析则返回 None

---

### DataExtractor

**位置**: `src.data.data_extractor`

**描述**: 数据提取器，用于从解析后的数据中提取特定列。

#### 类定义

```python
class DataExtractor:
    """数据提取器
    
    从解析后的数据矩阵中提取特定参数的数据列。
    """
```

#### 方法

##### `__init__(data: np.ndarray, param_ids: Dict[str, any])`

初始化数据提取器。

**参数**:
- `data` (np.ndarray): 数据矩阵
- `param_ids` (Dict[str, any]): 参数ID字典

##### `extract_column(param_id: int) -> np.ndarray`

提取指定ID的数据列。

**参数**:
- `param_id` (int): 参数ID

**返回**:
- `np.ndarray`: 数据列数组

**异常**:
- `ValueError`: 参数ID无效时抛出

##### `extract_by_name(param_name: str) -> Optional[np.ndarray]`

根据参数名称提取数据。

**参数**:
- `param_name` (str): 参数名称

**返回**:
- `Optional[np.ndarray]`: 数据数组，如果参数不存在则返回 None

---

### KCCalculator

**位置**: `src.data.kc_calculator`

**描述**: K&C 计算器，提供各种测试工况的计算功能。

#### 类定义

```python
class KCCalculator:
    """K&C计算器
    
    提供各种K&C测试工况的计算功能。
    """
```

#### 方法

##### `__init__(data_extractor: DataExtractor, vehicle_params: Optional[Dict[str, float]] = None)`

初始化 K&C 计算器。

**参数**:
- `data_extractor` (DataExtractor): DataExtractor 实例
- `vehicle_params` (Optional[Dict[str, float]]): 车辆参数字典

##### `set_vehicle_params(vehicle_params: Dict[str, float])`

设置车辆参数。

**参数**:
- `vehicle_params` (Dict[str, float]): 车辆参数字典

##### `calculate_bump_steer() -> Dict[str, float]`

计算 Bump Steer。

**返回**:
- `Dict[str, float]`: 计算结果字典

##### `calculate_bump_camber() -> Dict[str, float]`

计算 Bump Camber。

**返回**:
- `Dict[str, float]`: 计算结果字典

##### `calculate_roll_steer() -> Dict[str, float]`

计算 Roll Steer。

**返回**:
- `Dict[str, float]`: 计算结果字典

##### `calculate_roll_camber() -> Dict[str, float]`

计算 Roll Camber。

**返回**:
- `Dict[str, float]`: 计算结果字典

##### `calculate_lateral_compliance() -> Dict[str, float]`

计算 Lateral Compliance。

**返回**:
- `Dict[str, float]`: 计算结果字典

##### `calculate_braking_compliance() -> Dict[str, float]`

计算 Braking Compliance。

**返回**:
- `Dict[str, float]`: 计算结果字典

##### `calculate_acceleration_compliance() -> Dict[str, float]`

计算 Acceleration Compliance。

**返回**:
- `Dict[str, float]`: 计算结果字典

---

### UnitConverter

**位置**: `src.data.unit_converter`

**描述**: 单位转换工具，提供角度、长度等单位的转换功能。

#### 函数

##### `convert_angle_rad_to_deg(angle_rad: Union[float, np.ndarray]) -> Union[float, np.ndarray]`

将角度从弧度转换为度。

**参数**:
- `angle_rad` (Union[float, np.ndarray]): 弧度值或数组

**返回**:
- `Union[float, np.ndarray]`: 度数值或数组

##### `convert_angle_deg_to_rad(angle_deg: Union[float, np.ndarray]) -> Union[float, np.ndarray]`

将角度从度转换为弧度。

**参数**:
- `angle_deg` (Union[float, np.ndarray]): 度数值或数组

**返回**:
- `Union[float, np.ndarray]`: 弧度值或数组

##### `convert_length_mm_to_m(length_mm: Union[float, np.ndarray]) -> Union[float, np.ndarray]`

将长度从毫米转换为米。

**参数**:
- `length_mm` (Union[float, np.ndarray]): 毫米值或数组

**返回**:
- `Union[float, np.ndarray]`: 米值或数组

##### `convert_length_m_to_mm(length_m: Union[float, np.ndarray]) -> Union[float, np.ndarray]`

将长度从米转换为毫米。

**参数**:
- `length_m` (Union[float, np.ndarray]): 米值或数组

**返回**:
- `Union[float, np.ndarray]`: 毫米值或数组

##### `convert_angle_array(data: np.ndarray, from_unit: str, to_unit: str) -> np.ndarray`

批量转换角度数组。

**参数**:
- `data` (np.ndarray): 数据数组
- `from_unit` (str): 源单位 ("rad" 或 "deg")
- `to_unit` (str): 目标单位 ("rad" 或 "deg")

**返回**:
- `np.ndarray`: 转换后的数组

##### `convert_length_array(data: np.ndarray, from_unit: str, to_unit: str) -> np.ndarray`

批量转换长度数组。

**参数**:
- `data` (np.ndarray): 数据数组
- `from_unit` (str): 源单位 ("mm" 或 "m")
- `to_unit` (str): 目标单位 ("mm" 或 "m")

**返回**:
- `np.ndarray`: 转换后的数组

---

## 使用示例

### 完整工作流程

```python
from src.data import ResParser, DataExtractor, KCCalculator

# 1. 解析文件
parser = ResParser("path/to/file.res")
param_ids, data = parser.parse()

# 2. 创建数据提取器
extractor = DataExtractor(data, param_ids)

# 3. 创建计算器
vehicle_params = {
    "half_load": 500.0,
    "max_load": 1000.0,
    "wheel_base": 2.7
}
calculator = KCCalculator(extractor, vehicle_params)

# 4. 执行计算
bump_steer = calculator.calculate_bump_steer()
print(f"Bump Steer: {bump_steer}")
```

---

## 异常

数据处理模块可能抛出以下异常：

- `FileError`: 文件操作错误
- `ParseError`: 解析错误
- `DataValidationError`: 数据验证错误
- `CalculationError`: 计算错误

所有异常都继承自 `src.utils.exceptions.KnCToolError`。
