"""错误处理工具模块

提供统一的错误处理和用户友好的错误消息。
"""

from typing import Optional, Dict, Any, TYPE_CHECKING

# 尝试导入 PyQt6，如果失败则设为 None（用于无头环境）
try:
    from PyQt6.QtWidgets import QMessageBox, QWidget
    HAS_PYQT6 = True
except ImportError:
    # 在无头环境（如 CI）中，PyQt6 可能不可用
    HAS_PYQT6 = False
    if TYPE_CHECKING:
        from PyQt6.QtWidgets import QMessageBox, QWidget

from ..utils.logger import get_logger
from ..utils.exceptions import (KnCToolError, FileError, DataValidationError, 
                                CalculationError, PlotGenerationError)

logger = get_logger(__name__)


class ErrorHandler:
    """错误处理器
    
    提供统一的错误处理和用户友好的错误消息。
    """
    
    # 错误消息模板（中英文）
    ERROR_MESSAGES = {
        'file_not_found': {
            'en': 'File not found',
            'zh': '文件未找到',
            'suggestion': 'Please check if the file path is correct and the file exists.'
        },
        'permission_denied': {
            'en': 'Permission denied',
            'zh': '权限被拒绝',
            'suggestion': 'Please check file permissions or try running as administrator.'
        },
        'file_format_error': {
            'en': 'Invalid file format',
            'zh': '文件格式错误',
            'suggestion': 'Please ensure the file is a valid .res file from Adams.'
        },
        'data_validation_error': {
            'en': 'Data validation failed',
            'zh': '数据验证失败',
            'suggestion': 'Please check the data quality and try again.'
        },
        'calculation_error': {
            'en': 'Calculation error',
            'zh': '计算错误',
            'suggestion': 'Please check input parameters and data quality.'
        },
        'plot_generation_error': {
            'en': 'Failed to generate plot',
            'zh': '图表生成失败',
            'suggestion': 'Please check data and try again.'
        },
        'unknown_error': {
            'en': 'Unknown error occurred',
            'zh': '发生未知错误',
            'suggestion': 'Please check the log file for details.'
        }
    }
    
    @staticmethod
    def get_error_message(error_type: str, language: str = 'zh', 
                         details: Optional[str] = None) -> str:
        """获取错误消息
        
        Args:
            error_type: 错误类型
            language: 语言 ('zh' 或 'en')
            details: 详细信息
            
        Returns:
            格式化的错误消息
        """
        if error_type not in ErrorHandler.ERROR_MESSAGES:
            error_type = 'unknown_error'
        
        msg_template = ErrorHandler.ERROR_MESSAGES[error_type]
        title = msg_template[language]
        suggestion = msg_template['suggestion']
        
        if details:
            return f"{title}\n\n详细信息: {details}\n\n建议: {suggestion}"
        else:
            return f"{title}\n\n建议: {suggestion}"
    
    @staticmethod
    def show_error(parent: Optional['QWidget'], error: Exception, 
                  error_type: Optional[str] = None, 
                  language: str = 'zh') -> None:
        """显示错误对话框
        
        Args:
            parent: 父窗口
            error: 异常对象
            error_type: 错误类型，如果为None则自动判断
            language: 语言 ('zh' 或 'en')
        """
        # 自动判断错误类型
        if error_type is None:
            if isinstance(error, FileError):
                if isinstance(error, FileNotFoundError):
                    error_type = 'file_not_found'
                elif isinstance(error, PermissionError):
                    error_type = 'permission_denied'
                else:
                    error_type = 'file_format_error'
            elif isinstance(error, DataValidationError):
                error_type = 'data_validation_error'
            elif isinstance(error, CalculationError):
                error_type = 'calculation_error'
            elif isinstance(error, PlotGenerationError):
                error_type = 'plot_generation_error'
            else:
                error_type = 'unknown_error'
        
        # 获取错误消息
        error_msg = str(error)
        if len(error_msg) > 300:
            error_msg = error_msg[:300] + "..."
        
        message = ErrorHandler.get_error_message(error_type, language, error_msg)
        
        # 记录日志
        logger.error(f"显示错误对话框: {error_type}, {error}", exc_info=True)
        
        # 显示对话框（如果 PyQt6 可用）
        if HAS_PYQT6:
            QMessageBox.critical(parent, "Error", message)
        else:
            logger.warning(f"无法显示错误对话框（无 GUI 环境）: {message}")
    
    @staticmethod
    def show_warning(parent: Optional['QWidget'], title: str, message: str,
                    language: str = 'zh') -> None:
        """显示警告对话框
        
        Args:
            parent: 父窗口
            title: 标题
            message: 消息内容
            language: 语言 ('zh' 或 'en')
        """
        logger.warning(f"显示警告: {title}, {message}")
        if HAS_PYQT6:
            QMessageBox.warning(parent, title, message)
        else:
            logger.warning(f"无法显示警告对话框（无 GUI 环境）: {title} - {message}")
    
    @staticmethod
    def show_info(parent: Optional['QWidget'], title: str, message: str) -> None:
        """显示信息对话框
        
        Args:
            parent: 父窗口
            title: 标题
            message: 消息内容
        """
        logger.info(f"显示信息: {title}, {message}")
        if HAS_PYQT6:
            QMessageBox.information(parent, title, message)
        else:
            logger.info(f"无法显示信息对话框（无 GUI 环境）: {title} - {message}")
    
    @staticmethod
    def handle_exception(parent: Optional['QWidget'], exception: Exception,
                        context: str = "", language: str = 'zh') -> None:
        """统一异常处理
        
        Args:
            parent: 父窗口
            exception: 异常对象
            context: 上下文信息（如操作名称）
            language: 语言 ('zh' 或 'en')
        """
        error_type = None
        
        # 根据异常类型确定错误类型
        if isinstance(exception, FileNotFoundError):
            error_type = 'file_not_found'
        elif isinstance(exception, PermissionError):
            error_type = 'permission_denied'
        elif isinstance(exception, DataValidationError):
            error_type = 'data_validation_error'
        elif isinstance(exception, CalculationError):
            error_type = 'calculation_error'
        elif isinstance(exception, PlotGenerationError):
            error_type = 'plot_generation_error'
        elif isinstance(exception, KnCToolError):
            error_type = 'unknown_error'
        
        # 构建详细信息
        details = f"{context}\n{str(exception)}" if context else str(exception)
        
        ErrorHandler.show_error(parent, exception, error_type, language)
