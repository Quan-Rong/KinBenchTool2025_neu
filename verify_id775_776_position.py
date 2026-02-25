"""验证 ID 775 和 776 在 res 文件行中的实际位置"""
from pathlib import Path

res_file = "NRAC_G023_Results/NRAC_G023_parallel_travel.res"
res_path = Path(res_file)

if not res_path.exists():
    print(f"文件不存在: {res_file}")
    exit(1)

target_id_775 = 775
target_id_776 = 776

# 读取文件
with open(res_path, 'r', encoding='utf-8', errors='ignore') as f:
    lines = f.readlines()

print(f"文件总行数: {len(lines)}")

# 查找 quasiStatic 标记
quasistatic_markers = ['"quasiStatic"', 'quasiStatic', '<Step type="quasiStatic">']

# 分析第一个分析步
i = 0
step_count = 0
all_steps_info = []

while i < len(lines):
    line = lines[i]
    line_num = i + 1
    
    # 检查是否是 quasiStatic 标记
    if any(marker in line for marker in quasistatic_markers):
        step_count += 1
        step_start_line = line_num
        test_data = []
        step_data_lines = []
        
        # 读取这个分析步的数据
        i += 1
        while i < len(lines):
            data_line = lines[i]
            data_line_num = i + 1
            
            if '</Step>' in data_line or (data_line_num > step_start_line + 1 and '<Step' in data_line):
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
        
        # 检查这个分析步是否有 ID 775 和 776 的数据
        if len(test_data) > target_id_776:
            value_775 = test_data[target_id_775]
            value_776 = test_data[target_id_776]
            
            # 找到 ID 775 在哪一行
            current_idx = 0
            line_775 = None
            pos_775 = None
            line_776 = None
            pos_776 = None
            
            for data_line_num, numbers in step_data_lines:
                # 检查 ID 775
                if line_775 is None and current_idx <= target_id_775 < current_idx + len(numbers):
                    pos_775 = target_id_775 - current_idx
                    line_775 = data_line_num
                
                # 检查 ID 776
                if line_776 is None and current_idx <= target_id_776 < current_idx + len(numbers):
                    pos_776 = target_id_776 - current_idx
                    line_776 = data_line_num
                
                if line_775 is not None and line_776 is not None:
                    break
                
                current_idx += len(numbers)
            
            all_steps_info.append({
                'step': step_count,
                'value_775': value_775,
                'value_776': value_776,
                'line_775': line_775,
                'pos_775': pos_775,
                'line_776': line_776,
                'pos_776': pos_776,
                'same_line': line_775 == line_776,
                'line_content': lines[line_775 - 1].strip() if line_775 else None
            })
    else:
        i += 1

# 显示前几个分析步的信息
print(f"\n共找到 {len(all_steps_info)} 个分析步")
print(f"\n前 5 个分析步的详细信息:")
for info in all_steps_info[:5]:
    print(f"\n分析步 {info['step']}:")
    print(f"  ID 775 值: {info['value_775']:.6f}")
    print(f"  ID 776 值: {info['value_776']:.6f}")
    print(f"  ID 775 位置: 文件行号 {info['line_775']}, 该行第 {info['pos_775'] + 1} 个数字 (索引 {info['pos_775']})")
    print(f"  ID 776 位置: 文件行号 {info['line_776']}, 该行第 {info['pos_776'] + 1} 个数字 (索引 {info['pos_776']})")
    print(f"  是否在同一行: {info['same_line']}")
    if info['line_content']:
        # 显示该行的前几个数字
        numbers = [float(x) for x in info['line_content'].split()]
        print(f"  该行内容 (前10个数字): {numbers[:10]}")
        if len(numbers) > info['pos_775']:
            print(f"    该行第 {info['pos_775'] + 1} 个数字 (ID 775): {numbers[info['pos_775']]}")
        if len(numbers) > info['pos_776']:
            print(f"    该行第 {info['pos_776'] + 1} 个数字 (ID 776): {numbers[info['pos_776']]}")

# 统计
same_line_count = sum(1 for info in all_steps_info if info['same_line'])
print(f"\n统计:")
print(f"  ID 775 和 776 在同一行的分析步数: {same_line_count} / {len(all_steps_info)}")
if same_line_count > 0:
    # 检查同一行时，ID 775 是否总是第 1 个，ID 776 是否总是第 2 个
    same_line_info = [info for info in all_steps_info if info['same_line']]
    pos_775_is_0 = sum(1 for info in same_line_info if info['pos_775'] == 0)
    pos_776_is_1 = sum(1 for info in same_line_info if info['pos_776'] == 1)
    print(f"  在同一行时，ID 775 是第 1 个数字的分析步数: {pos_775_is_0} / {same_line_count}")
    print(f"  在同一行时，ID 776 是第 2 个数字的分析步数: {pos_776_is_1} / {same_line_count}")
