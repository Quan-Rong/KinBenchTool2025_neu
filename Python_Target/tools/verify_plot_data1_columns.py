"""
验证 Python 的 plot_data1 是否与 MATLAB 的 Susp_parallel_travel_plot_data1 完全一致
（26列，列顺序、单位转换都要匹配）
"""
import sys
import os
# 添加项目根目录到路径
project_root = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
sys.path.insert(0, project_root)

import numpy as np
from src.data.kc_calculator import KCCalculator
from src.data.res_parser import ResParser
from src.data.data_extractor import DataExtractor

# 使用测试文件
res_file = r'C:\CAE\Cursor_Test\KinBenchTool2025_neu\NRAC_G023_Results\NRAC_G023_parallel_travel.res'

print("=" * 80)
print("验证 plot_data1 的26列是否与MATLAB Susp_parallel_travel_plot_ID完全匹配")
print("=" * 80)

# 解析
parser = ResParser(res_file)
parser.parse()

# 创建DataExtractor和KCCalculator
extractor = DataExtractor(parser)
calc = KCCalculator(extractor)

# 获取ID
toe_angle_ID = parser.get_param_id('toe_angle')
left_tire_contact_point_ID = parser.get_param_id('left_tire_contact_point')
right_tire_contact_point_ID = parser.get_param_id('right_tire_contact_point')
wheel_travel_base_ID = parser.get_param_id('wheel_travel_base')
wheel_travel_track_ID = parser.get_param_id('wheel_travel_track')
anti_dive_ID = parser.get_param_id('anti_dive')
anti_lift_ID = parser.get_param_id('anti_lift')
wheel_rate_ID = parser.get_param_id('wheel_rate')
camber_angle_ID = parser.get_param_id('camber_angle')
wheel_travel_ID = parser.get_param_id('wheel_travel')
wheel_load_vertical_force_ID = parser.get_param_id('wheel_load_vertical_force')
side_view_swing_arm_angle_ID = parser.get_param_id('side_view_swing_arm_angle')
side_view_swing_arm_length_ID = parser.get_param_id('side_view_swing_arm_length')
caster_angle_ID = parser.get_param_id('caster_angle')

# MATLAB的Susp_parallel_travel_plot_ID（按顺序）
matlab_plot_ID = [
    toe_angle_ID[0],                    # 1: toe left
    toe_angle_ID[1],                    # 2: toe right
    left_tire_contact_point_ID[1],       # 3: left_tire_contact_point Y
    right_tire_contact_point_ID[1],      # 4: right_tire_contact_point Y
    wheel_travel_base_ID[0],            # 5: wheel_travel_base left
    wheel_travel_base_ID[1],            # 6: wheel_travel_base right
    wheel_travel_track_ID[0],           # 7: wheel_travel_track left
    wheel_travel_track_ID[1],           # 8: wheel_travel_track right
    anti_dive_ID[0],                    # 9: anti_dive left
    anti_dive_ID[1],                    # 10: anti_dive right
    anti_lift_ID[0],                    # 11: anti_lift left
    anti_lift_ID[1],                    # 12: anti_lift right
    wheel_rate_ID[0],                   # 13: wheel_rate left
    wheel_rate_ID[1],                   # 14: wheel_rate right
    camber_angle_ID[0],                 # 15: camber left
    camber_angle_ID[1],                 # 16: camber right
    wheel_travel_ID[0],                 # 17: wheel_travel left
    wheel_travel_ID[1],                 # 18: wheel_travel right
    wheel_load_vertical_force_ID[0],    # 19: wheel_load_vertical_force left
    wheel_load_vertical_force_ID[1],    # 20: wheel_load_vertical_force right
    side_view_swing_arm_angle_ID[0],    # 21: side_view_swing_arm_angle left
    side_view_swing_arm_angle_ID[1],    # 22: side_view_swing_arm_angle right
    side_view_swing_arm_length_ID[0],   # 23: side_view_swing_arm_length left
    side_view_swing_arm_length_ID[1],   # 24: side_view_swing_arm_length right
    caster_angle_ID[0],                 # 25: caster left
    caster_angle_ID[1],                 # 26: caster right
]

