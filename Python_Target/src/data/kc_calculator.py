"""K&C计算模块

提供各种K&C测试工况的计算函数，包括Bump、Roll、Static Load等。
"""

from typing import Dict, Tuple, Optional, List, Any
import numpy as np

from .data_extractor import DataExtractor
from .unit_converter import convert_angle_array, convert_length_array
from ..utils.math_utils import linear_fit, find_zero_crossing, find_value_index, calculate_slope
from ..utils.logger import get_logger

logger = get_logger(__name__)


def _find_fit_range_indices_by_value(force_arr: np.ndarray, fit_range: float) -> Tuple[int, int]:
    """按力值查找拟合区间索引，与MATLAB逻辑完全一致
    
    MATLAB: Row_No_p1=min(abs(force+fit_range)), Row_No_p2=min(abs(force-fit_range))
    fit_range: kN（如1.0表示±1kN）
    
    Returns:
        (fit_start, fit_end): 用于切片 force_arr[fit_start:fit_end]
    """
    idx_neg = find_value_index(force_arr, -fit_range)
    idx_pos = find_value_index(force_arr, fit_range)
    if idx_neg is None:
        idx_neg = 0
    if idx_pos is None:
        idx_pos = len(force_arr) - 1
    fit_start = min(idx_neg, idx_pos)
    fit_end = max(idx_neg, idx_pos) + 1
    return fit_start, fit_end
from ..utils.logger import get_logger

logger = get_logger(__name__)


