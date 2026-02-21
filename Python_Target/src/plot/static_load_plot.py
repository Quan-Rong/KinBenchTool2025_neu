"""静态载荷测试绘图模块

提供Static Load测试（侧向力、制动力、加速力测试）的各种图表绘制功能。
"""

from typing import Optional
import numpy as np
from matplotlib.axes import Axes

from .plot_utils import (
    setup_axes_style, plot_data_curve, plot_fit_line,
    add_fit_formula_text, setup_legend, convert_matlab_color_to_python
)
from ..data import KCCalculator
from ..utils.logger import get_logger

logger = get_logger(__name__)


def plot_lateral_toe_compliance(ax_left: Axes,
                               ax_right: Axes,
                               calculator: KCCalculator,
                               fit_range: float = 1.0,
                               curve_color: Optional[str] = None,
                               fit_color: Optional[str] = None,
                               compare_count: int = 0) -> None:
    """绘制Lateral Toe Compliance图（左右对比）
    
    Args:
        ax_left: 左轮图表坐标轴
        ax_right: 右轮图表坐标轴
        calculator: K&C计算器
        fit_range: 拟合区间范围（kN）
        curve_color: 数据曲线颜色
        fit_color: 拟合线颜色
        compare_count: 对比数量
    """
    logger.debug("绘制Lateral Toe Compliance图")
    
    # 计算Lateral Toe Compliance
    result = calculator.calculate_lateral_toe_compliance(fit_range=fit_range)
    
    # 提取原始数据
    extractor = calculator.extractor
    lateral_force_left = extractor.extract_by_name('wheel_load_lateral', convert_length=False)
    lateral_force_right = extractor.extract_by_name('wheel_load_lateral', convert_length=False)
    toe_left = extractor.extract_by_name('toe_angle', convert_angle=True)
    toe_right = extractor.extract_by_name('toe_angle', convert_angle=True)
    
    # 处理多维数据
    if lateral_force_left.ndim > 1:
        lateral_force_left = lateral_force_left[:, 0]
    if lateral_force_right.ndim > 1:
        lateral_force_right = lateral_force_right[:, 1] if lateral_force_right.shape[1] > 1 else lateral_force_right[:, 0]
    if toe_left.ndim > 1:
        toe_left = toe_left[:, 0]
    if toe_right.ndim > 1:
        toe_right = toe_right[:, 1] if toe_right.shape[1] > 1 else toe_right[:, 0]
    
    # 转换为kN
    lateral_force_left_kn = lateral_force_left / 1000
    lateral_force_right_kn = lateral_force_right / 1000
    
    # 获取零位置和拟合区间
    zero_idx = result.get('zero_position_idx', len(lateral_force_left) // 2)
    fit_range_idx = int(fit_range * 100)  # 假设每kN对应100个数据点
    fit_start = max(0, zero_idx - fit_range_idx)
    fit_end = min(len(lateral_force_left), zero_idx + fit_range_idx + 1)
    
    # 获取拟合系数
    coeffs_left = np.array(result['left_coeffs'])
    coeffs_right = np.array(result['right_coeffs'])
    
    # 计算拟合值
    y_fit_left = np.polyval(coeffs_left, lateral_force_left_kn)
    y_fit_right = np.polyval(coeffs_right, lateral_force_right_kn)
    
    # 转换颜色
    curve_color = convert_matlab_color_to_python(curve_color) if curve_color else None
    fit_color = convert_matlab_color_to_python(fit_color) if fit_color else '#0000ff'
    
    # 绘制左轮
    plot_data_curve(ax_left, lateral_force_left_kn, toe_left,
                   label='Result', color=curve_color)
    plot_fit_line(ax_left, lateral_force_left_kn, y_fit_left,
                 fit_range=(lateral_force_left_kn[fit_start], lateral_force_left_kn[fit_end-1]),
                 label=f'curve fitting [{-fit_range:.1f}kN, {fit_range:.1f}kN]',
                 color=fit_color, markevery=(0, fit_end-fit_start-1))
    
    setup_axes_style(ax_left,
                    xlabel='lateral force [kN]',
                    ylabel='toe angle variation [°]',
                    title='Lateral Toe Compliance Left')
    setup_legend(ax_left)
    add_fit_formula_text(ax_left, coeffs_left, color=fit_color, compare_count=compare_count)
    
    # 绘制右轮
    plot_data_curve(ax_right, lateral_force_right_kn, toe_right,
                   label='Result', color=curve_color)
    plot_fit_line(ax_right, lateral_force_right_kn, y_fit_right,
                 fit_range=(lateral_force_right_kn[fit_start], lateral_force_right_kn[fit_end-1]),
                 label=f'curve fitting [{-fit_range:.1f}kN, {fit_range:.1f}kN]',
                 color=fit_color, markevery=(0, fit_end-fit_start-1))
    
    setup_axes_style(ax_right,
                    xlabel='lateral force [kN]',
                    ylabel='toe angle variation [°]',
                    title='Lateral Toe Compliance Right')
    setup_legend(ax_right)
    add_fit_formula_text(ax_right, coeffs_right, color=fit_color, compare_count=compare_count)


def plot_lateral_camber_compliance(ax_left: Axes,
                                 ax_right: Axes,
                                 calculator: KCCalculator,
                                 fit_range: float = 1.0,
                                 curve_color: Optional[str] = None,
                                 fit_color: Optional[str] = None,
                                 compare_count: int = 0) -> None:
    """绘制Lateral Camber Compliance图（左右对比）
    
    Args:
        ax_left: 左轮图表坐标轴
        ax_right: 右轮图表坐标轴
        calculator: K&C计算器
        fit_range: 拟合区间范围（kN）
        curve_color: 数据曲线颜色
        fit_color: 拟合线颜色
        compare_count: 对比数量
    """
    logger.debug("绘制Lateral Camber Compliance图")
    
    # 计算Lateral Camber Compliance
    result = calculator.calculate_lateral_camber_compliance(fit_range=fit_range)
    
    # 提取原始数据
    extractor = calculator.extractor
    lateral_force_left = extractor.extract_by_name('wheel_load_lateral', convert_length=False)
    lateral_force_right = extractor.extract_by_name('wheel_load_lateral', convert_length=False)
    camber_left = extractor.extract_by_name('camber_angle', convert_angle=True)
    camber_right = extractor.extract_by_name('camber_angle', convert_angle=True)
    
    # 处理多维数据
    if lateral_force_left.ndim > 1:
        lateral_force_left = lateral_force_left[:, 0]
    if lateral_force_right.ndim > 1:
        lateral_force_right = lateral_force_right[:, 1] if lateral_force_right.shape[1] > 1 else lateral_force_right[:, 0]
    if camber_left.ndim > 1:
        camber_left = camber_left[:, 0]
    if camber_right.ndim > 1:
        camber_right = camber_right[:, 1] if camber_right.shape[1] > 1 else camber_right[:, 0]
    
    # 转换为kN
    lateral_force_left_kn = lateral_force_left / 1000
    lateral_force_right_kn = lateral_force_right / 1000
    
    # 获取零位置和拟合区间
    zero_idx = result.get('zero_position_idx', len(lateral_force_left) // 2)
    fit_range_idx = int(fit_range * 100)
    fit_start = max(0, zero_idx - fit_range_idx)
    fit_end = min(len(lateral_force_left), zero_idx + fit_range_idx + 1)
    
    # 获取拟合系数
    coeffs_left = np.array(result['left_coeffs'])
    coeffs_right = np.array(result['right_coeffs'])
    
    # 计算拟合值
    y_fit_left = np.polyval(coeffs_left, lateral_force_left_kn)
    y_fit_right = np.polyval(coeffs_right, lateral_force_right_kn)
    
    # 转换颜色
    curve_color = convert_matlab_color_to_python(curve_color) if curve_color else None
    fit_color = convert_matlab_color_to_python(fit_color) if fit_color else '#0000ff'
    
    # 绘制左轮
    plot_data_curve(ax_left, lateral_force_left_kn, camber_left,
                   label='Result', color=curve_color)
    plot_fit_line(ax_left, lateral_force_left_kn, y_fit_left,
                 fit_range=(lateral_force_left_kn[fit_start], lateral_force_left_kn[fit_end-1]),
                 label=f'curve fitting [{-fit_range:.1f}kN, {fit_range:.1f}kN]',
                 color=fit_color, markevery=(0, fit_end-fit_start-1))
    
    setup_axes_style(ax_left,
                    xlabel='lateral force [kN]',
                    ylabel='camber angle variation [°]',
                    title='Lateral Camber Compliance Left')
    setup_legend(ax_left)
    add_fit_formula_text(ax_left, coeffs_left, color=fit_color, compare_count=compare_count)
    
    # 绘制右轮
    plot_data_curve(ax_right, lateral_force_right_kn, camber_right,
                   label='Result', color=curve_color)
    plot_fit_line(ax_right, lateral_force_right_kn, y_fit_right,
                 fit_range=(lateral_force_right_kn[fit_start], lateral_force_right_kn[fit_end-1]),
                 label=f'curve fitting [{-fit_range:.1f}kN, {fit_range:.1f}kN]',
                 color=fit_color, markevery=(0, fit_end-fit_start-1))
    
    setup_axes_style(ax_right,
                    xlabel='lateral force [kN]',
                    ylabel='camber angle variation [°]',
                    title='Lateral Camber Compliance Right')
    setup_legend(ax_right)
    add_fit_formula_text(ax_right, coeffs_right, color=fit_color, compare_count=compare_count)


def plot_braking_toe_compliance(ax_left: Axes,
                               ax_right: Axes,
                               calculator: KCCalculator,
                               fit_range: float = 1.0,
                               curve_color: Optional[str] = None,
                               fit_color: Optional[str] = None,
                               compare_count: int = 0) -> None:
    """绘制Braking Toe Compliance图（左右对比）
    
    Args:
        ax_left: 左轮图表坐标轴
        ax_right: 右轮图表坐标轴
        calculator: K&C计算器
        fit_range: 拟合区间范围（kN）
        curve_color: 数据曲线颜色
        fit_color: 拟合线颜色
        compare_count: 对比数量
    """
    logger.debug("绘制Braking Toe Compliance图")
    
    # 计算Braking Toe Compliance
    result = calculator.calculate_braking_toe_compliance(fit_range=fit_range)
    
    # 提取原始数据
    extractor = calculator.extractor
    braking_force_left = extractor.extract_by_name('wheel_load_longitudinal', convert_length=False)
    braking_force_right = extractor.extract_by_name('wheel_load_longitudinal', convert_length=False)
    toe_left = extractor.extract_by_name('toe_angle', convert_angle=True)
    toe_right = extractor.extract_by_name('toe_angle', convert_angle=True)
    
    # 处理多维数据（braking force有4列：brak_left, brak_right, driv_left, driv_right）
    if braking_force_left.ndim > 1:
        braking_force_left = braking_force_left[:, 0]  # brak_left
    if braking_force_right.ndim > 1:
        braking_force_right = braking_force_right[:, 1] if braking_force_right.shape[1] > 1 else braking_force_right[:, 0]  # brak_right
    if toe_left.ndim > 1:
        toe_left = toe_left[:, 0]
    if toe_right.ndim > 1:
        toe_right = toe_right[:, 1] if toe_right.shape[1] > 1 else toe_right[:, 0]
    
    # 转换为kN
    braking_force_left_kn = braking_force_left / 1000
    braking_force_right_kn = braking_force_right / 1000
    
    # 获取零位置和拟合区间
    zero_idx = result.get('zero_position_idx', len(braking_force_left) // 2)
    fit_range_idx = int(fit_range * 100)
    fit_start = max(0, zero_idx - fit_range_idx)
    fit_end = min(len(braking_force_left), zero_idx + fit_range_idx + 1)
    
    # 获取拟合系数
    coeffs_left = np.array(result['left_coeffs'])
    coeffs_right = np.array(result['right_coeffs'])
    
    # 计算拟合值
    y_fit_left = np.polyval(coeffs_left, braking_force_left_kn)
    y_fit_right = np.polyval(coeffs_right, braking_force_right_kn)
    
    # 转换颜色
    curve_color = convert_matlab_color_to_python(curve_color) if curve_color else None
    fit_color = convert_matlab_color_to_python(fit_color) if fit_color else '#0000ff'
    
    # 绘制左轮
    plot_data_curve(ax_left, braking_force_left_kn, toe_left,
                   label='Result', color=curve_color)
    plot_fit_line(ax_left, braking_force_left_kn, y_fit_left,
                 fit_range=(braking_force_left_kn[fit_start], braking_force_left_kn[fit_end-1]),
                 label=f'curve fitting [{-fit_range:.1f}kN, {fit_range:.1f}kN]',
                 color=fit_color, markevery=(0, fit_end-fit_start-1))
    
    setup_axes_style(ax_left,
                    xlabel='braking force [kN]',
                    ylabel='toe angle variation [°]',
                    title='Braking Toe Compliance Left')
    setup_legend(ax_left)
    add_fit_formula_text(ax_left, coeffs_left, color=fit_color, compare_count=compare_count)
    
    # 绘制右轮
    plot_data_curve(ax_right, braking_force_right_kn, toe_right,
                   label='Result', color=curve_color)
    plot_fit_line(ax_right, braking_force_right_kn, y_fit_right,
                 fit_range=(braking_force_right_kn[fit_start], braking_force_right_kn[fit_end-1]),
                 label=f'curve fitting [{-fit_range:.1f}kN, {fit_range:.1f}kN]',
                 color=fit_color, markevery=(0, fit_end-fit_start-1))
    
    setup_axes_style(ax_right,
                    xlabel='braking force [kN]',
                    ylabel='toe angle variation [°]',
                    title='Braking Toe Compliance Right')
    setup_legend(ax_right)
    add_fit_formula_text(ax_right, coeffs_right, color=fit_color, compare_count=compare_count)


def plot_acceleration_toe_compliance(ax_left: Axes,
                                   ax_right: Axes,
                                   calculator: KCCalculator,
                                   fit_range: float = 1.0,
                                   curve_color: Optional[str] = None,
                                   fit_color: Optional[str] = None,
                                   compare_count: int = 0) -> None:
    """绘制Acceleration Toe Compliance图（左右对比）
    
    Args:
        ax_left: 左轮图表坐标轴
        ax_right: 右轮图表坐标轴
        calculator: K&C计算器
        fit_range: 拟合区间范围（kN）
        curve_color: 数据曲线颜色
        fit_color: 拟合线颜色
        compare_count: 对比数量
    """
    logger.debug("绘制Acceleration Toe Compliance图")
    
    # 计算Acceleration Toe Compliance
    result = calculator.calculate_acceleration_toe_compliance(fit_range=fit_range)
    
    # 提取原始数据
    extractor = calculator.extractor
    acceleration_force_left = extractor.extract_by_name('wheel_load_longitudinal', convert_length=False)
    acceleration_force_right = extractor.extract_by_name('wheel_load_longitudinal', convert_length=False)
    toe_left = extractor.extract_by_name('toe_angle', convert_angle=True)
    toe_right = extractor.extract_by_name('toe_angle', convert_angle=True)
    
    # 处理多维数据（acceleration force有4列：brak_left, brak_right, driv_left, driv_right）
    if acceleration_force_left.ndim > 1:
        acceleration_force_left = acceleration_force_left[:, 2] if acceleration_force_left.shape[1] > 2 else acceleration_force_left[:, 0]  # driv_left
    if acceleration_force_right.ndim > 1:
        acceleration_force_right = acceleration_force_right[:, 3] if acceleration_force_right.shape[1] > 3 else acceleration_force_right[:, 1]  # driv_right
    if toe_left.ndim > 1:
        toe_left = toe_left[:, 0]
    if toe_right.ndim > 1:
        toe_right = toe_right[:, 1] if toe_right.shape[1] > 1 else toe_right[:, 0]
    
    # 转换为kN
    acceleration_force_left_kn = acceleration_force_left / 1000
    acceleration_force_right_kn = acceleration_force_right / 1000
    
    # 获取零位置和拟合区间
    zero_idx = result.get('zero_position_idx', len(acceleration_force_left) // 2)
    fit_range_idx = int(fit_range * 100)
    fit_start = max(0, zero_idx - fit_range_idx)
    fit_end = min(len(acceleration_force_left), zero_idx + fit_range_idx + 1)
    
    # 获取拟合系数
    coeffs_left = np.array(result['left_coeffs'])
    coeffs_right = np.array(result['right_coeffs'])
    
    # 计算拟合值
    y_fit_left = np.polyval(coeffs_left, acceleration_force_left_kn)
    y_fit_right = np.polyval(coeffs_right, acceleration_force_right_kn)
    
    # 转换颜色
    curve_color = convert_matlab_color_to_python(curve_color) if curve_color else None
    fit_color = convert_matlab_color_to_python(fit_color) if fit_color else '#0000ff'
    
    # 绘制左轮
    plot_data_curve(ax_left, acceleration_force_left_kn, toe_left,
                   label='Result', color=curve_color)
    plot_fit_line(ax_left, acceleration_force_left_kn, y_fit_left,
                 fit_range=(acceleration_force_left_kn[fit_start], acceleration_force_left_kn[fit_end-1]),
                 label=f'curve fitting [{-fit_range:.1f}kN, {fit_range:.1f}kN]',
                 color=fit_color, markevery=(0, fit_end-fit_start-1))
    
    setup_axes_style(ax_left,
                    xlabel='acceleration force [kN]',
                    ylabel='toe angle variation [°]',
                    title='Acceleration Toe Compliance Left')
    setup_legend(ax_left)
    add_fit_formula_text(ax_left, coeffs_left, color=fit_color, compare_count=compare_count)
    
    # 绘制右轮
    plot_data_curve(ax_right, acceleration_force_right_kn, toe_right,
                   label='Result', color=curve_color)
    plot_fit_line(ax_right, acceleration_force_right_kn, y_fit_right,
                 fit_range=(acceleration_force_right_kn[fit_start], acceleration_force_right_kn[fit_end-1]),
                 label=f'curve fitting [{-fit_range:.1f}kN, {fit_range:.1f}kN]',
                 color=fit_color, markevery=(0, fit_end-fit_start-1))
    
    setup_axes_style(ax_right,
                    xlabel='acceleration force [kN]',
                    ylabel='toe angle variation [°]',
                    title='Acceleration Toe Compliance Right')
    setup_legend(ax_right)
    add_fit_formula_text(ax_right, coeffs_right, color=fit_color, compare_count=compare_count)
