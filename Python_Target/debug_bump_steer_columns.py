"""调试脚本：检查 bump steer 的列顺序和实际提取的数据"""

import sys
from pathlib import Path

# 添加项目路径
project_root = Path(__file__).parent.parent
sys.path.insert(0, str(project_root / "Python_Target"))

from src.data.res_parser import ResParser
from src.data.data_extractor import DataExtractor
from src.data.kc_calculator import KCCalculator
from src.data.unit_converter import convert_angle_array
import numpy as np

# 解析文件
res_file = "../NRAC_G023_Results/NRAC_G023_parallel_travel.res"
parser = ResParser(res_file)
param_ids, quasi_data = parser.parse()

# 创建计算器
extractor = DataExtractor(parser)
calculator = KCCalculator(extractor)

# 获取ID
toe_angle_ID = parser.get_param_id('toe_angle')
wheel_travel_ID = parser.get_param_id('wheel_travel')

print("=" * 80)
print("ID 验证:")
print(f"  toe_angle_ID: {toe_angle_ID} (left={toe_angle_ID[0]}, right={toe_angle_ID[1]})")
print(f"  wheel_travel_ID: {wheel_travel_ID} (left={wheel_travel_ID[0]}, right={wheel_travel_ID[1]})")
print()

# 构建矩阵
mats = calculator._build_parallel_travel_matrices()
plot_data1 = mats['plot_data1']
Row_No = mats['Row_No']

print("=" * 80)
print("plot_data1 列顺序验证:")
print("  列 0 (索引0): toe_angle left (ID {})".format(toe_angle_ID[0]))
print("  列 1 (索引1): toe_angle right (ID {})".format(toe_angle_ID[1]))
print("  列 16 (索引16): wheel_travel left (ID {})".format(wheel_travel_ID[0]))
print("  列 17 (索引17): wheel_travel right (ID {})".format(wheel_travel_ID[1]))
print()

# 从 plot_data1 提取数据
toe_left_from_plot = plot_data1[:, 0]
toe_right_from_plot = plot_data1[:, 1]
wheel_left_from_plot = plot_data1[:, 16]
wheel_right_from_plot = plot_data1[:, 17]

# 直接从 quasi_data 提取原始数据
toe_left_raw = quasi_data[:, toe_angle_ID[0]]
toe_right_raw = quasi_data[:, toe_angle_ID[1]]
wheel_left_raw = quasi_data[:, wheel_travel_ID[0]]
wheel_right_raw = quasi_data[:, wheel_travel_ID[1]]

# 转换单位
toe_left_raw_deg = convert_angle_array(toe_left_raw, from_unit='rad', to_unit='deg')
toe_right_raw_deg = convert_angle_array(toe_right_raw, from_unit='rad', to_unit='deg')

print("=" * 80)
print("数据对比 (前5个点和后5个点):")
print()
print("左轮数据对比:")
print("  索引  | plot_data1[:,0] (toe) | 原始ID880 (toe) | plot_data1[:,16] (wheel) | 原始ID775 (wheel)")
print("  " + "-" * 80)
for i in [0, 1, 2, Row_No-1, Row_No, Row_No+1, len(toe_left_from_plot)-2, len(toe_left_from_plot)-1]:
    if i < len(toe_left_from_plot):
        print(f"  {i:5d} | {toe_left_from_plot[i]:18.6f} | {toe_left_raw_deg[i]:18.6f} | {wheel_left_from_plot[i]:20.6f} | {wheel_left_raw[i]:20.6f}")

print()
print("右轮数据对比:")
print("  索引  | plot_data1[:,1] (toe) | 原始ID881 (toe) | plot_data1[:,17] (wheel) | 原始ID776 (wheel)")
print("  " + "-" * 80)
for i in [0, 1, 2, Row_No-1, Row_No, Row_No+1, len(toe_right_from_plot)-2, len(toe_right_from_plot)-1]:
    if i < len(toe_right_from_plot):
        print(f"  {i:5d} | {toe_right_from_plot[i]:18.6f} | {toe_right_raw_deg[i]:18.6f} | {wheel_right_from_plot[i]:20.6f} | {wheel_right_raw[i]:20.6f}")

print()
print("=" * 80)
print("检查是否有数据不匹配:")
toe_left_diff = np.abs(toe_left_from_plot - toe_left_raw_deg)
toe_right_diff = np.abs(toe_right_from_plot - toe_right_raw_deg)
wheel_left_diff = np.abs(wheel_left_from_plot - wheel_left_raw)
wheel_right_diff = np.abs(wheel_right_from_plot - wheel_right_raw)

print(f"  左轮 toe 最大差异: {toe_left_diff.max():.10f}")
print(f"  右轮 toe 最大差异: {toe_right_diff.max():.10f}")
print(f"  左轮 wheel 最大差异: {wheel_left_diff.max():.10f}")
print(f"  右轮 wheel 最大差异: {wheel_right_diff.max():.10f}")

if toe_left_diff.max() > 1e-6:
    print("  ⚠️  左轮 toe 数据不匹配！")
if toe_right_diff.max() > 1e-6:
    print("  ⚠️  右轮 toe 数据不匹配！")
if wheel_left_diff.max() > 1e-6:
    print("  ⚠️  左轮 wheel 数据不匹配！")
if wheel_right_diff.max() > 1e-6:
    print("  ⚠️  右轮 wheel 数据不匹配！")

print()
print("=" * 80)
print("检查 calculate_bump_steer 中使用的数据:")
result = calculator.calculate_bump_steer(fit_range=15)
print(f"  左轮斜率: {result['left_slope']:.6f} deg/m")
print(f"  右轮斜率: {result['right_slope']:.6f} deg/m")

# 手动提取并对比
fit_start = max(0, Row_No - 15)
fit_end = min(plot_data1.shape[0], Row_No + 16)

x_left_manual = plot_data1[fit_start:fit_end, 16]
y_left_manual = plot_data1[fit_start:fit_end, 0]
x_right_manual = plot_data1[fit_start:fit_end, 17]
y_right_manual = plot_data1[fit_start:fit_end, 1]

print()
print("手动提取的拟合区间数据 (前3个和后3个点):")
print("左轮:")
for i in [0, 1, 2, len(x_left_manual)-3, len(x_left_manual)-2, len(x_left_manual)-1]:
    if i < len(x_left_manual):
        print(f"  [{fit_start+i}] X={x_left_manual[i]:.6f} mm, Y={y_left_manual[i]:.6f} deg")
print("右轮:")
for i in [0, 1, 2, len(x_right_manual)-3, len(x_right_manual)-2, len(x_right_manual)-1]:
    if i < len(x_right_manual):
        print(f"  [{fit_start+i}] X={x_right_manual[i]:.6f} mm, Y={y_right_manual[i]:.6f} deg")
