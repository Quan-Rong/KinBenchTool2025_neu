"""直接比较 MATLAB 和 Python 读取的 wheel_travel 原始数值"""

import sys
from pathlib import Path
import numpy as np
import re

# 添加项目路径
project_root = Path(__file__).parent.parent
sys.path.insert(0, str(project_root / "Python_Target"))

from src.data.res_parser import ResParser

# 解析文件
res_file = "../NRAC_G023_Results/NRAC_G023_parallel_travel.res"

print("=" * 80)
print("1. 模拟 MATLAB 的读取方式")
print("=" * 80)

# 模拟 MATLAB 的读取逻辑
expression = r'id="(\d+)"'

with open(res_file, 'r', encoding='utf-8', errors='ignore') as f:
    lines = f.readlines()

matlab_wheel_travel_ID = [None, None]

for i, line in enumerate(lines):
    if '"wheel_travel"' in line:
        print(f"找到 wheel_travel Entity (行 {i+1}):")
        print(f"  {line.strip()[:100]}")
        
        # 读取接下来的两行
        if i + 1 < len(lines):
            tline1 = lines[i + 1]
            match1 = re.search(expression, tline1)
            if match1:
                matlab_wheel_travel_ID[0] = int(match1.group(1))
                print(f"  MATLAB wheel_travel_ID(1) = {matlab_wheel_travel_ID[0]} (行 {i+2})")
                print(f"    {tline1.strip()[:100]}")
        
        if i + 2 < len(lines):
            tline2 = lines[i + 2]
            match2 = re.search(expression, tline2)
            if match2:
                matlab_wheel_travel_ID[1] = int(match2.group(1))
                print(f"  MATLAB wheel_travel_ID(2) = {matlab_wheel_travel_ID[1]} (行 {i+3})")
                print(f"    {tline2.strip()[:100]}")
        
        # 显示完整的 Entity 结构
        print("\n完整的 wheel_travel Entity 结构:")
        for j in range(i, min(i + 10, len(lines))):
            print(f"  行 {j+1}: {lines[j].rstrip()}")
            if '</Entity>' in lines[j]:
                break
        break

print()
print("=" * 80)
print("2. Python 解析器的读取方式")
print("=" * 80)

parser = ResParser(res_file)
param_ids, quasi_data = parser.parse()

python_wheel_travel_ID = parser.get_param_id('wheel_travel')
print(f"Python wheel_travel_ID: {python_wheel_travel_ID}")
print(f"  Python wheel_travel_ID[0] = {python_wheel_travel_ID[0]}")
print(f"  Python wheel_travel_ID[1] = {python_wheel_travel_ID[1]}")

print()
print("=" * 80)
print("3. 比较 ID 是否一致")
print("=" * 80)

if matlab_wheel_travel_ID[0] == python_wheel_travel_ID[0] and matlab_wheel_travel_ID[1] == python_wheel_travel_ID[1]:
    print("[OK] ID 完全一致")
    print(f"  MATLAB ID(1) = Python ID[0] = {matlab_wheel_travel_ID[0]}")
    print(f"  MATLAB ID(2) = Python ID[1] = {matlab_wheel_travel_ID[1]}")
elif matlab_wheel_travel_ID[0] == python_wheel_travel_ID[1] and matlab_wheel_travel_ID[1] == python_wheel_travel_ID[0]:
    print("[ERROR] ID 顺序相反！")
    print(f"  MATLAB ID(1) = {matlab_wheel_travel_ID[0]} 对应 Python ID[1] = {python_wheel_travel_ID[1]}")
    print(f"  MATLAB ID(2) = {matlab_wheel_travel_ID[1]} 对应 Python ID[0] = {python_wheel_travel_ID[0]}")
else:
    print("[ERROR] ID 不匹配！")
    print(f"  MATLAB: [{matlab_wheel_travel_ID[0]}, {matlab_wheel_travel_ID[1]}]")
    print(f"  Python: [{python_wheel_travel_ID[0]}, {python_wheel_travel_ID[1]}]")

