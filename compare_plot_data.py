"""对比MATLAB和Python的Susp_parallel_travel_plot_data1结果"""

import sys
import numpy as np
from pathlib import Path
import os

# 添加Python_Target/src到路径
project_root = Path(__file__).parent
src_path = project_root / "Python_Target" / "src"
sys.path.insert(0, str(src_path))
os.chdir(str(src_path))  # 改变工作目录

from data.res_parser import ResParser
from data.data_extractor import DataExtractor
from data.unit_converter import convert_angle_array

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
    
    print("参数ID:")
    print(f"  toe_angle_ID: {toe_angle_ID}")
    print(f"  camber_angle_ID: {camber_angle_ID}")
    print(f"  caster_angle_ID: {caster_angle_ID}")
    print(f"  left_tire_contact_point_ID: {left_tire_contact_point_ID}")
    print(f"  right_tire_contact_point_ID: {right_tire_contact_point_ID}")
    print(f"  wheel_travel_base_ID: {wheel_travel_base_ID}")
    print(f"  wheel_travel_track_ID: {wheel_travel_track_ID}")
    print(f"  anti_dive_ID: {anti_dive_ID}")
    print(f"  anti_lift_ID: {anti_lift_ID}")
    print(f"  wheel_rate_ID: {wheel_rate_ID}")
    print(f"  wheel_travel_ID: {wheel_travel_ID}")
    print(f"  wheel_load_vertical_force_ID: {wheel_load_vertical_force_ID}")
    print(f"  side_view_swing_arm_angle_ID: {side_view_swing_arm_angle_ID}")
    print(f"  side_view_swing_arm_length_ID: {side_view_swing_arm_length_ID}")
    print()
    
    # ========== MATLAB逻辑 ==========
    # MATLAB: Susp_parallel_travel_plot_ID=[toe_angle_ID(1),toe_angle_ID(2),...]
    # MATLAB使用1-based索引
    matlab_plot_ID = [
        toe_angle_ID[0],  # MATLAB: toe_angle_ID(1) -> Python: [0]
        toe_angle_ID[1],  # MATLAB: toe_angle_ID(2) -> Python: [1]
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
    
    print("MATLAB逻辑的ID列表:")
    print(f"  Susp_parallel_travel_plot_ID = {matlab_plot_ID}\n")
    
    # MATLAB: Susp_parallel_travel_plot_data1=quasiStatic_data(:,Susp_parallel_travel_plot_ID);
    matlab_plot_data1 = quasi[:, matlab_plot_ID].copy()
    
    # MATLAB: 角度转换（MATLAB使用1-based索引）
    # Susp_parallel_travel_plot_data1(:,1:2)=... (列1-2，Python索引0-1)
    # Susp_parallel_travel_plot_data1(:,15:16)=... (列15-16，Python索引14-15)
    # Susp_parallel_travel_plot_data1(:,21:22)=... (列21-22，Python索引20-21)
    # Susp_parallel_travel_plot_data1(:,25:26)=... (列25-26，Python索引24-25)
    matlab_plot_data1[:, 0:2] = matlab_plot_data1[:, 0:2] * 180 / np.pi  # toe (列1-2)
    matlab_plot_data1[:, 14:16] = matlab_plot_data1[:, 14:16] * 180 / np.pi  # camber (列15-16)
    matlab_plot_data1[:, 20:22] = matlab_plot_data1[:, 20:22] * 180 / np.pi  # svsa_angle (列21-22)
    matlab_plot_data1[:, 24:26] = matlab_plot_data1[:, 24:26] * 180 / np.pi  # caster (列25-26)
    
    # ========== Python逻辑（当前代码）==========
    python_plot_ID = [
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
    
    print("Python逻辑的ID列表:")
    print(f"  susp_parallel_travel_plot_ID = {python_plot_ID}\n")
    
    python_plot_data1 = quasi[:, python_plot_ID].copy()
    
    # Python: 角度转换（当前代码）
    python_plot_data1[:, 0:2] = convert_angle_array(python_plot_data1[:, 0:2], from_unit='rad', to_unit='deg')
    python_plot_data1[:, 14:16] = convert_angle_array(python_plot_data1[:, 14:16], from_unit='rad', to_unit='deg')
    python_plot_data1[:, 20:22] = convert_angle_array(python_plot_data1[:, 20:22], from_unit='rad', to_unit='deg')
    python_plot_data1[:, 24:26] = convert_angle_array(python_plot_data1[:, 24:26], from_unit='rad', to_unit='deg')
    
    # ========== 对比结果 ==========
    print("=" * 80)
    print("对比结果")
    print("=" * 80)
    
    print(f"\nMATLAB结果形状: {matlab_plot_data1.shape}")
    print(f"Python结果形状: {python_plot_data1.shape}")
    
    # 检查是否完全一致
    if np.array_equal(matlab_plot_data1, python_plot_data1):
        print("\n✓ 两个矩阵完全一致！")
    else:
        print("\n✗ 两个矩阵不一致！")
        diff = np.abs(matlab_plot_data1 - python_plot_data1)
        max_diff = np.max(diff)
        print(f"  最大差异: {max_diff}")
        print(f"  差异位置: {np.unravel_index(np.argmax(diff), diff.shape)}")
        
        # 找出所有有差异的位置
        diff_mask = diff > 1e-10
        n_diff = np.sum(diff_mask)
        print(f"  有差异的元素数量: {n_diff} / {diff.size}")
        
        if n_diff < 100:  # 如果差异不多，打印出来
            print("\n  差异详情:")
            diff_indices = np.where(diff_mask)
            for i in range(min(10, len(diff_indices[0]))):
                row = diff_indices[0][i]
                col = diff_indices[1][i]
                print(f"    位置[{row}, {col}]: MATLAB={matlab_plot_data1[row, col]:.10f}, "
                      f"Python={python_plot_data1[row, col]:.10f}, "
                      f"差异={diff[row, col]:.10e}")
    
    # 输出前几行数据用于对比
    print("\n" + "=" * 80)
    print("前5行数据对比（MATLAB vs Python）")
    print("=" * 80)
    print("\nMATLAB结果（前5行，前10列）:")
    print(matlab_plot_data1[:5, :10])
    print("\nPython结果（前5行，前10列）:")
    print(python_plot_data1[:5, :10])
    
    print("\n" + "=" * 80)
    print("列索引说明")
    print("=" * 80)
    print("列索引对应关系（MATLAB 1-based -> Python 0-based）:")
    print("  列1-2 (MATLAB) = 列0-1 (Python): toe_angle")
    print("  列15-16 (MATLAB) = 列14-15 (Python): camber_angle")
    print("  列21-22 (MATLAB) = 列20-21 (Python): side_view_swing_arm_angle")
    print("  列25-26 (MATLAB) = 列24-25 (Python): caster_angle")
    
    # 检查角度转换的列
    print("\n角度转换列对比:")
    print(f"  toe (列0-1): MATLAB前3行 = {matlab_plot_data1[:3, 0:2]}")
    print(f"              Python前3行 = {python_plot_data1[:3, 0:2]}")
    print(f"  camber (列14-15): MATLAB前3行 = {matlab_plot_data1[:3, 14:16]}")
    print(f"                    Python前3行 = {python_plot_data1[:3, 14:16]}")
    print(f"  svsa_angle (列20-21): MATLAB前3行 = {matlab_plot_data1[:3, 20:22]}")
    print(f"                       Python前3行 = {python_plot_data1[:3, 20:22]}")
    print(f"  caster (列24-25): MATLAB前3行 = {matlab_plot_data1[:3, 24:26]}")
    print(f"                    Python前3行 = {python_plot_data1[:3, 24:26]}")


if __name__ == "__main__":
    # 使用parallel_travel的res文件
    project_root = Path(__file__).parent
    res_file = project_root / "NRAC_G023_Results" / "NRAC_G023_parallel_travel.res"
    
    if not res_file.exists():
        print(f"错误: 文件不存在: {res_file}")
        print("请提供正确的res文件路径")
        sys.exit(1)
    
    compare_plot_data(str(res_file))
