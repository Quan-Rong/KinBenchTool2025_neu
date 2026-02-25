"""检查 MATLAB 代码实际读取的行，看看它提取的 ID 是什么"""

import re
from pathlib import Path

res_file = "../NRAC_G023_Results/NRAC_G023_parallel_travel.res"

# 模拟 MATLAB 的读取逻辑
expression = r'id="(\d+)"'

with open(res_file, 'r', encoding='utf-8', errors='ignore') as f:
    lines = f.readlines()

print("=" * 80)
print("模拟 MATLAB 代码的读取逻辑:")
print("=" * 80)
print()

# 找到包含 "wheel_travel" 的行
for i, line in enumerate(lines):
    if '"wheel_travel"' in line or (i > 0 and 'wheel_travel' in line and '<Entity' in line):
        print(f"找到 wheel_travel Entity 行 (行 {i+1}):")
        print(f"  {line.strip()}")
        print()
        
        # 模拟 MATLAB: 读取接下来的两行
        if i + 1 < len(lines):
            tline1 = lines[i + 1]
            print(f"tline1 (行 {i+2}): {tline1.strip()}")
            match1 = re.search(expression, tline1)
            if match1:
                id1 = match1.group(1)
                print(f"  提取的 ID(1): {id1}")
            print()
        
        if i + 2 < len(lines):
            tline2 = lines[i + 2]
            print(f"tline2 (行 {i+3}): {tline2.strip()}")
            match2 = re.search(expression, tline2)
            if match2:
                id2 = match2.group(1)
                print(f"  提取的 ID(2): {id2}")
            print()
        
        # 显示完整的 Entity 结构
        print("完整的 Entity 结构:")
        for j in range(i, min(i + 10, len(lines))):
            print(f"  行 {j+1}: {lines[j].rstrip()}")
            if '</Entity>' in lines[j]:
                break
        print()
        break

print("=" * 80)
print("对比 Python 解析器的结果:")
print("  Python 解析器得到的 ID: [775, 776]")
print("  对应 Component: vertical_left (775), vertical_right (776)")
print()
