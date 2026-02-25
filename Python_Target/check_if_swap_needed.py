"""检查是否需要交换 wheel_travel 的左右顺序"""

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
print(f"当前 wheel_travel_ID: {wheel_travel_ID}")
print(f"  ID[0] = {wheel_travel_ID[0]} (应该是 vertical_left)")
print(f"  ID[1] = {wheel_travel_ID[1]} (应该是 vertical_right)")
print()

# 提取数据
wheel_left = quasi_data[:, wheel_travel_ID[0]]
wheel_right = quasi_data[:, wheel_travel_ID[1]]

print("=" * 80)
print("当前数据 (不交换):")
print("=" * 80)
print(f"左轮 (ID {wheel_travel_ID[0]}): 范围 [{wheel_left.min():.3f}, {wheel_left.max():.3f}] mm, 跨度 {wheel_left.max() - wheel_left.min():.3f} mm")
print(f"右轮 (ID {wheel_travel_ID[1]}): 范围 [{wheel_right.min():.3f}, {wheel_right.max():.3f}] mm, 跨度 {wheel_right.max() - wheel_right.min():.3f} mm")
print()

# 尝试交换
wheel_left_swapped = quasi_data[:, wheel_travel_ID[1]]
wheel_right_swapped = quasi_data[:, wheel_travel_ID[0]]

print("=" * 80)
print("交换后的数据:")
print("=" * 80)
print(f"左轮 (使用 ID {wheel_travel_ID[1]}): 范围 [{wheel_left_swapped.min():.3f}, {wheel_left_swapped.max():.3f}] mm, 跨度 {wheel_left_swapped.max() - wheel_left_swapped.min():.3f} mm")
print(f"右轮 (使用 ID {wheel_travel_ID[0]}): 范围 [{wheel_right_swapped.min():.3f}, {wheel_right_swapped.max():.3f}] mm, 跨度 {wheel_right_swapped.max() - wheel_right_swapped.min():.3f} mm")
print()

# 在 parallel_travel 测试中，左右轮应该是同步的，所以数据应该相似
print("=" * 80)
print("分析:")
print("=" * 80)
print("在 parallel_travel 测试中，左右轮应该同步运动，所以左右轮的数据应该相似。")
print()

left_range = wheel_left.max() - wheel_left.min()
right_range = wheel_right.max() - wheel_right.min()
left_swapped_range = wheel_left_swapped.max() - wheel_left_swapped.min()
right_swapped_range = wheel_right_swapped.max() - wheel_right_swapped.min()

print(f"当前配置:")
print(f"  左轮范围: {left_range:.3f} mm")
print(f"  右轮范围: {right_range:.3f} mm")
print(f"  范围比: {left_range / right_range if right_range > 0 else 'inf':.1f}x")
print()

print(f"交换后配置:")
print(f"  左轮范围: {left_swapped_range:.3f} mm")
print(f"  右轮范围: {right_swapped_range:.3f} mm")
print(f"  范围比: {left_swapped_range / right_swapped_range if right_swapped_range > 0 else 'inf':.1f}x")
print()

# 检查哪个配置更合理（左右轮范围应该相似）
if abs(left_range - right_range) < abs(left_swapped_range - right_swapped_range):
    print("结论: 当前配置更合理（左右轮范围更接近）")
else:
    print("结论: 交换后配置更合理（左右轮范围更接近）")
    print("  可能需要交换 wheel_travel 的左右顺序！")
