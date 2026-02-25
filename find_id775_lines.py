"""查找 ID 775 的数据在 res 文件中的行号"""
import re
from pathlib import Path

def find_id775_lines(res_file):
    """查找 ID 775 的数据在 res 文件中的行号"""
    res_path = Path(res_file)
    
    if not res_path.exists():
        print(f"文件不存在: {res_file}")
        return
    
    # ID 775 对应的是第 776 列（索引从 0 开始，所以是索引 775）
    target_id = 775
    
    # 读取文件
    with open(res_path, 'r', encoding='utf-8', errors='ignore') as f:
        lines = f.readlines()
    
    print(f"文件总行数: {len(lines)}")
    
    # 查找 quasiStatic 标记
    quasistatic_markers = ['"quasiStatic"', 'quasiStatic', '<Step type="quasiStatic">']
    quasistatic_start = None
    
    for i, line in enumerate(lines, 1):
        if any(marker in line for marker in quasistatic_markers):
            quasistatic_start = i
            print(f"\n找到 quasiStatic 标记在第 {i} 行: {line.strip()}")
            break
    
    if quasistatic_start is None:
        print("未找到 quasiStatic 标记")
        return
    
    # 从 quasiStatic 标记后开始读取数据
    data_start_line = quasistatic_start + 1
    test_data = []
    data_lines = []  # 记录包含数据的行号
    
    for i in range(data_start_line - 1, len(lines)):
        line = lines[i]
        line_num = i + 1
        
        # 检查是否是 Step 结束标记
        if '</Step>' in line or (line_num > data_start_line and '<Step' in line):
            break
        
        # 尝试解析为数字
        stripped = line.strip()
        if not stripped:
            continue
        
        try:
            numbers = [float(x) for x in stripped.split()]
            if numbers:
                test_data.extend(numbers)
                data_lines.append((line_num, numbers))
        except (ValueError, AttributeError):
            # 如果解析失败，检查是否已经有数据
            if test_data:
                break
    
    print(f"\n数据读取完成，共读取 {len(test_data)} 个数字")
    print(f"数据分布在 {len(data_lines)} 行中")
    
    # 检查是否有足够的数据
    if len(test_data) < target_id + 1:
        print(f"\n警告: 数据长度 {len(test_data)} 小于 ID {target_id} 所需的最小长度 {target_id + 1}")
        return
    
    # 找到 ID 775 对应的值
    value_at_775 = test_data[target_id]
    
    print(f"\nID {target_id} (索引 {target_id}) 的值: {value_at_775}")
    
    # 确定这个值在哪一行
    current_index = 0
    found_line = None
    
    for line_num, numbers in data_lines:
        if current_index <= target_id < current_index + len(numbers):
            # 找到了！计算在这个行中的位置
            position_in_line = target_id - current_index
            found_line = line_num
            print(f"\nID {target_id} 的数据位于:")
            print(f"  文件行号: {found_line}")
            print(f"  该行的内容: {lines[found_line - 1].strip()}")
            print(f"  在该行中的位置: 第 {position_in_line + 1} 个数字")
            print(f"  该行的所有数字: {numbers}")
            print(f"  对应的值: {numbers[position_in_line]}")
            break
        current_index += len(numbers)
    
    # 显示前几行和后几行数据行的信息
    print(f"\n前 5 行数据行信息:")
    for i, (line_num, numbers) in enumerate(data_lines[:5]):
        print(f"  行 {line_num}: {len(numbers)} 个数字, 前3个: {numbers[:3]}")
    
    if len(data_lines) > 5:
        print(f"\n后 5 行数据行信息:")
        for i, (line_num, numbers) in enumerate(data_lines[-5:], len(data_lines) - 5):
            print(f"  行 {line_num}: {len(numbers)} 个数字, 前3个: {numbers[:3]}")
    
    # 显示包含 ID 775 附近的数据
    if found_line:
        print(f"\n包含 ID {target_id} 的数据行及其前后各 2 行:")
        found_index = None
        for idx, (line_num, _) in enumerate(data_lines):
            if line_num == found_line:
                found_index = idx
                break
        
        if found_index is not None:
            start_idx = max(0, found_index - 2)
            end_idx = min(len(data_lines), found_index + 3)
            for idx in range(start_idx, end_idx):
                line_num, numbers = data_lines[idx]
                marker = " <-- ID 775 在这里" if line_num == found_line else ""
                print(f"  行 {line_num}: {numbers[:10]}... (共 {len(numbers)} 个数字){marker}")
    
    # 分析所有分析步中 ID 775 的数据
    print(f"\n分析所有分析步中 ID {target_id} 的数据位置:")
    
    # 重新解析，找到所有 quasiStatic 数据段
    step_count = 0
    all_steps_data = []
    
    with open(res_path, 'r', encoding='utf-8', errors='ignore') as f:
        lines = f.readlines()
    
    i = 0
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
            
            # 检查这个分析步是否有 ID 775 的数据
            if len(test_data) > target_id:
                value = test_data[target_id]
                # 找到这个值在哪一行
                current_idx = 0
                for data_line_num, numbers in step_data_lines:
                    if current_idx <= target_id < current_idx + len(numbers):
                        pos_in_line = target_id - current_idx
                        all_steps_data.append({
                            'step': step_count,
                            'line': data_line_num,
                            'value': value,
                            'position_in_line': pos_in_line
                        })
                        break
                    current_idx += len(numbers)
        else:
            i += 1
    
    print(f"\n共找到 {len(all_steps_data)} 个分析步包含 ID {target_id} 的数据:")
    print(f"前 10 个分析步的数据位置:")
    for step_info in all_steps_data[:10]:
        print(f"  分析步 {step_info['step']}: 文件行号 {step_info['line']}, 值 = {step_info['value']:.6f}, 在该行第 {step_info['position_in_line'] + 1} 个数字")
    
    if len(all_steps_data) > 10:
        print(f"\n后 10 个分析步的数据位置:")
        for step_info in all_steps_data[-10:]:
            print(f"  分析步 {step_info['step']}: 文件行号 {step_info['line']}, 值 = {step_info['value']:.6f}, 在该行第 {step_info['position_in_line'] + 1} 个数字")
    
    # 统计所有包含 ID 775 的行号
    unique_lines = sorted(set([info['line'] for info in all_steps_data]))
    print(f"\nID {target_id} 的数据出现在以下 {len(unique_lines)} 个不同的文件行中:")
    if len(unique_lines) <= 20:
        for line_num in unique_lines:
            # 统计这一行出现在多少个分析步中
            count = sum(1 for info in all_steps_data if info['line'] == line_num)
            print(f"  行 {line_num} (出现在 {count} 个分析步中)")
    else:
        print(f"  前 10 行: {unique_lines[:10]}")
        print(f"  后 10 行: {unique_lines[-10:]}")
        print(f"  总共 {len(unique_lines)} 行")

if __name__ == "__main__":
    res_file = "NRAC_G023_Results/NRAC_G023_parallel_travel.res"
    find_id775_lines(res_file)
