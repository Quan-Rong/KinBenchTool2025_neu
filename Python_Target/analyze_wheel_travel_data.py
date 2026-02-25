"""分析 wheel_travel 数据，找出右轮数据异常的原因"""

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
print(f"  ID 775 (vertical_left): {wheel_travel_ID[0]}")
print(f"  ID 776 (vertical_right): {wheel_travel_ID[1]}")
print()

# 直接从 quasi_data 提取原始数据
wheel_left_raw = quasi_data[:, wheel_travel_ID[0]]
wheel_right_raw = quasi_data[:, wheel_travel_ID[1]]

print("=" * 80)
print("原始数据统计:")
print(f"左轮 (ID 775):")
print(f"  最小值: {wheel_left_raw.min():.6f} mm")
print(f"  最大值: {wheel_left_raw.max():.6f} mm")
print(f"  范围: {wheel_left_raw.max() - wheel_left_raw.min():.6f} mm")
print(f"  平均值: {wheel_left_raw.mean():.6f} mm")
print(f"  标准差: {wheel_left_raw.std():.6f} mm")
print()

print(f"右轮 (ID 776):")
print(f"  最小值: {wheel_right_raw.min():.6f} mm")
print(f"  最大值: {wheel_right_raw.max():.6f} mm")
print(f"  范围: {wheel_right_raw.max() - wheel_right_raw.min():.6f} mm")
print(f"  平均值: {wheel_right_raw.mean():.6f} mm")
print(f"  标准差: {wheel_right_raw.std():.6f} mm")
print()

# 检查零位置附近的数据
zero_idx_left = int(np.argmin(np.abs(wheel_left_raw)))
zero_idx_right = int(np.argmin(np.abs(wheel_right_raw)))

print("=" * 80)
print("零位置附近的数据 (索引 45-55):")
print(f"左轮零位置索引: {zero_idx_left}")
print(f"右轮零位置索引: {zero_idx_right}")
print()

print("左轮数据 (索引 45-55):")
for i in range(45, min(56, len(wheel_left_raw))):
    print(f"  [{i}] {wheel_left_raw[i]:.6f} mm")
print()

print("右轮数据 (索引 45-55):")
for i in range(45, min(56, len(wheel_right_raw))):
    print(f"  [{i}] {wheel_right_raw[i]:.6f} mm")
print()

# 检查是否有其他 wheel_travel 相关的 ID
print("=" * 80)
print("检查其他可能的 wheel_travel 相关参数:")
wheel_travel_base_ID = parser.get_param_id('wheel_travel_base')
wheel_travel_track_ID = parser.get_param_id('wheel_travel_track')

print(f"wheel_travel_base_ID: {wheel_travel_base_ID}")
print(f"wheel_travel_track_ID: {wheel_travel_track_ID}")

# 检查这些数据
if isinstance(wheel_travel_base_ID, (list, tuple)) and len(wheel_travel_base_ID) >= 2:
    base_left = quasi_data[:, wheel_travel_base_ID[0]]
    base_right = quasi_data[:, wheel_travel_base_ID[1]]
    print(f"wheel_travel_base 左: 范围 [{base_left.min():.3f}, {base_left.max():.3f}] mm")
    print(f"wheel_travel_base 右: 范围 [{base_right.min():.3f}, {base_right.max():.3f}] mm")

if isinstance(wheel_travel_track_ID, (list, tuple)) and len(wheel_travel_track_ID) >= 2:
    track_left = quasi_data[:, wheel_travel_track_ID[0]]
    track_right = quasi_data[:, wheel_travel_track_ID[1]]
    print(f"wheel_travel_track 左: 范围 [{track_left.min():.3f}, {track_left.max():.3f}] mm")
    print(f"wheel_travel_track 右: 范围 [{track_right.min():.3f}, {track_right.max():.3f}] mm")
