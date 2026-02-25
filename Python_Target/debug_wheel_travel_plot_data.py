"""调试 plot_data1 中的 wheel_travel 数据"""

import sys
from pathlib import Path
import numpy as np

# 添加项目路径
project_root = Path(__file__).parent.parent
sys.path.insert(0, str(project_root / "Python_Target"))

from src.data.res_parser import ResParser
from src.data.data_extractor import DataExtractor
from src.data.kc_calculator import KCCalculator

# 解析文件
res_file = "../NRAC_G023_Results/NRAC_G023_parallel_travel.res"
parser = ResParser(res_file)
param_ids, quasi_data = parser.parse()

# 创建计算器
extractor = DataExtractor(parser)
calculator = KCCalculator(extractor)

# 获取ID
wheel_travel_ID = parser.get_param_id('wheel_travel')
print(f"wheel_travel_ID: {wheel_travel_ID}")
print()

# 构建矩阵
mats = calculator._build_parallel_travel_matrices()
plot_data1 = mats['plot_data1']

print("=" * 80)
print("plot_data1 的列信息:")
print("=" * 80)
print(f"  总列数: {plot_data1.shape[1]}")
print(f"  总行数: {plot_data1.shape[0]}")
print()

# 根据代码，wheel_travel 应该在列 16 和 17
wheel_travel_left_from_plot = plot_data1[:, 16]
wheel_travel_right_from_plot = plot_data1[:, 17]

print("=" * 80)
print("从 plot_data1 提取的 wheel_travel 数据:")
print("=" * 80)
print(f"左轮 (列 16):")
print(f"  最小值: {wheel_travel_left_from_plot.min():.6f}")
print(f"  最大值: {wheel_travel_left_from_plot.max():.6f}")
print(f"  范围: {wheel_travel_left_from_plot.max() - wheel_travel_left_from_plot.min():.6f}")
print()

print(f"右轮 (列 17):")
print(f"  最小值: {wheel_travel_right_from_plot.min():.6f}")
print(f"  最大值: {wheel_travel_right_from_plot.max():.6f}")
print(f"  范围: {wheel_travel_right_from_plot.max() - wheel_travel_right_from_plot.min():.6f}")
print()

# 直接从 quasi_data 提取原始数据
wheel_left_raw = quasi_data[:, wheel_travel_ID[0]]
wheel_right_raw = quasi_data[:, wheel_travel_ID[1]]

print("=" * 80)
print("从 quasi_data 直接提取的原始数据:")
print("=" * 80)
print(f"左轮 (ID {wheel_travel_ID[0]}):")
print(f"  最小值: {wheel_left_raw.min():.6f}")
print(f"  最大值: {wheel_left_raw.max():.6f}")
print(f"  范围: {wheel_left_raw.max() - wheel_left_raw.min():.6f}")
print()

print(f"右轮 (ID {wheel_travel_ID[1]}):")
print(f"  最小值: {wheel_right_raw.min():.6f}")
print(f"  最大值: {wheel_right_raw.max():.6f}")
print(f"  范围: {wheel_right_raw.max() - wheel_right_raw.min():.6f}")
print()

# 对比
print("=" * 80)
print("数据对比:")
print("=" * 80)
print(f"左轮 plot_data1 vs 原始数据是否一致: {np.allclose(wheel_travel_left_from_plot, wheel_left_raw)}")
print(f"右轮 plot_data1 vs 原始数据是否一致: {np.allclose(wheel_travel_right_from_plot, wheel_right_raw)}")
print()

# 检查 plot_data1 的列顺序
print("=" * 80)
print("检查 plot_data1 的列顺序 (根据代码):")
print("=" * 80)
print("  列 0-1: toe_angle (left, right)")
print("  列 2-3: tire_contact_point_Y (left, right)")
print("  列 4-5: wheel_travel_base (left, right)")
print("  列 6-7: wheel_travel_track (left, right)")
print("  列 8-9: anti_dive (left, right)")
print("  列 10-11: anti_lift (left, right)")
print("  列 12-13: wheel_rate (left, right)")
print("  列 14-15: camber_angle (left, right)")
print("  列 16-17: wheel_travel (left, right) <- 这里")
print("  列 18-19: wheel_load_vertical_force (left, right)")
print("  列 20-21: side_view_swing_arm_angle (left, right)")
print("  列 22-23: side_view_swing_arm_length (left, right)")
print("  列 24-25: caster_angle (left, right)")
print()

# 检查是否有数据转换
print("=" * 80)
print("检查数据转换:")
print("=" * 80)
print("  wheel_travel 数据在放入 plot_data1 前是否有转换？")
print("  查看代码中是否有单位转换...")
print()
