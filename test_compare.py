"""对比MATLAB和Python的Susp_parallel_travel_plot_data1结果"""

import sys
from pathlib import Path

# 设置路径（按照main.py的方式）
project_root = Path(__file__).parent
src_dir = project_root / "Python_Target" / "src"
sys.path.insert(0, str(src_dir))
sys.path.insert(0, str(src_dir.parent))

import numpy as np
from src.data.res_parser import ResParser
from src.data.unit_converter import convert_angle_array

def compare_plot_data(res_file_path: str):
    """对比MATLAB和Python的plot_data1结果"""
    
    print("=" * 80)
    print("对比MATLAB和Python的Susp_parallel_travel_plot_data1结果")
    print("=" * 80)
    print(f"\n文件: {res_file_path}\n")
    
    # 解析文件
    parser = ResParser(res_file_path)
    parser.parse()
    quasi = parser.quasi_static_data
    
    print(f"数据矩阵形状: {quasi.shape}\n")
    
    # 获取所有ID
    toe_angle_ID = parser.get_param_id('toe_angle')
    camber_angle_ID = parser.get_param_id('camber_angle')
    caster_angle_ID = parser.get_param_id('caster_angle')
    left_tire_contact_point_ID = parser.get_param_id('left_tire_contact_point')
    right_tire_contact_point_ID = parser.get_param_id('right_tire_contact_point')
    wheel_travel_base_ID = parser.get_param_id('wheel_travel_base')
    wheel_travel_track_ID = parser.get_param_id('wheel_travel_track')
    anti_dive_ID = parser.get_param_id('anti_dive')
    anti_lift_ID = parser.get_param_id('anti_lift')
    wheel_rate_ID = parser.get_param_id('wheel_rate')
    wheel_travel_ID = parser.get_param_id('wheel_travel')
    wheel_load_vertical_force_ID = parser.get_param_id('wheel_load_vertical_force')
    side_view_swing_arm_angle_ID = parser.get_param_id('side_view_swing_arm_angle')
    side_view_swing_arm_length_ID = parser.get_param_id('side_view_swing_arm_length')
    
    # ========== MATLAB逻辑 ==========
    matlab_plot_ID = [
        toe_angle_ID[0], toe_angle_ID[1],
        left_tire_contact_point_ID[1], right_tire_contact_point_ID[1],
        wheel_travel_base_ID[0], wheel_travel_base_ID[1],
        wheel_travel_track_ID[0], wheel_travel_track_ID[1],
        anti_dive_ID[0], anti_dive_ID[1],
        anti_lift_ID[0], anti_lift_ID[1],
        wheel_rate_ID[0], wheel_rate_ID[1],
        camber_angle_ID[0], camber_angle_ID[1],
        wheel_travel_ID[0], wheel_travel_ID[1],
        wheel_load_vertical_force_ID[0], wheel_load_vertical_force_ID[1],
        side_view_swing_arm_angle_ID[0], side_view_swing_arm_angle_ID[1],
        side_view_swing_arm_length_ID[0], side_view_swing_arm_length_ID[1],
        caster_angle_ID[0], caster_angle_ID[1],
    ]
    
    matlab_plot_data1 = quasi[:, matlab_plot_ID].copy()
    # MATLAB: 列1-2, 15-16, 21-22, 25-26 (1-based) -> Python: 0-1, 14-15, 20-21, 24-25 (0-based)
    matlab_plot_data1[:, 0:2] = matlab_plot_data1[:, 0:2] * 180 / np.pi
    matlab_plot_data1[:, 14:16] = matlab_plot_data1[:, 14:16] * 180 / np.pi
    matlab_plot_data1[:, 20:22] = matlab_plot_data1[:, 20:22] * 180 / np.pi
    matlab_plot_data1[:, 24:26] = matlab_plot_data1[:, 24:26] * 180 / np.pi
    
    # ========== Python逻辑（当前代码）==========
    python_plot_ID = matlab_plot_ID.copy()  # ID列表相同
    
    python_plot_data1 = quasi[:, python_plot_ID].copy()
    python_plot_data1[:, 0:2] = convert_angle_array(python_plot_data1[:, 0:2], from_unit='rad', to_unit='deg')
    python_plot_data1[:, 14:16] = convert_angle_array(python_plot_data1[:, 14:16], from_unit='rad', to_unit='deg')
    python_plot_data1[:, 20:22] = convert_angle_array(python_plot_data1[:, 20:22], from_unit='rad', to_unit='deg')
    python_plot_data1[:, 24:26] = convert_angle_array(python_plot_data1[:, 24:26], from_unit='rad', to_unit='deg')
    
    # ========== 对比结果 ==========
    print("=" * 80)
    print("对比结果")
    print("=" * 80)
    
    # 计算差异
    diff = np.abs(matlab_plot_data1 - python_plot_data1)
    max_diff = np.max(diff)
    diff_mask = diff > 1e-10
    n_diff = np.sum(diff_mask)
    
    # 使用 allclose 进行合理的浮点数比较（相对容差1e-9，绝对容差1e-10）
    is_close = np.allclose(matlab_plot_data1, python_plot_data1, rtol=1e-9, atol=1e-10)
    
    if is_close:
        print("\n[OK] 两个矩阵在浮点数精度范围内完全一致！")
        print(f"  最大差异: {max_diff:.10e} (在可接受范围内)")
    else:
        print("\n[ERROR] 两个矩阵存在显著差异！")
        print(f"  最大差异: {max_diff:.10e}")
        print(f"  差异位置: {np.unravel_index(np.argmax(diff), diff.shape)}")
        print(f"  有差异的元素数量: {n_diff} / {diff.size}")
    
    # 输出矩阵数据
    print("\n" + "=" * 80)
    print("MATLAB结果 (Susp_parallel_travel_plot_data1)")
    print("=" * 80)
    print(f"形状: {matlab_plot_data1.shape}")
    print("前10行，所有26列:")
    np.set_printoptions(precision=6, suppress=True, linewidth=200)
    print(matlab_plot_data1[:10, :])
    
    print("\n" + "=" * 80)
    print("Python结果 (plot_data1)")
    print("=" * 80)
    print(f"形状: {python_plot_data1.shape}")
    print("前10行，所有26列:")
    print(python_plot_data1[:10, :])


if __name__ == "__main__":
    root = Path(__file__).parent
    res_file = root / "NRAC_G023_Results" / "NRAC_G023_parallel_travel.res"
    if not res_file.exists():
        print(f"错误: 文件不存在: {res_file}")
        sys.exit(1)
    compare_plot_data(str(res_file))
