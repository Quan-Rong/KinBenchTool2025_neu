"""图表组件模块

提供自定义的Matplotlib Widget，用于在PyQt6界面中显示图表。
"""

from typing import Optional, Tuple
import io
import numpy as np
import matplotlib
matplotlib.use('Qt5Agg')  # 使用Qt5后端
from matplotlib.backends.backend_qt5agg import FigureCanvasQTAgg as FigureCanvas
from matplotlib.backends.backend_qt5agg import NavigationToolbar2QT as NavigationToolbar
from matplotlib.figure import Figure
from PyQt6.QtWidgets import QWidget, QVBoxLayout, QHBoxLayout, QPushButton, QApplication, QMainWindow
from PyQt6.QtCore import Qt, pyqtSignal
from PyQt6.QtGui import QImage

from ..plot.plot_utils import setup_matplotlib_style
from ..utils.logger import get_logger

logger = get_logger(__name__)

# 按钮样式常量
_BTN_COPY_STYLE = """
    QPushButton {
        background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
            stop:0 #6366f1, stop:1 #4f46e5);
        color: white;
        border: none;
        padding: 4px 12px;
        border-radius: 6px;
        font-weight: 600;
        font-size: 11px;
        min-height: 24px;
        max-height: 28px;
    }
    QPushButton:hover {
        background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
            stop:0 #818cf8, stop:1 #6366f1);
    }
    QPushButton:pressed {
        background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
            stop:0 #4f46e5, stop:1 #4338ca);
    }
"""
_BTN_ZERO_STYLE = """
    QPushButton {
        background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
            stop:0 #10b981, stop:1 #059669);
        color: white;
        border: none;
        padding: 4px 12px;
        border-radius: 6px;
        font-weight: 600;
        font-size: 11px;
        min-height: 24px;
        max-height: 28px;
    }
    QPushButton:hover {
        background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
            stop:0 #34d399, stop:1 #10b981);
    }
    QPushButton:pressed {
        background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
            stop:0 #059669, stop:1 #047857);
    }
"""
_BTN_OPEN_STYLE = """
    QPushButton {
        background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
            stop:0 #0ea5e9, stop:1 #0284c7);
        color: white;
        border: none;
        padding: 4px 12px;
        border-radius: 6px;
        font-weight: 600;
        font-size: 11px;
        min-height: 24px;
        max-height: 28px;
    }
    QPushButton:hover {
        background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
            stop:0 #38bdf8, stop:1 #0ea5e9);
    }
    QPushButton:pressed {
        background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
            stop:0 #0284c7, stop:1 #0369a1);
    }
"""
_BTN_DISABLED_STYLE = """
    QPushButton {
        background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
            stop:0 #f1f5f9, stop:1 #e2e8f0);
        color: #475569;
        border: 1px solid #cbd5e1;
        padding: 4px 12px;
        border-radius: 6px;
        font-weight: 600;
        font-size: 11px;
        min-height: 24px;
        max-height: 28px;
    }
    QPushButton:hover {
        background: qlineargradient(x1:0, y1:0, x2:0, y2:1,
            stop:0 #e2e8f0, stop:1 #cbd5e1);
    }
    QPushButton:pressed {
        background: #cbd5e1;
    }
"""


# 保持独立窗口引用，防止被垃圾回收
_plot_windows: list = []


def _show_plot_in_window(png_bytes: bytes, title: str = "图表"):
    """在独立窗口中显示图表图像
    
    Args:
        png_bytes: PNG格式的图像字节数据
        title: 窗口标题
    """
    from PyQt6.QtWidgets import QLabel, QScrollArea
    from PyQt6.QtCore import Qt
    from PyQt6.QtGui import QPixmap
    
    win = QMainWindow()
    win.setWindowTitle(title)
    scroll = QScrollArea()
    scroll.setWidgetResizable(True)
    label = QLabel()
    pixmap = QPixmap()
    if not pixmap.loadFromData(png_bytes):
        logger.error("加载PNG图像失败")
        return
    label.setPixmap(pixmap)
    label.setAlignment(Qt.AlignmentFlag.AlignCenter)
    scroll.setWidget(label)
    win.setCentralWidget(scroll)
    win.resize(800, 600)
    
    def _on_destroyed():
        if win in _plot_windows:
            _plot_windows.remove(win)
    
    win.destroyed.connect(_on_destroyed)
    _plot_windows.append(win)
    win.show()
    win.raise_()
    win.activateWindow()


