"""测试正确的数据提取方式"""
import sys
from pathlib import Path
sys.path.insert(0, 'Python_Target')

from src.data.res_parser import ResParser

res_file = "NRAC_G023_Results/NRAC_G023_parallel_travel.res"
parser = ResParser(res_file)
param_ids, quasi = parser.parse()

# 获取 wheel_travel 的 ID
wheel_travel_ID = parser.get_param_id('wheel_travel')
print(f"wheel_travel IDs: {wheel_travel_ID}")
print(f"Left wheel travel ID: {wheel_travel_ID[0]} (应该是 775)")
print(f"Right wheel travel ID: {wheel_travel_ID[1]} (应该是 776)")

# 提取数据
left_data = parser.get_data_column(wheel_travel_ID[0])
right_data = parser.get_data_column(wheel_travel_ID[1])

print(f"\n第一个分析步的数据:")
print(f"  ID {wheel_travel_ID[0]} (左轮): {left_data[0]:.6f}")
print(f"  ID {wheel_travel_ID[1]} (右轮): {right_data[0]:.6f}")

# 现在检查：如果用户说 ID 775 应该是该行的第 1 个数字，ID 776 应该是该行的第 2 个数字
# 那么我们需要找到起始索引为 775 的行
print("\n" + "=" * 80)
print("验证：检查索引 775 和 776 的数据是否在同一行")
print("=" * 80)

# 读取原始文件，找到包含索引 775 和 776 的行
from src.utils.file_utils import read_file_generator

quasistatic_markers = ['"quasiStatic"', 'quasiStatic', '<Step type="quasiStatic">']
file_gen = read_file_generator(res_file)

test_data = []
step_data_lines = []
in_quasistatic = False

for line in file_gen:
    if any(marker in line for marker in quasistatic_markers):
        in_quasistatic = True
        test_data = []
        step_data_lines = []
        continue
    
    if in_quasistatic:
        if '</Step>' in line or '<Step' in line:
            break
        
        stripped = line.strip()
        if not stripped:
            continue
        
        try:
            numbers = [float(x) for x in stripped.split()]
            if numbers:
                test_data.extend(numbers)
                step_data_lines.append(numbers)
        except (ValueError, AttributeError):
            if test_data:
                break

# 找到索引 775 和 776 对应的行
current_idx = 0
line_775 = None
pos_775 = None
line_776 = None
pos_776 = None

for line_idx, numbers in enumerate(step_data_lines):
    # 检查索引 775
    if line_775 is None and current_idx <= 775 < current_idx + len(numbers):
        pos_775 = 775 - current_idx
        line_775 = line_idx
        print(f"\n索引 775 在数据行 {line_idx}, 该行第 {pos_775 + 1} 个数字")
        print(f"  该行的数字: {numbers}")
        print(f"  该行第 1 个数字: {numbers[0] if len(numbers) > 0 else 'N/A'}")
        print(f"  该行第 2 个数字: {numbers[1] if len(numbers) > 1 else 'N/A'}")
        print(f"  索引 775 对应的数字: {numbers[pos_775] if len(numbers) > pos_775 else 'N/A'}")
        print(f"  提取的 ID {wheel_travel_ID[0]} 值: {left_data[0]:.6f}")
    
    # 检查索引 776
    if line_776 is None and current_idx <= 776 < current_idx + len(numbers):
        pos_776 = 776 - current_idx
        line_776 = line_idx
        print(f"\n索引 776 在数据行 {line_idx}, 该行第 {pos_776 + 1} 个数字")
        print(f"  该行的数字: {numbers}")
        print(f"  该行第 1 个数字: {numbers[0] if len(numbers) > 0 else 'N/A'}")
        print(f"  该行第 2 个数字: {numbers[1] if len(numbers) > 1 else 'N/A'}")
        print(f"  索引 776 对应的数字: {numbers[pos_776] if len(numbers) > pos_776 else 'N/A'}")
        print(f"  提取的 ID {wheel_travel_ID[1]} 值: {right_data[0]:.6f}")
    
    if line_775 is not None and line_776 is not None:
        break
    
    current_idx += len(numbers)

print("\n" + "=" * 80)
print("结论:")
print("=" * 80)
if line_775 == line_776:
    print(f"✓ ID 775 和 776 在同一数据行: 行 {line_775}")
    if pos_775 == 0 and pos_776 == 1:
        print(f"✓ 位置正确: ID 775 是该行第 1 个数字，ID 776 是该行第 2 个数字")
    else:
        print(f"✗ 位置不正确:")
        print(f"  ID 775 实际位置: 该行第 {pos_775 + 1} 个数字")
        print(f"  ID 776 实际位置: 该行第 {pos_776 + 1} 个数字")
        print(f"\n  根据用户反馈，应该修正为:")
        print(f"  ID 775 应该是该行第 1 个数字")
        print(f"  ID 776 应该是该行第 2 个数字")
else:
    print(f"✗ ID 775 和 776 不在同一数据行:")
    print(f"  ID 775 在数据行 {line_775}, 该行第 {pos_775 + 1} 个数字")
    print(f"  ID 776 在数据行 {line_776}, 该行第 {pos_776 + 1} 个数字")
    print(f"\n  根据用户反馈，它们应该在同一行，且:")
    print(f"  ID 775 应该是该行第 1 个数字")
    print(f"  ID 776 应该是该行第 2 个数字")
