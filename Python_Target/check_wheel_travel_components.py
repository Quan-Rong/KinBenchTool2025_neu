"""检查 wheel_travel 的实际 Component 名称"""

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
param_ids, quasi = parser.parse()

# 获取 wheel_travel ID
wt_id = parser.get_param_id('wheel_travel')
print(f"wheel_travel_ID from parser: {wt_id}")
print(f"Type: {type(wt_id)}")
print()

# 检查实际文件中的 Component 名称
print("=" * 80)
print("检查 res 文件中的 wheel_travel Entity 和 Component:")
print("=" * 80)

with open(res_file, 'r', encoding='utf-8', errors='ignore') as f:
    lines = f.readlines()

in_wheel_travel = False
component_count = 0
found_entities = []

# 先找到所有包含 wheel_travel 的行
for i, line in enumerate(lines):
    if 'wheel_travel' in line.lower():
        print(f"Line {i+1}: {line.strip()[:100]}")
        if '<Entity' in line:
            found_entities.append(i)

print()
print(f"找到 {len(found_entities)} 个包含 wheel_travel 的 Entity")
print()

# 检查每个 Entity
for entity_line_idx in found_entities:
    print(f"检查 Entity (从行 {entity_line_idx+1} 开始):")
    in_entity = False
    component_count = 0
    
    for i in range(entity_line_idx, min(entity_line_idx + 50, len(lines))):
        line = lines[i]
        
        if '<Entity' in line and 'wheel_travel' in line.lower():
            in_entity = True
            print(f"  Line {i+1}: {line.strip()}")
            continue
        
        if in_entity:
            if '<Component' in line:
                component_count += 1
                match = re.search(r'name="([^"]+)"', line)
                id_match = re.search(r'id="(\d+)"', line)
                if match:
                    comp_name = match.group(1)
                    comp_id = id_match.group(1) if id_match else "N/A"
                    print(f"    Component {component_count}: name='{comp_name}', id={comp_id}")
            
            if '</Entity>' in line:
                print(f"  Line {i+1}: {line.strip()}")
                break
    print()

print()
print("=" * 80)
print("对比解析结果:")
print(f"  解析得到的 ID: {wt_id}")
print(f"  期望的 Component 名称: ['vertical_left', 'vertical_right']")
print(f"  实际找到的 Component 数量: {component_count}")
