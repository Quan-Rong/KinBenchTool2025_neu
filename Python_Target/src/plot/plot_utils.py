"""绘图工具函数模块

提供图表样式配置、坐标轴设置、图例设置、文本标注等通用绘图功能。
"""

from typing import Optional, Tuple, Dict, Any
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.axes import Axes
from matplotlib.figure import Figure
from matplotlib.ticker import AutoMinorLocator

from ..utils.logger import get_logger

logger = get_logger(__name__)


# 默认样式配置
DEFAULT_FONT_FAMILY = 'Times New Roman'
DEFAULT_FONT_SIZE = 10
DEFAULT_LINE_WIDTH = 2.5  # 加粗一号（从1.5改为2.5）
DEFAULT_MARKER_SIZE = 12


def setup_matplotlib_style() -> None:
    """设置matplotlib全局样式，使其与MATLAB风格一致
    
    这个函数应该在程序启动时调用一次。
    """
    plt.rcParams['font.family'] = DEFAULT_FONT_FAMILY
    plt.rcParams['font.size'] = DEFAULT_FONT_SIZE
    plt.rcParams['axes.linewidth'] = 1.0
    plt.rcParams['grid.alpha'] = 0.3
    plt.rcParams['grid.linestyle'] = '--'
    plt.rcParams['figure.dpi'] = 100
    
    logger.debug("Matplotlib样式已设置为MATLAB兼容模式")


def setup_axes_style(ax: Axes,
                     xlabel: Optional[str] = None,
                     ylabel: Optional[str] = None,
                     title: Optional[str] = None,
                     enable_grid: bool = True,
                     enable_minor_ticks: bool = True) -> None:
    """设置坐标轴样式
    
    Args:
        ax: matplotlib坐标轴对象
        xlabel: X轴标签
        ylabel: Y轴标签
        title: 图表标题
        enable_grid: 是否启用网格
        enable_minor_ticks: 是否启用次刻度
    """
    # 设置标签
    if xlabel:
        ax.set_xlabel(xlabel, horizontalalignment='center', fontweight='bold',
                     fontfamily=DEFAULT_FONT_FAMILY, fontsize=DEFAULT_FONT_SIZE)
    if ylabel:
        ax.set_ylabel(ylabel, horizontalalignment='center', fontweight='bold',
                     fontfamily=DEFAULT_FONT_FAMILY, fontsize=DEFAULT_FONT_SIZE)
    if title:
        ax.set_title(title, horizontalalignment='center', fontweight='bold',
                    fontfamily=DEFAULT_FONT_FAMILY, fontsize=DEFAULT_FONT_SIZE)
    
    # 设置字体大小
    ax.tick_params(axis='both', labelsize=DEFAULT_FONT_SIZE)
    
    # 启用边框
    ax.spines['top'].set_visible(True)
    ax.spines['right'].set_visible(True)
    ax.spines['bottom'].set_visible(True)
    ax.spines['left'].set_visible(True)
    
    # 设置网格
    if enable_grid:
        ax.grid(True, alpha=0.3, linestyle='--')
        ax.set_axisbelow(True)
    
    # 设置次刻度
    if enable_minor_ticks:
        ax.xaxis.set_minor_locator(AutoMinorLocator())
        ax.yaxis.set_minor_locator(AutoMinorLocator())
        ax.tick_params(which='minor', length=3)
    
    logger.debug(f"坐标轴样式已设置: title={title}")


def plot_data_curve(ax: Axes,
                   x: np.ndarray,
                   y: np.ndarray,
                   label: str = 'Result',
                   color: Optional[str] = None,
                   linewidth: float = DEFAULT_LINE_WIDTH,
                   linestyle: str = '-') -> None:
    """绘制数据曲线
    
    Args:
        ax: matplotlib坐标轴对象
        x: X轴数据
        y: Y轴数据
        label: 曲线标签
        color: 曲线颜色（默认黑色）
        linewidth: 线宽
        linestyle: 线形（默认实线）
    """
    # 默认颜色为黑色
    if color is None:
        color = '#000000'
    ax.plot(x, y, label=label, color=color, linewidth=linewidth, linestyle=linestyle)
    logger.debug(f"绘制数据曲线: label={label}, 数据点数={len(x)}")


