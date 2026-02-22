"""程序监控脚本
运行程序并记录所有操作中遇到的问题
"""

import sys
import traceback
import logging
from pathlib import Path
from datetime import datetime
from io import StringIO

# 设置日志记录
log_file = Path(__file__).parent / "monitor_log.txt"
logging.basicConfig(
    level=logging.DEBUG,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler(log_file, encoding='utf-8'),
        logging.StreamHandler(sys.stdout)
    ]
)

logger = logging.getLogger(__name__)

# 重定向stderr以捕获所有错误
class ErrorCapture:
    def __init__(self):
        self.errors = []
        self.original_stderr = sys.stderr
        self.buffer = StringIO()
        
    def write(self, text):
        if text.strip():
            self.errors.append(text)
            logger.error(f"STDERR: {text.strip()}")
        self.original_stderr.write(text)
        self.buffer.write(text)
        
    def flush(self):
        self.original_stderr.flush()
        
    def get_errors(self):
        return self.errors

error_capture = ErrorCapture()
sys.stderr = error_capture

# 捕获所有未处理的异常
def handle_exception(exc_type, exc_value, exc_traceback):
    if issubclass(exc_type, KeyboardInterrupt):
        sys.__excepthook__(exc_type, exc_value, exc_traceback)
        return
    
    error_msg = ''.join(traceback.format_exception(exc_type, exc_value, exc_traceback))
    logger.critical(f"未捕获的异常:\n{error_msg}")
    error_capture.errors.append(error_msg)

sys.excepthook = handle_exception

logger.info("=" * 80)
logger.info(f"开始监控程序运行 - {datetime.now()}")
logger.info("=" * 80)

try:
    # 导入并运行主程序
    from main import main
    
    logger.info("正在启动主程序...")
    main()
    
except KeyboardInterrupt:
    logger.info("程序被用户中断")
except Exception as e:
    error_msg = ''.join(traceback.format_exception(type(e), e, e.__traceback__))
    logger.critical(f"程序启动失败:\n{error_msg}")
finally:
    logger.info("=" * 80)
    logger.info(f"程序运行结束 - {datetime.now()}")
    logger.info(f"共捕获 {len(error_capture.get_errors())} 个错误")
    logger.info("=" * 80)
    
    # 恢复stderr
    sys.stderr = error_capture.original_stderr
    
    # 输出总结
    if error_capture.get_errors():
        logger.info("\n捕获的错误列表:")
        for i, error in enumerate(error_capture.get_errors(), 1):
            logger.info(f"\n错误 #{i}:\n{error}")