print()
print("=" * 80)
print("4. 读取原始数据并比较数值")
print("=" * 80)

# MATLAB 方式读取的数据
matlab_left = quasi_data[:, matlab_wheel_travel_ID[0]]
matlab_right = quasi_data[:, matlab_wheel_travel_ID[1]]

# Python 方式读取的数据
python_left = quasi_data[:, python_wheel_travel_ID[0]]
python_right = quasi_data[:, python_wheel_travel_ID[1]]

print("\nMATLAB 方式读取的数据:")
print(f"  左轮 (ID {matlab_wheel_travel_ID[0]}):")
print(f"    最小值: {matlab_left.min():.6f}")
print(f"    最大值: {matlab_left.max():.6f}")
print(f"    范围: {matlab_left.max() - matlab_left.min():.6f}")
print(f"  右轮 (ID {matlab_wheel_travel_ID[1]}):")
print(f"    最小值: {matlab_right.min():.6f}")
print(f"    最大值: {matlab_right.max():.6f}")
print(f"    范围: {matlab_right.max() - matlab_right.min():.6f}")

print("\nPython 方式读取的数据:")
print(f"  左轮 (ID {python_wheel_travel_ID[0]}):")
print(f"    最小值: {python_left.min():.6f}")
print(f"    最大值: {python_left.max():.6f}")
print(f"    范围: {python_left.max() - python_left.min():.6f}")
print(f"  右轮 (ID {python_wheel_travel_ID[1]}):")
print(f"    最小值: {python_right.min():.6f}")
print(f"    最大值: {python_right.max():.6f}")
print(f"    范围: {python_right.max() - python_right.min():.6f}")

print()
print("=" * 80)
print("5. 检查数据是否匹配")
print("=" * 80)

if np.allclose(matlab_left, python_left) and np.allclose(matlab_right, python_right):
    print("[OK] 数据完全匹配")
elif np.allclose(matlab_left, python_right) and np.allclose(matlab_right, python_left):
    print("[ERROR] 数据顺序相反！左轮和右轮的数据被交换了")
    print("  这会导致右轮的数据范围异常小")
else:
    print("[ERROR] 数据不匹配")
    print(f"  MATLAB 左 vs Python 左: {np.allclose(matlab_left, python_left)}")
    print(f"  MATLAB 右 vs Python 右: {np.allclose(matlab_right, python_right)}")
    print(f"  MATLAB 左 vs Python 右: {np.allclose(matlab_left, python_right)}")
    print(f"  MATLAB 右 vs Python 左: {np.allclose(matlab_right, python_left)}")

print()
print("=" * 80)
print("6. 检查 Component 名称")
print("=" * 80)

# 查找 wheel_travel Entity 中的所有 Component
in_wheel_travel = False
components = []

for i, line in enumerate(lines):
    if '"wheel_travel"' in line and '<Entity' in line:
        in_wheel_travel = True
        continue
    
    if in_wheel_travel:
        if '<Component' in line:
            match = re.search(r'name="([^"]+)"[^>]*id="(\d+)"', line)
            if match:
                comp_name = match.group(1)
                comp_id = int(match.group(2))
                components.append((comp_name, comp_id))
                print(f"  Component: name='{comp_name}', id={comp_id}")
        
        if '</Entity>' in line:
            break

print(f"\n文件中的 Component 顺序:")
for idx, (name, comp_id) in enumerate(components):
    print(f"  顺序 {idx+1}: {name} (ID {comp_id})")
    if comp_id == matlab_wheel_travel_ID[0]:
        print(f"    -> MATLAB ID(1), Python 应该对应: {python_wheel_travel_ID[0] if comp_id == python_wheel_travel_ID[0] else '不匹配!'}")
    if comp_id == matlab_wheel_travel_ID[1]:
        print(f"    -> MATLAB ID(2), Python 应该对应: {python_wheel_travel_ID[1] if comp_id == python_wheel_travel_ID[1] else '不匹配!'}")
