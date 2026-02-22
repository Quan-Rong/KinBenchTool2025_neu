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
    
    # quasiStatic数据段标识
    QUASISTATIC_MARKER = '"quasiStatic"'
    
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
        """
        logger.debug("开始提取参数ID")
        
        # 参数定义：参数名 -> (查找关键词, 读取行数, 维度说明)
        param_definitions = {
            'toe_angle': ('toe_angle', 2, 'left/right'),
            'camber_angle': ('camber_angle', 2, 'left/right'),
            'caster_angle': ('caster_angle', 2, 'left/right'),
            'kingpin_incl_angle': ('kingpin_incl_angle', 2, 'left/right'),
            'caster_moment_arm': ('caster_moment_arm', 2, 'left/right'),
            'scrub_radius': ('scrub_radius', 2, 'left/right'),
            'left_tire_contact_point': ('left_tire_contact_point', 2, 'base/track'),
            'right_tire_contact_point': ('right_tire_contact_point', 2, 'base/track'),
            'wheel_travel_track': ('"wheel_travel_track"', 2, 'left/right'),
            'wheel_travel_base': ('wheel_travel_base', 2, 'left/right'),
            'total_track': ('total_track', 1, 'vehicle'),
            'roll_center_location': ('roll_center_location', 2, 'lateral/vertical'),
            'anti_dive': ('anti_dive', 2, 'left/right'),
            'anti_lift': ('anti_lift', 2, 'left/right'),
            'roll_steer': ('roll_Steer', 2, 'left/right'),
            'roll_camber_coefficient': ('roll_camber_coefficient', 2, 'left/right'),
            'susp_roll_rate': ('susp_roll_rate', 1, 'vehicle'),
            'total_roll_rate': ('total_roll_rate', 1, 'vehicle'),
            'wheel_rate': ('wheel_rate', 2, 'left/right'),
            'ride_rate': ('ride_rate', 2, 'left/right'),
            'left_tire_forces': ('left_tire_forces', 3, 'x/y/z'),
            'right_tire_forces': ('right_tire_forces', 3, 'x/y/z'),
            'wheel_travel': ('"wheel_travel"', 2, 'lateral/vertical'),
            'roll_angle': ('roll_angle', 2, 'WC/CP'),
            'wheel_load_lateral': ('wheel_load_lateral', 2, 'left/right'),
            'wheel_load_longitudinal': ('wheel_load_longitudinal', 4, 'brak_left/brak_right/driv_left/driv_right'),
            'wheel_load_align': ('wheel_load_align', 2, 'left/right'),
            'side_view_swing_arm_angle': ('side_view_swing_arm_angle', 2, 'left/right'),
            'side_view_swing_arm_length': ('side_view_swing_arm_length', 2, 'left/right'),
            'steering_displacements': ('steering_displacements', 1, 'vehicle'),
            'steering_wheel_input': ('steering_wheel_input', 1, 'vehicle'),
            'anti_squat_acceleration': ('anti_squat_acceleration', 2, 'left/right'),
            'percent_ackerman': ('percent_ackerman', 2, 'left/right'),
            'outside_turn_diameter': ('outside_turn_diameter', 2, 'left/right'),
            'wheel_load_vertical_force': ('wheel_load_vertical_force', 2, 'left/right'),
        }
        
        # 使用生成器逐行读取文件
        file_gen = read_file_generator(str(self.file_path))
        
        for line in file_gen:
            for param_name, (keyword, num_lines, _) in param_definitions.items():
                if keyword in line:
                    # 读取后续行获取ID
                    ids = []
                    try:
                        for _ in range(num_lines):
                            next_line = next(file_gen, None)
                            if next_line is None:
                                break
                            # 使用正则表达式提取ID
                            match = self.ID_PATTERN.search(next_line)
                            if match:
                                ids.append(int(match.group()))
                    except StopIteration:
                        break
                    
                    if len(ids) == num_lines:
                        if num_lines == 1:
                            self.param_ids[param_name] = ids[0]
                        else:
                            self.param_ids[param_name] = ids
                        logger.debug(f"提取参数 {param_name}: {self.param_ids[param_name]}")
        
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
            # 检查是否是quasiStatic标记（支持两种格式）
            if self.QUASISTATIC_MARKER in line or '<Step type="quasiStatic">' in line:
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
    
    def get_param_id(self, param_name: str) -> any:
        """获取参数ID
        
        Args:
            param_name: 参数名称
            
        Returns:
            参数ID（可能是单个值或列表）
        """
        if param_name not in self.param_ids:
            raise ValueError(f"参数 {param_name} 未找到")
        return self.param_ids[param_name]
    
    def get_data_column(self, param_id: Union[int, list]) -> np.ndarray:
        """根据参数ID获取数据列
        
        Args:
            param_id: 参数ID（单个值或列表）
            
        Returns:
            数据列（如果是列表则返回多列）
        """
        if self.quasi_static_data is None:
            raise ValueError("数据未解析，请先调用parse()方法")
        
        if isinstance(param_id, list):
            # 返回多列
            return self.quasi_static_data[:, param_id]
        else:
            # 返回单列
            return self.quasi_static_data[:, param_id]