def plot_fit_line(ax: Axes,
                  x: np.ndarray,
                  y_fit: np.ndarray,
                  fit_range: Tuple[float, float],
                  label: Optional[str] = None,
                  color: Optional[str] = None,
                  marker: str = 'o',
                  marker_size: int = DEFAULT_MARKER_SIZE,
                  markevery: Optional[Tuple[int, int]] = None,
                  linestyle: str = '-') -> None:
    """绘制拟合直线
    
    Args:
        ax: matplotlib坐标轴对象
        x: X轴数据
        y_fit: 拟合后的Y值
        fit_range: 拟合区间 (min, max)
        label: 曲线标签
        color: 曲线颜色（默认红色）
        marker: 标记样式（默认空心小圆点）
        marker_size: 标记大小
        markevery: 标记间隔 (start, end)，用于标记拟合区间的起点和终点
        linestyle: 线形（默认实线）
    """
    # 筛选拟合区间内的数据
    mask = (x >= fit_range[0]) & (x <= fit_range[1])
    x_fit = x[mask]
    y_fit_filtered = y_fit[mask]
    
    if len(x_fit) == 0:
        logger.warning(f"拟合区间内无数据点: {fit_range}")
        return
    
    # 生成标签
    if label is None:
        label = f'curve fitting [{fit_range[0]:.0f}mm, {fit_range[1]:.0f}mm]'
    
    # 默认颜色为红色
    if color is None:
        color = '#ff0000'
    
    # 绘制拟合线
    plot_kwargs = {
        'label': label,
        'color': color,
        'marker': marker,
        'markersize': marker_size,
        'markerfacecolor': 'none',  # 空心标记
        'markeredgecolor': color,
        'markeredgewidth': 1.5,
        'linewidth': DEFAULT_LINE_WIDTH + 0.5,  # 稍微加粗拟合线使其更明显
        'linestyle': linestyle,
        'zorder': 10  # 确保拟合线显示在数据曲线之上
    }
    
    if markevery is not None:
        # 计算标记位置
        indices = np.where(mask)[0]
        if len(indices) >= 2:
            start_idx = indices[0]
            end_idx = indices[-1]
            # 创建markevery列表，只标记起点和终点
            mark_indices = [0, len(x_fit) - 1]
            plot_kwargs['markevery'] = mark_indices
    
    ax.plot(x_fit, y_fit_filtered, **plot_kwargs)
    
    logger.debug(f"绘制拟合直线: label={label}, 拟合区间={fit_range}")


def plot_sample_points(ax: Axes,
                       x: np.ndarray,
                       y: np.ndarray,
                       fit_start: int,
                       fit_end: int,
                       color: Optional[str] = None,
                       label: str = 'Sample points',
                       marker_size: int = DEFAULT_MARKER_SIZE) -> None:
    """在曲线上绘制全部curve区域的样本点（空心方块）
    
    Args:
        ax: matplotlib坐标轴对象
        x: X轴数据
        y: Y轴数据
        fit_start: 拟合区间起始索引（含，保留参数以保持兼容性，但不使用）
        fit_end: 拟合区间结束索引（不含，保留参数以保持兼容性，但不使用）
        color: 样本点颜色（默认与曲线一致）
        label: 图例标签
        marker_size: 标记大小
    """
    # 显示全部curve区域的采样点，而不是仅限于fit range
    if len(x) == 0 or len(y) == 0:
        return
    if len(x) != len(y):
        logger.warning(f"X和Y数据长度不匹配: x={len(x)}, y={len(y)}")
        return
    
    x_sample = x
    y_sample = y
    
    if color is None:
        color = '#000000'
    ax.scatter(x_sample, y_sample,
               marker='s',
               s=marker_size * 12,  # 面积，使空心方块大小与拟合线标记相近
               facecolors='none',
               edgecolors=color,
               linewidths=1.5,
               label=label,
               zorder=11)
    logger.debug(f"绘制样本点: {len(x_sample)}个点, 全部curve区域")