class MatplotlibWidget(QWidget):
    """Matplotlib图表Widget
    
    封装了matplotlib图表，可以在PyQt6界面中使用。
    支持工具栏、图表清空、图表导出等功能。
    """
    
    # 信号：当需要重新绘制图表时发出（用于移动曲线功能）
    replot_requested = pyqtSignal()
    
    def __init__(self, parent: Optional[QWidget] = None, 
                 figsize: Tuple[int, int] = (7, 5),
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
        
        # Y轴偏移量（用于移动曲线功能）
        self.y_offset = 0.0
        
        # 设置布局
        layout = QVBoxLayout()
        layout.setContentsMargins(0, 0, 0, 0)
        layout.setSpacing(0)
        layout.addWidget(self.toolbar)
        layout.addWidget(self.canvas)
        
        # 添加按钮栏
        self.setup_button_bar(layout)
        
        self.setLayout(layout)
        
        # 获取默认axes
        self.axes = self.figure.add_subplot(111)
        
        # 样本点显示状态
        self.show_sample_points = False
    
    def _on_sample_points_toggled(self):
        """样本点显示按钮切换"""
        self.show_sample_points = self.sample_points_btn.isChecked()
        self.replot_requested.emit()
    
    def set_sample_points_button_enabled(self, enabled: bool):
        """设置样本点按钮是否可用"""
        self.sample_points_btn.setEnabled(enabled)
        if enabled:
            self.sample_points_btn.setStyleSheet(_BTN_OPEN_STYLE)
        else:
            self.sample_points_btn.setStyleSheet(_BTN_DISABLED_STYLE)
    
    def setup_button_bar(self, parent_layout: QVBoxLayout):
        """设置按钮栏"""
        button_layout = QHBoxLayout()
        button_layout.setContentsMargins(8, 4, 8, 4)
        button_layout.setSpacing(8)
        
        button_layout.addStretch()
        self.copy_btn = QPushButton("复制到剪贴板")
        self.copy_btn.setStyleSheet(_BTN_COPY_STYLE)
        self.copy_btn.clicked.connect(self.copy_to_clipboard)
        button_layout.addWidget(self.copy_btn)
        
        self.zero_curve_btn = QPushButton("移动曲线到原点")
        self.zero_curve_btn.setStyleSheet(_BTN_ZERO_STYLE)
        self.zero_curve_btn.clicked.connect(self.move_curve_to_zero)
        button_layout.addWidget(self.zero_curve_btn)
        
        self.open_window_btn = QPushButton("独立窗口")
        self.open_window_btn.setStyleSheet(_BTN_OPEN_STYLE)
        self.open_window_btn.clicked.connect(self.open_in_window)
        button_layout.addWidget(self.open_window_btn)
        
        self.sample_points_btn = QPushButton("样本点显示")
        self.sample_points_btn.setCheckable(True)
        self.sample_points_btn.setChecked(False)
        self.sample_points_btn.setStyleSheet(_BTN_DISABLED_STYLE)
        self.sample_points_btn.setEnabled(False)
        self.sample_points_btn.clicked.connect(self._on_sample_points_toggled)
        button_layout.addWidget(self.sample_points_btn)
        button_layout.addStretch()
        parent_layout.addLayout(button_layout)
    
    def copy_to_clipboard(self):
        """复制图表到剪贴板"""
        try:
            app = QApplication.instance()
            if app is None:
                logger.error("QApplication未初始化，无法访问剪贴板")
                return
            clipboard = app.clipboard()
            if clipboard is None:
                logger.error("无法获取剪贴板")
                return
            buf = io.BytesIO()
            self.figure.savefig(buf, format='png', dpi=150, bbox_inches='tight')
            buf.seek(0)
            image = QImage()
            image.loadFromData(buf.getvalue())
            clipboard.setImage(image)
            logger.info("图表已复制到剪贴板")
        except Exception as e:
            logger.error(f"复制图表到剪贴板失败: {e}", exc_info=True)
    
    def open_in_window(self):
        """在独立窗口中打开图表"""
        try:
            buf = io.BytesIO()
            self.figure.savefig(buf, format='png', dpi=150, bbox_inches='tight')
            buf.seek(0)
            _show_plot_in_window(buf.getvalue(), "图表")
        except Exception as e:
            logger.error(f"在独立窗口打开图表失败: {e}", exc_info=True)
    
    def move_curve_to_zero(self):
        """移动曲线使x=0时y=0"""
        try:
            # 从axes中获取所有线条
            lines = self.axes.get_lines()
            if len(lines) == 0:
                logger.warning("图表中没有线条数据")
                return
            
            # 找到数据曲线（通常是第一条，label='Result'）
            data_line = None
            for line in lines:
                if line.get_label() == 'Result' or line.get_label().startswith('Result'):
                    data_line = line
                    break
            
            if data_line is None:
                # 如果没有找到Result标签的线条，使用第一条
                data_line = lines[0]
            
            # 获取数据
            x_data = np.array(data_line.get_xdata())
            y_data = np.array(data_line.get_ydata())
            
            if len(x_data) == 0:
                return
            
            # 找到x=0对应的y值（使用插值）
            if x_data.min() > 0 or x_data.max() < 0:
                # 如果x=0不在范围内，使用最接近0的点
                zero_idx = np.argmin(np.abs(x_data))
                y_at_zero = y_data[zero_idx]
            else:
                y_at_zero = np.interp(0, x_data, y_data)
            
            # 计算偏移量
            offset = -y_at_zero
            
            # 更新所有线条的y值
            for line in lines:
                y_old = np.array(line.get_ydata())
                y_new = y_old + offset
                line.set_ydata(y_new)
            
            # 更新y轴偏移量
            self.y_offset = offset
            
            # 重新计算拟合线
            self._recalculate_fit_line(offset)
            
            # 刷新图表
            self.canvas.draw()
            
            logger.info(f"曲线已移动到原点，偏移量: {offset:.6f}")
        except Exception as e:
            logger.error(f"移动曲线到原点失败: {e}", exc_info=True)
    
    def _recalculate_fit_line(self, offset: float):
        """重新计算拟合线
        
        Args:
            offset: Y轴偏移量
        """
        try:
            # 找到拟合线（通常label包含'fitting'）
            fit_lines = [line for line in self.axes.get_lines() 
                        if 'fitting' in line.get_label().lower()]
            
            if len(fit_lines) == 0:
                return
            
            # 获取拟合公式文本
            texts = self.axes.texts
            fit_text = None
            for text in texts:
                if 'y =' in text.get_text():
                    fit_text = text
                    break
            
            if fit_text is None:
                return
            
            # 获取拟合线的数据
            fit_line = fit_lines[0]
            x_fit = np.array(fit_line.get_xdata())
            y_fit_old = np.array(fit_line.get_ydata())
            
            # 应用偏移量
            y_fit_new = y_fit_old + offset
            
            # 更新拟合线
            fit_line.set_ydata(y_fit_new)
            
            # 重新计算拟合系数（使用偏移后的数据）
            if len(x_fit) > 1:
                # 使用numpy的polyfit重新拟合
                coeffs = np.polyfit(x_fit, y_fit_new, 1)
                
                # 更新拟合公式文本
                a, b = coeffs[0], coeffs[1]
                if b >= 0:
                    formula = f'y = {a:.4f}*x+{b:.4f}'
                else:
                    formula = f'y = {a:.4f}*x{b:.4f}'
                
                fit_text.set_text(formula)
                
                logger.debug(f"拟合公式已更新: {formula}")
        except Exception as e:
            logger.warning(f"重新计算拟合线失败: {e}")
    
    def get_y_offset(self) -> float:
        """获取Y轴偏移量
        
        Returns:
            Y轴偏移量
        """
        return self.y_offset
    
    def set_y_offset(self, offset: float):
        """设置Y轴偏移量
        
        Args:
            offset: Y轴偏移量
        """
        self.y_offset = offset
    
    def reset_y_offset(self):
        """重置Y轴偏移量"""
        self.y_offset = 0.0
        
    def get_axes(self):
        """获取当前axes
        
        Returns:
            matplotlib.axes.Axes: 当前axes对象
        """
        return self.axes
    
    def clear(self):
        """清空图表"""
        self.axes.clear()
        self.y_offset = 0.0  # 重置偏移量
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
    
    用于显示左右两个对比图表，每个子plot下方有独立的4个功能按钮。
    """
    
    replot_requested = pyqtSignal()
    
    def __init__(self, parent: Optional[QWidget] = None,
                 figsize: Tuple[int, int] = (14, 5),
                 dpi: int = 100):
        super().__init__(parent)
        setup_matplotlib_style()
        
        # 左右各一个figure和canvas
        half_width = figsize[0] // 2
        self.figure_left = Figure(figsize=(half_width, figsize[1]), dpi=dpi)
        self.figure_right = Figure(figsize=(half_width, figsize[1]), dpi=dpi)
        self.canvas_left = FigureCanvas(self.figure_left)
        self.canvas_right = FigureCanvas(self.figure_right)
        
        self.axes_left = self.figure_left.add_subplot(111)
        self.axes_right = self.figure_right.add_subplot(111)
        
        self.y_offset_left = 0.0
        self.y_offset_right = 0.0
        
        # 样本点显示状态（在_add_button_bar中初始化按钮引用）
        self.show_sample_points_left = False
        self.show_sample_points_right = False
        
        # 主布局：左右两列
        main_layout = QHBoxLayout()
        main_layout.setContentsMargins(0, 0, 0, 0)
        main_layout.setSpacing(8)
        
        # 左侧面板：canvas + 4按钮
        left_panel = QVBoxLayout()
        left_panel.setSpacing(0)
        left_panel.addWidget(NavigationToolbar(self.canvas_left, self))
        left_panel.addWidget(self.canvas_left)
        self._add_button_bar(left_panel, is_left=True)
        main_layout.addLayout(left_panel, 1)
        
        # 右侧面板：canvas + 4按钮
        right_panel = QVBoxLayout()
        right_panel.setSpacing(0)
        right_panel.addWidget(NavigationToolbar(self.canvas_right, self))
        right_panel.addWidget(self.canvas_right)
        self._add_button_bar(right_panel, is_left=False)
        main_layout.addLayout(right_panel, 1)
        
        self.setLayout(main_layout)
    
    def _add_button_bar(self, parent_layout: QVBoxLayout, is_left: bool):
        """为指定侧添加按钮栏"""
        btn_layout = QHBoxLayout()
        btn_layout.setContentsMargins(8, 4, 8, 4)
        btn_layout.setSpacing(8)
        
        btn_layout.addStretch()
        copy_btn = QPushButton("复制到剪贴板")
        copy_btn.setStyleSheet(_BTN_COPY_STYLE)
        copy_btn.clicked.connect(lambda: self._copy_axes_to_clipboard(is_left))
        btn_layout.addWidget(copy_btn)
        
        zero_btn = QPushButton("移动曲线到原点")
        zero_btn.setStyleSheet(_BTN_ZERO_STYLE)
        zero_btn.clicked.connect(lambda: self._move_curve_to_zero_axes(is_left))
        btn_layout.addWidget(zero_btn)
        
        open_btn = QPushButton("独立窗口")
        open_btn.setStyleSheet(_BTN_OPEN_STYLE)
        open_btn.clicked.connect(lambda: self._open_axes_in_window(is_left))
        btn_layout.addWidget(open_btn)
        
        sample_btn = QPushButton("样本点显示")
        sample_btn.setCheckable(True)
        sample_btn.setChecked(False)
        sample_btn.setStyleSheet(_BTN_DISABLED_STYLE)
        sample_btn.setEnabled(False)
        if is_left:
            self.sample_points_btn_left = sample_btn
        else:
            self.sample_points_btn_right = sample_btn
        sample_btn.clicked.connect(lambda: self._on_sample_points_toggled(is_left))
        btn_layout.addWidget(sample_btn)
        btn_layout.addStretch()
        parent_layout.addLayout(btn_layout)
    
    def _on_sample_points_toggled(self, is_left: bool):
        """样本点显示按钮切换"""
        if is_left:
            self.show_sample_points_left = self.sample_points_btn_left.isChecked()
        else:
            self.show_sample_points_right = self.sample_points_btn_right.isChecked()
        self.replot_requested.emit()
    
    def set_sample_points_button_enabled(self, enabled: bool, is_left: Optional[bool] = None):
        """设置样本点按钮是否可用
        
        Args:
            enabled: 是否启用
            is_left: 若为None则同时设置左右两侧
        """
        style = _BTN_OPEN_STYLE if enabled else _BTN_DISABLED_STYLE
        if is_left is None:
            self.sample_points_btn_left.setEnabled(enabled)
            self.sample_points_btn_right.setEnabled(enabled)
            self.sample_points_btn_left.setStyleSheet(style)
            self.sample_points_btn_right.setStyleSheet(style)
        elif is_left:
            self.sample_points_btn_left.setEnabled(enabled)
            self.sample_points_btn_left.setStyleSheet(style)
        else:
            self.sample_points_btn_right.setEnabled(enabled)
            self.sample_points_btn_right.setStyleSheet(style)
    
    def _copy_axes_to_clipboard(self, is_left: bool):
        """复制指定侧的axes到剪贴板"""
        try:
            app = QApplication.instance()
            if app is None:
                logger.error("QApplication未初始化，无法访问剪贴板")
                return
            clipboard = app.clipboard()
            if clipboard is None:
                logger.error("无法获取剪贴板")
                return
            fig = self.figure_left if is_left else self.figure_right
            buf = io.BytesIO()
            fig.savefig(buf, format='png', dpi=150, bbox_inches='tight')
            buf.seek(0)
            image = QImage()
            image.loadFromData(buf.getvalue())
            clipboard.setImage(image)
            logger.info("图表已复制到剪贴板")
        except Exception as e:
            logger.error(f"复制图表到剪贴板失败: {e}", exc_info=True)
    
    def _open_axes_in_window(self, is_left: bool):
        """在独立窗口中打开指定侧的plot"""
        try:
            fig = self.figure_left if is_left else self.figure_right
            buf = io.BytesIO()
            fig.savefig(buf, format='png', dpi=150, bbox_inches='tight')
            buf.seek(0)
            title = "左图" if is_left else "右图"
            _show_plot_in_window(buf.getvalue(), title)
        except Exception as e:
            logger.error(f"在独立窗口打开图表失败: {e}", exc_info=True)
    
    def _move_curve_to_zero_axes(self, is_left: bool):
        """移动指定侧的曲线到原点"""
        try:
            ax = self.axes_left if is_left else self.axes_right
            self._move_curve_to_zero_for_axes(ax, is_left=is_left)
            canvas = self.canvas_left if is_left else self.canvas_right
            canvas.draw()
            logger.info("曲线已移动到原点")
        except Exception as e:
            logger.error(f"移动曲线到原点失败: {e}", exc_info=True)
    
    def _move_curve_to_zero_for_axes(self, ax, is_left: bool):
        """移动指定axes的曲线到原点
        
        Args:
            ax: matplotlib axes对象
            is_left: 是否为左侧axes
        """
        try:
            # 从axes中获取所有线条
            lines = ax.get_lines()
            if len(lines) == 0:
                return
            
            # 找到数据曲线（通常是第一条，label='Result'）
            data_line = None
            for line in lines:
                if line.get_label() == 'Result' or line.get_label().startswith('Result'):
                    data_line = line
                    break
            
            if data_line is None:
                # 如果没有找到Result标签的线条，使用第一条
                data_line = lines[0]
            
            # 获取数据
            x_data = np.array(data_line.get_xdata())
            y_data = np.array(data_line.get_ydata())
            
            if len(x_data) == 0:
                return
            
            # 找到x=0对应的y值（使用插值）
            if x_data.min() > 0 or x_data.max() < 0:
                # 如果x=0不在范围内，使用最接近0的点
                zero_idx = np.argmin(np.abs(x_data))
                y_at_zero = y_data[zero_idx]
            else:
                y_at_zero = np.interp(0, x_data, y_data)
            
            # 计算偏移量
            offset = -y_at_zero
            
            # 更新所有线条的y值
            for line in lines:
                y_old = np.array(line.get_ydata())
                y_new = y_old + offset
                line.set_ydata(y_new)
            
            # 更新y轴偏移量
            if is_left:
                self.y_offset_left = offset
            else:
                self.y_offset_right = offset
            
            # 重新计算拟合线
            self._recalculate_fit_line_for_axes(ax, offset)
        except Exception as e:
            logger.warning(f"移动曲线失败 (is_left={is_left}): {e}")
    
    def _recalculate_fit_line_for_axes(self, ax, offset: float):
        """重新计算指定axes的拟合线
        
        Args:
            ax: matplotlib axes对象
            offset: Y轴偏移量
        """
        try:
            # 找到拟合线（通常label包含'fitting'）
            fit_lines = [line for line in ax.get_lines() 
                        if 'fitting' in line.get_label().lower()]
            
            if len(fit_lines) == 0:
                return
            
            # 获取拟合公式文本
            texts = ax.texts
            fit_text = None
            for text in texts:
                if 'y =' in text.get_text():
                    fit_text = text
                    break
            
            if fit_text is None:
                return
            
            # 获取拟合线的数据
            fit_line = fit_lines[0]
            x_fit = np.array(fit_line.get_xdata())
            y_fit_old = np.array(fit_line.get_ydata())
            
            # 应用偏移量
            y_fit_new = y_fit_old + offset
            
            # 更新拟合线
            fit_line.set_ydata(y_fit_new)
            
            # 重新计算拟合系数（使用偏移后的数据）
            if len(x_fit) > 1:
                # 使用numpy的polyfit重新拟合
                coeffs = np.polyfit(x_fit, y_fit_new, 1)
                
                # 更新拟合公式文本
                a, b = coeffs[0], coeffs[1]
                if b >= 0:
                    formula = f'y = {a:.4f}*x+{b:.4f}'
                else:
                    formula = f'y = {a:.4f}*x{b:.4f}'
                
                fit_text.set_text(formula)
                
                logger.debug(f"拟合公式已更新: {formula}")
        except Exception as e:
            logger.warning(f"重新计算拟合线失败: {e}")
    
    def get_y_offset_left(self) -> float:
        """获取左侧Y轴偏移量
        
        Returns:
            左侧Y轴偏移量
        """
        return self.y_offset_left
    
    def get_y_offset_right(self) -> float:
        """获取右侧Y轴偏移量
        
        Returns:
            右侧Y轴偏移量
        """
        return self.y_offset_right
    
    def set_y_offset_left(self, offset: float):
        """设置左侧Y轴偏移量
        
        Args:
            offset: Y轴偏移量
        """
        self.y_offset_left = offset
    
    def set_y_offset_right(self, offset: float):
        """设置右侧Y轴偏移量
        
        Args:
            offset: Y轴偏移量
        """
        self.y_offset_right = offset
    
    def reset_y_offsets(self):
        """重置Y轴偏移量"""
        self.y_offset_left = 0.0
        self.y_offset_right = 0.0
        
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
        self.y_offset_left = 0.0
        self.y_offset_right = 0.0
        self.canvas_left.draw()
        self.canvas_right.draw()
        
    def draw(self):
        """刷新图表显示"""
        self.canvas_left.draw()
        self.canvas_right.draw()
        
    def save_figure(self, filename: str, dpi: int = 300,
                   bbox_inches: str = 'tight'):
        """保存图表（左右合并为一张图）"""
        try:
            import matplotlib.image as mpimg
            buf_left = io.BytesIO()
            buf_right = io.BytesIO()
            self.figure_left.savefig(buf_left, dpi=dpi, bbox_inches=bbox_inches)
            self.figure_right.savefig(buf_right, dpi=dpi, bbox_inches=bbox_inches)
            buf_left.seek(0)
            buf_right.seek(0)
            img_left = mpimg.imread(buf_left)
            img_right = mpimg.imread(buf_right)
            fig = Figure(figsize=(14, 5), dpi=dpi)
            ax1 = fig.add_subplot(121)
            ax2 = fig.add_subplot(122)
            ax1.imshow(img_left)
            ax1.axis('off')
            ax2.imshow(img_right)
            ax2.axis('off')
            fig.savefig(filename, dpi=dpi, bbox_inches=bbox_inches)
            logger.info(f"图表已保存到: {filename}")
        except Exception as e:
            logger.error(f"保存图表失败: {e}", exc_info=True)
