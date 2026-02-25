"""验证正确的 ID 775 和 776 位置"""
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
        print("验证：如果 ID 775 是该行的第 1 个数字，ID 776 是该行的第 2 个数字")
        print("=" * 80)
        
        # 找到起始索引为 775 的行
        current_idx = 0
        found_line = None
        
        for data_line_num, numbers in step_data_lines:
            # 检查：如果该行的起始索引是 775，那么该行的第 1 个数字应该是 ID 775
            if current_idx == 775:
                found_line = data_line_num
                print(f"\n找到起始索引为 775 的行: 行 {data_line_num}")
                print(f"  该行的数字: {numbers}")
                print(f"  该行第 1 个数字: {numbers[0] if len(numbers) > 0 else 'N/A'}")
                print(f"  该行第 2 个数字: {numbers[1] if len(numbers) > 1 else 'N/A'}")
                print(f"\n  验证:")
                print(f"    如果该行第 1 个数字是 ID 775: {numbers[0] if len(numbers) > 0 else 'N/A'}")
                print(f"    如果该行第 2 个数字是 ID 776: {numbers[1] if len(numbers) > 1 else 'N/A'}")
                print(f"\n  当前脚本计算的 ID 775 值: {test_data[775] if len(test_data) > 775 else 'N/A'}")
                print(f"  当前脚本计算的 ID 776 值: {test_data[776] if len(test_data) > 776 else 'N/A'}")
                
                # 检查是否匹配
                if len(numbers) >= 2 and len(test_data) > 776:
                    match_775 = abs(numbers[0] - test_data[775]) < 1e-10
                    match_776 = abs(numbers[1] - test_data[776]) < 1e-10
                    print(f"\n  匹配结果:")
                    print(f"    行第 1 个数字 == ID 775 值: {match_775}")
                    print(f"    行第 2 个数字 == ID 776 值: {match_776}")
                    if match_775 and match_776:
                        print(f"  ✓ 确认：ID 775 是该行的第 1 个数字，ID 776 是该行的第 2 个数字")
                    else:
                        print(f"  ✗ 不匹配，需要检查索引计算")
                break
            
            current_idx += len(numbers)
        
        if found_line is None:
            print("\n未找到起始索引为 775 的行")
            # 显示所有行的起始索引
            print("\n所有数据行的起始索引:")
            current_idx = 0
            for data_line_num, numbers in step_data_lines[:20]:  # 只显示前20行
                print(f"  行 {data_line_num}: 起始索引 {current_idx}, 长度 {len(numbers)}")
                current_idx += len(numbers)
        
        break
    else:
        i += 1