def add_fit_formula_text(ax: Axes,
                        coeffs: np.ndarray,
                        position: Tuple[float, float] = (0.5, 0.6),
                        color: Optional[str] = None,
                        fontsize: int = DEFAULT_FONT_SIZE,
                        compare_count: int = 0) -> None:
    """添加拟合公式文本
    
    Args:
        ax: matplotlib坐标轴对象
        coeffs: 拟合系数 [a, b]，表示 y = ax + b
        position: 文本位置（归一化坐标，0-1之间）
        color: 文本颜色
        fontsize: 字体大小
        compare_count: 对比数量，用于调整文本垂直位置
    """
    a, b = coeffs[0], coeffs[1]
    
    # 格式化公式
    if b >= 0:
        formula = f'y = {a:.4f}*x+{b:.4f}'
    else:
        formula = f'y = {a:.4f}*x{b:.4f}'
    
    # 调整垂直位置（根据对比数量）
    y_pos = position[1] + 0.1 * compare_count
    
    ax.text(position[0], y_pos, formula,
           transform=ax.transAxes,
           horizontalalignment='center',
           verticalalignment='bottom',
           color=color,
           fontsize=fontsize,
           fontfamily=DEFAULT_FONT_FAMILY)
    
    logger.debug(f"添加拟合公式: {formula}")


def add_direction_indicator(ax: Axes,
                           direction_type: str = 'bump_rebound',
                           position: Tuple[float, float] = (0.55, 0.01),
                           fontsize: int = DEFAULT_FONT_SIZE) -> None:
    """添加方向指示文本（水平方向）
    
    Args:
        ax: matplotlib坐标轴对象
        direction_type: 方向类型
            - 'bump_rebound': rebound << >> bump
            - 'toe': toe out << >> toe in
            - 'camber': top in << >> top out
            - 'wheel_base': forwards << >> backwards
        position: 文本位置（归一化坐标）
        fontsize: 字体大小
    """
    direction_texts = {
        'bump_rebound': 'rebound <<                                                          >> bump',
        'toe': 'toe out <<                                          >> toe in',
        'camber': 'top in <<                                          >> top out',
        'wheel_base': 'forwards <<                                      >> backwards'
    }
    
    text = direction_texts.get(direction_type, direction_type)
    
    ax.text(position[0], position[1], text,
           transform=ax.transAxes,
           horizontalalignment='center',
           verticalalignment='bottom',
           fontsize=fontsize,
           fontfamily=DEFAULT_FONT_FAMILY,
           fontweight='bold')
    
    logger.debug(f"添加方向指示: {direction_type}")


def add_vertical_direction_indicator(ax: Axes,
                                     direction_type: str = 'toe',
                                     position: Tuple[float, float] = (0.03, 0.55),
                                     fontsize: int = DEFAULT_FONT_SIZE) -> None:
    """添加方向指示文本（垂直方向，旋转90度）
    
    Args:
        ax: matplotlib坐标轴对象
        direction_type: 方向类型
            - 'toe': toe out << >> toe in
            - 'camber': top in << >> top out
            - 'wheel_base': forwards << >> backwards
        position: 文本位置（归一化坐标）
        fontsize: 字体大小
    """
    direction_texts = {
        'toe': 'toe out <<                                          >> toe in',
        'camber': 'top in <<                                          >> top out',
        'wheel_base': 'forwards <<                                      >> backwards',
        'caster': 'rolling backward <<                        >> rolling forward'
    }
    
    text = direction_texts.get(direction_type, direction_type)
    
    ax.text(position[0], position[1], text,
           transform=ax.transAxes,
           horizontalalignment='center',
           verticalalignment='center',
           fontsize=fontsize,
           fontfamily=DEFAULT_FONT_FAMILY,
           fontweight='bold',
           rotation=90)
    
    logger.debug(f"添加垂直方向指示: {direction_type}")