class KCCalculator:
    """K&C计算器
    
    提供各种K&C测试工况的计算功能。
    """
    
    def __init__(self, data_extractor: DataExtractor, vehicle_params: Optional[Dict[str, float]] = None):
        """初始化K&C计算器
        
        Args:
            data_extractor: DataExtractor实例，用于提取数据
            vehicle_params: 车辆参数字典，包含half_load, max_load, wheel_base等
        """
        self.extractor = data_extractor
        self.vehicle_params = vehicle_params or {}
    
    def set_vehicle_params(self, vehicle_params: Dict[str, float]):
        """设置车辆参数
        
        Args:
            vehicle_params: 车辆参数字典
        """
        self.vehicle_params = vehicle_params
        logger.debug(f"车辆参数已更新: {vehicle_params}")
    
    def get_vehicle_param(self, key: str, default: float = 0.0) -> float:
        """获取车辆参数
        
        Args:
            key: 参数键名
            default: 默认值
            
        Returns:
            参数值
        """
        return self.vehicle_params.get(key, default)
    
    # ==================== 与 MATLAB 完全一致的数据构造助手 ====================

    def _build_parallel_travel_matrices(self) -> Dict[str, Any]:
        """构造与 MATLAB `KinBenchTool_Bump_Plot.m` 中
        `Susp_parallel_travel_data1` 和 `Susp_parallel_travel_plot_data1`
        完全一致的数据矩阵。

        - 列顺序严格按照 MATLAB 的 ID 列表
        - 单位转换（rad->deg、mm/deg 等）与 MATLAB 完全一致
        - Row_No / Row_No1 / Row_No2g 的计算公式与 MATLAB 完全一致

        Returns:
            {
                'data1': Susp_parallel_travel_data1 (np.ndarray),
                'plot_data1': Susp_parallel_travel_plot_data1 (np.ndarray),
                'Row_No': int,
                'Row_No1': int,
                'Row_No2g': int,
            }
        """
        # 通过 DataExtractor 访问底层 ResParser 和 quasiStatic_data
        parser = self.extractor.parser  # type: ignore[attr-defined]
        quasi = parser.quasi_static_data
        if quasi is None:
            raise ValueError("quasiStatic 数据不存在，请先解析 .res 文件")

        # ==== 1) 按 MATLAB 的 ID 顺序构造 Susp_parallel_travel_ID ====
        # 使用 try-except 处理缺失的参数，对于缺失的参数使用 None 作为标记
        def safe_get_param_id(param_name: str) -> Optional[Any]:
            """安全获取参数ID，如果不存在则返回 None 并记录警告"""
            try:
                return parser.get_param_id(param_name)
            except ValueError:
                logger.warning(f"参数 {param_name} 未找到，将使用全零占位符")
                return None
        
        toe_angle_ID = parser.get_param_id('toe_angle')
        camber_angle_ID = parser.get_param_id('camber_angle')
        caster_angle_ID = parser.get_param_id('caster_angle')
        kingpin_incl_angle_ID = parser.get_param_id('kingpin_incl_angle')
        caster_moment_arm_ID = parser.get_param_id('caster_moment_arm')
        scrub_radius_ID = parser.get_param_id('scrub_radius')
        left_tire_contact_point_ID = parser.get_param_id('left_tire_contact_point')
        wheel_travel_base_ID = parser.get_param_id('wheel_travel_base')
        wheel_travel_track_ID = parser.get_param_id('wheel_travel_track')
        total_track_ID = parser.get_param_id('total_track')
        roll_steer_ID = safe_get_param_id('roll_steer')  # 可能为 None
        roll_camber_coefficient_ID = parser.get_param_id('roll_camber_coefficient')
        roll_center_location_ID = parser.get_param_id('roll_center_location')
        anti_dive_ID = parser.get_param_id('anti_dive')
        anti_lift_ID = parser.get_param_id('anti_lift')
        susp_roll_rate_ID = parser.get_param_id('susp_roll_rate')
        total_roll_rate_ID = parser.get_param_id('total_roll_rate')
        wheel_rate_ID = parser.get_param_id('wheel_rate')
        ride_rate_ID = parser.get_param_id('ride_rate')
        left_tire_forces_ID = parser.get_param_id('left_tire_forces')
        wheel_travel_ID = parser.get_param_id('wheel_travel')
        wheel_load_vertical_force_ID = parser.get_param_id('wheel_load_vertical_force')
        side_view_swing_arm_angle_ID = parser.get_param_id('side_view_swing_arm_angle')
        side_view_swing_arm_length_ID = parser.get_param_id('side_view_swing_arm_length')
        right_tire_contact_point_ID = parser.get_param_id('right_tire_contact_point')

        # MATLAB: Susp_parallel_travel_ID = [...]
        # 构建 ID 列表，对于 None（缺失参数）使用全零列
        n_rows = quasi.shape[0]
        
        def get_id_value(param_id: Any, index: int = 0) -> Optional[int]:
            """获取参数ID值，如果是None则返回None（后续用全零列替换）"""
            if param_id is None:
                return None
            if isinstance(param_id, list):
                return param_id[index] if index < len(param_id) else param_id[0]
            return param_id
        
        susp_parallel_travel_ID: List[Optional[int]] = [
            toe_angle_ID[0],
            camber_angle_ID[0],
            caster_angle_ID[0],
            kingpin_incl_angle_ID[0],
            caster_moment_arm_ID[0],
            scrub_radius_ID[0],
            left_tire_contact_point_ID[0],
            left_tire_contact_point_ID[1],
            wheel_travel_base_ID[0],
            wheel_travel_track_ID[0],
            total_track_ID,
            get_id_value(roll_steer_ID, 0),  # 可能为 None
            roll_camber_coefficient_ID[0],
            roll_center_location_ID[1],  # vertical
            anti_dive_ID[0],
            anti_lift_ID[0],
            susp_roll_rate_ID,
            total_roll_rate_ID,
            wheel_rate_ID[0],
            ride_rate_ID[0],
            left_tire_forces_ID[2],      # z 分量
            wheel_travel_ID[0],
        ]

        # 构建矩阵，对于 None 占位符使用全零列
        data1_cols = []
        param_names = ['toe', 'camber', 'caster', 'kingpin', 'caster_moment_arm', 'scrub_radius',
                      'left_tire_contact_X', 'left_tire_contact_Y', 'wheel_travel_base',
                      'wheel_travel_track', 'total_track', 'roll_steer', 'roll_camber_coefficient',
                      'roll_center_vertical', 'anti_dive', 'anti_lift', 'susp_roll_rate',
                      'total_roll_rate', 'wheel_rate', 'ride_rate', 'left_tire_forces_Z', 'wheel_travel']
        for col_idx, (param_id, param_name) in enumerate(zip(susp_parallel_travel_ID, param_names)):
            if param_id is None:
                # 使用全零列作为占位符
                data1_cols.append(np.zeros(n_rows))
                logger.debug(f"列 {col_idx} ({param_name}) 使用全零占位符")
            else:
                # 将1-based的ID转换为0-based的索引
                data1_cols.append(quasi[:, param_id - 1])
        data1 = np.column_stack(data1_cols)

        # MATLAB: Susp_parallel_travel_data1(:,1:4) = ... *180/pi
        data1[:, 0:4] = convert_angle_array(data1[:, 0:4], from_unit='rad', to_unit='deg')

        # MATLAB: data1(:,end-5:end-4) = data1(:,end-5:end-4) * pi/180/1000
        # end-5: susp_roll_rate, end-4: total_roll_rate
        idx_susp_roll = data1.shape[1] - 5
        idx_total_roll = data1.shape[1] - 4
        data1[:, [idx_susp_roll, idx_total_roll]] = (
            data1[:, [idx_susp_roll, idx_total_roll]] * (np.pi / 180.0 / 1000.0)
        )

        # ==== 2) 构造 Susp_parallel_travel_plot_data1 ====
        # MATLAB: Susp_parallel_travel_plot_ID = [...]
        susp_parallel_travel_plot_ID: List[int] = [
            toe_angle_ID[0],
            toe_angle_ID[1],
            left_tire_contact_point_ID[1],
            right_tire_contact_point_ID[1],
            wheel_travel_base_ID[0],
            wheel_travel_base_ID[1],
            wheel_travel_track_ID[0],
            wheel_travel_track_ID[1],
            anti_dive_ID[0],
            anti_dive_ID[1],
            anti_lift_ID[0],
            anti_lift_ID[1],
            wheel_rate_ID[0],
            wheel_rate_ID[1],
            camber_angle_ID[0],
            camber_angle_ID[1],
            wheel_travel_ID[0],
            wheel_travel_ID[1],
            wheel_load_vertical_force_ID[0],
            wheel_load_vertical_force_ID[1],
            side_view_swing_arm_angle_ID[0],
            side_view_swing_arm_angle_ID[1],
            side_view_swing_arm_length_ID[0],
            side_view_swing_arm_length_ID[1],
            caster_angle_ID[0],
            caster_angle_ID[1],
        ]

        # 将1-based的ID转换为0-based的索引
        plot_indices = [pid - 1 for pid in susp_parallel_travel_plot_ID]
        plot_data1 = quasi[:, plot_indices].copy()

        # MATLAB: toe/camber/svsa/caster 列从弧度转为角度
        plot_data1[:, 0:2] = convert_angle_array(plot_data1[:, 0:2], from_unit='rad', to_unit='deg')
        plot_data1[:, 14:16] = convert_angle_array(plot_data1[:, 14:16], from_unit='rad', to_unit='deg')
        plot_data1[:, 20:22] = convert_angle_array(plot_data1[:, 20:22], from_unit='rad', to_unit='deg')
        plot_data1[:, 24:26] = convert_angle_array(plot_data1[:, 24:26], from_unit='rad', to_unit='deg')

        # ==== 3) 按 MATLAB 公式计算 Row_No / Row_No1 / Row_No2g ====
        # data1 最后一列：wheel_travel_ID(1)
        wheel_travel_col = data1[:, -1]

        # Row_No: 使轮跳绝对值最小的行 -> 整备 0 位置
        Row_No = int(np.argmin(np.abs(wheel_travel_col)))

        # Row_No1 / Row_No2g: 使用 data1(:, end-1) (left_tire_forces_Z) 与 Wheel_Load 对齐
        left_wheel_force_z = data1[:, -2]

        max_load = self.get_vehicle_param('max_load', 0.0)
        Wheel_Load = max_load * 9.8 / 2.0  # 与 MATLAB 完全一致

        Row_No1 = int(np.argmin(np.abs(left_wheel_force_z - Wheel_Load)))
        Row_No2g = int(np.argmin(np.abs(left_wheel_force_z - Wheel_Load * 2.0)))

        return {
            'data1': data1,
            'plot_data1': plot_data1,
            'Row_No': Row_No,
            'Row_No1': Row_No1,
            'Row_No2g': Row_No2g,
        }
    
    def _build_opposite_travel_matrices(self) -> Dict[str, Any]:
        """构造与 MATLAB `KinBenchTool_Roll_Plot.m` 中
        `Susp_opposite_travel_data1` 和 `Susp_oppo_travel_plot_data1`
        完全一致的数据矩阵。

        - 列顺序严格按照 MATLAB 的 ID 列表
        - 单位转换（rad->deg、mm/deg 等）与 MATLAB 完全一致
        - Row_No 的计算公式与 MATLAB 完全一致

        Returns:
            {
                'data1': Susp_opposite_travel_data1 (np.ndarray),
                'plot_data1': Susp_oppo_travel_plot_data1 (np.ndarray),
                'Row_No': int,
            }
        """
        # 通过 DataExtractor 访问底层 ResParser 和 quasiStatic_data
        parser = self.extractor.parser  # type: ignore[attr-defined]
        quasi = parser.quasi_static_data
        if quasi is None:
            raise ValueError("quasiStatic 数据不存在，请先解析 .res 文件")

        # ==== 1) 按 MATLAB 的 ID 顺序构造 Susp_opposite_travel_ID ====
        # 使用 try-except 处理缺失的参数，对于缺失的参数使用 None 作为标记
        def safe_get_param_id(param_name: str) -> Optional[Any]:
            """安全获取参数ID，如果不存在则返回 None 并记录警告"""
            try:
                return parser.get_param_id(param_name)
            except ValueError:
                logger.warning(f"参数 {param_name} 未找到，将使用全零占位符")
                return None
        
        toe_angle_ID = parser.get_param_id('toe_angle')
        camber_angle_ID = parser.get_param_id('camber_angle')
        roll_steer_ID = safe_get_param_id('roll_steer')  # 可能为 None
        roll_camber_coefficient_ID = parser.get_param_id('roll_camber_coefficient')
        susp_roll_rate_ID = parser.get_param_id('susp_roll_rate')
        total_roll_rate_ID = parser.get_param_id('total_roll_rate')
        roll_center_location_ID = parser.get_param_id('roll_center_location')
        wheel_travel_base_ID = parser.get_param_id('wheel_travel_base')
        wheel_travel_track_ID = parser.get_param_id('wheel_travel_track')
        left_tire_contact_point_ID = parser.get_param_id('left_tire_contact_point')
        right_tire_contact_point_ID = parser.get_param_id('right_tire_contact_point')
        roll_angle_ID = parser.get_param_id('roll_angle')
        wheel_travel_ID = parser.get_param_id('wheel_travel')
        left_tire_forces_ID = parser.get_param_id('left_tire_forces')
        right_tire_forces_ID = parser.get_param_id('right_tire_forces')

        # MATLAB: Susp_opposite_travel_ID = [toe_angle_ID, camber_angle_ID, roll_steer_ID, ...]
        # 构建 ID 列表，对于 None（缺失参数）使用全零列
        n_rows = quasi.shape[0]
        
        def get_id_value(param_id: Any, index: int = 0) -> Optional[int]:
            """获取参数ID值，如果是None则返回None（后续用全零列替换）"""
            if param_id is None:
                return None
            if isinstance(param_id, list):
                return param_id[index] if index < len(param_id) else param_id[0]
            return param_id
        
        # MATLAB: Susp_opposite_travel_ID = [toe_angle_ID, camber_angle_ID, roll_steer_ID, 
        #         roll_camber_coefficient_ID, susp_roll_rate_ID, total_roll_rate_ID, 
        #         roll_center_location_ID(2), wheel_travel_base_ID, wheel_travel_track_ID,
        #         left_tire_contact_point_ID(1), right_tire_contact_point_ID(1),
        #         left_tire_contact_point_ID(2), right_tire_contact_point_ID(2), roll_angle_ID]
        susp_opposite_travel_ID: List[Optional[int]] = [
            toe_angle_ID[0],
            toe_angle_ID[1],
            camber_angle_ID[0],
            camber_angle_ID[1],
            get_id_value(roll_steer_ID, 0),  # 可能为 None
            get_id_value(roll_steer_ID, 1) if roll_steer_ID is not None and isinstance(roll_steer_ID, list) and len(roll_steer_ID) > 1 else None,
            roll_camber_coefficient_ID[0],
            roll_camber_coefficient_ID[1],
            susp_roll_rate_ID,
            total_roll_rate_ID,
            roll_center_location_ID[1],  # vertical
            wheel_travel_base_ID[0],
            wheel_travel_base_ID[1],
            wheel_travel_track_ID[0],
            wheel_travel_track_ID[1],
            left_tire_contact_point_ID[0],
            right_tire_contact_point_ID[0],
            left_tire_contact_point_ID[1],
            right_tire_contact_point_ID[1],
            roll_angle_ID[0],
            roll_angle_ID[1],
        ]

        # 构建矩阵，对于 None 占位符使用全零列
        data1_cols = []
        param_names = ['toe_left', 'toe_right', 'camber_left', 'camber_right', 
                      'roll_steer_left', 'roll_steer_right', 'roll_camber_coeff_left', 'roll_camber_coeff_right',
                      'susp_roll_rate', 'total_roll_rate', 'roll_center_vertical',
                      'wheel_travel_base_left', 'wheel_travel_base_right',
                      'wheel_travel_track_left', 'wheel_travel_track_right',
                      'left_tire_contact_X', 'right_tire_contact_X',
                      'left_tire_contact_Y', 'right_tire_contact_Y',
                      'roll_angle_WC', 'roll_angle_CP']
        for col_idx, (param_id, param_name) in enumerate(zip(susp_opposite_travel_ID, param_names)):
            if param_id is None:
                # 使用全零列作为占位符
                data1_cols.append(np.zeros(n_rows))
                logger.debug(f"列 {col_idx} ({param_name}) 使用全零占位符")
            else:
                # 将1-based的ID转换为0-based的索引
                data1_cols.append(quasi[:, param_id - 1])
        data1 = np.column_stack(data1_cols)

        # MATLAB: Susp_opposite_travel_data1(:,1:4) = ... *180/pi
        # 列1-4: toe_left, toe_right, camber_left, camber_right
        data1[:, 0:4] = convert_angle_array(data1[:, 0:4], from_unit='rad', to_unit='deg')

        # MATLAB: data1(:,9:10) = data1(:,9:10) * pi/180/1000
        # 列9-10: susp_roll_rate, total_roll_rate
        data1[:, 8:10] = data1[:, 8:10] * (np.pi / 180.0 / 1000.0)

        # MATLAB: data1(:,end-1:end) = data1(:,end-1:end) * 180/pi
        # 最后两列: roll_angle_WC, roll_angle_CP
        data1[:, -2:] = convert_angle_array(data1[:, -2:], from_unit='rad', to_unit='deg')

        # ==== 2) 构造 Susp_oppo_travel_plot_data1 ====
        # MATLAB: Susp_oppo_travel_plot_ID = [toe_angle_ID(1), toe_angle_ID(2), ...]
        susp_oppo_travel_plot_ID: List[int] = [
            toe_angle_ID[0],
            toe_angle_ID[1],
            camber_angle_ID[0],
            camber_angle_ID[1],
            wheel_travel_ID[0],
            wheel_travel_ID[1],
            left_tire_forces_ID[2],      # z 分量
            right_tire_forces_ID[2],     # z 分量
            roll_center_location_ID[1],  # vertical
            susp_roll_rate_ID,
            total_roll_rate_ID,
            roll_angle_ID[0],            # @WC
            roll_angle_ID[1],            # @CP
        ]

        # 将1-based的ID转换为0-based的索引
        plot_indices = [pid - 1 for pid in susp_oppo_travel_plot_ID]
        plot_data1 = quasi[:, plot_indices].copy()

        # MATLAB: plot_data1(:,1:4) = ... *180/pi
        plot_data1[:, 0:4] = convert_angle_array(plot_data1[:, 0:4], from_unit='rad', to_unit='deg')

        # MATLAB: plot_data1(:,10:11) = ... * pi/180/1000
        plot_data1[:, 9:11] = plot_data1[:, 9:11] * (np.pi / 180.0 / 1000.0)

        # MATLAB: plot_data1(:,12:13) = ... * 180/pi
        plot_data1[:, 11:13] = convert_angle_array(plot_data1[:, 11:13], from_unit='rad', to_unit='deg')

        # MATLAB: 计算新的两列 camber relative ground
        # new_col1 = camber_left + roll_angle_CP
        # new_col2 = camber_right - roll_angle_CP
        new_col1 = plot_data1[:, 2] + plot_data1[:, 12]  # camber_left + roll_angle_CP
        new_col2 = plot_data1[:, 3] - plot_data1[:, 12]  # camber_right - roll_angle_CP

        # MATLAB: 计算左右tire force的和
        new_col3 = plot_data1[:, 6] + plot_data1[:, 7]  # left_tire_force_Z + right_tire_force_Z

        # 将新的列添加到矩阵的末尾
        plot_data1 = np.column_stack([plot_data1, new_col1, new_col2, new_col3])

        # ==== 3) 按 MATLAB 公式计算 Row_No ====
        # MATLAB: [Row_Data, Row_No] = min(abs(Susp_opposite_travel_data1(:,end)))
        # 使用最后一列（roll_angle_CP）查找零位置
        roll_angle_cp_col = data1[:, -1]
        Row_No = int(np.argmin(np.abs(roll_angle_cp_col)))

        return {
            'data1': data1,
            'plot_data1': plot_data1,
            'Row_No': Row_No,
        }
    
    # ==================== Bump测试计算 ====================
    
    def calculate_bump_steer(self, 
                             fit_range: int = 15,
                             zero_position_idx: Optional[int] = None) -> Dict[str, float]:
        """计算Bump Steer（轮跳转向）
        
        Args:
            fit_range: 拟合区间范围（mm），默认15mm
            zero_position_idx: 零位置索引，如果为None则自动查找
            
        Returns:
            包含左右轮Bump Steer斜率的字典
            {
                'left_slope': 左轮斜率 (deg/m),
                'right_slope': 右轮斜率 (deg/m),
                'average_slope': 平均斜率 (deg/m),
                'left_coeffs': [a, b] 左轮拟合系数,
                'right_coeffs': [a, b] 右轮拟合系数
            }
        """
        logger.debug("计算Bump Steer（按 MATLAB 逻辑）")

        mats = self._build_parallel_travel_matrices()
        plot_data1 = mats['plot_data1']
        Row_No = mats['Row_No']

        # MATLAB: 以 Row_No 为中心，左右各 fit_range 个步长
        zero_idx = Row_No if zero_position_idx is None else zero_position_idx
        fit_start = max(0, zero_idx - fit_range)
        fit_end = min(plot_data1.shape[0], zero_idx + fit_range + 1)

        # X 轴：列 17/18（@WC vertical travel [mm]）
        wheel_travel_left_mm = plot_data1[:, 16]
        wheel_travel_right_mm = plot_data1[:, 17]

        # Y 轴：toe 左右（列 1/2，已是 deg）
        toe_angle_left = plot_data1[:, 0]
        toe_angle_right = plot_data1[:, 1]
        
        # 左轮拟合
        x_left = wheel_travel_left_mm[fit_start:fit_end]
        y_left = toe_angle_left[fit_start:fit_end]
        coeffs_left, _ = linear_fit(x_left, y_left, degree=1)
        
        # 右轮拟合
        x_right = wheel_travel_right_mm[fit_start:fit_end]
        y_right = toe_angle_right[fit_start:fit_end]
        coeffs_right, _ = linear_fit(x_right, y_right, degree=1)
        
        # 计算斜率（deg/m = deg/mm * 1000）
        slope_left = coeffs_left[0] * 1000  # deg/m
        slope_right = coeffs_right[0] * 1000  # deg/m
        slope_avg = (slope_left + slope_right) / 2
        
        logger.debug(f"Bump Steer: 左={slope_left:.2f}, 右={slope_right:.2f}, 平均={slope_avg:.2f} deg/m")
        
        return {
            'left_slope': slope_left,
            'right_slope': slope_right,
            'average_slope': slope_avg,
            'left_coeffs': coeffs_left.tolist(),
            'right_coeffs': coeffs_right.tolist(),
            'zero_position_idx': zero_idx,
            'fit_range': fit_range
        }
    
    def calculate_bump_camber(self,
                             fit_range: int = 15,
                             zero_position_idx: Optional[int] = None) -> Dict[str, float]:
        """计算Bump Camber（轮跳外倾）
        
        Args:
            fit_range: 拟合区间范围（mm），默认15mm
            zero_position_idx: 零位置索引
            
        Returns:
            包含左右轮Bump Camber斜率的字典
        """
        logger.debug("计算Bump Camber（按 MATLAB 逻辑）")

        mats = self._build_parallel_travel_matrices()
        plot_data1 = mats['plot_data1']
        Row_No = mats['Row_No']

        zero_idx = Row_No if zero_position_idx is None else zero_position_idx
        fit_start = max(0, zero_idx - fit_range)
        fit_end = min(plot_data1.shape[0], zero_idx + fit_range + 1)

        # X 轴：列 17/18（@WC vertical travel [mm]）
        wheel_travel_left_mm = plot_data1[:, 16]
        wheel_travel_right_mm = plot_data1[:, 17]

        # Y 轴：camber 左右（列 15/16，已是 deg）
        camber_left = plot_data1[:, 14]
        camber_right = plot_data1[:, 15]
        
        # 左轮拟合
        x_left = wheel_travel_left_mm[fit_start:fit_end]
        y_left = camber_left[fit_start:fit_end]
        coeffs_left, _ = linear_fit(x_left, y_left, degree=1)
        
        # 右轮拟合
        x_right = wheel_travel_right_mm[fit_start:fit_end]
        y_right = camber_right[fit_start:fit_end]
        coeffs_right, _ = linear_fit(x_right, y_right, degree=1)
        
        # 计算斜率（deg/m）
        slope_left = coeffs_left[0] * 1000
        slope_right = coeffs_right[0] * 1000
        slope_avg = (slope_left + slope_right) / 2
        
        logger.debug(f"Bump Camber: 左={slope_left:.2f}, 右={slope_right:.2f}, 平均={slope_avg:.2f} deg/m")
        
        return {
            'left_slope': slope_left,
            'right_slope': slope_right,
            'average_slope': slope_avg,
            'left_coeffs': coeffs_left.tolist(),
            'right_coeffs': coeffs_right.tolist(),
            'zero_position_idx': zero_idx,
            'fit_range': fit_range
        }
    
    def calculate_wheel_rate(self,
                            fit_range: int = 15,
                            zero_position_idx: Optional[int] = None) -> Dict[str, float]:
        """计算Wheel Rate（车轮刚度）
        
        Args:
            fit_range: 拟合区间范围（mm），默认15mm
            zero_position_idx: 零位置索引
            
        Returns:
            包含左右轮Wheel Rate的字典
        """
        logger.debug("计算Wheel Rate（按 MATLAB 逻辑）")

        mats = self._build_parallel_travel_matrices()
        plot_data1 = mats['plot_data1']
        Row_No = mats['Row_No']

        zero_idx = Row_No if zero_position_idx is None else zero_position_idx
        fit_start = max(0, zero_idx - fit_range)
        fit_end = min(plot_data1.shape[0], zero_idx + fit_range + 1)

        # X 轴：列 17/18（@WC vertical travel [mm]）
        wheel_travel_left_mm = plot_data1[:, 16]
        wheel_travel_right_mm = plot_data1[:, 17]

        # Y 轴：wheel_rate 左右（列 13/14，单位 N/mm）
        wheel_rate_left = plot_data1[:, 12]
        wheel_rate_right = plot_data1[:, 13]

        # 左轮拟合
        x_left = wheel_travel_left_mm[fit_start:fit_end]
        y_left = wheel_rate_left[fit_start:fit_end]
        coeffs_left, _ = linear_fit(x_left, y_left, degree=1)

        # 右轮拟合
        x_right = wheel_travel_right_mm[fit_start:fit_end]
        y_right = wheel_rate_right[fit_start:fit_end]
        coeffs_right, _ = linear_fit(x_right, y_right, degree=1)

        # Wheel Rate斜率（N/mm/mm）
        slope_left = coeffs_left[0]
        slope_right = coeffs_right[0]
        slope_avg = (slope_left + slope_right) / 2.0

        # 零位置的Wheel Rate值（N/mm）
        rate_left = wheel_rate_left[zero_idx]
        rate_right = wheel_rate_right[zero_idx]
        rate_avg = (rate_left + rate_right) / 2.0

        logger.debug(f"Wheel Rate: 左斜率={slope_left:.2f}, 右斜率={slope_right:.2f}, 平均斜率={slope_avg:.2f} N/mm/mm")
        logger.debug(f"Wheel Rate@WC: 左={rate_left:.2f}, 右={rate_right:.2f}, 平均={rate_avg:.2f} N/mm")

        return {
            'left_slope': slope_left,
            'right_slope': slope_right,
            'average_slope': slope_avg,
            'left_rate_at_zero': rate_left,
            'right_rate_at_zero': rate_right,
            'average_rate_at_zero': rate_avg,
            'left_coeffs': coeffs_left.tolist(),
            'right_coeffs': coeffs_right.tolist(),
            'zero_position_idx': zero_idx,
            'fit_range': fit_range
        }
    
    def calculate_wheel_recession(self,
                                  fit_range: int = 15,
                                  zero_position_idx: Optional[int] = None) -> Dict[str, float]:
        """计算Wheel Recession（轮心后移）
        
        Args:
            fit_range: 拟合区间范围（mm），默认15mm
            zero_position_idx: 零位置索引
            
        Returns:
            包含左右轮Wheel Recession斜率的字典
        """
        logger.debug("计算Wheel Recession（按 MATLAB 逻辑）")

        mats = self._build_parallel_travel_matrices()
        plot_data1 = mats['plot_data1']
        Row_No = mats['Row_No']

        zero_idx = Row_No if zero_position_idx is None else zero_position_idx
        fit_start = max(0, zero_idx - fit_range)
        fit_end = min(plot_data1.shape[0], zero_idx + fit_range + 1)

        # X 轴：列 17/18（@WC vertical travel [mm]）
        wheel_travel_left_mm = plot_data1[:, 16]
        wheel_travel_right_mm = plot_data1[:, 17]

        # Y 轴：wheel recession（wheel_travel_base，列 5/6，mm）
        wheel_travel_base_left_mm = plot_data1[:, 4]
        wheel_travel_base_right_mm = plot_data1[:, 5]

        # 左轮拟合
        x_left = wheel_travel_left_mm[fit_start:fit_end]
        y_left = wheel_travel_base_left_mm[fit_start:fit_end]
        coeffs_left, _ = linear_fit(x_left, y_left, degree=1)

        # 右轮拟合
        x_right = wheel_travel_right_mm[fit_start:fit_end]
        y_right = wheel_travel_base_right_mm[fit_start:fit_end]
        coeffs_right, _ = linear_fit(x_right, y_right, degree=1)

        # 斜率单位：mm/mm（和 MATLAB polyfit 一致），换算成 mm/m 时乘以 1000
        slope_left = coeffs_left[0] * 1000.0
        slope_right = coeffs_right[0] * 1000.0
        slope_avg = (slope_left + slope_right) / 2.0

        logger.debug(f"Wheel Recession: 左={slope_left:.2f}, 右={slope_right:.2f}, 平均={slope_avg:.2f} mm/m")

        return {
            'left_slope': slope_left,
            'right_slope': slope_right,
            'average_slope': slope_avg,
            'left_coeffs': coeffs_left.tolist(),
            'right_coeffs': coeffs_right.tolist(),
            'zero_position_idx': zero_idx,
            'fit_range': fit_range
        }
    
    def calculate_track_change(self,
                               fit_range: int = 15,
                               zero_position_idx: Optional[int] = None) -> Dict[str, float]:
        """计算Track Change（轮距变化）
        
        Args:
            fit_range: 拟合区间范围（mm），默认15mm
            zero_position_idx: 零位置索引
            
        Returns:
            包含左右轮Track Change斜率的字典
        """
        logger.debug("计算Track Change（按 MATLAB 逻辑）")

        mats = self._build_parallel_travel_matrices()
        plot_data1 = mats['plot_data1']
        Row_No = mats['Row_No']

        zero_idx = Row_No if zero_position_idx is None else zero_position_idx
        fit_start = max(0, zero_idx - fit_range)
        fit_end = min(plot_data1.shape[0], zero_idx + fit_range + 1)

        # X 轴：列 17/18（@WC vertical travel [mm]）
        wheel_travel_left_mm = plot_data1[:, 16]
        wheel_travel_right_mm = plot_data1[:, 17]

        # Y 轴：wheel centre Y disp.（列 7/8，mm）
        wheel_centre_y_left_mm = plot_data1[:, 6]
        wheel_centre_y_right_mm = plot_data1[:, 7]

        # 左轮拟合
        x_left = wheel_travel_left_mm[fit_start:fit_end]
        y_left = wheel_centre_y_left_mm[fit_start:fit_end]
        coeffs_left, _ = linear_fit(x_left, y_left, degree=1)

        # 右轮拟合
        x_right = wheel_travel_right_mm[fit_start:fit_end]
        y_right = wheel_centre_y_right_mm[fit_start:fit_end]
        coeffs_right, _ = linear_fit(x_right, y_right, degree=1)

        # MATLAB: app.TrackChangeEditField.Value
        # = (P_Left(1,1)*-1000 + P_Right(1,1)*1000)/2
        slope_left = -coeffs_left[0] * 1000.0
        slope_right = coeffs_right[0] * 1000.0
        slope_avg = (slope_left + slope_right) / 2.0

        logger.debug(f"Track Change: 左={slope_left:.2f}, 右={slope_right:.2f}, 平均={slope_avg:.2f} mm/m")

        return {
            'left_slope': slope_left,
            'right_slope': slope_right,
            'average_slope': slope_avg,
            'left_coeffs': coeffs_left.tolist(),
            'right_coeffs': coeffs_right.tolist(),
            'zero_position_idx': zero_idx,
            'fit_range': fit_range
        }
    
    def calculate_toe_at_50mm(self,
                              bump_50mm_idx: Optional[int] = None,
                              rebound_50mm_idx: Optional[int] = None) -> Dict[str, float]:
        """计算50mm轮跳时的toe角
        
        Args:
            bump_50mm_idx: bump 50mm位置的索引
            rebound_50mm_idx: rebound 50mm位置的索引
            
        Returns:
            包含50mm轮跳时toe角的字典
        """
        logger.debug("计算50mm轮跳时的toe角（按 MATLAB 逻辑）")

        mats = self._build_parallel_travel_matrices()
        plot_data1 = mats['plot_data1']

        # MATLAB 固定使用第 76 行 / 第 26 行（假定 101 个步长、±100mm）
        # 这里直接使用固定行号，与 MATLAB 一致；由上层决定是否采用这些行。
        toe_left = plot_data1[:, 0]
        toe_right = plot_data1[:, 1]

        result: Dict[str, float] = {}

        if bump_50mm_idx is not None and 0 <= bump_50mm_idx < len(toe_left):
            result['bump_50mm_left'] = float(toe_left[bump_50mm_idx])
            result['bump_50mm_right'] = float(toe_right[bump_50mm_idx])

        if rebound_50mm_idx is not None and 0 <= rebound_50mm_idx < len(toe_left):
            result['rebound_50mm_left'] = float(toe_left[rebound_50mm_idx])
            result['rebound_50mm_right'] = float(toe_right[rebound_50mm_idx])

        return result
    
    def calculate_2g_wheel_travel_and_rate(self,
                                           target_load: float = 2.0,
                                           max_load: Optional[float] = None) -> Dict[str, float]:
        """计算2g载荷时的轮跳行程和车轮刚度
        
        根据Matlab代码：Row_No2g=min(abs(Susp_parallel_travel_data1(:,end-1)-Wheel_Load*2))
        使用max_load*2作为目标载荷
        
        Args:
            target_load: 目标载荷倍数（g），默认2.0
            max_load: 满载质量（kg），如果为None则从vehicle_params获取
            
        Returns:
            包含2g载荷时轮跳行程和车轮刚度的字典
        """
        logger.debug(f"计算{target_load}g载荷时的轮跳行程和车轮刚度（按 MATLAB 逻辑）")

        mats = self._build_parallel_travel_matrices()
        data1 = mats['data1']
        Row_No2g = mats['Row_No2g']

        # data1 末列：wheel_travel（mm），倒数第 3 列：wheel_rate（N/mm）
        wheel_travel_mm = data1[:, -1]
        wheel_rate = data1[:, -3]

        travel_2g = float(wheel_travel_mm[Row_No2g])
        rate_2g = float(wheel_rate[Row_No2g])

        logger.debug(f"{target_load}g载荷: 轮跳行程={travel_2g:.2f}mm, 车轮刚度={rate_2g:.2f}N/mm")

        return {
            'wheel_travel_2g': travel_2g,
            'wheel_rate_2g': rate_2g,
            'target_load': target_load,
            'index': Row_No2g
        }
    
    def calculate_bump_caster(self,
                             fit_range: int = 15,
                             zero_position_idx: Optional[int] = None) -> Dict[str, float]:
        """计算Bump Caster（轮跳主销后倾）
        
        Args:
            fit_range: 拟合区间范围（mm），默认15mm
            zero_position_idx: 零位置索引
            
        Returns:
            包含左右轮Caster Angle的字典
        """
        logger.debug("计算Bump Caster（按 MATLAB 逻辑）")

        mats = self._build_parallel_travel_matrices()
        plot_data1 = mats['plot_data1']
        Row_No = mats['Row_No']

        zero_idx = Row_No if zero_position_idx is None else zero_position_idx
        fit_start = max(0, zero_idx - fit_range)
        fit_end = min(plot_data1.shape[0], zero_idx + fit_range + 1)

        # X 轴：列 17/18（@WC vertical travel [mm]）
        wheel_travel_left_mm = plot_data1[:, 16]
        wheel_travel_right_mm = plot_data1[:, 17]

        # Y 轴：caster 左右（列 25/26，deg）
        caster_left = plot_data1[:, 24]
        caster_right = plot_data1[:, 25]

        x_left = wheel_travel_left_mm[fit_start:fit_end]
        y_left = caster_left[fit_start:fit_end]
        coeffs_left, _ = linear_fit(x_left, y_left, degree=1)

        x_right = wheel_travel_right_mm[fit_start:fit_end]
        y_right = caster_right[fit_start:fit_end]
        coeffs_right, _ = linear_fit(x_right, y_right, degree=1)

        caster_at_zero_left = coeffs_left[1]
        caster_at_zero_right = coeffs_right[1]
        caster_at_zero_avg = (caster_at_zero_left + caster_at_zero_right) / 2.0

        logger.debug(f"Bump Caster@WC: 左={caster_at_zero_left:.2f}, 右={caster_at_zero_right:.2f}, 平均={caster_at_zero_avg:.2f} deg")

        return {
            'left_at_zero': caster_at_zero_left,
            'right_at_zero': caster_at_zero_right,
            'average_at_zero': caster_at_zero_avg,
            'left_coeffs': coeffs_left.tolist(),
            'right_coeffs': coeffs_right.tolist(),
            'zero_position_idx': zero_idx,
            'fit_range': fit_range
        }
    
    def calculate_bump_side_swing_arm_angle(self,
                                           fit_range: int = 15,
                                           zero_position_idx: Optional[int] = None) -> Dict[str, float]:
        """计算Bump Side Swing Arm Angle（轮跳侧视摆臂角）
        
        Args:
            fit_range: 拟合区间范围（mm），默认15mm
            zero_position_idx: 零位置索引
            
        Returns:
            包含左右轮Side Swing Arm Angle的字典
        """
        logger.debug("计算Bump Side Swing Arm Angle（按 MATLAB 逻辑）")

        mats = self._build_parallel_travel_matrices()
        plot_data1 = mats['plot_data1']
        Row_No = mats['Row_No']

        zero_idx = Row_No if zero_position_idx is None else zero_position_idx
        fit_start = max(0, zero_idx - fit_range)
        fit_end = min(plot_data1.shape[0], zero_idx + fit_range + 1)

        # X 轴：列 17/18（@WC vertical travel [mm]）
        wheel_travel_left_mm = plot_data1[:, 16]
        wheel_travel_right_mm = plot_data1[:, 17]

        # Y 轴：side swing arm angle 左右（列 21/22，deg）
        swa_angle_left = plot_data1[:, 20]
        swa_angle_right = plot_data1[:, 21]

        x_left = wheel_travel_left_mm[fit_start:fit_end]
        y_left = swa_angle_left[fit_start:fit_end]
        coeffs_left, _ = linear_fit(x_left, y_left, degree=1)

        x_right = wheel_travel_right_mm[fit_start:fit_end]
        y_right = swa_angle_right[fit_start:fit_end]
        coeffs_right, _ = linear_fit(x_right, y_right, degree=1)

        swa_at_zero_left = coeffs_left[1]
        swa_at_zero_right = coeffs_right[1]
        swa_at_zero_avg = (swa_at_zero_left + swa_at_zero_right) / 2.0

        logger.debug(f"Bump Side Swing Arm Angle@WC: 左={swa_at_zero_left:.3f}, 右={swa_at_zero_right:.3f}, 平均={swa_at_zero_avg:.3f} deg")

        return {
            'left_at_zero': swa_at_zero_left,
            'right_at_zero': swa_at_zero_right,
            'average_at_zero': swa_at_zero_avg,
            'left_coeffs': coeffs_left.tolist(),
            'right_coeffs': coeffs_right.tolist(),
            'zero_position_idx': zero_idx,
            'fit_range': fit_range
        }
    
    def calculate_bump_side_swing_arm_length(self,
                                           fit_range: int = 15,
                                           zero_position_idx: Optional[int] = None) -> Dict[str, float]:
        """计算Bump Side Swing Arm Length（轮跳侧视摆臂长度）
        
        Args:
            fit_range: 拟合区间范围（mm），默认15mm
            zero_position_idx: 零位置索引
            
        Returns:
            包含左右轮Side Swing Arm Length的字典
        """
        logger.debug("计算Bump Side Swing Arm Length（按 MATLAB 逻辑）")

        mats = self._build_parallel_travel_matrices()
        plot_data1 = mats['plot_data1']
        Row_No = mats['Row_No']

        zero_idx = Row_No if zero_position_idx is None else zero_position_idx
        fit_start = max(0, zero_idx - fit_range)
        fit_end = min(plot_data1.shape[0], zero_idx + fit_range + 1)

        # X 轴：列 17/18（@WC vertical travel [mm]）
        wheel_travel_left_mm = plot_data1[:, 16]
        wheel_travel_right_mm = plot_data1[:, 17]

        # Y 轴：side swing arm length 左右（列 23/24，mm）
        swa_length_left_mm = plot_data1[:, 22]
        swa_length_right_mm = plot_data1[:, 23]

        x_left = wheel_travel_left_mm[fit_start:fit_end]
        y_left = swa_length_left_mm[fit_start:fit_end]
        coeffs_left, _ = linear_fit(x_left, y_left, degree=1)

        x_right = wheel_travel_right_mm[fit_start:fit_end]
        y_right = swa_length_right_mm[fit_start:fit_end]
        coeffs_right, _ = linear_fit(x_right, y_right, degree=1)

        swa_length_at_zero_left = coeffs_left[1]
        swa_length_at_zero_right = coeffs_right[1]
        swa_length_at_zero_avg = (swa_length_at_zero_left + swa_length_at_zero_right) / 2.0

        logger.debug(f"Bump Side Swing Arm Length@WC: 左={swa_length_at_zero_left:.3f}, 右={swa_length_at_zero_right:.3f}, 平均={swa_length_at_zero_avg:.3f} mm")

        return {
            'left_at_zero': swa_length_at_zero_left,
            'right_at_zero': swa_length_at_zero_right,
            'average_at_zero': swa_length_at_zero_avg,
            'left_coeffs': coeffs_left.tolist(),
            'right_coeffs': coeffs_right.tolist(),
            'zero_position_idx': zero_idx,
            'fit_range': fit_range
        }
    
    def calculate_bump_wheel_load(self,
                                 fit_range: int = 15,
                                 zero_position_idx: Optional[int] = None) -> Dict[str, float]:
        """计算Bump Wheel Load（轮跳载荷）
        
        Args:
            fit_range: 拟合区间范围（mm），默认15mm
            zero_position_idx: 零位置索引
            
        Returns:
            包含左右轮Wheel Rate（载荷斜率）的字典
        """
        logger.debug("计算Bump Wheel Load（按 MATLAB 逻辑）")

        mats = self._build_parallel_travel_matrices()
        plot_data1 = mats['plot_data1']
        Row_No = mats['Row_No']

        zero_idx = Row_No if zero_position_idx is None else zero_position_idx
        fit_start = max(0, zero_idx - fit_range)
        fit_end = min(plot_data1.shape[0], zero_idx + fit_range + 1)

        # X 轴：列 17/18（@WC vertical travel [mm]）
        wheel_travel_left_mm = plot_data1[:, 16]
        wheel_travel_right_mm = plot_data1[:, 17]

        # Y 轴：wheel load 左右（列 19/20，N）
        wheel_load_left = plot_data1[:, 18]
        wheel_load_right = plot_data1[:, 19]

        x_left = wheel_travel_left_mm[fit_start:fit_end]
        y_left = wheel_load_left[fit_start:fit_end]
        coeffs_left, _ = linear_fit(x_left, y_left, degree=1)

        x_right = wheel_travel_right_mm[fit_start:fit_end]
        y_right = wheel_load_right[fit_start:fit_end]
        coeffs_right, _ = linear_fit(x_right, y_right, degree=1)

        # 载荷对轮跳斜率 N/mm
        rate_left = coeffs_left[0]
        rate_right = coeffs_right[0]
        rate_avg = (rate_left + rate_right) / 2.0

        logger.debug(f"Bump Wheel Rate: 左={rate_left:.2f}, 右={rate_right:.2f}, 平均={rate_avg:.2f} N/mm")

        return {
            'left_rate': rate_left,
            'right_rate': rate_right,
            'average_rate': rate_avg,
            'left_coeffs': coeffs_left.tolist(),
            'right_coeffs': coeffs_right.tolist(),
            'zero_position_idx': zero_idx,
            'fit_range': fit_range
        }
    
    # ==================== Roll测试计算 ====================
    
    def calculate_roll_steer(self,
                             fit_range: float = 1.0,
                             zero_position_idx: Optional[int] = None) -> Dict[str, float]:
        """计算Roll Steer（侧倾转向）
        
        严格按照MATLAB `KinBenchTool_Roll_Plot.m` 的逻辑：
        - 使用 Susp_oppo_travel_plot_data1 矩阵
        - X轴：列12（roll_angle @WC）
        - Y轴：列1（toe_left）、列2（toe_right）
        - 拟合区间：Row_No ± 10*fit_range
        
        Args:
            fit_range: 拟合区间范围（度），默认1.0度
            zero_position_idx: 零位置索引
            
        Returns:
            包含左右轮Roll Steer系数的字典
        """
        logger.debug("计算Roll Steer（按 MATLAB 逻辑）")
        
        mats = self._build_opposite_travel_matrices()
        plot_data1 = mats['plot_data1']
        Row_No = mats['Row_No']
        
        # MATLAB: 使用 Row_No ± 10*fit_range 作为拟合区间
        zero_idx = Row_No if zero_position_idx is None else zero_position_idx
        fit_range_idx = int(10 * fit_range)  # MATLAB: 10*app.EditField_R_roll_range.Value
        fit_start = max(0, zero_idx - fit_range_idx)
        fit_end = min(plot_data1.shape[0], zero_idx + fit_range_idx + 1)
        
        # MATLAB: X轴是列12（roll_angle @WC），Y轴是列1（toe_left）和列2（toe_right）
        roll_angle_wc = plot_data1[:, 11]  # 列12（索引11）：roll_angle @WC
        toe_left = plot_data1[:, 0]        # 列1：toe_left
        toe_right = plot_data1[:, 1]       # 列2：toe_right
        
        # MATLAB: polyfit(Susp_oppo_travel_plot_data1(Row_No-10*range:Row_No+10*range,12), 
        #                  Susp_oppo_travel_plot_data1(Row_No-10*range:Row_No+10*range,1), 1)
        x_left = roll_angle_wc[fit_start:fit_end]
        y_left = toe_left[fit_start:fit_end]
        coeffs_left, _ = linear_fit(x_left, y_left, degree=1)
        
        x_right = roll_angle_wc[fit_start:fit_end]
        y_right = toe_right[fit_start:fit_end]
        coeffs_right, _ = linear_fit(x_right, y_right, degree=1)
        
        # MATLAB: app.RollSteerEditField.Value = (round(P_left(1,1),3) + round(P_right(1,1),3)*-1)/2
        slope_left = coeffs_left[0]
        slope_right = -coeffs_right[0]  # 右轮取负
        slope_avg = (slope_left + slope_right) / 2
        
        logger.debug(f"Roll Steer: 左={slope_left:.3f}, 右={slope_right:.3f}, 平均={slope_avg:.3f} deg/deg")
        
        return {
            'left_slope': slope_left,
            'right_slope': slope_right,
            'average_slope': slope_avg,
            'left_coeffs': coeffs_left.tolist(),
            'right_coeffs': coeffs_right.tolist(),
            'zero_position_idx': zero_idx,
            'fit_range': fit_range
        }
    
    def calculate_roll_camber(self,
                             fit_range: float = 1.0,
                             zero_position_idx: Optional[int] = None) -> Dict[str, float]:
        """计算Roll Camber（侧倾外倾）
        
        严格按照MATLAB `KinBenchTool_Roll_Plot.m` 的逻辑：
        - 使用 Susp_oppo_travel_plot_data1 矩阵
        - X轴：列12（roll_angle @WC）
        - Y轴：列3（camber_left）、列4（camber_right）
        - 拟合区间：Row_No ± 10*fit_range
        
        Args:
            fit_range: 拟合区间范围（度），默认1.0度
            zero_position_idx: 零位置索引
            
        Returns:
            包含左右轮Roll Camber系数的字典
        """
        logger.debug("计算Roll Camber（按 MATLAB 逻辑）")
        
        mats = self._build_opposite_travel_matrices()
        plot_data1 = mats['plot_data1']
        Row_No = mats['Row_No']
        
        # MATLAB: 使用 Row_No ± 10*fit_range 作为拟合区间
        zero_idx = Row_No if zero_position_idx is None else zero_position_idx
        fit_range_idx = int(10 * fit_range)
        fit_start = max(0, zero_idx - fit_range_idx)
        fit_end = min(plot_data1.shape[0], zero_idx + fit_range_idx + 1)
        
        # MATLAB: X轴是列12（roll_angle @WC），Y轴是列3（camber_left）和列4（camber_right）
        roll_angle_wc = plot_data1[:, 11]  # 列12（索引11）：roll_angle @WC
        camber_left = plot_data1[:, 2]     # 列3：camber_left
        camber_right = plot_data1[:, 3]    # 列4：camber_right
        
        # MATLAB: polyfit(Susp_oppo_travel_plot_data1(Row_No-10*range:Row_No+10*range,12), 
        #                  Susp_oppo_travel_plot_data1(Row_No-10*range:Row_No+10*range,3), 1)
        x_left = roll_angle_wc[fit_start:fit_end]
        y_left = camber_left[fit_start:fit_end]
        coeffs_left, _ = linear_fit(x_left, y_left, degree=1)
        
        x_right = roll_angle_wc[fit_start:fit_end]
        y_right = camber_right[fit_start:fit_end]
        coeffs_right, _ = linear_fit(x_right, y_right, degree=1)
        
        # MATLAB: app.RollCamberEditField.Value = (round(P_left(1,1),3) + round(P_right(1,1),3)*-1)/2
        slope_left = coeffs_left[0]
        slope_right = -coeffs_right[0]  # 右轮取负
        slope_avg = (slope_left + slope_right) / 2
        
        logger.debug(f"Roll Camber: 左={slope_left:.3f}, 右={slope_right:.3f}, 平均={slope_avg:.3f} deg/deg")
        
        return {
            'left_slope': slope_left,
            'right_slope': slope_right,
            'average_slope': slope_avg,
            'left_coeffs': coeffs_left.tolist(),
            'right_coeffs': coeffs_right.tolist(),
            'zero_position_idx': zero_idx,
            'fit_range': fit_range
        }
    
    def calculate_roll_camber_relative_ground(self,
                                             fit_range: float = 1.0,
                                             zero_position_idx: Optional[int] = None) -> Dict[str, float]:
        """计算Roll Camber Relative Ground（相对地面外倾）
        
        严格按照MATLAB `KinBenchTool_Roll_Plot.m` 的逻辑：
        - 使用 Susp_oppo_travel_plot_data1 矩阵
        - X轴：列12（roll_angle @WC）
        - Y轴：列14（camber_relative_ground_left）、列15（camber_relative_ground_right）
        - 这些列已经在 _build_opposite_travel_matrices 中计算好
        - 拟合区间：Row_No ± 10*fit_range
        
        Args:
            fit_range: 拟合区间范围（度），默认1.0度
            zero_position_idx: 零位置索引
            
        Returns:
            包含左右轮Roll Camber Relative Ground系数的字典
        """
        logger.debug("计算Roll Camber Relative Ground（按 MATLAB 逻辑）")
        
        mats = self._build_opposite_travel_matrices()
        plot_data1 = mats['plot_data1']
        Row_No = mats['Row_No']
        
        # MATLAB: 使用 Row_No ± 10*fit_range 作为拟合区间
        zero_idx = Row_No if zero_position_idx is None else zero_position_idx
        fit_range_idx = int(10 * fit_range)
        fit_start = max(0, zero_idx - fit_range_idx)
        fit_end = min(plot_data1.shape[0], zero_idx + fit_range_idx + 1)
        
        # MATLAB: X轴是列12（roll_angle @WC），Y轴是列14和15（camber_relative_ground）
        # 列14 = camber_left + roll_angle_CP，列15 = camber_right - roll_angle_CP
        roll_angle_wc = plot_data1[:, 11]  # 列12（索引11）：roll_angle @WC
        camber_ground_left = plot_data1[:, 13]   # 列14：camber_relative_ground_left
        camber_ground_right = plot_data1[:, 14]  # 列15：camber_relative_ground_right
        
        # 左轮拟合
        x_left = roll_angle_wc[fit_start:fit_end]
        y_left = camber_ground_left[fit_start:fit_end]
        coeffs_left, _ = linear_fit(x_left, y_left, degree=1)
        
        # 右轮拟合
        x_right = roll_angle_wc[fit_start:fit_end]
        y_right = camber_ground_right[fit_start:fit_end]
        coeffs_right, _ = linear_fit(x_right, y_right, degree=1)
        
        # Roll Camber Relative Ground系数（deg/deg）
        slope_left = coeffs_left[0]
        slope_right = -coeffs_right[0]  # 右轮取负
        slope_avg = (slope_left + slope_right) / 2
        
        logger.debug(f"Roll Camber Relative Ground: 左={slope_left:.3f}, 右={slope_right:.3f}, 平均={slope_avg:.3f} deg/deg")
        
        return {
            'left_slope': slope_left,
            'right_slope': slope_right,
            'average_slope': slope_avg,
            'left_coeffs': coeffs_left.tolist(),
            'right_coeffs': coeffs_right.tolist(),
            'zero_position_idx': zero_idx,
            'fit_range': fit_range
        }
    
    def calculate_roll_rate(self) -> Dict[str, float]:
        """计算Roll Rate（侧倾刚度）
        
        严格按照MATLAB `KinBenchTool_Roll_Plot.m` 的逻辑：
        - 使用 Susp_opposite_travel_data1 矩阵
        - 列9：susp_roll_rate，列10：total_roll_rate
        - 取 Row_No 位置的值
        
        Returns:
            包含悬架侧倾刚度和总侧倾刚度的字典
        """
        logger.debug("计算Roll Rate（按 MATLAB 逻辑）")
        
        mats = self._build_opposite_travel_matrices()
        data1 = mats['data1']
        Row_No = mats['Row_No']
        
        # MATLAB: 列9和10是 susp_roll_rate 和 total_roll_rate（已转换单位）
        susp_rate = float(data1[Row_No, 8])   # 列9（索引8）：susp_roll_rate
        total_rate = float(data1[Row_No, 9]) # 列10（索引9）：total_roll_rate
        
        logger.debug(f"Roll Rate: 悬架={susp_rate:.2f}, 总={total_rate:.2f} Nm/deg")
        
        return {
            'susp_roll_rate': susp_rate,
            'total_roll_rate': total_rate,
            'zero_position_idx': Row_No
        }
    
    def calculate_roll_center_height(self) -> Dict[str, float]:
        """计算Roll Center Height（侧倾中心高度）
        
        严格按照MATLAB `KinBenchTool_Roll_Plot.m` 的逻辑：
        - 使用 Susp_opposite_travel_data1 矩阵
        - 列11：roll_center_location vertical（已转换单位）
        - 取 Row_No 位置的值
        
        Returns:
            包含侧倾中心高度的字典
        """
        logger.debug("计算Roll Center Height（按 MATLAB 逻辑）")
        
        mats = self._build_opposite_travel_matrices()
        data1 = mats['data1']
        Row_No = mats['Row_No']
        
        # MATLAB: 列11是 roll_center_location vertical（单位：mm）
        height = float(data1[Row_No, 10])  # 列11（索引10）：roll_center_height
        
        logger.debug(f"Roll Center Height: {height:.2f} mm")
        
        return {
            'roll_center_height': height,
            'zero_position_idx': Row_No
        }
    
    # ==================== Static Load Lateral计算 ====================
    
    def calculate_lateral_toe_compliance(self,
                                        fit_range: float = 1.0) -> Dict[str, float]:
        """计算Lateral Toe Compliance（侧向力前束柔度）
        
        Args:
            fit_range: 拟合区间范围（kN），默认1.0kN
            
        Returns:
            包含左右轮Lateral Toe Compliance的字典
        """
        logger.debug("计算Lateral Toe Compliance")
        
        # 提取数据
        lateral_force_left = self.extractor.extract_by_name('wheel_load_lateral')
        lateral_force_right = self.extractor.extract_by_name('wheel_load_lateral')
        toe_left = self.extractor.extract_by_name('toe_angle', convert_angle=True)
        toe_right = self.extractor.extract_by_name('toe_angle', convert_angle=True)
        
        # 处理多维数据
        if lateral_force_left.ndim > 1:
            lateral_force_left = lateral_force_left[:, 0]
        if lateral_force_right.ndim > 1:
            lateral_force_right = lateral_force_right[:, 1] if lateral_force_right.shape[1] > 1 else lateral_force_right[:, 0]
        
        if toe_left.ndim > 1:
            toe_left = toe_left[:, 0]
        if toe_right.ndim > 1:
            toe_right = toe_right[:, 1] if toe_right.shape[1] > 1 else toe_right[:, 0]
        
        # 转换单位：N -> kN
        lateral_force_left_kn = lateral_force_left / 1000
        lateral_force_right_kn = lateral_force_right / 1000
        
        # 查找零位置（与MATLAB一致：min(abs(force))）
        zero_idx = find_zero_crossing(lateral_force_left_kn, lateral_force_left_kn)
        if zero_idx is None:
            zero_idx = len(lateral_force_left_kn) // 2
        
        # 确定拟合区间（与MATLAB一致：按力值查找，非按索引）
        fit_start, fit_end = _find_fit_range_indices_by_value(lateral_force_left_kn, fit_range)
        fit_start = max(0, fit_start)
        fit_end = min(len(lateral_force_left_kn), fit_end)
        fit_start_r, fit_end_r = _find_fit_range_indices_by_value(lateral_force_right_kn, fit_range)
        fit_start_r = max(0, fit_start_r)
        fit_end_r = min(len(lateral_force_right_kn), fit_end_r)
        
        # 左轮拟合（polyfit与MATLAB完全一致）
        x_left = lateral_force_left_kn[fit_start:fit_end]
        y_left = toe_left[fit_start:fit_end]
        coeffs_left, _ = linear_fit(x_left, y_left, degree=1)
        
        # 右轮拟合
        x_right = lateral_force_right_kn[fit_start_r:fit_end_r]
        y_right = toe_right[fit_start_r:fit_end_r]
        coeffs_right, _ = linear_fit(x_right, y_right, degree=1)
        
        # Lateral Toe Compliance（deg/kN）
        slope_left = coeffs_left[0]
        slope_right = coeffs_right[0]
        slope_avg = (slope_left + slope_right) / 2
        
        logger.debug(f"Lateral Toe Compliance: 左={slope_left:.3f}, 右={slope_right:.3f}, 平均={slope_avg:.3f} deg/kN")
        
        return {
            'left_slope': slope_left,
            'right_slope': slope_right,
            'average_slope': slope_avg,
            'left_coeffs': coeffs_left.tolist(),
            'right_coeffs': coeffs_right.tolist(),
            'zero_position_idx': zero_idx,
            'fit_range': fit_range,
            'fit_start_left': fit_start,
            'fit_end_left': fit_end,
            'fit_start_right': fit_start_r,
            'fit_end_right': fit_end_r
        }
    
    def calculate_lateral_camber_compliance(self,
                                            fit_range: float = 1.0) -> Dict[str, float]:
        """计算Lateral Camber Compliance（侧向力外倾柔度）
        
        Args:
            fit_range: 拟合区间范围（kN），默认1.0kN
            
        Returns:
            包含左右轮Lateral Camber Compliance的字典
        """
        logger.debug("计算Lateral Camber Compliance")
        
        # 提取数据
        lateral_force_left = self.extractor.extract_by_name('wheel_load_lateral')
        lateral_force_right = self.extractor.extract_by_name('wheel_load_lateral')
        camber_left = self.extractor.extract_by_name('camber_angle', convert_angle=True)
        camber_right = self.extractor.extract_by_name('camber_angle', convert_angle=True)
        
        # 处理多维数据
        if lateral_force_left.ndim > 1:
            lateral_force_left = lateral_force_left[:, 0]
        if lateral_force_right.ndim > 1:
            lateral_force_right = lateral_force_right[:, 1] if lateral_force_right.shape[1] > 1 else lateral_force_right[:, 0]
        
        if camber_left.ndim > 1:
            camber_left = camber_left[:, 0]
        if camber_right.ndim > 1:
            camber_right = camber_right[:, 1] if camber_right.shape[1] > 1 else camber_right[:, 0]
        
        # 转换单位：N -> kN
        lateral_force_left_kn = lateral_force_left / 1000
        lateral_force_right_kn = lateral_force_right / 1000
        
        # 查找零位置（与MATLAB一致）
        zero_idx = find_zero_crossing(lateral_force_left_kn, lateral_force_left_kn)
        if zero_idx is None:
            zero_idx = len(lateral_force_left_kn) // 2
        
        # 确定拟合区间（与MATLAB一致：按力值查找）
        fit_start, fit_end = _find_fit_range_indices_by_value(lateral_force_left_kn, fit_range)
        fit_start = max(0, fit_start)
        fit_end = min(len(lateral_force_left_kn), fit_end)
        fit_start_r, fit_end_r = _find_fit_range_indices_by_value(lateral_force_right_kn, fit_range)
        fit_start_r = max(0, fit_start_r)
        fit_end_r = min(len(lateral_force_right_kn), fit_end_r)
        
        # 左轮拟合（polyfit与MATLAB完全一致）
        x_left = lateral_force_left_kn[fit_start:fit_end]
        y_left = camber_left[fit_start:fit_end]
        coeffs_left, _ = linear_fit(x_left, y_left, degree=1)
        
        # 右轮拟合
        x_right = lateral_force_right_kn[fit_start_r:fit_end_r]
        y_right = camber_right[fit_start_r:fit_end_r]
        coeffs_right, _ = linear_fit(x_right, y_right, degree=1)
        
        # Lateral Camber Compliance（deg/kN）
        slope_left = coeffs_left[0]
        slope_right = coeffs_right[0]
        slope_avg = (slope_left + slope_right) / 2
        
        logger.debug(f"Lateral Camber Compliance: 左={slope_left:.3f}, 右={slope_right:.3f}, 平均={slope_avg:.3f} deg/kN")
        
        return {
            'left_slope': slope_left,
            'right_slope': slope_right,
            'average_slope': slope_avg,
            'left_coeffs': coeffs_left.tolist(),
            'right_coeffs': coeffs_right.tolist(),
            'zero_position_idx': zero_idx,
            'fit_range': fit_range,
            'fit_start_left': fit_start,
            'fit_end_left': fit_end,
            'fit_start_right': fit_start_r,
            'fit_end_right': fit_end_r
        }
    
    # ==================== Static Load Braking计算 ====================
    
    def calculate_braking_toe_compliance(self,
                                         fit_range: float = 1.0) -> Dict[str, float]:
        """计算Braking Toe Compliance（制动力前束柔度）
        
        Args:
            fit_range: 拟合区间范围（kN），默认1.0kN
            
        Returns:
            包含左右轮Braking Toe Compliance的字典
        """
        logger.debug("计算Braking Toe Compliance")
        
        # 提取数据（制动力通常是braking_left和braking_right）
        braking_force = self.extractor.extract_by_name('wheel_load_longitudinal')
        toe_left = self.extractor.extract_by_name('toe_angle', convert_angle=True)
        toe_right = self.extractor.extract_by_name('toe_angle', convert_angle=True)
        
        # 处理多维数据（braking通常是4列：brak_left, brak_right, driv_left, driv_right）
        if braking_force.ndim > 1:
            braking_force_left = braking_force[:, 0]  # brak_left
            braking_force_right = braking_force[:, 1]  # brak_right
        else:
            braking_force_left = braking_force
            braking_force_right = braking_force
        
        if toe_left.ndim > 1:
            toe_left = toe_left[:, 0]
        if toe_right.ndim > 1:
            toe_right = toe_right[:, 1] if toe_right.shape[1] > 1 else toe_right[:, 0]
        
        # 转换单位：N -> kN
        braking_force_left_kn = braking_force_left / 1000
        braking_force_right_kn = braking_force_right / 1000
        
        # 查找零位置（与MATLAB一致）
        zero_idx = find_zero_crossing(braking_force_left_kn, braking_force_left_kn)
        if zero_idx is None:
            zero_idx = len(braking_force_left_kn) // 2
        
        # 确定拟合区间（与MATLAB一致：按力值查找）
        fit_start, fit_end = _find_fit_range_indices_by_value(braking_force_left_kn, fit_range)
        fit_start = max(0, fit_start)
        fit_end = min(len(braking_force_left_kn), fit_end)
        fit_start_r, fit_end_r = _find_fit_range_indices_by_value(braking_force_right_kn, fit_range)
        fit_start_r = max(0, fit_start_r)
        fit_end_r = min(len(braking_force_right_kn), fit_end_r)
        
        # 左轮拟合（polyfit与MATLAB完全一致）
        x_left = braking_force_left_kn[fit_start:fit_end]
        y_left = toe_left[fit_start:fit_end]
        coeffs_left, _ = linear_fit(x_left, y_left, degree=1)
        
        # 右轮拟合
        x_right = braking_force_right_kn[fit_start_r:fit_end_r]
        y_right = toe_right[fit_start_r:fit_end_r]
        coeffs_right, _ = linear_fit(x_right, y_right, degree=1)
        
        # Braking Toe Compliance（deg/kN）
        slope_left = coeffs_left[0]
        slope_right = coeffs_right[0]
        slope_avg = (slope_left + slope_right) / 2
        
        logger.debug(f"Braking Toe Compliance: 左={slope_left:.3f}, 右={slope_right:.3f}, 平均={slope_avg:.3f} deg/kN")
        
        return {
            'left_slope': slope_left,
            'right_slope': slope_right,
            'average_slope': slope_avg,
            'left_coeffs': coeffs_left.tolist(),
            'right_coeffs': coeffs_right.tolist(),
            'zero_position_idx': zero_idx,
            'fit_range': fit_range,
            'fit_start_left': fit_start,
            'fit_end_left': fit_end,
            'fit_start_right': fit_start_r,
            'fit_end_right': fit_end_r
        }
    
    def calculate_anti_dive(self) -> Dict[str, float]:
        """计算Anti-dive（抗点头率）
        
        Returns:
            包含左右轮Anti-dive的字典
        """
        logger.debug("计算Anti-dive")
        
        # 提取数据
        anti_dive = self.extractor.extract_by_name('anti_dive')
        
        # 处理多维数据
        if anti_dive.ndim > 1:
            anti_dive_left = anti_dive[:, 0]
            anti_dive_right = anti_dive[:, 1] if anti_dive.shape[1] > 1 else anti_dive[:, 0]
        else:
            anti_dive_left = anti_dive
            anti_dive_right = anti_dive
        
        # 取零位置的值
        zero_idx = len(anti_dive_left) // 2
        anti_dive_left_val = anti_dive_left[zero_idx]
        anti_dive_right_val = anti_dive_right[zero_idx]
        anti_dive_avg = (anti_dive_left_val + anti_dive_right_val) / 2
        
        logger.debug(f"Anti-dive: 左={anti_dive_left_val:.2f}%, 右={anti_dive_right_val:.2f}%, 平均={anti_dive_avg:.2f}%")
        
        return {
            'left': anti_dive_left_val,
            'right': anti_dive_right_val,
            'average': anti_dive_avg,
            'zero_position_idx': zero_idx
        }
    
    # ==================== Static Load Acceleration计算 ====================
    
    def calculate_acceleration_toe_compliance(self,
                                             fit_range: float = 1.0) -> Dict[str, float]:
        """计算Acceleration Toe Compliance（加速力前束柔度）
        
        Args:
            fit_range: 拟合区间范围（kN），默认1.0kN
            
        Returns:
            包含左右轮Acceleration Toe Compliance的字典
        """
        logger.debug("计算Acceleration Toe Compliance")
        
        # 提取数据（加速力通常是driv_left和driv_right）
        acceleration_force = self.extractor.extract_by_name('wheel_load_longitudinal')
        toe_left = self.extractor.extract_by_name('toe_angle', convert_angle=True)
        toe_right = self.extractor.extract_by_name('toe_angle', convert_angle=True)
        
        # 处理多维数据
        if acceleration_force.ndim > 1:
            acceleration_force_left = acceleration_force[:, 2]  # driv_left
            acceleration_force_right = acceleration_force[:, 3]  # driv_right
        else:
            acceleration_force_left = acceleration_force
            acceleration_force_right = acceleration_force
        
        if toe_left.ndim > 1:
            toe_left = toe_left[:, 0]
        if toe_right.ndim > 1:
            toe_right = toe_right[:, 1] if toe_right.shape[1] > 1 else toe_right[:, 0]
        
        # 转换单位：N -> kN
        acceleration_force_left_kn = acceleration_force_left / 1000
        acceleration_force_right_kn = acceleration_force_right / 1000
        
        # 查找零位置（与MATLAB一致）
        zero_idx = find_zero_crossing(acceleration_force_left_kn, acceleration_force_left_kn)
        if zero_idx is None:
            zero_idx = len(acceleration_force_left_kn) // 2
        
        # 确定拟合区间（与MATLAB一致：按力值查找）
        fit_start, fit_end = _find_fit_range_indices_by_value(acceleration_force_left_kn, fit_range)
        fit_start = max(0, fit_start)
        fit_end = min(len(acceleration_force_left_kn), fit_end)
        fit_start_r, fit_end_r = _find_fit_range_indices_by_value(acceleration_force_right_kn, fit_range)
        fit_start_r = max(0, fit_start_r)
        fit_end_r = min(len(acceleration_force_right_kn), fit_end_r)
        
        # 左轮拟合（polyfit与MATLAB完全一致）
        x_left = acceleration_force_left_kn[fit_start:fit_end]
        y_left = toe_left[fit_start:fit_end]
        coeffs_left, _ = linear_fit(x_left, y_left, degree=1)
        
        # 右轮拟合
        x_right = acceleration_force_right_kn[fit_start_r:fit_end_r]
        y_right = toe_right[fit_start_r:fit_end_r]
        coeffs_right, _ = linear_fit(x_right, y_right, degree=1)
        
        # Acceleration Toe Compliance（deg/kN）
        slope_left = coeffs_left[0]
        slope_right = coeffs_right[0]
        slope_avg = (slope_left + slope_right) / 2
        
        logger.debug(f"Acceleration Toe Compliance: 左={slope_left:.3f}, 右={slope_right:.3f}, 平均={slope_avg:.3f} deg/kN")
        
        return {
            'left_slope': slope_left,
            'right_slope': slope_right,
            'average_slope': slope_avg,
            'left_coeffs': coeffs_left.tolist(),
            'right_coeffs': coeffs_right.tolist(),
            'zero_position_idx': zero_idx,
            'fit_range': fit_range,
            'fit_start_left': fit_start,
            'fit_end_left': fit_end,
            'fit_start_right': fit_start_r,
            'fit_end_right': fit_end_r
        }
    
    def calculate_anti_squat(self) -> Dict[str, float]:
        """计算Anti-squat（抗下蹲率）
        
        Returns:
            包含左右轮Anti-squat的字典
        """
        logger.debug("计算Anti-squat")
        
        # 提取数据
        anti_squat = self.extractor.extract_by_name('anti_squat_acceleration')
        
        # 处理多维数据
        if anti_squat.ndim > 1:
            anti_squat_left = anti_squat[:, 0]
            anti_squat_right = anti_squat[:, 1] if anti_squat.shape[1] > 1 else anti_squat[:, 0]
        else:
            anti_squat_left = anti_squat
            anti_squat_right = anti_squat
        
        # 取零位置的值
        zero_idx = len(anti_squat_left) // 2
        anti_squat_left_val = anti_squat_left[zero_idx]
        anti_squat_right_val = anti_squat_right[zero_idx]
        anti_squat_avg = (anti_squat_left_val + anti_squat_right_val) / 2
        
        logger.debug(f"Anti-squat: 左={anti_squat_left_val:.2f}%, 右={anti_squat_right_val:.2f}%, 平均={anti_squat_avg:.2f}%")
        
        return {
            'left': anti_squat_left_val,
            'right': anti_squat_right_val,
            'average': anti_squat_avg,
            'zero_position_idx': zero_idx
        }
