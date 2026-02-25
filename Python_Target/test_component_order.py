"""测试 Component 的匹配顺序 - 检查是否应该按文件顺序而不是名称顺序"""

import sys
from pathlib import Path
import re
from collections import OrderedDict

# 添加项目路径
project_root = Path(__file__).parent.parent
sys.path.insert(0, str(project_root / "Python_Target"))

from src.data.res_parser import ResParser

# 解析文件
res_file = "../NRAC_G023_Results/NRAC_G023_parallel_travel.res"
parser = ResParser(res_file)
param_ids, quasi_data = parser.parse()

print("=" * 80)
print("检查 Component 的匹配顺序:")
print("=" * 80)
print()

# 直接检查文件中的 Component 顺序
with open(res_file, 'r', encoding='utf-8', errors='ignore') as f:
    lines = f.readlines()

# 找到 wheel_travel Entity 并记录 Component 的顺序
wheel_travel_components_ordered = []
in_wheel_travel = False

for i, line in enumerate(lines):
    if '<Entity' in line and 'wheel_travel' in line and '"wheel_travel"' in line:
        in_wheel_travel = True
        print(f"找到 wheel_travel Entity (行 {i+1})")
        continue
    
    if in_wheel_travel:
        if '<Component' in line:
            match = re.search(r'name="([^"]+)"[^>]*id="(\d+)"', line)
            if match:
                comp_name = match.group(1)
                comp_id = int(match.group(2))
                wheel_travel_components_ordered.append((comp_name, comp_id))
                print(f"  文件顺序 {len(wheel_travel_components_ordered)}: {comp_name} (ID {comp_id})")
        
        if '</Entity>' in line:
            break

print()
print("=" * 80)
print("Python 解析器的配置:")
print("=" * 80)
print("  component_names: ['vertical_left', 'vertical_right']")
print("  期望顺序: vertical_left (索引0), vertical_right (索引1)")
print()

print("=" * 80)
print("实际文件中的顺序:")
print("=" * 80)
for idx, (name, comp_id) in enumerate(wheel_travel_components_ordered):
    print(f"  索引 {idx}: {name} (ID {comp_id})")

print()
print("=" * 80)
print("Python 解析器的匹配结果:")
print("=" * 80)
wheel_travel_ID = parser.get_param_id('wheel_travel')
print(f"  wheel_travel_ID: {wheel_travel_ID}")
print(f"  wheel_travel_ID[0] = {wheel_travel_ID[0]} (应该是 {wheel_travel_components_ordered[0][1]} 如果按文件顺序)")
print(f"  wheel_travel_ID[1] = {wheel_travel_ID[1]} (应该是 {wheel_travel_components_ordered[1][1]} 如果按文件顺序)")
print()

# 检查是否匹配
if wheel_travel_ID[0] == wheel_travel_components_ordered[0][1] and wheel_travel_ID[1] == wheel_travel_components_ordered[1][1]:
    print("结论: Python 解析器按文件顺序匹配（正确）")
elif wheel_travel_ID[0] == wheel_travel_components_ordered[1][1] and wheel_travel_ID[1] == wheel_travel_components_ordered[0][1]:
    print("结论: Python 解析器按名称顺序匹配（可能与 MATLAB 不一致）")
    print("  需要修改为按文件顺序匹配！")
else:
    print("结论: 匹配结果异常")