def add_custom_text(ax: Axes,
                   text: str,
                   position: Tuple[float, float],
                   color: Optional[str] = None,
                   fontsize: int = DEFAULT_FONT_SIZE,
                   fontweight: Optional[str] = None,
                   horizontalalignment: str = 'center',
                   verticalalignment: str = 'bottom',
                   rotation: float = 0,
                   use_normalized: bool = True) -> None:
    """添加自定义文本
    
    Args:
        ax: matplotlib坐标轴对象
        text: 文本内容
        position: 文本位置 (x, y)
        color: 文本颜色
        fontsize: 字体大小
        fontweight: 字体粗细 ('normal', 'bold')
        horizontalalignment: 水平对齐方式
        verticalalignment: 垂直对齐方式
        rotation: 旋转角度（度）
        use_normalized: 是否使用归一化坐标（0-1之间）
    """
    transform = ax.transAxes if use_normalized else None
    
    ax.text(position[0], position[1], text,
           transform=transform,
           horizontalalignment=horizontalalignment,
           verticalalignment=verticalalignment,
           color=color,
           fontsize=fontsize,
           fontfamily=DEFAULT_FONT_FAMILY,
           fontweight=fontweight,
           rotation=rotation)
    
    logger.debug(f"添加自定义文本: {text}")


def setup_legend(ax: Axes, location: str = 'best') -> None:
    """设置图例
    
    Args:
        ax: matplotlib坐标轴对象
        location: 图例位置
    """
    legend = ax.legend(loc=location)
    if legend:
        legend.set_visible(True)
        logger.debug(f"图例已设置: location={location}")


def create_comparison_figure(nrows: int = 1, ncols: int = 2,
                            figsize: Tuple[float, float] = (12, 6),
                            dpi: int = 100) -> Tuple[Figure, np.ndarray]:
    """创建左右对比图表
    
    Args:
        nrows: 行数
        ncols: 列数（通常为2，左右对比）
        figsize: 图表尺寸（英寸）
        dpi: 分辨率
        
    Returns:
        (figure, axes_array): 图表对象和坐标轴数组
    """
    fig, axes = plt.subplots(nrows, ncols, figsize=figsize, dpi=dpi)
    
    # 如果只有一行，确保axes是数组
    if nrows == 1 and ncols == 2:
        axes = np.array([axes[0], axes[1]])
    elif nrows == 1:
        axes = np.array([axes])
    
    logger.debug(f"创建对比图表: {nrows}x{ncols}, size={figsize}")
    return fig, axes


def clear_axes(ax: Axes) -> None:
    """清空坐标轴
    
    Args:
        ax: matplotlib坐标轴对象
    """
    ax.clear()
    logger.debug("坐标轴已清空")


def save_plot(fig: Figure, filepath: str, dpi: int = 300, 
             bbox_inches: str = 'tight') -> None:
    """保存图表
    
    Args:
        fig: matplotlib图表对象
        filepath: 保存路径
        dpi: 分辨率
        bbox_inches: 边界框设置
    """
    fig.savefig(filepath, dpi=dpi, bbox_inches=bbox_inches)
    logger.info(f"图表已保存: {filepath}")


def get_color_from_rgb(rgb: Tuple[float, float, float]) -> str:
    """将RGB元组转换为matplotlib颜色字符串
    
    Args:
        rgb: RGB值元组，每个值在0-1之间
        
    Returns:
        颜色字符串（十六进制格式）
    """
    r, g, b = rgb
    return f'#{int(r*255):02x}{int(g*255):02x}{int(b*255):02x}'


def convert_matlab_color_to_python(color: Any) -> str:
    """将MATLAB颜色格式转换为Python格式
    
    Args:
        color: MATLAB颜色（可以是RGB数组、颜色名称等）
        
    Returns:
        Python颜色字符串
    """
    if isinstance(color, (list, tuple, np.ndarray)):
        if len(color) == 3:
            # RGB数组，值在0-1之间
            return get_color_from_rgb(tuple(color))
        elif len(color) == 4:
            # RGBA数组，只取RGB
            return get_color_from_rgb(tuple(color[:3]))
    elif isinstance(color, str):
        # 颜色名称
        return color
    else:
        # 默认返回黑色
        logger.warning(f"无法识别的颜色格式: {color}, 使用默认黑色")
        return '#000000'
