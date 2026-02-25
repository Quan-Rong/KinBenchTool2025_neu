"""找到索引 775 和 776 对应的行"""
from pathlib import Path

res_file = "NRAC_G023_Results/NRAC_G023_parallel_travel.res"
res_path = Path(res_file)

# 读取文件
with open(res_path, 'r', encoding='utf-8', errors='ignore') as f:
    lines = f.readlines()

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
        
        print("=" * 80)
        print("找到索引 775 和 776 对应的行")
        print("=" * 80)
        
        # 找到索引 775 和 776 对应的行
        current_idx = 0
        line_775 = None
        pos_775 = None
        line_776 = None
        pos_776 = None
        
        for data_line_num, numbers in step_data_lines:
            # 检查索引 775
            if line_775 is None and current_idx <= 775 < current_idx + len(numbers):
                pos_775 = 775 - current_idx
                line_775 = data_line_num
                print(f"\n索引 775 在行 {data_line_num}, 该行第 {pos_775 + 1} 个数字 (索引 {pos_775})")
                print(f"  该行的数字: {numbers}")
                print(f"  该行第 1 个数字: {numbers[0] if len(numbers) > 0 else 'N/A'}")
                print(f"  该行第 2 个数字: {numbers[1] if len(numbers) > 1 else 'N/A'}")
                print(f"  索引 775 对应的数字: {numbers[pos_775] if len(numbers) > pos_775 else 'N/A'}")
                print(f"  当前脚本计算的 ID 775 值: {test_data[775] if len(test_data) > 775 else 'N/A'}")
            
            # 检查索引 776
            if line_776 is None and current_idx <= 776 < current_idx + len(numbers):
                pos_776 = 776 - current_idx
                line_776 = data_line_num
                print(f"\n索引 776 在行 {data_line_num}, 该行第 {pos_776 + 1} 个数字 (索引 {pos_776})")
                print(f"  该行的数字: {numbers}")
                print(f"  该行第 1 个数字: {numbers[0] if len(numbers) > 0 else 'N/A'}")
                print(f"  该行第 2 个数字: {numbers[1] if len(numbers) > 1 else 'N/A'}")
                print(f"  索引 776 对应的数字: {numbers[pos_776] if len(numbers) > pos_776 else 'N/A'}")
                print(f"  当前脚本计算的 ID 776 值: {test_data[776] if len(test_data) > 776 else 'N/A'}")
            
            if line_775 is not None and line_776 is not None:
                break
            
            current_idx += len(numbers)
        
        # 现在检查：如果用户说 ID 775 应该是该行的第 1 个数字，ID 776 应该是该行的第 2 个数字
        # 那么它们应该在同一行，且该行的起始索引应该是 775
        print("\n" + "=" * 80)
        print("用户说：ID 775 应该是该行的第 1 个数字，ID 776 应该是该行的第 2 个数字")
        print("=" * 80)
        
        if line_775 == line_776:
            print(f"\n✓ ID 775 和 776 在同一行: 行 {line_775}")
            if pos_775 == 0 and pos_776 == 1:
                print(f"✓ 位置正确: ID 775 是第 1 个数字，ID 776 是第 2 个数字")
            else:
                print(f"✗ 位置不正确:")
                print(f"  ID 775 实际位置: 第 {pos_775 + 1} 个数字")
                print(f"  ID 776 实际位置: 第 {pos_776 + 1} 个数字")
        else:
            print(f"\n✗ ID 775 和 776 不在同一行:")
            print(f"  ID 775 在行 {line_775}, 第 {pos_775 + 1} 个数字")
            print(f"  ID 776 在行 {line_776}, 第 {pos_776 + 1} 个数字")
            print(f"\n  这意味着索引计算可能有问题")
            print(f"  如果它们应该在同一行，那么该行的起始索引应该是 775")
            print(f"  让我们检查起始索引为 775 的行:")
            
            # 找到起始索引为 775 的行
            current_idx = 0
            for data_line_num, numbers in step_data_lines:
                if current_idx == 775:
                    print(f"\n  找到起始索引为 775 的行: 行 {data_line_num}")
                    print(f"    该行的数字: {numbers}")
                    print(f"    该行第 1 个数字 (应该是 ID 775): {numbers[0] if len(numbers) > 0 else 'N/A'}")
                    print(f"    该行第 2 个数字 (应该是 ID 776): {numbers[1] if len(numbers) > 1 else 'N/A'}")
                    print(f"    实际 ID 775 值: {test_data[775] if len(test_data) > 775 else 'N/A'}")
                    print(f"    实际 ID 776 值: {test_data[776] if len(test_data) > 776 else 'N/A'}")
                    break
                current_idx += len(numbers)
        
        break
    else:
        i += 1