print(f"\nMATLAB Susp_parallel_travel_plot_ID (共{len(matlab_plot_ID)}列):")
col_names = [
    'toe_left', 'toe_right',
    'left_tire_contact_Y', 'right_tire_contact_Y',
    'wheel_travel_base_left', 'wheel_travel_base_right',
    'wheel_travel_track_left', 'wheel_travel_track_right',
    'anti_dive_left', 'anti_dive_right',
    'anti_lift_left', 'anti_lift_right',
    'wheel_rate_left', 'wheel_rate_right',
    'camber_left', 'camber_right',
    'wheel_travel_left', 'wheel_travel_right',
    'wheel_load_vertical_force_left', 'wheel_load_vertical_force_right',
    'side_view_swing_arm_angle_left', 'side_view_swing_arm_angle_right',
    'side_view_swing_arm_length_left', 'side_view_swing_arm_length_right',
    'caster_left', 'caster_right',
]
for i, (name, pid) in enumerate(zip(col_names, matlab_plot_ID), 1):
    print(f"  列{i:2d} ({name:35s}): ID={pid}")

# 构建Python的plot_data1
mats = calc._build_parallel_travel_matrices()
plot_data1 = mats['plot_data1']

print(f"\nPython plot_data1 shape: {plot_data1.shape}")
print(f"期望: ({parser.quasi_static_data.shape[0]}, 26)")

# 手动构建MATLAB版本的plot_data1（用于对比）
quasi = parser.quasi_static_data
matlab_plot_data1 = quasi[:, matlab_plot_ID].copy()

# MATLAB的单位转换（1-based索引，Python用0-based）
# 列1-2: toe (0:2 in Python)
matlab_plot_data1[:, 0:2] = matlab_plot_data1[:, 0:2] * 180 / np.pi
# 列15-16: camber (14:16 in Python)
matlab_plot_data1[:, 14:16] = matlab_plot_data1[:, 14:16] * 180 / np.pi
# 列21-22: side_view_swing_arm_angle (20:22 in Python)
matlab_plot_data1[:, 20:22] = matlab_plot_data1[:, 20:22] * 180 / np.pi
# 列25-26: caster (24:26 in Python)
matlab_plot_data1[:, 24:26] = matlab_plot_data1[:, 24:26] * 180 / np.pi

print("\n" + "=" * 80)
print("逐列对比（前5行）：")
print("=" * 80)

max_diffs = []
for col_idx in range(26):
    py_col = plot_data1[:, col_idx]
    matlab_col = matlab_plot_data1[:, col_idx]
    max_diff = np.max(np.abs(py_col - matlab_col))
    max_diffs.append(max_diff)
    
    if col_idx < 5:  # 只打印前5行
        print(f"\n列{col_idx+1:2d} ({col_names[col_idx]}):")
        print(f"  Python前5行: {py_col[:5]}")
        print(f"  MATLAB前5行: {matlab_col[:5]}")
        print(f"  最大差异: {max_diff:.10e}")

print("\n" + "=" * 80)
print("所有26列的最大差异汇总：")
print("=" * 80)
for col_idx, (name, max_diff) in enumerate(zip(col_names, max_diffs), 1):
    status = "OK" if max_diff < 1e-10 else "FAIL"
    print(f"  列{col_idx:2d} ({name:35s}): max_diff = {max_diff:.10e} {status}")

overall_max = max(max_diffs)
print(f"\n总体最大差异: {overall_max:.10e}")
if overall_max < 1e-10:
    print("OK: Python plot_data1 与 MATLAB Susp_parallel_travel_plot_data1 完全一致！")
else:
    print("FAIL: 存在差异，需要检查！")
