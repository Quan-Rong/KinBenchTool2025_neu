"""测试 wheel_travel Component 的匹配顺序"""

import sys
from pathlib import Path
import re

# 添加项目路径
project_root = Path(__file__).parent.parent
sys.path.insert(0, str(project_root / "Python_Target"))

from src.data.res_parser import ResParser

# 解析文件
res_file = "../NRAC_G023_Results/NRAC_G023_parallel_travel.res"
parser = ResParser(res_file)
param_ids, quasi_data = parser.parse()

print("=" * 80)
print("检查 wheel_travel Component 的匹配逻辑:")
print("=" * 80)
print()

# 检查解析器内部存储的 Component 信息
# 由于这是私有属性，我们需要直接检查文件

with open(res_file, 'r', encoding='utf-8', errors='ignore') as f:
    lines = f.readlines()

# 找到 wheel_travel Entity
wheel_travel_components = []
in_wheel_travel = False

for i, line in enumerate(lines):
    if '<Entity' in line and 'wheel_travel' in line and '"wheel_travel"' in line:
        in_wheel_travel = True
        print(f"找到 wheel_travel Entity (行 {i+1}):")
        print(f"  {line.strip()}")
        print()
        continue
    
    if in_wheel_travel:
        if '<Component' in line:
            match = re.search(r'name="([^"]+)"[^>]*id="(\d+)"', line)
            if match:
                comp_name = match.group(1)
                comp_id = int(match.group(2))
                wheel_travel_components.append((comp_name, comp_id))
                print(f"  Component: name='{comp_name}', id={comp_id}")
        
        if '</Entity>' in line:
            print(f"  Entity 结束 (行 {i+1})")
            break

print()
print("=" * 80)
print("Component 顺序:")
print("=" * 80)
for idx, (name, comp_id) in enumerate(wheel_travel_components):
    print(f"  索引 {idx}: {name} (ID {comp_id})")

print()
print("=" * 80)
print("Python 解析器的配置:")
print("=" * 80)
print("  component_names: ['vertical_left', 'vertical_right']")
print("  期望顺序: vertical_left (索引0), vertical_right (索引1)")
print()

print("=" * 80)
print("实际匹配结果:")
print("=" * 80)
wheel_travel_ID = parser.get_param_id('wheel_travel')
print(f"  wheel_travel_ID: {wheel_travel_ID}")
print(f"  wheel_travel_ID[0] (应该是 vertical_left): {wheel_travel_ID[0]}")
print(f"  wheel_travel_ID[1] (应该是 vertical_right): {wheel_travel_ID[1]}")

# 验证
if len(wheel_travel_components) >= 2:
    expected_left_id = wheel_travel_components[0][1] if wheel_travel_components[0][0] == 'vertical_left' else None
    expected_right_id = wheel_travel_components[1][1] if wheel_travel_components[1][0] == 'vertical_right' else None
    
    print()
    print("=" * 80)
    print("验证:")
    print("=" * 80)
    if expected_left_id == wheel_travel_ID[0]:
        print(f"  ✓ 左轮 ID 匹配正确: {wheel_travel_ID[0]}")
    else:
        print(f"  ✗ 左轮 ID 不匹配: 期望 {expected_left_id}, 实际 {wheel_travel_ID[0]}")
    
    if expected_right_id == wheel_travel_ID[1]:
        print(f"  ✓ 右轮 ID 匹配正确: {wheel_travel_ID[1]}")
    else:
        print(f"  ✗ 右轮 ID 不匹配: 期望 {expected_right_id}, 实际 {wheel_travel_ID[1]}")
