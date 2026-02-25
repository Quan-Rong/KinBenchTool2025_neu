"""检查 wheel_travel 数据的单位问题"""

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

# 获取ID
wheel_travel_ID = parser.get_param_id('wheel_travel')
print(f"wheel_travel_ID: {wheel_travel_ID}")
print()

# 读取原始数据
wheel_left_raw = quasi_data[:, wheel_travel_ID[0]]
wheel_right_raw = quasi_data[:, wheel_travel_ID[1]]

print("=" * 80)
print("原始数据（从 quasi_data 直接读取）:")
print("=" * 80)
print(f"左轮 (ID {wheel_travel_ID[0]}):")
print(f"  最小值: {wheel_left_raw.min():.6f}")
print(f"  最大值: {wheel_left_raw.max():.6f}")
print(f"  范围: {wheel_left_raw.max() - wheel_left_raw.min():.6f}")
print(f"  零位置索引: {np.argmin(np.abs(wheel_left_raw))}")
print(f"  零位置值: {wheel_left_raw[np.argmin(np.abs(wheel_left_raw))]:.6f}")
print()

print(f"右轮 (ID {wheel_travel_ID[1]}):")
print(f"  最小值: {wheel_right_raw.min():.6f}")
print(f"  最大值: {wheel_right_raw.max():.6f}")
print(f"  范围: {wheel_right_raw.max() - wheel_right_raw.min():.6f}")
print(f"  零位置索引: {np.argmin(np.abs(wheel_right_raw))}")
print(f"  零位置值: {wheel_right_raw[np.argmin(np.abs(wheel_right_raw))]:.6f}")
print()

# 检查如果右轮数据单位是 m 而不是 mm 的情况
print("=" * 80)
print("假设右轮数据单位是 m（需要乘以 1000 转换为 mm）:")
print("=" * 80)
wheel_right_mm_converted = wheel_right_raw * 1000
print(f"右轮 (转换后):")
print(f"  最小值: {wheel_right_mm_converted.min():.6f} mm")
print(f"  最大值: {wheel_right_mm_converted.max():.6f} mm")
print(f"  范围: {wheel_right_mm_converted.max() - wheel_right_mm_converted.min():.6f} mm")
print()

# 比较左轮和转换后的右轮
print("=" * 80)
print("比较左轮和转换后的右轮:")
print("=" * 80)
print(f"左轮范围: {wheel_left_raw.max() - wheel_left_raw.min():.6f} mm")
print(f"右轮范围（转换后）: {wheel_right_mm_converted.max() - wheel_right_mm_converted.min():.6f} mm")
print(f"范围差异: {abs((wheel_left_raw.max() - wheel_left_raw.min()) - (wheel_right_mm_converted.max() - wheel_right_mm_converted.min())):.6f} mm")
print()

# 检查 plot_data1 中的数据
extractor = DataExtractor(parser)
calculator = KCCalculator(extractor)
mats = calculator._build_parallel_travel_matrices()
plot_data1 = mats['plot_data1']

wheel_travel_left_from_plot = plot_data1[:, 16]
wheel_travel_right_from_plot = plot_data1[:, 17]

print("=" * 80)
print("从 plot_data1 读取的数据:")
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

# 检查是否一致
print("=" * 80)
print("数据一致性检查:")
print("=" * 80)
print(f"左轮 plot_data1 vs 原始数据: {np.allclose(wheel_travel_left_from_plot, wheel_left_raw)}")
print(f"右轮 plot_data1 vs 原始数据: {np.allclose(wheel_travel_right_from_plot, wheel_right_raw)}")
print()

# 检查是否有其他 wheel_travel 相关的参数
wheel_travel_base_ID = parser.get_param_id('wheel_travel_base')
wheel_travel_track_ID = parser.get_param_id('wheel_travel_track')

print("=" * 80)
print("检查其他 wheel_travel 相关参数:")
print("=" * 80)
print(f"wheel_travel_base_ID: {wheel_travel_base_ID}")
print(f"wheel_travel_track_ID: {wheel_travel_track_ID}")
print()

if wheel_travel_base_ID:
    base_left = quasi_data[:, wheel_travel_base_ID[0]]
    base_right = quasi_data[:, wheel_travel_base_ID[1]]
    print(f"wheel_travel_base 左: 范围 [{base_left.min():.3f}, {base_left.max():.3f}] mm")
    print(f"wheel_travel_base 右: 范围 [{base_right.min():.3f}, {base_right.max():.3f}] mm")
    print()

if wheel_travel_track_ID:
    track_left = quasi_data[:, wheel_travel_track_ID[0]]
    track_right = quasi_data[:, wheel_travel_track_ID[1]]
    print(f"wheel_travel_track 左: 范围 [{track_left.min():.3f}, {track_left.max():.3f}] mm")
    print(f"wheel_travel_track 右: 范围 [{track_right.min():.3f}, {track_right.max():.3f}] mm")
