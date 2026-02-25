"""Bump测试绘图模块

提供Bump测试（轮跳测试）的各种图表绘制功能。
"""

from typing import Optional, Tuple, Dict, Any
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.axes import Axes
from matplotlib.figure import Figure

from .plot_utils import (
    setup_axes_style, plot_data_curve, plot_fit_line, plot_sample_points,
    add_fit_formula_text, add_direction_indicator, add_vertical_direction_indicator,
    setup_legend, create_comparison_figure, convert_matlab_color_to_python,
    add_custom_text, get_compare_style
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
                   compare_count: int = 0,
                   linestyle: Optional[str] = None,
                   marker: Optional[str] = None,
                   show_sample_points_left: bool = False,
                   show_sample_points_right: bool = False) -> None:
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
    wheel_travel_left, wheel_travel_right = extractor.extract_wheel_travel_left_right(convert_length=True)
    toe_angle_left = extractor.extract_by_name('toe_angle', convert_angle=True)
    toe_angle_right = extractor.extract_by_name('toe_angle', convert_angle=True)
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
    
    # 如果compare_count > 0，使用对比样式（灰色曲线+蓝色拟合线）
    if compare_count > 0:
        compare_style = get_compare_style(compare_count)
        curve_color = compare_style['curve_color']  # 灰色
        fit_color = compare_style['fit_color']      # 蓝色
        curve_linestyle = compare_style['curve_linestyle']
        fit_linestyle = compare_style['fit_linestyle']
        fit_marker = 'o'  # 对比结果的拟合线使用默认标记
    else:
        # 转换颜色（仅当compare_count=0时）
        curve_color = convert_matlab_color_to_python(curve_color) if curve_color else None
        fit_color = convert_matlab_color_to_python(fit_color) if fit_color else None
        curve_linestyle = '-'
        fit_linestyle = '-'
        fit_marker = 'o'
    
    # 如果明确指定了linestyle和marker，使用指定的值（仅当compare_count=0时）
    if compare_count == 0:
        if linestyle is not None:
            curve_linestyle = linestyle
            fit_linestyle = linestyle
        if marker is not None:
            fit_marker = marker
    
    # 绘制左轮
    plot_data_curve(ax_left, wheel_travel_left_mm, toe_angle_left,
                   label='Result', color=curve_color, linestyle=curve_linestyle)
    plot_fit_line(ax_left, wheel_travel_left_mm, y_fit_left,
                 fit_range=(wheel_travel_left_mm[fit_start], wheel_travel_left_mm[fit_end-1]),
                 label=f'curve fitting [{-2*fit_range}mm, {2*fit_range}mm]',
                 color=fit_color, markevery=(0, fit_end-fit_start-1),
                 linestyle=fit_linestyle, marker=fit_marker)
    if show_sample_points_left:
        plot_sample_points(ax_left, wheel_travel_left_mm, toe_angle_left,
                          fit_start, fit_end, color=curve_color)
    
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
                   label='Result', color=curve_color, linestyle=curve_linestyle)
    plot_fit_line(ax_right, wheel_travel_right_mm, y_fit_right,
                 fit_range=(wheel_travel_right_mm[fit_start], wheel_travel_right_mm[fit_end-1]),
                 label=f'curve fitting [{-2*fit_range}mm, {2*fit_range}mm]',
                 color=fit_color, markevery=(0, fit_end-fit_start-1),
                 linestyle=fit_linestyle, marker=fit_marker)
    if show_sample_points_right:
        plot_sample_points(ax_right, wheel_travel_right_mm, toe_angle_right,
                          fit_start, fit_end, color=curve_color)
    
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
                     compare_count: int = 0,
                     show_sample_points_left: bool = False,
                     show_sample_points_right: bool = False) -> None:
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
    wheel_travel_left, wheel_travel_right = extractor.extract_wheel_travel_left_right(convert_length=True)
    camber_left = extractor.extract_by_name('camber_angle', convert_angle=True)
    camber_right = extractor.extract_by_name('camber_angle', convert_angle=True)
    
    # wheel_travel已经通过extract_wheel_travel_left_right处理为一维数组
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
    
    # 如果compare_count > 0，使用对比样式（灰色曲线+蓝色拟合线）
    if compare_count > 0:
        compare_style = get_compare_style(compare_count)
        curve_color = compare_style['curve_color']  # 灰色
        fit_color = compare_style['fit_color']      # 蓝色
        curve_linestyle = compare_style['curve_linestyle']
        fit_linestyle = compare_style['fit_linestyle']
    else:
        # 转换颜色（仅当compare_count=0时）
        curve_color = convert_matlab_color_to_python(curve_color) if curve_color else None
        fit_color = convert_matlab_color_to_python(fit_color) if fit_color else None
        curve_linestyle = '-'
        fit_linestyle = '-'
    
    # 绘制左轮
    plot_data_curve(ax_left, wheel_travel_left_mm, camber_left,
                   label='Result', color=curve_color, linestyle=curve_linestyle)
    plot_fit_line(ax_left, wheel_travel_left_mm, y_fit_left,
                 fit_range=(wheel_travel_left_mm[fit_start], wheel_travel_left_mm[fit_end-1]),
                 label=f'curve fitting [{-2*fit_range}mm, {2*fit_range}mm]',
                 color=fit_color, markevery=(0, fit_end-fit_start-1),
                 linestyle=fit_linestyle)
    if show_sample_points_left:
        plot_sample_points(ax_left, wheel_travel_left_mm, camber_left,
                          fit_start, fit_end, color=curve_color)
    
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
                   label='Result', color=curve_color, linestyle=curve_linestyle)
    plot_fit_line(ax_right, wheel_travel_right_mm, y_fit_right,
                 fit_range=(wheel_travel_right_mm[fit_start], wheel_travel_right_mm[fit_end-1]),
                 label=f'curve fitting [{-2*fit_range}mm, {2*fit_range}mm]',
                 color=fit_color, markevery=(0, fit_end-fit_start-1),
                 linestyle=fit_linestyle)
    if show_sample_points_right:
        plot_sample_points(ax_right, wheel_travel_right_mm, camber_right,
                          fit_start, fit_end, color=curve_color)
    
    setup_axes_style(ax_right,
                    xlabel='@WC vertical travel [mm]',
                    ylabel='camber angle variation [°]',
                    title='Bump Camber Right')
    setup_legend(ax_right)
    add_fit_formula_text(ax_right, coeffs_right, color=fit_color, compare_count=compare_count)
    add_direction_indicator(ax_right, 'bump_rebound')
    add_vertical_direction_indicator(ax_right, 'camber')


