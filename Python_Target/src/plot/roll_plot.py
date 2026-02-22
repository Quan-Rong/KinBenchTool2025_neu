"""Roll测试绘图模块

提供Roll测试（侧倾测试）的各种图表绘制功能。
"""

from typing import Optional, Tuple
import numpy as np
from matplotlib.axes import Axes

from .plot_utils import (
    setup_axes_style, plot_data_curve, plot_fit_line, plot_sample_points,
    add_fit_formula_text, add_direction_indicator,
    setup_legend, convert_matlab_color_to_python, add_custom_text
)
from ..data import KCCalculator
from ..utils.logger import get_logger

logger = get_logger(__name__)


def plot_roll_steer(ax_left: Axes,
                   ax_right: Axes,
                   calculator: KCCalculator,
                   fit_range: float = 1.0,
                   curve_color: Optional[str] = None,
                   fit_color: Optional[str] = None,
                   compare_count: int = 0,
                   show_sample_points_left: bool = False,
                   show_sample_points_right: bool = False) -> None:
    """绘制Roll Steer图（左右对比）
    
    Args:
        ax_left: 左轮图表坐标轴
        ax_right: 右轮图表坐标轴
        calculator: K&C计算器
        fit_range: 拟合区间范围（度）
        curve_color: 数据曲线颜色
        fit_color: 拟合线颜色
        compare_count: 对比数量
    """
    logger.debug("绘制Roll Steer图")
    
    # 计算Roll Steer
    result = calculator.calculate_roll_steer(fit_range=fit_range)
    
    # 提取原始数据
    extractor = calculator.extractor
    roll_angle = extractor.extract_by_name('roll_angle', convert_angle=True)
    toe_left = extractor.extract_by_name('toe_angle', convert_angle=True)
    toe_right = extractor.extract_by_name('toe_angle', convert_angle=True)
    
    # 处理多维数据
    if roll_angle.ndim > 1:
        roll_angle_wc = roll_angle[:, 0]  # @WC roll angle
    else:
        roll_angle_wc = roll_angle
    
    if toe_left.ndim > 1:
        toe_left = toe_left[:, 0]
    if toe_right.ndim > 1:
        toe_right = toe_right[:, 1] if toe_right.shape[1] > 1 else toe_right[:, 0]
    
    # 获取零位置和拟合区间
    zero_idx = result.get('zero_position_idx', len(roll_angle_wc) // 2)
    fit_range_idx = int(fit_range * 10)  # 假设每度对应10个数据点
    fit_start = max(0, zero_idx - fit_range_idx)
    fit_end = min(len(roll_angle_wc), zero_idx + fit_range_idx + 1)
    
    # 获取拟合系数（注意右轮需要取负）
    coeffs_left = np.array(result['left_coeffs'])
    coeffs_right = np.array(result['right_coeffs'])
    # 右轮系数需要取负（用于显示）
    coeffs_right_display = coeffs_right.copy()
    coeffs_right_display[0] = -coeffs_right_display[0]
    
    # 计算拟合值
    y_fit_left = np.polyval(coeffs_left, roll_angle_wc)
    y_fit_right = np.polyval(coeffs_right_display, roll_angle_wc)
    
    # 转换颜色
    curve_color = convert_matlab_color_to_python(curve_color) if curve_color else None
    fit_color = convert_matlab_color_to_python(fit_color) if fit_color else None
    
    # 绘制左轮
    plot_data_curve(ax_left, roll_angle_wc, toe_left,
                   label='Result', color=curve_color)
    plot_fit_line(ax_left, roll_angle_wc, y_fit_left,
                 fit_range=(roll_angle_wc[fit_start], roll_angle_wc[fit_end-1]),
                 label=f'curve fitting [{-fit_range:.1f}°, {fit_range:.1f}°]',
                 color=fit_color, markevery=(0, fit_end-fit_start-1))
    if show_sample_points_left:
        plot_sample_points(ax_left, roll_angle_wc, toe_left,
                          fit_start, fit_end, color=curve_color)
    
    setup_axes_style(ax_left,
                    xlabel='roll angle [°]',
                    ylabel='toe angle variation [°]',
                    title='Roll Steer Left')
    setup_legend(ax_left)
    add_fit_formula_text(ax_left, coeffs_left, color=fit_color, compare_count=compare_count)
    
    # 绘制右轮（注意右轮数据需要取负）
    toe_right_neg = -toe_right  # 右轮取负
    plot_data_curve(ax_right, roll_angle_wc, toe_right_neg,
                   label='Result', color=curve_color)
    plot_fit_line(ax_right, roll_angle_wc, y_fit_right,
                 fit_range=(roll_angle_wc[fit_start], roll_angle_wc[fit_end-1]),
                 label=f'curve fitting [{-fit_range:.1f}°, {fit_range:.1f}°]',
                 color=fit_color, markevery=(0, fit_end-fit_start-1))
    if show_sample_points_right:
        plot_sample_points(ax_right, roll_angle_wc, toe_right_neg,
                          fit_start, fit_end, color=curve_color)
    
    setup_axes_style(ax_right,
                    xlabel='roll angle [°]',
                    ylabel='toe angle variation [°]',
                    title='Roll Steer Right')
    setup_legend(ax_right)
    add_fit_formula_text(ax_right, coeffs_right_display, color=fit_color, compare_count=compare_count)


def plot_roll_camber(ax_left: Axes,
                    ax_right: Axes,
                    calculator: KCCalculator,
                    fit_range: float = 1.0,
                    curve_color: Optional[str] = None,
                    fit_color: Optional[str] = None,
                    compare_count: int = 0,
                    show_sample_points_left: bool = False,
                    show_sample_points_right: bool = False) -> None:
    """绘制Roll Camber图（左右对比）
    
    Args:
        ax_left: 左轮图表坐标轴
        ax_right: 右轮图表坐标轴
        calculator: K&C计算器
        fit_range: 拟合区间范围（度）
        curve_color: 数据曲线颜色
        fit_color: 拟合线颜色
        compare_count: 对比数量
    """
    logger.debug("绘制Roll Camber图")
    
    # 计算Roll Camber
    result = calculator.calculate_roll_camber(fit_range=fit_range)
    
    # 提取原始数据
    extractor = calculator.extractor
    roll_angle = extractor.extract_by_name('roll_angle', convert_angle=True)
    camber_left = extractor.extract_by_name('camber_angle', convert_angle=True)
    camber_right = extractor.extract_by_name('camber_angle', convert_angle=True)
    
    # 处理多维数据
    if roll_angle.ndim > 1:
        roll_angle_wc = roll_angle[:, 0]
    else:
        roll_angle_wc = roll_angle
    
    if camber_left.ndim > 1:
        camber_left = camber_left[:, 0]
    if camber_right.ndim > 1:
        camber_right = camber_right[:, 1] if camber_right.shape[1] > 1 else camber_right[:, 0]
    
    # 获取零位置和拟合区间
    zero_idx = result.get('zero_position_idx', len(roll_angle_wc) // 2)
    fit_range_idx = int(fit_range * 10)
    fit_start = max(0, zero_idx - fit_range_idx)
    fit_end = min(len(roll_angle_wc), zero_idx + fit_range_idx + 1)
    
    # 获取拟合系数（注意右轮需要取负）
    coeffs_left = np.array(result['left_coeffs'])
    coeffs_right = np.array(result['right_coeffs'])
    coeffs_right_display = coeffs_right.copy()
    coeffs_right_display[0] = -coeffs_right_display[0]
    
    # 计算拟合值
    y_fit_left = np.polyval(coeffs_left, roll_angle_wc)
    y_fit_right = np.polyval(coeffs_right_display, roll_angle_wc)
    
    # 转换颜色
    curve_color = convert_matlab_color_to_python(curve_color) if curve_color else None
    fit_color = convert_matlab_color_to_python(fit_color) if fit_color else None
    
    # 绘制左轮
    plot_data_curve(ax_left, roll_angle_wc, camber_left,
                   label='Result', color=curve_color)
    plot_fit_line(ax_left, roll_angle_wc, y_fit_left,
                 fit_range=(roll_angle_wc[fit_start], roll_angle_wc[fit_end-1]),
                 label=f'curve fitting [{-fit_range:.1f}°, {fit_range:.1f}°]',
                 color=fit_color, markevery=(0, fit_end-fit_start-1))
    if show_sample_points_left:
        plot_sample_points(ax_left, roll_angle_wc, camber_left,
                          fit_start, fit_end, color=curve_color)
    
    setup_axes_style(ax_left,
                    xlabel='roll angle [°]',
                    ylabel='camber angle variation [°]',
                    title='Roll Camber Left')
    setup_legend(ax_left)
    add_fit_formula_text(ax_left, coeffs_left, color=fit_color, compare_count=compare_count)
    
    # 绘制右轮（注意右轮数据需要取负）
    camber_right_neg = -camber_right
    plot_data_curve(ax_right, roll_angle_wc, camber_right_neg,
                   label='Result', color=curve_color)
    plot_fit_line(ax_right, roll_angle_wc, y_fit_right,
                 fit_range=(roll_angle_wc[fit_start], roll_angle_wc[fit_end-1]),
                 label=f'curve fitting [{-fit_range:.1f}°, {fit_range:.1f}°]',
                 color=fit_color, markevery=(0, fit_end-fit_start-1))
    if show_sample_points_right:
        plot_sample_points(ax_right, roll_angle_wc, camber_right_neg,
                          fit_start, fit_end, color=curve_color)
    
    setup_axes_style(ax_right,
                    xlabel='roll angle [°]',
                    ylabel='camber angle variation [°]',
                    title='Roll Camber Right')
    setup_legend(ax_right)
    add_fit_formula_text(ax_right, coeffs_right_display, color=fit_color, compare_count=compare_count)


def plot_roll_camber_relative_ground(ax_left: Axes,
                                    ax_right: Axes,
                                    calculator: KCCalculator,
                                    fit_range: float = 1.0,
                                    curve_color: Optional[str] = None,
                                    fit_color: Optional[str] = None,
                                    compare_count: int = 0,
                                    show_sample_points_left: bool = False,
                                    show_sample_points_right: bool = False) -> None:
    """绘制Roll Camber Relative Ground图（左右对比）
    
    Args:
        ax_left: 左轮图表坐标轴
        ax_right: 右轮图表坐标轴
        calculator: K&C计算器
        fit_range: 拟合区间范围（度）
        curve_color: 数据曲线颜色
        fit_color: 拟合线颜色
        compare_count: 对比数量
    """
    logger.debug("绘制Roll Camber Relative Ground图")
    
    # 计算Roll Camber Relative Ground
    result = calculator.calculate_roll_camber_relative_ground(fit_range=fit_range)
    
    # 提取原始数据
    extractor = calculator.extractor
    roll_angle = extractor.extract_by_name('roll_angle', convert_angle=True)
    camber_left = extractor.extract_by_name('camber_angle', convert_angle=True)
    camber_right = extractor.extract_by_name('camber_angle', convert_angle=True)
    
    # 处理多维数据
    if roll_angle.ndim > 1:
        roll_angle_wc = roll_angle[:, 0]
    else:
        roll_angle_wc = roll_angle
    
    if camber_left.ndim > 1:
        camber_left = camber_left[:, 0]
    if camber_right.ndim > 1:
        camber_right = camber_right[:, 1] if camber_right.shape[1] > 1 else camber_right[:, 0]
    
    # 计算相对地面外倾角（camber - roll_angle）
    camber_rel_ground_left = camber_left - roll_angle_wc
    camber_rel_ground_right = camber_right + roll_angle_wc  # 右轮取正
    
    # 获取零位置和拟合区间
    zero_idx = result.get('zero_position_idx', len(roll_angle_wc) // 2)
    fit_range_idx = int(fit_range * 10)
    fit_start = max(0, zero_idx - fit_range_idx)
    fit_end = min(len(roll_angle_wc), zero_idx + fit_range_idx + 1)
    
    # 获取拟合系数
    coeffs_left = np.array(result['left_coeffs'])
    coeffs_right = np.array(result['right_coeffs'])
    coeffs_right_display = coeffs_right.copy()
    coeffs_right_display[0] = -coeffs_right_display[0]
    
    # 计算拟合值
    y_fit_left = np.polyval(coeffs_left, roll_angle_wc)
    y_fit_right = np.polyval(coeffs_right_display, roll_angle_wc)
    
    # 转换颜色
    curve_color = convert_matlab_color_to_python(curve_color) if curve_color else None
    fit_color = convert_matlab_color_to_python(fit_color) if fit_color else None
    
    # 绘制左轮
    plot_data_curve(ax_left, roll_angle_wc, camber_rel_ground_left,
                   label='Result', color=curve_color)
    plot_fit_line(ax_left, roll_angle_wc, y_fit_left,
                 fit_range=(roll_angle_wc[fit_start], roll_angle_wc[fit_end-1]),
                 label=f'curve fitting [{-fit_range:.1f}°, {fit_range:.1f}°]',
                 color=fit_color, markevery=(0, fit_end-fit_start-1))
    if show_sample_points_left:
        plot_sample_points(ax_left, roll_angle_wc, camber_rel_ground_left,
                          fit_start, fit_end, color=curve_color)
    
    setup_axes_style(ax_left,
                    xlabel='roll angle [°]',
                    ylabel='camber angle relative ground [°]',
                    title='Roll Camber Relative Ground Left')
    setup_legend(ax_left)
    add_fit_formula_text(ax_left, coeffs_left, color=fit_color, compare_count=compare_count)
    
    # 绘制右轮
    camber_rel_ground_right_neg = -camber_rel_ground_right
    plot_data_curve(ax_right, roll_angle_wc, camber_rel_ground_right_neg,
                   label='Result', color=curve_color)
    plot_fit_line(ax_right, roll_angle_wc, y_fit_right,
                 fit_range=(roll_angle_wc[fit_start], roll_angle_wc[fit_end-1]),
                 label=f'curve fitting [{-fit_range:.1f}°, {fit_range:.1f}°]',
                 color=fit_color, markevery=(0, fit_end-fit_start-1))
    if show_sample_points_right:
        plot_sample_points(ax_right, roll_angle_wc, camber_rel_ground_right_neg,
                          fit_start, fit_end, color=curve_color)
    
    setup_axes_style(ax_right,
                    xlabel='roll angle [°]',
                    ylabel='camber angle relative ground [°]',
                    title='Roll Camber Relative Ground Right')
    setup_legend(ax_right)
    add_fit_formula_text(ax_right, coeffs_right_display, color=fit_color, compare_count=compare_count)


def plot_roll_rate(ax: Axes,
                  calculator: KCCalculator,
                  curve_color: Optional[str] = None) -> None:
    """绘制Roll Rate图（悬架侧倾刚度和总侧倾刚度）
    
    Args:
        ax: 图表坐标轴
        calculator: K&C计算器
        curve_color: 数据曲线颜色
    """
    logger.debug("绘制Roll Rate图")
    
    # 计算Roll Rate
    result = calculator.calculate_roll_rate()
    
    # 提取原始数据
    extractor = calculator.extractor
    roll_angle = extractor.extract_by_name('roll_angle', convert_angle=True)
    susp_roll_rate = extractor.extract_by_name('susp_roll_rate', convert_length=False)
    total_roll_rate = extractor.extract_by_name('total_roll_rate', convert_length=False)
    
    # 处理多维数据
    if roll_angle.ndim > 1:
        roll_angle_wc = roll_angle[:, 0]
    else:
        roll_angle_wc = roll_angle
    
    if susp_roll_rate.ndim > 1:
        susp_roll_rate = susp_roll_rate[:, 0]
    if total_roll_rate.ndim > 1:
        total_roll_rate = total_roll_rate[:, 0]
    
    # 转换单位：Nm/rad -> Nm/deg
    susp_roll_rate_deg = susp_roll_rate * np.pi / 180
    total_roll_rate_deg = total_roll_rate * np.pi / 180
    
    # 转换颜色
    curve_color = convert_matlab_color_to_python(curve_color) if curve_color else None
    
    # 绘制悬架侧倾刚度
    plot_data_curve(ax, roll_angle_wc, susp_roll_rate_deg,
                   label='Suspension Roll Rate', color=curve_color)
    
    # 绘制总侧倾刚度
    plot_data_curve(ax, roll_angle_wc, total_roll_rate_deg,
                   label='Total Roll Rate', color=curve_color)
    
    setup_axes_style(ax,
                    xlabel='roll angle [°]',
                    ylabel='Roll Rate [Nm/deg]',
                    title='Roll Rate')
    setup_legend(ax)


def plot_roll_center_height(ax: Axes,
                           calculator: KCCalculator,
                           curve_color: Optional[str] = None) -> None:
    """绘制Roll Center Height图
    
    Args:
        ax: 图表坐标轴
        calculator: K&C计算器
        curve_color: 数据曲线颜色
    """
    logger.debug("绘制Roll Center Height图")
    
    # 计算Roll Center Height
    result = calculator.calculate_roll_center_height()
    
    # 提取原始数据
    extractor = calculator.extractor
    roll_angle = extractor.extract_by_name('roll_angle', convert_angle=True)
    roll_center_vertical = extractor.extract_by_name('roll_center_location', convert_length=True)
    
    # 处理多维数据
    if roll_angle.ndim > 1:
        roll_angle_wc = roll_angle[:, 0]
    else:
        roll_angle_wc = roll_angle
    
    if roll_center_vertical.ndim > 1:
        roll_center_vertical = roll_center_vertical[:, 1] if roll_center_vertical.shape[1] > 1 else roll_center_vertical[:, 0]
    
    # 转换为mm
    roll_center_vertical_mm = roll_center_vertical * 1000
    
    # 转换颜色
    curve_color = convert_matlab_color_to_python(curve_color) if curve_color else None
    
    # 绘制
    plot_data_curve(ax, roll_angle_wc, roll_center_vertical_mm,
                   label='Roll Center Height', color=curve_color)
    
    setup_axes_style(ax,
                    xlabel='roll angle [°]',
                    ylabel='Roll Center Height [mm]',
                    title='Roll Center Height')
    setup_legend(ax)
