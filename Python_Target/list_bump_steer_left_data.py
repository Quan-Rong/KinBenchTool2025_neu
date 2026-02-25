"""列出Bump Steer Left的样本点数据

从res文件中提取ID 775 (wheel_travel.vertical_left) 和 ID 880 (toe_angle.left)，
并显示用于拟合的样本点。
"""

import sys
from pathlib import Path

# 添加项目路径
project_root = Path(__file__).parent.parent.parent
sys.path.insert(0, str(project_root / "Python_Target"))

from src.data.res_parser import ResParser
from src.data.data_extractor import DataExtractor
from src.data.kc_calculator import KCCalculator
from src.data.unit_converter import convert_angle_array
import numpy as np


def list_bump_steer_left_data(res_file_path: str, fit_range: int = 15):
    """列出Bump Steer Left的样本点数据
    
    Args:
        res_file_path: .res文件路径
        fit_range: 拟合区间范围（mm），默认15mm
    """
    print(f"正在解析文件: {res_file_path}")
    print("=" * 80)
    
    # 解析res文件
    parser = ResParser(res_file_path)
    param_ids, quasi_data = parser.parse()
    
    # 创建数据提取器和计算器
    extractor = DataExtractor(parser)
    calculator = KCCalculator(extractor)
    
    # 获取ID
    toe_angle_ID = parser.get_param_id('toe_angle')
    wheel_travel_ID = parser.get_param_id('wheel_travel')
    
    print(f"\n参数ID:")
    print(f"  Toe Angle Left (ID 880): {toe_angle_ID[0]}")
    print(f"  Wheel Travel Left (ID 775): {wheel_travel_ID[0]}")
    print()
    
    # 从quasi数据中提取原始数据
    # ID 880: toe_angle.left (原始单位: rad)
    toe_angle_left_raw = quasi_data[:, toe_angle_ID[0]]  # 单位: rad
    
    # ID 775: wheel_travel.vertical_left (原始单位: mm)
    wheel_travel_left_raw = quasi_data[:, wheel_travel_ID[0]]  # 单位: mm
    
    # 单位换算：toe_angle从rad转为deg
    toe_angle_left_deg = convert_angle_array(toe_angle_left_raw, from_unit='rad', to_unit='deg')
    
    print(f"数据点总数: {len(toe_angle_left_deg)}")
    print()
    
    # 构建矩阵以获取Row_No（零位置索引）
    mats = calculator._build_parallel_travel_matrices()
    plot_data1 = mats['plot_data1']
    Row_No = mats['Row_No']
    
    print(f"零位置索引 (Row_No): {Row_No}")
    print(f"零位置对应的轮跳: {wheel_travel_left_raw[Row_No]:.3f} mm")
    print(f"零位置对应的Toe角: {toe_angle_left_deg[Row_No]:.6f} deg")
    print()
    
    # 计算拟合区间
    zero_idx = Row_No
    fit_start = max(0, zero_idx - fit_range)
    fit_end = min(len(toe_angle_left_deg), zero_idx + fit_range + 1)
    
    print(f"拟合区间: [{fit_start}, {fit_end})")
    print(f"拟合区间范围: {fit_end - fit_start} 个点")
    print(f"拟合区间对应的轮跳范围: [{wheel_travel_left_raw[fit_start]:.3f}, {wheel_travel_left_raw[fit_end-1]:.3f}] mm")
    print()
    print("=" * 80)
    print("用于拟合的样本点数据 (Bump Steer Left):")
    print("=" * 80)
    print(f"{'索引':<8} {'X轴 (ID 775)':<20} {'Y轴 (ID 880)':<20} {'Y轴原始(rad)':<20}")
    print(f"{'':<8} {'Wheel Travel [mm]':<20} {'Toe Angle [deg]':<20} {'Toe Angle [rad]':<20}")
    print("-" * 80)
    
    # 显示拟合区间内的所有样本点
    for idx in range(fit_start, fit_end):
        x_val = wheel_travel_left_raw[idx]  # mm
        y_val_deg = toe_angle_left_deg[idx]  # deg
        y_val_rad = toe_angle_left_raw[idx]  # rad
        
        # 标记零位置
        marker = " <-- 零位置" if idx == Row_No else ""
        
        print(f"{idx:<8} {x_val:<20.6f} {y_val_deg:<20.6f} {y_val_rad:<20.10f}{marker}")
    
    print("=" * 80)
    print()
    
    # 显示统计信息
    x_fit = wheel_travel_left_raw[fit_start:fit_end]
    y_fit = toe_angle_left_deg[fit_start:fit_end]
    
    print("拟合区间统计:")
    print(f"  X轴 (Wheel Travel) 范围: [{x_fit.min():.6f}, {x_fit.max():.6f}] mm")
    print(f"  Y轴 (Toe Angle) 范围: [{y_fit.min():.6f}, {y_fit.max():.6f}] deg")
    print(f"  X轴平均值: {x_fit.mean():.6f} mm")
    print(f"  Y轴平均值: {y_fit.mean():.6f} deg")
    print()
    
    # 计算拟合系数
    from src.utils.math_utils import linear_fit
    coeffs, _ = linear_fit(x_fit, y_fit, degree=1)
    slope_deg_per_m = coeffs[0] * 1000  # deg/m
    
    print("线性拟合结果:")
    print(f"  拟合系数: a = {coeffs[0]:.10f} deg/mm, b = {coeffs[1]:.10f} deg")
    print(f"  Bump Steer斜率: {slope_deg_per_m:.6f} deg/m")
    print()
    
    return {
        'x_data': x_fit,
        'y_data': y_fit,
        'x_data_raw': wheel_travel_left_raw[fit_start:fit_end],
        'y_data_raw_rad': toe_angle_left_raw[fit_start:fit_end],
        'fit_start': fit_start,
        'fit_end': fit_end,
        'row_no': Row_No,
        'coeffs': coeffs,
        'slope': slope_deg_per_m
    }


if __name__ == "__main__":
    import argparse
    
    parser = argparse.ArgumentParser(description="列出Bump Steer Left的样本点数据")
    parser.add_argument("res_file", type=str, help=".res文件路径")
    parser.add_argument("--fit-range", type=int, default=15, help="拟合区间范围（mm），默认15")
    
    args = parser.parse_args()
    
    if not Path(args.res_file).exists():
        print(f"错误: 文件不存在: {args.res_file}")
        sys.exit(1)
    
    try:
        list_bump_steer_left_data(args.res_file, args.fit_range)
    except Exception as e:
        print(f"错误: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)