def plot_wheel_rate_slope(ax_left: Axes,
                         ax_right: Axes,
                         calculator: KCCalculator,
                         fit_range: int = 15,  # 保留参数以保持兼容性，但此图使用固定30mm范围
                         curve_color: Optional[str] = None,
                         fit_color: Optional[str] = None,
                         compare_count: int = 0,
                         show_sample_points_left: bool = False,
                         show_sample_points_right: bool = False) -> None:
    """绘制Wheel Rate Slope@WC图（左右对比）
    
    对应MATLAB的Wheel Rate图，显示wheel_travel vs wheel_rate
    
    Args:
        ax_left: 左轮图表坐标轴
        ax_right: 右轮图表坐标轴
        calculator: K&C计算器
        fit_range: 拟合区间范围（mm），保留参数以保持兼容性，但此图使用固定30mm范围（Row_No-15:Row_No+15）
        curve_color: 数据曲线颜色
        fit_color: 拟合线颜色
        compare_count: 对比数量
        show_sample_points_left: 是否显示左轮采样点
        show_sample_points_right: 是否显示右轮采样点
    """
    logger.debug("绘制Wheel Rate Slope@WC图")
    
    # 从plot_data1提取数据，与MATLAB一致
    # MATLAB: Susp_parallel_travel_plot_data1(:,17)和(:,18)作为X轴，(:,13)和(:,14)作为Y轴
    mats = calculator._build_parallel_travel_matrices()
    plot_data1 = mats['plot_data1']
    Row_No = mats['Row_No']
    
    # X轴：列16-17（@WC vertical travel [mm]）- 对应MATLAB的列17-18（1-based）
    wheel_travel_left_mm = plot_data1[:, 16]
    wheel_travel_right_mm = plot_data1[:, 17]
    
    # Y轴：列12-13（wheel_rate [N/mm]）- 对应MATLAB的列13-14（1-based）
    wheel_rate_left = plot_data1[:, 12]
    wheel_rate_right = plot_data1[:, 13]
    
    # MATLAB使用固定30mm范围（Row_No-15:Row_No+15），忽略fit_range参数
    fit_range_fixed = 15
    fit_start = max(0, Row_No - fit_range_fixed)
    fit_end = min(len(wheel_travel_left_mm), Row_No + fit_range_fixed + 1)
    
    # 左轮拟合
    x_left_fit = wheel_travel_left_mm[fit_start:fit_end]
    y_left_fit = wheel_rate_left[fit_start:fit_end]
    from ..utils.math_utils import linear_fit
    coeffs_left, _ = linear_fit(x_left_fit, y_left_fit, degree=1)
    
    # 右轮拟合
    x_right_fit = wheel_travel_right_mm[fit_start:fit_end]
    y_right_fit = wheel_rate_right[fit_start:fit_end]
    coeffs_right, _ = linear_fit(x_right_fit, y_right_fit, degree=1)
    
    # 计算拟合值 - 只在拟合区间内计算，与MATLAB一致
    y_fit_left = np.polyval(coeffs_left, x_left_fit)
    y_fit_right = np.polyval(coeffs_right, x_right_fit)
    
    # 如果compare_count > 0，使用对比样式（灰色曲线+蓝色拟合线）
    if compare_count > 0:
        compare_style = get_compare_style(compare_count)
        curve_color = compare_style['curve_color']  # 灰色
        fit_color = compare_style['fit_color']      # 蓝色
        curve_linestyle = compare_style['curve_linestyle']
        fit_linestyle = compare_style['fit_linestyle']
    else:
        # 转换颜色（仅当compare_count=0时）
        curve_color = convert_matlab_color_to_python(curve_color) if curve_color else None
        fit_color = convert_matlab_color_to_python(fit_color) if fit_color else [0, 0, 1]  # 默认蓝色
        curve_linestyle = '-'
        fit_linestyle = '-'
    
    # 绘制左轮
    plot_data_curve(ax_left, wheel_travel_left_mm, wheel_rate_left,
                   label='Result', color=curve_color, linewidth=1.5, linestyle=curve_linestyle)
    # 拟合线只在拟合区间内绘制，与MATLAB一致
    # MATLAB: MarkerIndices=[1 31] 表示第一个和最后一个点
    plot_fit_line(ax_left, x_left_fit, y_fit_left,
                 fit_range=(x_left_fit[0], x_left_fit[-1]),
                 label='curve fitting [-30mm,30mm]',
                 color=fit_color, markevery=(0, len(x_left_fit)-1), marker='o', marker_size=8,
                 linestyle=fit_linestyle)
    if show_sample_points_left:
        plot_sample_points(ax_left, wheel_travel_left_mm, wheel_rate_left,
                          fit_start, fit_end, color=curve_color)
    
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
                   label='Result', color=curve_color, linewidth=1.5, linestyle=curve_linestyle)
    # 拟合线只在拟合区间内绘制，与MATLAB一致
    plot_fit_line(ax_right, x_right_fit, y_fit_right,
                 fit_range=(x_right_fit[0], x_right_fit[-1]),
                 label='curve fitting [-30mm,30mm]',
                 color=fit_color, markevery=(0, len(x_right_fit)-1), marker='o', marker_size=8,
                 linestyle=fit_linestyle)
    if show_sample_points_right:
        plot_sample_points(ax_right, wheel_travel_right_mm, wheel_rate_right,
                          fit_start, fit_end, color=curve_color)
    
    setup_axes_style(ax_right,
                    xlabel='@WC vertical travel [mm]',
                    ylabel='Wheel Rate [N/mm]',
                    title='Instant. Wheel Rate Right')
    setup_legend(ax_right)
    
    slope_text = f"Wheel Rate change = {coeffs_right[0]:.4f} N/mm/mm"
    add_custom_text(ax_right, slope_text, (0.5, 0.6 + 0.1 * compare_count),
                   color=fit_color)
    add_direction_indicator(ax_right, 'bump_rebound')


