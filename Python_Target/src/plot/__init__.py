"""绘图模块

包含各种K&C测试工况的绘图功能。
"""

# 绘图工具函数
from .plot_utils import (
    setup_matplotlib_style,
    setup_axes_style,
    plot_data_curve,
    plot_fit_line,
    add_fit_formula_text,
    add_direction_indicator,
    add_vertical_direction_indicator,
    add_custom_text,
    setup_legend,
    create_comparison_figure,
    clear_axes,
    save_plot,
    convert_matlab_color_to_python,
)

# Bump测试绘图
from .bump_plot import (
    plot_bump_steer,
    plot_bump_camber,
    plot_wheel_rate_slope,
    plot_wheel_rate_wc,
    plot_wheel_recession,
    plot_track_change,
    plot_bump_caster,
    plot_bump_side_swing_arm_angle,
    plot_bump_side_swing_arm_length,
    plot_bump_wheel_load,
)

# Roll测试绘图
from .roll_plot import (
    plot_roll_steer,
    plot_roll_camber,
    plot_roll_camber_relative_ground,
    plot_roll_rate,
    plot_roll_center_height,
)

# Static Load测试绘图
from .static_load_plot import (
    plot_lateral_toe_compliance,
    plot_lateral_camber_compliance,
    plot_braking_toe_compliance,
    plot_acceleration_toe_compliance,
)

__all__ = [
    # 绘图工具函数
    'setup_matplotlib_style',
    'setup_axes_style',
    'plot_data_curve',
    'plot_fit_line',
    'add_fit_formula_text',
    'add_direction_indicator',
    'add_vertical_direction_indicator',
    'add_custom_text',
    'setup_legend',
    'create_comparison_figure',
    'clear_axes',
    'save_plot',
    'convert_matlab_color_to_python',
    # Bump测试绘图
    'plot_bump_steer',
    'plot_bump_camber',
    'plot_wheel_rate_slope',
    'plot_wheel_rate_wc',
    'plot_wheel_recession',
    'plot_track_change',
    'plot_bump_caster',
    'plot_bump_side_swing_arm_angle',
    'plot_bump_side_swing_arm_length',
    'plot_bump_wheel_load',
    # Roll测试绘图
    'plot_roll_steer',
    'plot_roll_camber',
    'plot_roll_camber_relative_ground',
    'plot_roll_rate',
    'plot_roll_center_height',
    # Static Load测试绘图
    'plot_lateral_toe_compliance',
    'plot_lateral_camber_compliance',
    'plot_braking_toe_compliance',
    'plot_acceleration_toe_compliance',
]
