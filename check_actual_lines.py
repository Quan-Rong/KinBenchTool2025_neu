"""检查包含 ID 775 和 776 的实际行内容"""
from pathlib import Path

res_file = "NRAC_G023_Results/NRAC_G023_parallel_travel.res"
res_path = Path(res_file)

# 读取文件
with open(res_path, 'r', encoding='utf-8', errors='ignore') as f:
    lines = f.readlines()

# 检查行 2212 和 2213（第一个分析步中 ID 775 和 776 的位置）
print("=" * 80)
print("检查第一个分析步中 ID 775 和 776 所在的行:")
print("=" * 80)

line_2212 = lines[2211]  # 索引从 0 开始
line_2213 = lines[2212]

print(f"\n行 2212 (ID 775 所在行):")
print(f"  内容: {line_2212.strip()}")
numbers_2212 = [float(x) for x in line_2212.strip().split()]
print(f"  数字: {numbers_2212}")
print(f"  第 1 个数字: {numbers_2212[0] if len(numbers_2212) > 0 else 'N/A'}")
print(f"  第 2 个数字: {numbers_2212[1] if len(numbers_2212) > 1 else 'N/A'}")

print(f"\n行 2213 (ID 776 所在行):")
print(f"  内容: {line_2213.strip()}")
numbers_2213 = [float(x) for x in line_2213.strip().split()]
print(f"  数字: {numbers_2213}")
print(f"  第 1 个数字: {numbers_2213[0] if len(numbers_2213) > 0 else 'N/A'}")
print(f"  第 2 个数字: {numbers_2213[1] if len(numbers_2213) > 1 else 'N/A'}")

# 检查前后几行
print(f"\n前后各 3 行的内容:")
for i in range(2209, min(2216, len(lines))):
    line = lines[i]
    numbers = [float(x) for x in line.strip().split()] if line.strip() else []
    marker = ""
    if i == 2211:
        marker = " <-- ID 775 在这里 (第2个数字)"
    if i == 2212:
        marker = " <-- ID 776 在这里 (第1个数字)"
    print(f"  行 {i+1}: {numbers[:5]}... (共 {len(numbers)} 个数字){marker}")

# 现在检查：如果 ID 775 应该是该行的第 1 个数字，那么该行的起始索引应该是 775
# 让我们找到起始索引为 775 的行
print("\n" + "=" * 80)
print("重新分析：如果 ID 775 应该是该行的第 1 个数字（索引 0）")
print("=" * 80)

quasistatic_markers = ['"quasiStatic"', 'quasiStatic', '<Step type="quasiStatic">']

# 分析第一个分析步
i = 0
while i < len(lines):
    line = lines[i]
    line_num = i + 1
    
    if any(marker in line for marker in quasistatic_markers):
        test_data = []
        step_data_lines = []
        
        i += 1
        while i < len(lines):
            data_line = lines[i]
            data_line_num = i + 1
            
            if '</Step>' in data_line or (data_line_num > line_num + 1 and '<Step' in data_line):
                break
            
            stripped = data_line.strip()
            if not stripped:
                i += 1
                continue
            
            try:
                numbers = [float(x) for x in stripped.split()]
                if numbers:
                    test_data.extend(numbers)
                    step_data_lines.append((data_line_num, numbers))
            except (ValueError, AttributeError):
                if test_data:
                    break
            
            i += 1
        
        # 找到起始索引为 775 的行（即该行的第一个数字是索引 775）
        current_idx = 0
        for data_line_num, numbers in step_data_lines:
            if current_idx == 775:
                print(f"\n找到起始索引为 775 的行: 行 {data_line_num}")
                print(f"  该行的数字: {numbers[:5]}... (共 {len(numbers)} 个数字)")
                print(f"  第 1 个数字 (应该是 ID 775): {numbers[0] if len(numbers) > 0 else 'N/A'}")
                print(f"  第 2 个数字 (应该是 ID 776): {numbers[1] if len(numbers) > 1 else 'N/A'}")
                print(f"  实际 ID 775 的值: {test_data[775] if len(test_data) > 775 else 'N/A'}")
                print(f"  实际 ID 776 的值: {test_data[776] if len(test_data) > 776 else 'N/A'}")
                break
            current_idx += len(numbers)
        
        break
    else:
        i += 1