def plot_wheel_rate_wc(ax_left: Axes,
                       ax_right: Axes,
                       calculator: KCCalculator,
                       fit_range: int = 15,
                       curve_color: Optional[str] = None,
                       fit_color: Optional[str] = None,
                       compare_count: int = 0,
                       show_sample_points_left: bool = False,
                       show_sample_points_right: bool = False) -> None:
    """绘制Wheel Rate@WC图（左右对比）
    
    对应MATLAB的vertical force change图，显示wheel_travel vs wheel_load_vertical_force
    
    Args:
        ax_left: 左轮图表坐标轴
        ax_right: 右轮图表坐标轴
        calculator: K&C计算器
        fit_range: 拟合区间范围（mm），对应app.EditField_R_bump_range.Value
        curve_color: 数据曲线颜色
        fit_color: 拟合线颜色
        compare_count: 对比数量
        show_sample_points_left: 是否显示左轮采样点
        show_sample_points_right: 是否显示右轮采样点
    """
    logger.debug("绘制Wheel Rate@WC图")
    
    # 从plot_data1提取数据，与MATLAB一致
    # MATLAB: Susp_parallel_travel_plot_data1(:,17)和(:,18)作为X轴，(:,19)和(:,20)作为Y轴
    mats = calculator._build_parallel_travel_matrices()
    plot_data1 = mats['plot_data1']
    Row_No = mats['Row_No']
    
    # X轴：列16-17（@WC vertical travel [mm]）- 对应MATLAB的列17-18（1-based）
    wheel_travel_left_mm = plot_data1[:, 16]
    wheel_travel_right_mm = plot_data1[:, 17]
    
    # Y轴：列18-19（wheel_load_vertical_force [N]）- 对应MATLAB的列19-20（1-based）
    wheel_load_left = plot_data1[:, 18]
    wheel_load_right = plot_data1[:, 19]
    
    # MATLAB使用fit_range（Row_No-app.EditField_R_bump_range.Value:Row_No+app.EditField_R_bump_range.Value）
    fit_start = max(0, Row_No - fit_range)
    fit_end = min(len(wheel_travel_left_mm), Row_No + fit_range + 1)
    
    # 左轮拟合
    x_left_fit = wheel_travel_left_mm[fit_start:fit_end]
    y_left_fit = wheel_load_left[fit_start:fit_end]
    from ..utils.math_utils import linear_fit
    coeffs_left, _ = linear_fit(x_left_fit, y_left_fit, degree=1)
    
    # 右轮拟合
    x_right_fit = wheel_travel_right_mm[fit_start:fit_end]
    y_right_fit = wheel_load_right[fit_start:fit_end]
    coeffs_right, _ = linear_fit(x_right_fit, y_right_fit, degree=1)
    
    # 计算拟合值 - 只在拟合区间内计算，与MATLAB一致
    y_fit_left = np.polyval(coeffs_left, x_left_fit)
    y_fit_right = np.polyval(coeffs_right, x_right_fit)
    
    # 如果compare_count > 0，使用对比样式（灰色曲线+蓝色拟合线）
    if compare_count > 0:
        compare_style = get_compare_style(compare_count)
        curve_color = compare_style['curve_color']  # 灰色
        fit_color = compare_style['fit_color']      # 蓝色
        curve_linestyle = compare_style['curve_linestyle']
        fit_linestyle = compare_style['fit_linestyle']
    else:
        # 转换颜色（仅当compare_count=0时）
        curve_color = convert_matlab_color_to_python(curve_color) if curve_color else None
        fit_color = convert_matlab_color_to_python(fit_color) if fit_color else None
        curve_linestyle = '-'
        fit_linestyle = '-'
    
    # 绘制左轮
    plot_data_curve(ax_left, wheel_travel_left_mm, wheel_load_left,
                   label='Result', color=curve_color, linewidth=1.5, linestyle=curve_linestyle)
    # 拟合线只在拟合区间内绘制，与MATLAB一致
    # MATLAB: MarkerIndices=[1 (2*app.EditField_R_bump_range.Value+1)]
    fit_range_display = 2 * fit_range
    plot_fit_line(ax_left, x_left_fit, y_fit_left,
                 fit_range=(x_left_fit[0], x_left_fit[-1]),
                 label=f'curve fitting [{-fit_range_display}mm, {fit_range_display}mm]',
                 color=fit_color, markevery=(0, len(x_left_fit)-1), marker='o', marker_size=12,
                 linestyle=fit_linestyle)
    if show_sample_points_left:
        plot_sample_points(ax_left, wheel_travel_left_mm, wheel_load_left,
                          fit_start, fit_end, color=curve_color)
    
    setup_axes_style(ax_left,
                    xlabel='@WC vertical travel [mm]',
                    ylabel='wheel load [N]',
                    title='Wheel Rate Left')
    setup_legend(ax_left)
    
    # 添加文本：拟合公式 y = slope*x + intercept
    formula_text = f"y = {coeffs_left[0]:.4f}*x+{coeffs_left[1]:.4f}"
    add_custom_text(ax_left, formula_text, (0.5, 0.6 + 0.1 * compare_count),
                   color=fit_color)
    add_direction_indicator(ax_left, 'bump_rebound')
    
    # 绘制右轮
    plot_data_curve(ax_right, wheel_travel_right_mm, wheel_load_right,
                   label='Result', color=curve_color, linewidth=1.5, linestyle=curve_linestyle)
    # 拟合线只在拟合区间内绘制，与MATLAB一致
    plot_fit_line(ax_right, x_right_fit, y_fit_right,
                 fit_range=(x_right_fit[0], x_right_fit[-1]),
                 label=f'curve fitting [{-fit_range_display}mm, {fit_range_display}mm]',
                 color=fit_color, markevery=(0, len(x_right_fit)-1), marker='o', marker_size=12,
                 linestyle=fit_linestyle)
    if show_sample_points_right:
        plot_sample_points(ax_right, wheel_travel_right_mm, wheel_load_right,
                          fit_start, fit_end, color=curve_color)
    
    setup_axes_style(ax_right,
                    xlabel='@WC vertical travel [mm]',
                    ylabel='wheel load [N]',
                    title='Wheel Rate Right')
    setup_legend(ax_right)
    
    formula_text = f"y = {coeffs_right[0]:.4f}*x+{coeffs_right[1]:.4f}"
    add_custom_text(ax_right, formula_text, (0.5, 0.6 + 0.1 * compare_count),
                   color=fit_color)
    add_direction_indicator(ax_right, 'bump_rebound')


