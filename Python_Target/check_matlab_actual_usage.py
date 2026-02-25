"""检查 MATLAB 代码实际使用的参数"""

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

# 获取所有相关 ID
wheel_travel_ID = parser.get_param_id('wheel_travel')
wheel_travel_base_ID = parser.get_param_id('wheel_travel_base')
wheel_travel_track_ID = parser.get_param_id('wheel_travel_track')

print("=" * 80)
print("所有 wheel_travel 相关参数的 ID:")
print("=" * 80)
print(f"wheel_travel: {wheel_travel_ID}")
print(f"  ID[0] = {wheel_travel_ID[0]} (vertical_left)")
print(f"  ID[1] = {wheel_travel_ID[1]} (vertical_right)")
print()
print(f"wheel_travel_base: {wheel_travel_base_ID}")
print(f"  ID[0] = {wheel_travel_base_ID[0]} (base_left)")
print(f"  ID[1] = {wheel_travel_base_ID[1]} (base_right)")
print()
print(f"wheel_travel_track: {wheel_travel_track_ID}")
print(f"  ID[0] = {wheel_travel_track_ID[0]} (track_left)")
print(f"  ID[1] = {wheel_travel_track_ID[1]} (track_right)")
print()

# 提取所有数据
print("=" * 80)
print("数据范围分析:")
print("=" * 80)

# wheel_travel
wt_left = quasi_data[:, wheel_travel_ID[0]]
wt_right = quasi_data[:, wheel_travel_ID[1]]
print(f"wheel_travel vertical_left (ID {wheel_travel_ID[0]}): 范围 [{wt_left.min():.3f}, {wt_left.max():.3f}] mm, 跨度 {wt_left.max() - wt_left.min():.3f} mm")
print(f"wheel_travel vertical_right (ID {wheel_travel_ID[1]}): 范围 [{wt_right.min():.3f}, {wt_right.max():.3f}] mm, 跨度 {wt_right.max() - wt_right.min():.3f} mm")
print()

# wheel_travel_base
wtb_left = quasi_data[:, wheel_travel_base_ID[0]]
wtb_right = quasi_data[:, wheel_travel_base_ID[1]]
print(f"wheel_travel_base base_left (ID {wheel_travel_base_ID[0]}): 范围 [{wtb_left.min():.3f}, {wtb_left.max():.3f}] mm, 跨度 {wtb_left.max() - wtb_left.min():.3f} mm")
print(f"wheel_travel_base base_right (ID {wheel_travel_base_ID[1]}): 范围 [{wtb_right.min():.3f}, {wtb_right.max():.3f}] mm, 跨度 {wtb_right.max() - wtb_right.min():.3f} mm")
print()

# wheel_travel_track
wtt_left = quasi_data[:, wheel_travel_track_ID[0]]
wtt_right = quasi_data[:, wheel_travel_track_ID[1]]
print(f"wheel_travel_track track_left (ID {wheel_travel_track_ID[0]}): 范围 [{wtt_left.min():.3f}, {wtt_left.max():.3f}] mm, 跨度 {wtt_left.max() - wtt_left.min():.3f} mm")
print(f"wheel_travel_track track_right (ID {wheel_travel_track_ID[1]}): 范围 [{wtt_right.min():.3f}, {wtt_right.max():.3f}] mm, 跨度 {wtt_right.max() - wtt_right.min():.3f} mm")
print()

# 在 parallel_travel 中，左右轮应该同步，所以寻找范围相似的数据
print("=" * 80)
print("寻找左右轮范围相似的数据（parallel_travel 中左右轮应该同步）:")
print("=" * 80)

left_range = wt_left.max() - wt_left.min()
right_range = wt_right.max() - wt_right.min()

print(f"wheel_travel: 左轮范围 {left_range:.3f} mm, 右轮范围 {right_range:.3f} mm, 差异 {abs(left_range - right_range):.3f} mm")
if abs(left_range - right_range) < 10:
    print("  -> 这个配置合理！")
else:
    print("  -> 这个配置不合理（左右轮范围差异太大）")

# 检查是否有其他组合
# 也许 MATLAB 实际使用的是 wheel_travel_base 或 wheel_travel_track 的某个分量？
# 或者组合使用？
