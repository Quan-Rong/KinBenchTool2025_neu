"""检查 ID 1621 和 1622 对应的实际参数"""

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
print("检查 ID 1621 和 1622 对应的参数:")
print("=" * 80)
print()

# 检查所有参数的 ID
all_params = parser.param_ids
for param_name, ids in all_params.items():
    if isinstance(ids, (list, tuple)):
        if 1621 in ids or 1622 in ids:
            print(f"找到: {param_name} = {ids}")
            if 1621 in ids:
                idx = ids.index(1621)
                print(f"  ID 1621 是 {param_name} 的第 {idx+1} 个分量")
            if 1622 in ids:
                idx = ids.index(1622)
                print(f"  ID 1622 是 {param_name} 的第 {idx+1} 个分量")
            print()
    elif ids == 1621 or ids == 1622:
        print(f"找到: {param_name} = {ids}")
        print()

# 直接检查 res 文件中的 ID 1621 和 1622
print("=" * 80)
print("直接检查 res 文件中 ID 1621 和 1622 的 Component:")
print("=" * 80)
print()

with open(res_file, 'r', encoding='utf-8', errors='ignore') as f:
    lines = f.readlines()

for i, line in enumerate(lines):
    if 'id="1621"' in line or 'id="1622"' in line:
        # 找到包含这个 ID 的行，显示上下文
        start = max(0, i - 5)
        end = min(len(lines), i + 5)
        print(f"找到 ID 在行 {i+1}:")
        for j in range(start, end):
            marker = ">>> " if j == i else "    "
            print(f"{marker}行 {j+1}: {lines[j].rstrip()}")
        print()