def plot_wheel_recession(ax_left: Axes,
                        ax_right: Axes,
                        calculator: KCCalculator,
                        fit_range: int = 15,
                        curve_color: Optional[str] = None,
                        fit_color: Optional[str] = None,
                        compare_count: int = 0,
                        show_sample_points_left: bool = False,
                        show_sample_points_right: bool = False) -> None:
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
    wheel_travel_left, wheel_travel_right = extractor.extract_wheel_travel_left_right(convert_length=True)
    wheel_base_left = extractor.extract_by_name('wheel_travel_base', convert_length=True)
    wheel_base_right = extractor.extract_by_name('wheel_travel_base', convert_length=True)
    
    # wheel_travel已经通过extract_wheel_travel_left_right处理为一维数组
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
    
    # 如果compare_count > 0，使用对比样式（灰色曲线+蓝色拟合线）
    if compare_count > 0:
        compare_style = get_compare_style(compare_count)
        curve_color = compare_style['curve_color']  # 灰色
        fit_color = compare_style['fit_color']      # 蓝色
        curve_linestyle = compare_style['curve_linestyle']
        fit_linestyle = compare_style['fit_linestyle']
    else:
        # 转换颜色（仅当compare_count=0时）
        curve_color = convert_matlab_color_to_python(curve_color) if curve_color else None
        fit_color = convert_matlab_color_to_python(fit_color) if fit_color else None
        curve_linestyle = '-'
        fit_linestyle = '-'
    
    # 绘制左轮
    plot_data_curve(ax_left, wheel_travel_left_mm, wheel_base_left_mm,
                   label='Result', color=curve_color, linestyle=curve_linestyle)
    plot_fit_line(ax_left, wheel_travel_left_mm, y_fit_left,
                 fit_range=(wheel_travel_left_mm[fit_start], wheel_travel_left_mm[fit_end-1]),
                 label=f'curve fitting [{-2*fit_range}mm, {2*fit_range}mm]',
                 color=fit_color, markevery=(0, fit_end-fit_start-1),
                 linestyle=fit_linestyle)
    if show_sample_points_left:
        plot_sample_points(ax_left, wheel_travel_left_mm, wheel_base_left_mm,
                          fit_start, fit_end, color=curve_color)
    
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
                   label='Result', color=curve_color, linestyle=curve_linestyle)
    plot_fit_line(ax_right, wheel_travel_right_mm, y_fit_right,
                 fit_range=(wheel_travel_right_mm[fit_start], wheel_travel_right_mm[fit_end-1]),
                 label=f'curve fitting [{-2*fit_range}mm, {2*fit_range}mm]',
                 color=fit_color, markevery=(0, fit_end-fit_start-1),
                 linestyle=fit_linestyle)
    if show_sample_points_right:
        plot_sample_points(ax_right, wheel_travel_right_mm, wheel_base_right_mm,
                          fit_start, fit_end, color=curve_color)
    
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
                     compare_count: int = 0,
                     show_sample_points_left: bool = False,
                     show_sample_points_right: bool = False) -> None:
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
    
    # 从plot_data1提取数据，与MATLAB一致
    # MATLAB: Susp_parallel_travel_plot_data1(:,17)和(:,18)作为X轴，(:,7)和(:,8)作为Y轴
    mats = calculator._build_parallel_travel_matrices()
    plot_data1 = mats['plot_data1']
    
    # X轴：列16-17（@WC vertical travel [mm]）- 对应MATLAB的列17-18（1-based）
    wheel_travel_left_mm = plot_data1[:, 16]
    wheel_travel_right_mm = plot_data1[:, 17]
    
    # Y轴：列6-7（wheel_travel_track，wheel centre Y disp. [mm]）- 对应MATLAB的列7-8（1-based）
    wheel_centre_y_left_mm = plot_data1[:, 6]
    wheel_centre_y_right_mm = plot_data1[:, 7]
    
    # 获取零位置和拟合区间
    zero_idx = result.get('zero_position_idx', len(wheel_travel_left_mm) // 2)
    fit_start = max(0, zero_idx - fit_range)
    fit_end = min(len(wheel_travel_left_mm), zero_idx + fit_range + 1)
    
    # 获取拟合系数
    coeffs_left = np.array(result['left_coeffs'])
    coeffs_right = np.array(result['right_coeffs'])
    
    # 计算拟合值 - 只在拟合区间内计算，与MATLAB一致
    x_fit_left = wheel_travel_left_mm[fit_start:fit_end]
    x_fit_right = wheel_travel_right_mm[fit_start:fit_end]
    y_fit_left = np.polyval(coeffs_left, x_fit_left)
    y_fit_right = np.polyval(coeffs_right, x_fit_right)
    
    # 如果compare_count > 0，使用对比样式（灰色曲线+蓝色拟合线）
    if compare_count > 0:
        compare_style = get_compare_style(compare_count)
        curve_color = compare_style['curve_color']  # 灰色
        fit_color = compare_style['fit_color']      # 蓝色
        curve_linestyle = compare_style['curve_linestyle']
        fit_linestyle = compare_style['fit_linestyle']
    else:
        # 转换颜色（仅当compare_count=0时）
        curve_color = convert_matlab_color_to_python(curve_color) if curve_color else None
        fit_color = convert_matlab_color_to_python(fit_color) if fit_color else None
        curve_linestyle = '-'
        fit_linestyle = '-'
    
    # 绘制左轮
    plot_data_curve(ax_left, wheel_travel_left_mm, wheel_centre_y_left_mm,
                   label='Result', color=curve_color, linestyle=curve_linestyle)
    # 拟合线只在拟合区间内绘制，与MATLAB一致
    plot_fit_line(ax_left, x_fit_left, y_fit_left,
                 fit_range=(x_fit_left[0], x_fit_left[-1]),
                 label=f'curve fitting [{-2*fit_range}mm, {2*fit_range}mm]',
                 color=fit_color, markevery=(0, len(x_fit_left)-1),
                 linestyle=fit_linestyle)
    if show_sample_points_left:
        plot_sample_points(ax_left, wheel_travel_left_mm, wheel_centre_y_left_mm,
                          fit_start, fit_end, color=curve_color)
    
    setup_axes_style(ax_left,
                    xlabel='@WC vertical travel [mm]',
                    ylabel='wheel centre Y disp. [mm]',
                    title='Lateral Wheel Centre Displacement Left')
    setup_legend(ax_left)
    add_fit_formula_text(ax_left, coeffs_left, color=fit_color, compare_count=compare_count)
    add_direction_indicator(ax_left, 'bump_rebound')
    
    # 绘制右轮
    plot_data_curve(ax_right, wheel_travel_right_mm, wheel_centre_y_right_mm,
                   label='Result', color=curve_color, linestyle=curve_linestyle)
    # 拟合线只在拟合区间内绘制，与MATLAB一致
    plot_fit_line(ax_right, x_fit_right, y_fit_right,
                 fit_range=(x_fit_right[0], x_fit_right[-1]),
                 label=f'curve fitting [{-2*fit_range}mm, {2*fit_range}mm]',
                 color=fit_color, markevery=(0, len(x_fit_right)-1),
                 linestyle=fit_linestyle)
    if show_sample_points_right:
        plot_sample_points(ax_right, wheel_travel_right_mm, wheel_centre_y_right_mm,
                          fit_start, fit_end, color=curve_color)
    
    setup_axes_style(ax_right,
                    xlabel='@WC vertical travel [mm]',
                    ylabel='wheel centre Y disp. [mm]',
                    title='Lateral Wheel Centre Displacement Right')
    setup_legend(ax_right)
    add_fit_formula_text(ax_right, coeffs_right, color=fit_color, compare_count=compare_count)
    add_direction_indicator(ax_right, 'bump_rebound')


def plot_bump_caster(ax_left: Axes,
                     ax_right: Axes,
                     calculator: KCCalculator,
                     fit_range: int = 15,
                     curve_color: Optional[str] = None,
                     fit_color: Optional[str] = None,
                     compare_count: int = 0,
                     show_sample_points_left: bool = False,
                     show_sample_points_right: bool = False) -> None:
    """绘制Bump Caster图（左右对比）
    
    Args:
        ax_left: 左轮图表坐标轴
        ax_right: 右轮图表坐标轴
        calculator: K&C计算器
        fit_range: 拟合区间范围（mm）
        curve_color: 数据曲线颜色
        fit_color: 拟合线颜色
        compare_count: 对比数量
    """
    logger.debug("绘制Bump Caster图")
    
    # 计算Bump Caster
    result = calculator.calculate_bump_caster(fit_range=fit_range)
    
    # 提取原始数据
    extractor = calculator.extractor
    wheel_travel_left, wheel_travel_right = extractor.extract_wheel_travel_left_right(convert_length=True)
    caster_left = extractor.extract_by_name('caster_angle', convert_angle=True)
    caster_right = extractor.extract_by_name('caster_angle', convert_angle=True)
    
    # wheel_travel已经通过extract_wheel_travel_left_right处理为一维数组
    if caster_left.ndim > 1:
        caster_left = caster_left[:, 0]
    if caster_right.ndim > 1:
        caster_right = caster_right[:, 1] if caster_right.shape[1] > 1 else caster_right[:, 0]
    
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
    
    # 如果compare_count > 0，使用对比样式（灰色曲线+蓝色拟合线）
    if compare_count > 0:
        compare_style = get_compare_style(compare_count)
        curve_color = compare_style['curve_color']  # 灰色
        fit_color = compare_style['fit_color']      # 蓝色
        curve_linestyle = compare_style['curve_linestyle']
        fit_linestyle = compare_style['fit_linestyle']
    else:
        # 转换颜色（仅当compare_count=0时）
        curve_color = convert_matlab_color_to_python(curve_color) if curve_color else None
        fit_color = convert_matlab_color_to_python(fit_color) if fit_color else None
        curve_linestyle = '-'
        fit_linestyle = '-'
    
    # 绘制左轮
    plot_data_curve(ax_left, wheel_travel_left_mm, caster_left,
                   label='Result', color=curve_color, linestyle=curve_linestyle)
    plot_fit_line(ax_left, wheel_travel_left_mm, y_fit_left,
                 fit_range=(wheel_travel_left_mm[fit_start], wheel_travel_left_mm[fit_end-1]),
                 label=f'curve fitting [{-2*fit_range}mm, {2*fit_range}mm]',
                 color=fit_color, markevery=(0, fit_end-fit_start-1),
                 linestyle=fit_linestyle)
    if show_sample_points_left:
        plot_sample_points(ax_left, wheel_travel_left_mm, caster_left,
                          fit_start, fit_end, color=curve_color)
    
    setup_axes_style(ax_left,
                    xlabel='@WC vertical travel [mm]',
                    ylabel='castor angle[°]',
                    title='Castor Angle Left')
    setup_legend(ax_left)
    add_fit_formula_text(ax_left, coeffs_left, color=fit_color, compare_count=compare_count)
    add_direction_indicator(ax_left, 'bump_rebound')
    add_vertical_direction_indicator(ax_left, 'caster')
    
    # 绘制右轮
    plot_data_curve(ax_right, wheel_travel_right_mm, caster_right,
                   label='Result', color=curve_color, linestyle=curve_linestyle)
    plot_fit_line(ax_right, wheel_travel_right_mm, y_fit_right,
                 fit_range=(wheel_travel_right_mm[fit_start], wheel_travel_right_mm[fit_end-1]),
                 label=f'curve fitting [{-2*fit_range}mm, {2*fit_range}mm]',
                 color=fit_color, markevery=(0, fit_end-fit_start-1),
                 linestyle=fit_linestyle)
    if show_sample_points_right:
        plot_sample_points(ax_right, wheel_travel_right_mm, caster_right,
                          fit_start, fit_end, color=curve_color)
    
    setup_axes_style(ax_right,
                    xlabel='@WC vertical travel [mm]',
                    ylabel='castor angle [°]',
                    title='Castor Angle Right')
    setup_legend(ax_right)
    add_fit_formula_text(ax_right, coeffs_right, color=fit_color, compare_count=compare_count)
    add_direction_indicator(ax_right, 'bump_rebound')
    add_vertical_direction_indicator(ax_right, 'caster')


def plot_bump_side_swing_arm_angle(ax_left: Axes,
                                   ax_right: Axes,
                                   calculator: KCCalculator,
                                   fit_range: int = 15,
                                   curve_color: Optional[str] = None,
                                   fit_color: Optional[str] = None,
                                   compare_count: int = 0,
                                   show_sample_points_left: bool = False,
                                   show_sample_points_right: bool = False) -> None:
    """绘制Bump Side Swing Arm Angle图（左右对比）"""
    logger.debug("绘制Bump Side Swing Arm Angle图")
    
    result = calculator.calculate_bump_side_swing_arm_angle(fit_range=fit_range)
    extractor = calculator.extractor
    wheel_travel_left, wheel_travel_right = extractor.extract_wheel_travel_left_right(convert_length=True)
    swa_angle_left = extractor.extract_by_name('side_view_swing_arm_angle', convert_angle=True)
    swa_angle_right = extractor.extract_by_name('side_view_swing_arm_angle', convert_angle=True)
    
    if wheel_travel_left.ndim > 1:
        wheel_travel_left = wheel_travel_left[:, 1] if wheel_travel_left.shape[1] > 1 else wheel_travel_left[:, 0]
    if wheel_travel_right.ndim > 1:
        wheel_travel_right = wheel_travel_right[:, 1] if wheel_travel_right.shape[1] > 1 else wheel_travel_right[:, 0]
    if swa_angle_left.ndim > 1:
        swa_angle_left = swa_angle_left[:, 0]
    if swa_angle_right.ndim > 1:
        swa_angle_right = swa_angle_right[:, 1] if swa_angle_right.shape[1] > 1 else swa_angle_right[:, 0]
    
    wheel_travel_left_mm = wheel_travel_left * 1000
    wheel_travel_right_mm = wheel_travel_right * 1000
    
    zero_idx = result.get('zero_position_idx', len(wheel_travel_left) // 2)
    fit_start = max(0, zero_idx - fit_range)
    fit_end = min(len(wheel_travel_left), zero_idx + fit_range + 1)
    
    coeffs_left = np.array(result['left_coeffs'])
    coeffs_right = np.array(result['right_coeffs'])
    y_fit_left = np.polyval(coeffs_left, wheel_travel_left_mm)
    y_fit_right = np.polyval(coeffs_right, wheel_travel_right_mm)
    
    # 如果compare_count > 0，使用对比样式（灰色曲线+蓝色拟合线）
    if compare_count > 0:
        compare_style = get_compare_style(compare_count)
        curve_color = compare_style['curve_color']  # 灰色
        fit_color = compare_style['fit_color']      # 蓝色
        curve_linestyle = compare_style['curve_linestyle']
        fit_linestyle = compare_style['fit_linestyle']
    else:
        # 转换颜色（仅当compare_count=0时）
        curve_color = convert_matlab_color_to_python(curve_color) if curve_color else None
        fit_color = convert_matlab_color_to_python(fit_color) if fit_color else None
        curve_linestyle = '-'
        fit_linestyle = '-'
    
    plot_data_curve(ax_left, wheel_travel_left_mm, swa_angle_left, label='Result', color=curve_color, linestyle=curve_linestyle)
    plot_fit_line(ax_left, wheel_travel_left_mm, y_fit_left,
                 fit_range=(wheel_travel_left_mm[fit_start], wheel_travel_left_mm[fit_end-1]),
                 label=f'curve fitting [{-2*fit_range}mm, {2*fit_range}mm]',
                 color=fit_color, markevery=(0, fit_end-fit_start-1),
                 linestyle=fit_linestyle)
    if show_sample_points_left:
        plot_sample_points(ax_left, wheel_travel_left_mm, swa_angle_left,
                          fit_start, fit_end, color=curve_color)
    setup_axes_style(ax_left, xlabel='@WC vertical travel [mm]',
                    ylabel='side swing arm angle variation [°]', title='Side Swing Arm Angle Left')
    setup_legend(ax_left)
    add_fit_formula_text(ax_left, coeffs_left, color=fit_color, compare_count=compare_count)
    add_direction_indicator(ax_left, 'bump_rebound')
    
    plot_data_curve(ax_right, wheel_travel_right_mm, swa_angle_right, label='Result', color=curve_color, linestyle=curve_linestyle)
    plot_fit_line(ax_right, wheel_travel_right_mm, y_fit_right,
                 fit_range=(wheel_travel_right_mm[fit_start], wheel_travel_right_mm[fit_end-1]),
                 label=f'curve fitting [{-2*fit_range}mm, {2*fit_range}mm]',
                 color=fit_color, markevery=(0, fit_end-fit_start-1),
                 linestyle=fit_linestyle)
    if show_sample_points_right:
        plot_sample_points(ax_right, wheel_travel_right_mm, swa_angle_right,
                          fit_start, fit_end, color=curve_color)
    setup_axes_style(ax_right, xlabel='@WC vertical travel [mm]',
                    ylabel='side swing arm angle variation [°]', title='Side Swing Arm Angle Right')
    setup_legend(ax_right)
    add_fit_formula_text(ax_right, coeffs_right, color=fit_color, compare_count=compare_count)
    add_direction_indicator(ax_right, 'bump_rebound')


def plot_bump_side_swing_arm_length(ax_left: Axes,
                                    ax_right: Axes,
                                    calculator: KCCalculator,
                                    fit_range: int = 15,
                                    curve_color: Optional[str] = None,
                                    fit_color: Optional[str] = None,
                                    compare_count: int = 0,
                                    show_sample_points_left: bool = False,
                                    show_sample_points_right: bool = False) -> None:
    """绘制Bump Side Swing Arm Length图（左右对比）"""
    logger.debug("绘制Bump Side Swing Arm Length图")
    
    result = calculator.calculate_bump_side_swing_arm_length(fit_range=fit_range)
    extractor = calculator.extractor
    wheel_travel_left, wheel_travel_right = extractor.extract_wheel_travel_left_right(convert_length=True)
    swa_length_left = extractor.extract_by_name('side_view_swing_arm_length', convert_length=True)
    swa_length_right = extractor.extract_by_name('side_view_swing_arm_length', convert_length=True)
    
    if wheel_travel_left.ndim > 1:
        wheel_travel_left = wheel_travel_left[:, 1] if wheel_travel_left.shape[1] > 1 else wheel_travel_left[:, 0]
    if wheel_travel_right.ndim > 1:
        wheel_travel_right = wheel_travel_right[:, 1] if wheel_travel_right.shape[1] > 1 else wheel_travel_right[:, 0]
    if swa_length_left.ndim > 1:
        swa_length_left = swa_length_left[:, 0]
    if swa_length_right.ndim > 1:
        swa_length_right = swa_length_right[:, 1] if swa_length_right.shape[1] > 1 else swa_length_right[:, 0]
    
    wheel_travel_left_mm = wheel_travel_left * 1000
    wheel_travel_right_mm = wheel_travel_right * 1000
    swa_length_left_mm = swa_length_left * 1000
    swa_length_right_mm = swa_length_right * 1000
    
    zero_idx = result.get('zero_position_idx', len(wheel_travel_left) // 2)
    fit_start = max(0, zero_idx - fit_range)
    fit_end = min(len(wheel_travel_left), zero_idx + fit_range + 1)
    
    coeffs_left = np.array(result['left_coeffs'])
    coeffs_right = np.array(result['right_coeffs'])
    y_fit_left = np.polyval(coeffs_left, wheel_travel_left_mm)
    y_fit_right = np.polyval(coeffs_right, wheel_travel_right_mm)
    
    # 如果compare_count > 0，使用对比样式（灰色曲线+蓝色拟合线）
    if compare_count > 0:
        compare_style = get_compare_style(compare_count)
        curve_color = compare_style['curve_color']  # 灰色
        fit_color = compare_style['fit_color']      # 蓝色
        curve_linestyle = compare_style['curve_linestyle']
        fit_linestyle = compare_style['fit_linestyle']
    else:
        # 转换颜色（仅当compare_count=0时）
        curve_color = convert_matlab_color_to_python(curve_color) if curve_color else None
        fit_color = convert_matlab_color_to_python(fit_color) if fit_color else None
        curve_linestyle = '-'
        fit_linestyle = '-'
    
    plot_data_curve(ax_left, wheel_travel_left_mm, swa_length_left_mm, label='Result', color=curve_color, linestyle=curve_linestyle)
    plot_fit_line(ax_left, wheel_travel_left_mm, y_fit_left,
                 fit_range=(wheel_travel_left_mm[fit_start], wheel_travel_left_mm[fit_end-1]),
                 label=f'curve fitting [{-2*fit_range}mm, {2*fit_range}mm]',
                 color=fit_color, markevery=(0, fit_end-fit_start-1),
                 linestyle=fit_linestyle)
    if show_sample_points_left:
        plot_sample_points(ax_left, wheel_travel_left_mm, swa_length_left_mm,
                          fit_start, fit_end, color=curve_color)
    setup_axes_style(ax_left, xlabel='@WC vertical travel [mm]',
                    ylabel='side swing arm length variation [mm]', title='Side Swing Arm Length Left')
    setup_legend(ax_left)
    add_fit_formula_text(ax_left, coeffs_left, color=fit_color, compare_count=compare_count)
    add_direction_indicator(ax_left, 'bump_rebound')
    
    plot_data_curve(ax_right, wheel_travel_right_mm, swa_length_right_mm, label='Result', color=curve_color, linestyle=curve_linestyle)
    plot_fit_line(ax_right, wheel_travel_right_mm, y_fit_right,
                 fit_range=(wheel_travel_right_mm[fit_start], wheel_travel_right_mm[fit_end-1]),
                 label=f'curve fitting [{-2*fit_range}mm, {2*fit_range}mm]',
                 color=fit_color, markevery=(0, fit_end-fit_start-1),
                 linestyle=fit_linestyle)
    if show_sample_points_right:
        plot_sample_points(ax_right, wheel_travel_right_mm, swa_length_right_mm,
                          fit_start, fit_end, color=curve_color)
    setup_axes_style(ax_right, xlabel='@WC vertical travel [mm]',
                    ylabel='side swing arm length variation [mm]', title='Side Swing Arm Length Right')
    setup_legend(ax_right)
    add_fit_formula_text(ax_right, coeffs_right, color=fit_color, compare_count=compare_count)
    add_direction_indicator(ax_right, 'bump_rebound')


def plot_bump_wheel_load(ax_left: Axes,
                         ax_right: Axes,
                         calculator: KCCalculator,
                         fit_range: int = 15,
                         curve_color: Optional[str] = None,
                         fit_color: Optional[str] = None,
                         compare_count: int = 0,
                         show_sample_points_left: bool = False,
                         show_sample_points_right: bool = False) -> None:
    """绘制Bump Wheel Load图（左右对比）"""
    logger.debug("绘制Bump Wheel Load图")
    
    result = calculator.calculate_bump_wheel_load(fit_range=fit_range)
    extractor = calculator.extractor
    wheel_travel_left, wheel_travel_right = extractor.extract_wheel_travel_left_right(convert_length=True)
    wheel_load_left = extractor.extract_by_name('wheel_load_vertical_force')
    wheel_load_right = extractor.extract_by_name('wheel_load_vertical_force')
    
    # wheel_travel已经通过extract_wheel_travel_left_right处理为一维数组
    if wheel_load_left.ndim > 1:
        wheel_load_left = wheel_load_left[:, 0]
    if wheel_load_right.ndim > 1:
        wheel_load_right = wheel_load_right[:, 1] if wheel_load_right.shape[1] > 1 else wheel_load_right[:, 0]
    
    wheel_travel_left_mm = wheel_travel_left * 1000
    wheel_travel_right_mm = wheel_travel_right * 1000
    
    zero_idx = result.get('zero_position_idx', len(wheel_travel_left) // 2)
    fit_start = max(0, zero_idx - fit_range)
    fit_end = min(len(wheel_travel_left), zero_idx + fit_range + 1)
    
    coeffs_left = np.array(result['left_coeffs'])
    coeffs_right = np.array(result['right_coeffs'])
    y_fit_left = np.polyval(coeffs_left, wheel_travel_left_mm)
    y_fit_right = np.polyval(coeffs_right, wheel_travel_right_mm)
    
    # 如果compare_count > 0，使用对比样式（灰色曲线+蓝色拟合线）
    if compare_count > 0:
        compare_style = get_compare_style(compare_count)
        curve_color = compare_style['curve_color']  # 灰色
        fit_color = compare_style['fit_color']      # 蓝色
        curve_linestyle = compare_style['curve_linestyle']
        fit_linestyle = compare_style['fit_linestyle']
    else:
        # 转换颜色（仅当compare_count=0时）
        curve_color = convert_matlab_color_to_python(curve_color) if curve_color else None
        fit_color = convert_matlab_color_to_python(fit_color) if fit_color else None
        curve_linestyle = '-'
        fit_linestyle = '-'
    
    plot_data_curve(ax_left, wheel_travel_left_mm, wheel_load_left, label='Result', color=curve_color, linestyle=curve_linestyle)
    plot_fit_line(ax_left, wheel_travel_left_mm, y_fit_left,
                 fit_range=(wheel_travel_left_mm[fit_start], wheel_travel_left_mm[fit_end-1]),
                 label=f'curve fitting [{-2*fit_range}mm, {2*fit_range}mm]',
                 color=fit_color, markevery=(0, fit_end-fit_start-1),
                 linestyle=fit_linestyle)
    if show_sample_points_left:
        plot_sample_points(ax_left, wheel_travel_left_mm, wheel_load_left,
                          fit_start, fit_end, color=curve_color)
    setup_axes_style(ax_left, xlabel='@WC vertical travel [mm]',
                    ylabel='wheel load [N]', title='Wheel Rate Left')
    setup_legend(ax_left)
    add_fit_formula_text(ax_left, coeffs_left, color=fit_color, compare_count=compare_count)
    add_direction_indicator(ax_left, 'bump_rebound')
    
    plot_data_curve(ax_right, wheel_travel_right_mm, wheel_load_right, label='Result', color=curve_color, linestyle=curve_linestyle)
    plot_fit_line(ax_right, wheel_travel_right_mm, y_fit_right,
                 fit_range=(wheel_travel_right_mm[fit_start], wheel_travel_right_mm[fit_end-1]),
                 label=f'curve fitting [{-2*fit_range}mm, {2*fit_range}mm]',
                 color=fit_color, markevery=(0, fit_end-fit_start-1),
                 linestyle=fit_linestyle)
    if show_sample_points_right:
        plot_sample_points(ax_right, wheel_travel_right_mm, wheel_load_right,
                          fit_start, fit_end, color=curve_color)
    setup_axes_style(ax_right, xlabel='@WC vertical travel [mm]',
                    ylabel='wheel load [N]', title='Wheel Rate Right')
    setup_legend(ax_right)
    add_fit_formula_text(ax_right, coeffs_right, color=fit_color, compare_count=compare_count)
    add_direction_indicator(ax_right, 'bump_rebound')