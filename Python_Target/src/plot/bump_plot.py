"""Bump测试绘图模块

提供Bump测试（轮跳测试）的各种图表绘制功能。
"""

from typing import Optional, Tuple, Dict, Any
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.axes import Axes
from matplotlib.figure import Figure

from .plot_utils import (
    setup_axes_style, plot_data_curve, plot_fit_line,
    add_fit_formula_text, add_direction_indicator, add_vertical_direction_indicator,
    setup_legend, create_comparison_figure, convert_matlab_color_to_python,
    add_custom_text
)
from ..data import DataExtractor, KCCalculator
from ..utils.logger import get_logger

logger = get_logger(__name__)


def plot_bump_steer(ax_left: Axes,
                   ax_right: Axes,
                   calculator: KCCalculator,
                   fit_range: int = 15,
                   curve_color: Optional[str] = None,
                   fit_color: Optional[str] = None,
                   compare_count: int = 0) -> None:
    """绘制Bump Steer图（左右对比）
    
    Args:
        ax_left: 左轮图表坐标轴
        ax_right: 右轮图表坐标轴
        calculator: K&C计算器
        fit_range: 拟合区间范围（mm）
        curve_color: 数据曲线颜色
        fit_color: 拟合线颜色
        compare_count: 对比数量，用于调整文本位置
    """
    logger.debug("绘制Bump Steer图")
    
    # 计算Bump Steer
    result = calculator.calculate_bump_steer(fit_range=fit_range)
    
    # 提取原始数据
    extractor = calculator.extractor
    wheel_travel_left = extractor.extract_by_name('wheel_travel', convert_length=True)
    wheel_travel_right = extractor.extract_by_name('wheel_travel', convert_length=True)
    toe_angle_left = extractor.extract_by_name('toe_angle', convert_angle=True)
    toe_angle_right = extractor.extract_by_name('toe_angle', convert_angle=True)
    
    # 处理多维数据
    if wheel_travel_left.ndim > 1:
        wheel_travel_left = wheel_travel_left[:, 1] if wheel_travel_left.shape[1] > 1 else wheel_travel_left[:, 0]
    if wheel_travel_right.ndim > 1:
        wheel_travel_right = wheel_travel_right[:, 1] if wheel_travel_right.shape[1] > 1 else wheel_travel_right[:, 0]
    if toe_angle_left.ndim > 1:
        toe_angle_left = toe_angle_left[:, 0]
    if toe_angle_right.ndim > 1:
        toe_angle_right = toe_angle_right[:, 1] if toe_angle_right.shape[1] > 1 else toe_angle_right[:, 0]
    
    # 转换为mm
    wheel_travel_left_mm = wheel_travel_left * 1000
    wheel_travel_right_mm = wheel_travel_right * 1000
    
    # 获取零位置和拟合区间
    zero_idx = result.get('zero_position_idx', len(wheel_travel_left) // 2)
    fit_start = max(0, zero_idx - fit_range)
    fit_end = min(len(wheel_travel_left), zero_idx + fit_range + 1)
    
    # 获取拟合系数
    coeffs_left = np.array(result['left_coeffs'])
    coeffs_right = np.array(result['right_coeffs'])
    
    # 计算拟合值
    y_fit_left = np.polyval(coeffs_left, wheel_travel_left_mm)
    y_fit_right = np.polyval(coeffs_right, wheel_travel_right_mm)
    
    # 转换颜色
    curve_color = convert_matlab_color_to_python(curve_color) if curve_color else None
    fit_color = convert_matlab_color_to_python(fit_color) if fit_color else '#0000ff'
    
    # 绘制左轮
    plot_data_curve(ax_left, wheel_travel_left_mm, toe_angle_left,
                   label='Result', color=curve_color)
    plot_fit_line(ax_left, wheel_travel_left_mm, y_fit_left,
                 fit_range=(wheel_travel_left_mm[fit_start], wheel_travel_left_mm[fit_end-1]),
                 label=f'curve fitting [{-2*fit_range}mm, {2*fit_range}mm]',
                 color=fit_color, markevery=(0, fit_end-fit_start-1))
    
    setup_axes_style(ax_left,
                    xlabel='@WC vertical travel [mm]',
                    ylabel='toe angle variation [°]',
                    title='Bump Steer Left')
    setup_legend(ax_left)
    add_fit_formula_text(ax_left, coeffs_left, color=fit_color, compare_count=compare_count)
    add_direction_indicator(ax_left, 'bump_rebound')
    add_vertical_direction_indicator(ax_left, 'toe')
    
    # 绘制右轮
    plot_data_curve(ax_right, wheel_travel_right_mm, toe_angle_right,
                   label='Result', color=curve_color)
    plot_fit_line(ax_right, wheel_travel_right_mm, y_fit_right,
                 fit_range=(wheel_travel_right_mm[fit_start], wheel_travel_right_mm[fit_end-1]),
                 label=f'curve fitting [{-2*fit_range}mm, {2*fit_range}mm]',
                 color=fit_color, markevery=(0, fit_end-fit_start-1))
    
    setup_axes_style(ax_right,
                    xlabel='@WC vertical travel [mm]',
                    ylabel='toe angle variation [°]',
                    title='Bump Steer Right')
    setup_legend(ax_right)
    add_fit_formula_text(ax_right, coeffs_right, color=fit_color, compare_count=compare_count)
    add_direction_indicator(ax_right, 'bump_rebound')
    add_vertical_direction_indicator(ax_right, 'toe')


def plot_bump_camber(ax_left: Axes,
                     ax_right: Axes,
                     calculator: KCCalculator,
                     fit_range: int = 15,
                     curve_color: Optional[str] = None,
                     fit_color: Optional[str] = None,
                     compare_count: int = 0) -> None:
    """绘制Bump Camber图（左右对比）
    
    Args:
        ax_left: 左轮图表坐标轴
        ax_right: 右轮图表坐标轴
        calculator: K&C计算器
        fit_range: 拟合区间范围（mm）
        curve_color: 数据曲线颜色
        fit_color: 拟合线颜色
        compare_count: 对比数量
    """
    logger.debug("绘制Bump Camber图")
    
    # 计算Bump Camber
    result = calculator.calculate_bump_camber(fit_range=fit_range)
    
    # 提取原始数据
    extractor = calculator.extractor
    wheel_travel_left = extractor.extract_by_name('wheel_travel', convert_length=True)
    wheel_travel_right = extractor.extract_by_name('wheel_travel', convert_length=True)
    camber_left = extractor.extract_by_name('camber_angle', convert_angle=True)
    camber_right = extractor.extract_by_name('camber_angle', convert_angle=True)
    
    # 处理多维数据
    if wheel_travel_left.ndim > 1:
        wheel_travel_left = wheel_travel_left[:, 1] if wheel_travel_left.shape[1] > 1 else wheel_travel_left[:, 0]
    if wheel_travel_right.ndim > 1:
        wheel_travel_right = wheel_travel_right[:, 1] if wheel_travel_right.shape[1] > 1 else wheel_travel_right[:, 0]
    if camber_left.ndim > 1:
        camber_left = camber_left[:, 0]
    if camber_right.ndim > 1:
        camber_right = camber_right[:, 1] if camber_right.shape[1] > 1 else camber_right[:, 0]
    
    # 转换为mm
    wheel_travel_left_mm = wheel_travel_left * 1000
    wheel_travel_right_mm = wheel_travel_right * 1000
    
    # 获取零位置和拟合区间
    zero_idx = result.get('zero_position_idx', len(wheel_travel_left) // 2)
    fit_start = max(0, zero_idx - fit_range)
    fit_end = min(len(wheel_travel_left), zero_idx + fit_range + 1)
    
    # 获取拟合系数
    coeffs_left = np.array(result['left_coeffs'])
    coeffs_right = np.array(result['right_coeffs'])
    
    # 计算拟合值
    y_fit_left = np.polyval(coeffs_left, wheel_travel_left_mm)
    y_fit_right = np.polyval(coeffs_right, wheel_travel_right_mm)
    
    # 转换颜色
    curve_color = convert_matlab_color_to_python(curve_color) if curve_color else None
    fit_color = convert_matlab_color_to_python(fit_color) if fit_color else '#0000ff'
    
    # 绘制左轮
    plot_data_curve(ax_left, wheel_travel_left_mm, camber_left,
                   label='Result', color=curve_color)
    plot_fit_line(ax_left, wheel_travel_left_mm, y_fit_left,
                 fit_range=(wheel_travel_left_mm[fit_start], wheel_travel_left_mm[fit_end-1]),
                 label=f'curve fitting [{-2*fit_range}mm, {2*fit_range}mm]',
                 color=fit_color, markevery=(0, fit_end-fit_start-1))
    
    setup_axes_style(ax_left,
                    xlabel='@WC vertical travel [mm]',
                    ylabel='camber angle variation [°]',
                    title='Bump Camber Left')
    setup_legend(ax_left)
    add_fit_formula_text(ax_left, coeffs_left, color=fit_color, compare_count=compare_count)
    add_direction_indicator(ax_left, 'bump_rebound')
    add_vertical_direction_indicator(ax_left, 'camber')
    
    # 绘制右轮
    plot_data_curve(ax_right, wheel_travel_right_mm, camber_right,
                   label='Result', color=curve_color)
    plot_fit_line(ax_right, wheel_travel_right_mm, y_fit_right,
                 fit_range=(wheel_travel_right_mm[fit_start], wheel_travel_right_mm[fit_end-1]),
                 label=f'curve fitting [{-2*fit_range}mm, {2*fit_range}mm]',
                 color=fit_color, markevery=(0, fit_end-fit_start-1))
    
    setup_axes_style(ax_right,
                    xlabel='@WC vertical travel [mm]',
                    ylabel='camber angle variation [°]',
                    title='Bump Camber Right')
    setup_legend(ax_right)
    add_fit_formula_text(ax_right, coeffs_right, color=fit_color, compare_count=compare_count)
    add_direction_indicator(ax_right, 'bump_rebound')
    add_vertical_direction_indicator(ax_right, 'camber')


def plot_wheel_rate(ax_left: Axes,
                   ax_right: Axes,
                   calculator: KCCalculator,
                   fit_range: int = 15,
                   curve_color: Optional[str] = None,
                   fit_color: Optional[str] = None,
                   compare_count: int = 0) -> None:
    """绘制Wheel Rate图（左右对比）
    
    Args:
        ax_left: 左轮图表坐标轴
        ax_right: 右轮图表坐标轴
        calculator: K&C计算器
        fit_range: 拟合区间范围（mm），注意Wheel Rate使用固定30mm范围
        curve_color: 数据曲线颜色
        fit_color: 拟合线颜色
        compare_count: 对比数量
    """
    logger.debug("绘制Wheel Rate图")
    
    # 计算Wheel Rate（使用固定30mm范围）
    result = calculator.calculate_wheel_rate(fit_range=30)
    
    # 提取原始数据
    extractor = calculator.extractor
    wheel_travel_left = extractor.extract_by_name('wheel_travel', convert_length=True)
    wheel_travel_right = extractor.extract_by_name('wheel_travel', convert_length=True)
    wheel_rate_left = extractor.extract_by_name('wheel_rate', convert_length=False)  # 已经是N/mm
    wheel_rate_right = extractor.extract_by_name('wheel_rate', convert_length=False)
    
    # 处理多维数据
    if wheel_travel_left.ndim > 1:
        wheel_travel_left = wheel_travel_left[:, 1] if wheel_travel_left.shape[1] > 1 else wheel_travel_left[:, 0]
    if wheel_travel_right.ndim > 1:
        wheel_travel_right = wheel_travel_right[:, 1] if wheel_travel_right.shape[1] > 1 else wheel_travel_right[:, 0]
    if wheel_rate_left.ndim > 1:
        wheel_rate_left = wheel_rate_left[:, 0]
    if wheel_rate_right.ndim > 1:
        wheel_rate_right = wheel_rate_right[:, 1] if wheel_rate_right.shape[1] > 1 else wheel_rate_right[:, 0]
    
    # 转换为mm
    wheel_travel_left_mm = wheel_travel_left * 1000
    wheel_travel_right_mm = wheel_travel_right * 1000
    
    # 获取零位置和拟合区间（固定30mm）
    zero_idx = result.get('zero_position_idx', len(wheel_travel_left) // 2)
    fit_range_fixed = 30
    fit_start = max(0, zero_idx - fit_range_fixed)
    fit_end = min(len(wheel_travel_left), zero_idx + fit_range_fixed + 1)
    
    # 获取拟合系数
    coeffs_left = np.array(result['left_coeffs'])
    coeffs_right = np.array(result['right_coeffs'])
    
    # 计算拟合值
    y_fit_left = np.polyval(coeffs_left, wheel_travel_left_mm)
    y_fit_right = np.polyval(coeffs_right, wheel_travel_right_mm)
    
    # 转换颜色
    curve_color = convert_matlab_color_to_python(curve_color) if curve_color else None
    fit_color = convert_matlab_color_to_python(fit_color) if fit_color else '#0000ff'
    
    # 绘制左轮
    plot_data_curve(ax_left, wheel_travel_left_mm, wheel_rate_left,
                   label='Result', color=curve_color)
    plot_fit_line(ax_left, wheel_travel_left_mm, y_fit_left,
                 fit_range=(wheel_travel_left_mm[fit_start], wheel_travel_left_mm[fit_end-1]),
                 label='curve fitting [-30mm,30mm]',
                 color=fit_color, markevery=(0, fit_end-fit_start-1))
    
    setup_axes_style(ax_left,
                    xlabel='@WC vertical travel [mm]',
                    ylabel='Wheel Rate [N/mm]',
                    title='Instant. Wheel Rate Left')
    setup_legend(ax_left)
    
    # 添加文本：Wheel Rate change
    slope_text = f"Wheel Rate change = {coeffs_left[0]:.4f} N/mm/mm"
    add_custom_text(ax_left, slope_text, (0.5, 0.6 + 0.1 * compare_count),
                   color=fit_color)
    add_direction_indicator(ax_left, 'bump_rebound')
    
    # 绘制右轮
    plot_data_curve(ax_right, wheel_travel_right_mm, wheel_rate_right,
                   label='Result', color=curve_color)
    plot_fit_line(ax_right, wheel_travel_right_mm, y_fit_right,
                 fit_range=(wheel_travel_right_mm[fit_start], wheel_travel_right_mm[fit_end-1]),
                 label='curve fitting [-30mm,30mm]',
                 color=fit_color, markevery=(0, fit_end-fit_start-1))
    
    setup_axes_style(ax_right,
                    xlabel='@WC vertical travel [mm]',
                    ylabel='Wheel Rate [N/mm]',
                    title='Instant. Wheel Rate Right')
    setup_legend(ax_right)
    
    slope_text = f"Wheel Rate change = {coeffs_right[0]:.4f} N/mm/mm"
    add_custom_text(ax_right, slope_text, (0.5, 0.6 + 0.1 * compare_count),
                   color=fit_color)
    add_direction_indicator(ax_right, 'bump_rebound')


def plot_wheel_recession(ax_left: Axes,
                        ax_right: Axes,
                        calculator: KCCalculator,
                        fit_range: int = 15,
                        curve_color: Optional[str] = None,
                        fit_color: Optional[str] = None,
                        compare_count: int = 0) -> None:
    """绘制Wheel Recession图（左右对比）
    
    Args:
        ax_left: 左轮图表坐标轴
        ax_right: 右轮图表坐标轴
        calculator: K&C计算器
        fit_range: 拟合区间范围（mm）
        curve_color: 数据曲线颜色
        fit_color: 拟合线颜色
        compare_count: 对比数量
    """
    logger.debug("绘制Wheel Recession图")
    
    # 计算Wheel Recession
    result = calculator.calculate_wheel_recession(fit_range=fit_range)
    
    # 提取原始数据
    extractor = calculator.extractor
    wheel_travel_left = extractor.extract_by_name('wheel_travel', convert_length=True)
    wheel_travel_right = extractor.extract_by_name('wheel_travel', convert_length=True)
    wheel_base_left = extractor.extract_by_name('wheel_travel_base', convert_length=True)
    wheel_base_right = extractor.extract_by_name('wheel_travel_base', convert_length=True)
    
    # 处理多维数据
    if wheel_travel_left.ndim > 1:
        wheel_travel_left = wheel_travel_left[:, 1] if wheel_travel_left.shape[1] > 1 else wheel_travel_left[:, 0]
    if wheel_travel_right.ndim > 1:
        wheel_travel_right = wheel_travel_right[:, 1] if wheel_travel_right.shape[1] > 1 else wheel_travel_right[:, 0]
    if wheel_base_left.ndim > 1:
        wheel_base_left = wheel_base_left[:, 0]
    if wheel_base_right.ndim > 1:
        wheel_base_right = wheel_base_right[:, 1] if wheel_base_right.shape[1] > 1 else wheel_base_right[:, 0]
    
    # 转换为mm
    wheel_travel_left_mm = wheel_travel_left * 1000
    wheel_travel_right_mm = wheel_travel_right * 1000
    wheel_base_left_mm = wheel_base_left * 1000
    wheel_base_right_mm = wheel_base_right * 1000
    
    # 获取零位置和拟合区间
    zero_idx = result.get('zero_position_idx', len(wheel_travel_left) // 2)
    fit_start = max(0, zero_idx - fit_range)
    fit_end = min(len(wheel_travel_left), zero_idx + fit_range + 1)
    
    # 获取拟合系数
    coeffs_left = np.array(result['left_coeffs'])
    coeffs_right = np.array(result['right_coeffs'])
    
    # 计算拟合值
    y_fit_left = np.polyval(coeffs_left, wheel_travel_left_mm)
    y_fit_right = np.polyval(coeffs_right, wheel_travel_right_mm)
    
    # 转换颜色
    curve_color = convert_matlab_color_to_python(curve_color) if curve_color else None
    fit_color = convert_matlab_color_to_python(fit_color) if fit_color else '#0000ff'
    
    # 绘制左轮
    plot_data_curve(ax_left, wheel_travel_left_mm, wheel_base_left_mm,
                   label='Result', color=curve_color)
    plot_fit_line(ax_left, wheel_travel_left_mm, y_fit_left,
                 fit_range=(wheel_travel_left_mm[fit_start], wheel_travel_left_mm[fit_end-1]),
                 label=f'curve fitting [{-2*fit_range}mm, {2*fit_range}mm]',
                 color=fit_color, markevery=(0, fit_end-fit_start-1))
    
    setup_axes_style(ax_left,
                    xlabel='@WC vertical travel [mm]',
                    ylabel='wheel recession (wheel centre X disp.) [mm]',
                    title='Wheel Recession Left')
    setup_legend(ax_left)
    add_fit_formula_text(ax_left, coeffs_left, color=fit_color, compare_count=compare_count)
    add_direction_indicator(ax_left, 'bump_rebound')
    add_vertical_direction_indicator(ax_left, 'wheel_base')
    
    # 绘制右轮
    plot_data_curve(ax_right, wheel_travel_right_mm, wheel_base_right_mm,
                   label='Result', color=curve_color)
    plot_fit_line(ax_right, wheel_travel_right_mm, y_fit_right,
                 fit_range=(wheel_travel_right_mm[fit_start], wheel_travel_right_mm[fit_end-1]),
                 label=f'curve fitting [{-2*fit_range}mm, {2*fit_range}mm]',
                 color=fit_color, markevery=(0, fit_end-fit_start-1))
    
    setup_axes_style(ax_right,
                    xlabel='@WC vertical travel [mm]',
                    ylabel='wheel recession (wheel centre X disp.) [mm]',
                    title='Wheel Recession Right')
    setup_legend(ax_right)
    add_fit_formula_text(ax_right, coeffs_right, color=fit_color, compare_count=compare_count)
    add_direction_indicator(ax_right, 'bump_rebound')
    add_vertical_direction_indicator(ax_right, 'wheel_base')


def plot_track_change(ax_left: Axes,
                     ax_right: Axes,
                     calculator: KCCalculator,
                     fit_range: int = 15,
                     curve_color: Optional[str] = None,
                     fit_color: Optional[str] = None,
                     compare_count: int = 0) -> None:
    """绘制Track Change图（左右对比）
    
    Args:
        ax_left: 左轮图表坐标轴
        ax_right: 右轮图表坐标轴
        calculator: K&C计算器
        fit_range: 拟合区间范围（mm）
        curve_color: 数据曲线颜色
        fit_color: 拟合线颜色
        compare_count: 对比数量
    """
    logger.debug("绘制Track Change图")
    
    # 计算Track Change
    result = calculator.calculate_track_change(fit_range=fit_range)
    
    # 提取原始数据
    extractor = calculator.extractor
    wheel_travel_left = extractor.extract_by_name('wheel_travel', convert_length=True)
    wheel_travel_right = extractor.extract_by_name('wheel_travel', convert_length=True)
    wheel_track_left = extractor.extract_by_name('wheel_travel_track', convert_length=True)
    wheel_track_right = extractor.extract_by_name('wheel_travel_track', convert_length=True)
    
    # 处理多维数据
    if wheel_travel_left.ndim > 1:
        wheel_travel_left = wheel_travel_left[:, 1] if wheel_travel_left.shape[1] > 1 else wheel_travel_left[:, 0]
    if wheel_travel_right.ndim > 1:
        wheel_travel_right = wheel_travel_right[:, 1] if wheel_travel_right.shape[1] > 1 else wheel_travel_right[:, 0]
    if wheel_track_left.ndim > 1:
        wheel_track_left = wheel_track_left[:, 0]
    if wheel_track_right.ndim > 1:
        wheel_track_right = wheel_track_right[:, 1] if wheel_track_right.shape[1] > 1 else wheel_track_right[:, 0]
    
    # 转换为mm
    wheel_travel_left_mm = wheel_travel_left * 1000
    wheel_travel_right_mm = wheel_travel_right * 1000
    wheel_track_left_mm = wheel_track_left * 1000
    wheel_track_right_mm = wheel_track_right * 1000
    
    # 获取零位置和拟合区间
    zero_idx = result.get('zero_position_idx', len(wheel_travel_left) // 2)
    fit_start = max(0, zero_idx - fit_range)
    fit_end = min(len(wheel_travel_left), zero_idx + fit_range + 1)
    
    # 获取拟合系数
    coeffs_left = np.array(result['left_coeffs'])
    coeffs_right = np.array(result['right_coeffs'])
    
    # 计算拟合值
    y_fit_left = np.polyval(coeffs_left, wheel_travel_left_mm)
    y_fit_right = np.polyval(coeffs_right, wheel_travel_right_mm)
    
    # 转换颜色
    curve_color = convert_matlab_color_to_python(curve_color) if curve_color else None
    fit_color = convert_matlab_color_to_python(fit_color) if fit_color else '#0000ff'
    
    # 绘制左轮
    plot_data_curve(ax_left, wheel_travel_left_mm, wheel_track_left_mm,
                   label='Result', color=curve_color)
    plot_fit_line(ax_left, wheel_travel_left_mm, y_fit_left,
                 fit_range=(wheel_travel_left_mm[fit_start], wheel_travel_left_mm[fit_end-1]),
                 label=f'curve fitting [{-2*fit_range}mm, {2*fit_range}mm]',
                 color=fit_color, markevery=(0, fit_end-fit_start-1))
    
    setup_axes_style(ax_left,
                    xlabel='@WC vertical travel [mm]',
                    ylabel='track change (wheel centre Y disp.) [mm]',
                    title='Track Change Left')
    setup_legend(ax_left)
    add_fit_formula_text(ax_left, coeffs_left, color=fit_color, compare_count=compare_count)
    add_direction_indicator(ax_left, 'bump_rebound')
    
    # 绘制右轮
    plot_data_curve(ax_right, wheel_travel_right_mm, wheel_track_right_mm,
                   label='Result', color=curve_color)
    plot_fit_line(ax_right, wheel_travel_right_mm, y_fit_right,
                 fit_range=(wheel_travel_right_mm[fit_start], wheel_travel_right_mm[fit_end-1]),
                 label=f'curve fitting [{-2*fit_range}mm, {2*fit_range}mm]',
                 color=fit_color, markevery=(0, fit_end-fit_start-1))
    
    setup_axes_style(ax_right,
                    xlabel='@WC vertical travel [mm]',
                    ylabel='track change (wheel centre Y disp.) [mm]',
                    title='Track Change Right')
    setup_legend(ax_right)
    add_fit_formula_text(ax_right, coeffs_right, color=fit_color, compare_count=compare_count)
    add_direction_indicator(ax_right, 'bump_rebound')
