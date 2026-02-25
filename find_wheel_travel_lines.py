"""查找 left wheel travel (ID 775) 在 res 文件中的行号"""

import sys
sys.path.insert(0, 'Python_Target')

from src.data.res_parser import ResParser
from src.utils.file_utils import read_file_generator

# 解析文件
file_path = 'NRAC_G023_Results/NRAC_G023_parallel_travel.res'
parser = ResParser(file_path)
param_ids, quasi = parser.parse()

# 获取 wheel_travel 的 ID
wt_id = parser.get_param_id('wheel_travel')
print(f"wheel_travel IDs: {wt_id}")
print(f"Left wheel travel ID: {wt_id[0]} (应该是 775)")
print(f"Right wheel travel ID: {wt_id[1]} (应该是 776)")

# 现在查找这些数据在文件中的行号
print("\n查找 quasiStatic 数据段在文件中的位置...")
print("=" * 80)

quasistatic_markers = ['"quasiStatic"', 'quasiStatic', '<Step type="quasiStatic">']
file_gen = read_file_generator(file_path)

line_num = 0
quasistatic_start_line = None
data_start_line = None
data_lines = []
current_step = 0

for line in file_gen:
    line_num += 1
    
    # 检查是否是quasiStatic标记
    is_quasistatic = any(marker in line for marker in quasistatic_markers)
    if is_quasistatic and quasistatic_start_line is None:
        quasistatic_start_line = line_num
        print(f"找到 quasiStatic 标记: 第 {line_num} 行")
        print(f"  内容: {line.strip()[:100]}")
        continue
    
    # 如果已经找到 quasiStatic 标记，开始收集数据行
    if quasistatic_start_line is not None:
        # 检查是否是Step结束标记
        if '</Step>' in line or ('<Step' in line and 'type=' in line):
            if data_start_line is None:
                data_start_line = line_num
            print(f"\nStep {current_step} 结束: 第 {line_num} 行")
            print(f"  该 Step 的数据行范围: {data_start_line} - {line_num-1}")
            print(f"  数据行数: {len(data_lines)}")
            
            # 计算 ID 775 对应的列位置（0-based 索引是 774）
            col_index = wt_id[0] - 1  # ID 775 -> 索引 774
            if data_lines:
                # 显示该列的数据范围
                print(f"  Left wheel travel (ID {wt_id[0]}, 列索引 {col_index}) 的数据:")
                # 数据可能分布在多行中，需要重新组织
                all_numbers = []
                for line_num_tuple, data_line in data_lines:
                    stripped = data_line.strip()
                    if stripped:
                        try:
                            numbers = [float(x) for x in stripped.split()]
                            all_numbers.extend(numbers)
                        except:
                            pass
                
                if len(all_numbers) > col_index:
                    value = all_numbers[col_index]
                    print(f"    值: {value:.6f}")
                    
                    # 找出这个值在哪一行
                    current_pos = 0
                    for line_num_tuple, data_line in data_lines:
                        stripped = data_line.strip()
                        if stripped:
                            try:
                                numbers = [float(x) for x in stripped.split()]
                                if current_pos <= col_index < current_pos + len(numbers):
                                    offset = col_index - current_pos
                                    print(f"    位于文件第 {line_num_tuple} 行，该行的第 {offset+1} 个数字")
                                    print(f"    该行内容: {data_line[:200]}")
                                    break
                                current_pos += len(numbers)
                            except:
                                pass
                else:
                    print(f"    警告: 数据长度不足，无法访问列 {col_index}")
            
            data_lines = []
            data_start_line = None
            current_step += 1
            continue
        
        # 尝试解析为数字
        stripped = line.strip()
        if not stripped:
            continue
        
        try:
            # 尝试将整行解析为数字数组
            numbers = [float(x) for x in stripped.split()]
            if numbers:
                if data_start_line is None:
                    data_start_line = line_num
                data_lines.append((line_num, line.strip()))
        except (ValueError, AttributeError):
            # 如果解析失败，可能是数据段结束
            pass

print("\n" + "=" * 80)
print(f"总结:")
print(f"  quasiStatic 数据段起始行: {quasistatic_start_line}")
print(f"  总步数: {current_step}")
print(f"  数据矩阵形状: {quasi.shape}")
print(f"\nLeft wheel travel (ID {wt_id[0]}) 的数据范围:")
print(f"  min: {quasi[:, wt_id[0]-1].min():.6f}")
print(f"  max: {quasi[:, wt_id[0]-1].max():.6f}")
print(f"  range: {quasi[:, wt_id[0]-1].max() - quasi[:, wt_id[0]-1].min():.6f}")
