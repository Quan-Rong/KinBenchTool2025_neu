"""图表组件模块

提供自定义的Matplotlib Widget，用于在PyQt6界面中显示图表。
"""

from typing import Optional, Tuple
import matplotlib
matplotlib.use('Qt5Agg')  # 使用Qt5后端
from matplotlib.backends.backend_qt5agg import FigureCanvasQTAgg as FigureCanvas
from matplotlib.backends.backend_qt5agg import NavigationToolbar2QT as NavigationToolbar
from matplotlib.figure import Figure
from PyQt6.QtWidgets import QWidget, QVBoxLayout
from PyQt6.QtCore import Qt

from ..plot.plot_utils import setup_matplotlib_style
from ..utils.logger import get_logger

logger = get_logger(__name__)


class MatplotlibWidget(QWidget):
    """Matplotlib图表Widget
    
    封装了matplotlib图表，可以在PyQt6界面中使用。
    支持工具栏、图表清空、图表导出等功能。
    """
    
    def __init__(self, parent: Optional[QWidget] = None, 
                 figsize: Tuple[int, int] = (6, 4),
                 dpi: int = 100):
        """初始化Matplotlib Widget
        
        Args:
            parent: 父Widget
            figsize: 图表尺寸（宽，高），单位：英寸
            dpi: 分辨率
        """
        super().__init__(parent)
        
        # 创建matplotlib figure
        self.figure = Figure(figsize=figsize, dpi=dpi)
        self.canvas = FigureCanvas(self.figure)
        
        # 设置matplotlib样式
        setup_matplotlib_style()
        
        # 创建工具栏
        self.toolbar = NavigationToolbar(self.canvas, self)
        
        # 设置布局
        layout = QVBoxLayout()
        layout.setContentsMargins(0, 0, 0, 0)
        layout.setSpacing(0)
        layout.addWidget(self.toolbar)
        layout.addWidget(self.canvas)
        self.setLayout(layout)
        
        # 获取默认axes
        self.axes = self.figure.add_subplot(111)
        
    def get_axes(self):
        """获取当前axes
        
        Returns:
            matplotlib.axes.Axes: 当前axes对象
        """
        return self.axes
    
    def clear(self):
        """清空图表"""
        self.axes.clear()
        self.canvas.draw()
        
    def draw(self):
        """刷新图表显示"""
        self.canvas.draw()
        
    def save_figure(self, filename: str, dpi: int = 300, 
                   bbox_inches: str = 'tight'):
        """保存图表
        
        Args:
            filename: 保存路径
            dpi: 分辨率
            bbox_inches: 边界框设置
        """
        self.figure.savefig(filename, dpi=dpi, bbox_inches=bbox_inches)
        logger.info(f"图表已保存到: {filename}")


class ComparisonPlotWidget(QWidget):
    """左右对比图表Widget
    
    用于显示左右两个对比图表，常用于显示左右轮的数据对比。
    """
    
    def __init__(self, parent: Optional[QWidget] = None,
                 figsize: Tuple[int, int] = (12, 4),
                 dpi: int = 100):
        """初始化对比图表Widget
        
        Args:
            parent: 父Widget
            figsize: 图表尺寸（宽，高），单位：英寸
            dpi: 分辨率
        """
        super().__init__(parent)
        
        # 创建matplotlib figure
        self.figure = Figure(figsize=figsize, dpi=dpi)
        self.canvas = FigureCanvas(self.figure)
        
        # 设置matplotlib样式
        setup_matplotlib_style()
        
        # 创建工具栏
        self.toolbar = NavigationToolbar(self.canvas, self)
        
        # 创建左右两个axes
        self.axes_left = self.figure.add_subplot(121)
        self.axes_right = self.figure.add_subplot(122)
        
        # 设置布局
        layout = QVBoxLayout()
        layout.setContentsMargins(0, 0, 0, 0)
        layout.setSpacing(0)
        layout.addWidget(self.toolbar)
        layout.addWidget(self.canvas)
        self.setLayout(layout)
        
    def get_axes_left(self):
        """获取左侧axes
        
        Returns:
            matplotlib.axes.Axes: 左侧axes对象
        """
        return self.axes_left
    
    def get_axes_right(self):
        """获取右侧axes
        
        Returns:
            matplotlib.axes.Axes: 右侧axes对象
        """
        return self.axes_right
    
    def clear(self):
        """清空图表"""
        self.axes_left.clear()
        self.axes_right.clear()
        self.canvas.draw()
        
    def draw(self):
        """刷新图表显示"""
        self.canvas.draw()
        
    def save_figure(self, filename: str, dpi: int = 300,
                   bbox_inches: str = 'tight'):
        """保存图表
        
        Args:
            filename: 保存路径
            dpi: 分辨率
            bbox_inches: 边界框设置
        """
        self.figure.savefig(filename, dpi=dpi, bbox_inches=bbox_inches)
        logger.info(f"图表已保存到: {filename}")
