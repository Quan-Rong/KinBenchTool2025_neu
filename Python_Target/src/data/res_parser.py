"""Adams .res文件解析器

解析Adams仿真结果文件，提取K&C参数ID和quasiStatic数据。
"""

import re
from pathlib import Path
from typing import Dict, Optional, Tuple, Union

import numpy as np

from ..utils.file_utils import count_lines, read_file_generator
from ..utils.exceptions import FileError, ParseError
from ..utils.logger import get_logger

logger = get_logger(__name__)


class ResParser:
    """Adams .res文件解析器
    
    功能：
    1. 提取K&C参数的ID号
    2. 解析quasiStatic数据段
    3. 构建数据矩阵（n行 x 2751列）
    """
    
    # 正则表达式：匹配数字ID
    ID_PATTERN = re.compile(r'\d+')
    
    # quasiStatic数据段标识（支持多种格式）
    QUASISTATIC_MARKERS = ['"quasiStatic"', 'quasiStatic', '<Step type="quasiStatic">']
    
    def __init__(self, file_path: str):
        """初始化解析器
        
        Args:
            file_path: .res文件路径
        """
        self.file_path = Path(file_path)
        self.param_ids: Dict[str, any] = {}
        self.quasi_static_data: Optional[np.ndarray] = None
        self.total_rows: int = 0
        
        if not self.file_path.exists():
            raise FileError(f"文件不存在: {self.file_path}")
    
    def parse(self) -> Tuple[Dict[str, any], np.ndarray]:
        """解析.res文件
        
        Returns:
            (param_ids, quasi_static_data): 参数ID字典和数据矩阵
            
        Raises:
            ParseError: 解析失败
        """
        logger.info(f"开始解析文件: {self.file_path.name}")
        
        try:
            # 统计文件行数
            self.total_rows = count_lines(str(self.file_path))
            logger.debug(f"文件总行数: {self.total_rows}")
            
            # 提取参数ID
            self._extract_param_ids()
            
            # 解析quasiStatic数据
            self._parse_quasistatic_data()
            
            logger.info(f"解析完成: 提取了{len(self.param_ids)}个参数ID, "
                       f"数据矩阵形状: {self.quasi_static_data.shape}")
            
            return self.param_ids, self.quasi_static_data
            
        except Exception as e:
            logger.error(f"解析文件失败: {e}")
            raise ParseError(f"解析文件失败: {e}") from e
    
    def _extract_param_ids(self) -> None:
        """提取K&C参数的ID号
        
        根据参数名称查找对应的ID号，支持左右轮、多维度参数等。
        支持XML格式的res文件，从<Component>标签的id属性中提取ID。
        """
        logger.debug("开始提取参数ID")
        
        # 参数定义：参数名 -> (Entity名称, Component名称列表, 维度说明)
        # Component名称列表的顺序决定了ID的顺序
        param_definitions = {
            'toe_angle': ('toe_angle', ['left', 'right'], 'left/right'),
            'camber_angle': ('camber_angle', ['left', 'right'], 'left/right'),
            'caster_angle': ('caster_angle', ['left', 'right'], 'left/right'),
            'kingpin_incl_angle': ('kingpin_incl_angle', ['left', 'right'], 'left/right'),
            'caster_moment_arm': ('caster_moment_arm', ['left', 'right'], 'left/right'),
            'scrub_radius': ('scrub_radius', ['left', 'right'], 'left/right'),
            'left_tire_contact_point': ('left_tire_contact_point', ['base_change_left', 'track_change_left'], 'base/track'),
            'right_tire_contact_point': ('right_tire_contact_point', ['base_change_right', 'track_change_right'], 'base/track'),
            'wheel_travel_track': ('wheel_travel_track', ['track_left', 'track_right'], 'left/right'),
            'wheel_travel_base': ('wheel_travel_base', ['base_left', 'base_right'], 'left/right'),
            'total_track': ('total_track', ['track'], 'vehicle'),
            'roll_center_location': ('roll_center_location', ['lateral_from_half_track', 'vertical'], 'lateral/vertical'),
            'anti_dive': ('anti_dive_braking', ['left', 'right'], 'left/right'),
            'anti_lift': ('anti_lift_braking', ['left', 'right'], 'left/right'),
            'roll_steer': ('roll_steer', ['left', 'right'], 'left/right'),
            'roll_camber_coefficient': ('roll_camber_coefficient', ['left', 'right'], 'left/right'),
            'susp_roll_rate': ('susp_roll_rate', ['suspension_roll_rate'], 'vehicle'),
            'total_roll_rate': ('total_roll_rate', ['total_roll_rate'], 'vehicle'),
            'wheel_rate': ('wheel_rate', ['left', 'right'], 'left/right'),
            'ride_rate': ('ride_rate', ['left', 'right'], 'left/right'),
            'left_tire_forces': ('left_tire_forces', ['longitudinal', 'lateral', 'normal'], 'x/y/z'),
            'right_tire_forces': ('right_tire_forces', ['longitudinal', 'lateral', 'normal'], 'x/y/z'),
            'wheel_travel': ('wheel_travel', ['vertical_left', 'vertical_right'], 'lateral/vertical'),
            'roll_angle': ('roll_angle', ['at_wheel_centers', 'at_contact_patches'], 'WC/CP'),
            'wheel_load_lateral': ('wheel_load_lateral', ['lateral_left', 'lateral_right'], 'left/right'),
            'wheel_load_longitudinal': ('wheel_load_longitudinal', ['braking_left', 'braking_right', 'driving_left', 'driving_right'], 'brak_left/brak_right/driv_left/driv_right'),
            'wheel_load_align': ('wheel_load_align', ['algn_torque_left', 'algn_torque_right'], 'left/right'),
            'side_view_swing_arm_angle': ('side_view_swing_arm_angle', ['left', 'right'], 'left/right'),
            'side_view_swing_arm_length': ('side_view_swing_arm_length', ['left', 'right'], 'left/right'),
            'steering_displacements': ('steering_displacements', ['steering'], 'vehicle'),
            'steering_wheel_input': ('steering_wheel_input', ['steering'], 'vehicle'),
            'anti_squat_acceleration': ('anti_squat_acceleration', ['left', 'right'], 'left/right'),
            'percent_ackerman': ('percent_ackerman', ['left', 'right'], 'left/right'),
            'outside_turn_diameter': ('outside_turn_diameter', ['left', 'right'], 'left/right'),
            'wheel_load_vertical_force': ('wheel_load_vertical_force', ['vertical_left_force', 'vertical_right_force'], 'left/right'),
        }
        
        # 正则表达式：匹配<Component>标签中的id属性
        component_id_pattern = re.compile(r'<Component\s+[^>]*name="([^"]+)"[^>]*id="(\d+)"', re.IGNORECASE)
        entity_pattern = re.compile(r'<Entity\s+[^>]*name="([^"]+)"', re.IGNORECASE)
        
        # 使用生成器逐行读取文件
        file_gen = read_file_generator(str(self.file_path))
        current_entity = None
        entity_components = {}  # 字典：entity_name -> {comp_name: comp_id}
        entity_component_order = {}  # 字典：entity_name -> [comp_name, ...] 保持文件中的顺序
        
        for line in file_gen:
            # 检查是否是Entity开始标签
            entity_match = entity_pattern.search(line)
            if entity_match:
                entity_name = entity_match.group(1)
                current_entity = entity_name
                entity_components[entity_name] = {}
                entity_component_order[entity_name] = []  # 保持文件中的顺序
                continue
            
            # 检查是否是Entity结束标签
            if '</Entity>' in line:
                # 处理当前Entity的Component
                if current_entity:
                    for param_name, (target_entity, component_names, _) in param_definitions.items():
                        if target_entity == current_entity:
                            ids = []
                            # 关键修改：按照文件中的顺序匹配，而不是按照 component_names 的顺序
                            # MATLAB 代码是按照文件顺序读取的，所以我们也应该按照文件顺序匹配
                            for comp_name in entity_component_order[current_entity]:
                                # 如果这个 Component 在 component_names 中，就使用它
                                if comp_name in component_names:
                                    if comp_name in entity_components[current_entity]:
                                        ids.append(entity_components[current_entity][comp_name])
                            
                            # 如果按照文件顺序匹配到的数量不够，尝试按名称顺序匹配（向后兼容）
                            if len(ids) < len(component_names):
                                ids = []
                                for comp_name in component_names:
                                    if comp_name in entity_components[current_entity]:
                                        ids.append(entity_components[current_entity][comp_name])
                            
                            if len(ids) == len(component_names):
                                if len(ids) == 1:
                                    self.param_ids[param_name] = ids[0]
                                else:
                                    self.param_ids[param_name] = ids
                                logger.debug(f"提取参数 {param_name}: {self.param_ids[param_name]}")
                    current_entity = None
                continue
            
            # 检查是否是Component标签
            if current_entity and '<Component' in line:
                comp_match = component_id_pattern.search(line)
                if comp_match:
                    comp_name = comp_match.group(1)
                    comp_id = int(comp_match.group(2))
                    entity_components[current_entity][comp_name] = comp_id
                    # 保持文件中的顺序
                    entity_component_order[current_entity].append(comp_name)
        
        logger.info(f"提取了 {len(self.param_ids)} 个参数ID")
    
    def _parse_quasistatic_data(self) -> None:
        """解析quasiStatic数据段
        
        找到"quasiStatic"标记后，读取数字行构建数据矩阵。
        矩阵形状: (n_steps, 2751)，其中n_steps是分析步数。
        
        逻辑（参考MATLAB代码）：
        1. 找到包含"quasiStatic"的行（或<Step type="quasiStatic">）
        2. 读取后续行，如果行可以解析为数字，则添加到Test_Data
        3. 遇到非数字行时，将Test_Data的第一行作为一行数据添加到矩阵
        4. 每行数据应该是2751个数字（可能分布在多行中）
        """
        logger.debug("开始解析quasiStatic数据")
        
        data_rows = []
        file_gen = read_file_generator(str(self.file_path))
        warning_issued = False  # 标记是否已发出警告，避免重复输出
        
        for line in file_gen:
            # 检查是否是quasiStatic标记（支持多种格式）
            is_quasistatic = any(marker in line for marker in self.QUASISTATIC_MARKERS)
            if is_quasistatic:
                # 找到quasiStatic标记，开始读取数据
                test_data = []
                
                # 读取后续行直到遇到非数字行或</Step>
                for data_line in file_gen:
                    # 检查是否是Step结束标记
                    if '</Step>' in data_line or '<Step' in data_line:
                        break
                    
                    # 尝试解析为数字
                    stripped = data_line.strip()
                    if not stripped:
                        continue
                    
                    try:
                        # 尝试将整行解析为数字数组（MATLAB的str2num行为）
                        numbers = [float(x) for x in stripped.split()]
                        if numbers:
                            # 将数字添加到test_data（展平为一维数组）
                            test_data.extend(numbers)
                    except (ValueError, AttributeError):
                        # 如果解析失败，说明数据段结束
                        break
                
                # 将收集到的数据的第一行作为一行数据
                # MATLAB代码：quasiStatic_data(RowNo,:)=Test_Data(1,:)
                # 这意味着Test_Data是一个矩阵，我们取第一行
                if test_data:
                    # 如果test_data长度足够，取前2751个作为一行
                    # 注意：MATLAB代码中Test_Data可能是矩阵，这里我们假设是展平的数组
                    if len(test_data) >= 2751:
                        data_rows.append(test_data[:2751])
                    else:
                        # 如果不足2751，只在第一次出现时记录警告，避免重复输出
                        if not warning_issued:
                            logger.warning(
                                f"数据行长度不足2751，实际长度: {len(test_data)}。"
                                f"程序将用0填充到2751列。"
                                f"这可能是数据文件格式问题，建议检查数据文件完整性。"
                                f"后续相同情况将不再提示。"
                            )
                            warning_issued = True
                        # 仍然添加，但用0填充到2751
                        padded = test_data + [0.0] * (2751 - len(test_data))
                        data_rows.append(padded)
        
        if not data_rows:
            raise ParseError("未找到quasiStatic数据段")
        
        # 转换为numpy数组
        self.quasi_static_data = np.array(data_rows, dtype=np.float64)
        logger.info(f"解析quasiStatic数据完成: 形状 {self.quasi_static_data.shape}")
    
    def get_param_id(self, param_name: str, default: any = None) -> any:
        """获取参数ID
        
        Args:
            param_name: 参数名称
            default: 如果参数未找到，返回的默认值。如果为None且参数未找到，则抛出异常
            
        Returns:
            参数ID（可能是单个值或列表）
            
        Raises:
            ValueError: 如果参数未找到且default为None
        """
        if param_name not in self.param_ids:
            if default is not None:
                return default
            raise ValueError(f"参数 {param_name} 未找到")
        return self.param_ids[param_name]
    
    def get_data_column(self, param_id: Union[int, list]) -> np.ndarray:
        """根据参数ID获取数据列
        
        Args:
            param_id: 参数ID（单个值或列表，1-based）
            
        Returns:
            数据列（如果是列表则返回多列）
            
        注意：
            根据res文件的结构，同一Entity的所有Component数据在同一行，
            且该行的起始索引等于第一个Component的ID。
            ID是1-based的（从1开始），而NumPy数组索引是0-based的（从0开始），
            所以需要将ID减1才能正确访问数据。
            例如：ID 775对应列774（索引），ID 776对应列775（索引）。
            
            MATLAB代码：quasiStatic_data(:, ID) 其中ID是1-based索引
            Python代码：quasi[:, ID-1] 将1-based的ID转换为0-based的索引
        """
        if self.quasi_static_data is None:
            raise ValueError("数据未解析，请先调用parse()方法")
        
        if isinstance(param_id, list):
            # 返回多列
            # 将1-based的ID转换为0-based的索引
            indices = [pid - 1 for pid in param_id]
            return self.quasi_static_data[:, indices]
        else:
            # 返回单列
            # 将1-based的ID转换为0-based的索引
            return self.quasi_static_data[:, param_id - 1]
