"""找到包含 ID 775 和 776 的同一行"""
from pathlib import Path

res_file = "NRAC_G023_Results/NRAC_G023_parallel_travel.res"
res_path = Path(res_file)

# 读取文件
with open(res_path, 'r', encoding='utf-8', errors='ignore') as f:
    lines = f.readlines()

quasistatic_markers = ['"quasiStatic"', 'quasiStatic', '<Step type="quasiStatic">']

# 分析第一个分析步
i = 0
found = False

while i < len(lines) and not found:
    line = lines[i]
    line_num = i + 1
    
    if any(marker in line for marker in quasistatic_markers):
        test_data = []
        step_data_lines = []
        current_idx = 0
        
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
                    # 检查：如果该行的起始索引是 775，那么该行的第1个数字应该是ID 775，第2个数字应该是ID 776
                    if current_idx == 775:
                        print(f"找到起始索引为 775 的行: 文件行号 {data_line_num}")
                        print(f"  该行的数字: {numbers}")
                        print(f"  该行第 1 个数字 (应该是 ID 775): {numbers[0] if len(numbers) > 0 else 'N/A'}")
                        print(f"  该行第 2 个数字 (应该是 ID 776): {numbers[1] if len(numbers) > 1 else 'N/A'}")
                        
                        # 验证：检查索引 775 和 776 的值
                        if len(test_data) > 775:
                            print(f"\n  验证:")
                            print(f"    索引 775 的值 (从test_data): {test_data[775] if len(test_data) > 775 else 'N/A'}")
                            print(f"    索引 776 的值 (从test_data): {test_data[776] if len(test_data) > 776 else 'N/A'}")
                            print(f"    该行第 1 个数字: {numbers[0] if len(numbers) > 0 else 'N/A'}")
                            print(f"    该行第 2 个数字: {numbers[1] if len(numbers) > 1 else 'N/A'}")
                            
                            # 检查是否匹配
                            if len(numbers) >= 2 and len(test_data) > 776:
                                match_775 = abs(numbers[0] - test_data[775]) < 1e-10
                                match_776 = abs(numbers[1] - test_data[776]) < 1e-10
                                print(f"\n  匹配结果:")
                                print(f"    该行第 1 个数字 == 索引 775 的值: {match_775}")
                                print(f"    该行第 2 个数字 == 索引 776 的值: {match_776}")
                                if match_775 and match_776:
                                    print(f"  ✓ 确认：ID 775 应该是该行的第 1 个数字，ID 776 应该是该行的第 2 个数字")
                                    found = True
                    
                    test_data.extend(numbers)
                    step_data_lines.append((data_line_num, numbers, current_idx))
                    current_idx += len(numbers)
            except (ValueError, AttributeError):
                if test_data:
                    break
            
            i += 1
        
        if found:
            break
    else:
        i += 1

if not found:
    print("未找到起始索引为 775 的行")
    print("显示接近索引 775 的行:")
    
    # 重新分析，显示接近索引 775 的行
    i = 0
    while i < len(lines):
        line = lines[i]
        line_num = i + 1
        
        if any(marker in line for marker in quasistatic_markers):
            test_data = []
            current_idx = 0
            
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
                        # 显示接近索引 775 的行
                        if 770 <= current_idx <= 780:
                            print(f"  行 {data_line_num}: 起始索引 {current_idx}, 数字: {numbers[:5]}...")
                        
                        test_data.extend(numbers)
                        current_idx += len(numbers)
                except (ValueError, AttributeError):
                    if test_data:
                        break
                
                i += 1
            
            break
        else:
            i += 1
