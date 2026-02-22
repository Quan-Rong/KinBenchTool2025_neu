"""改进的程序监控脚本
运行程序并实时记录所有操作中遇到的问题
"""

import sys
import traceback
import logging
import threading
import time
from pathlib import Path
from datetime import datetime
from io import StringIO

# 设置日志记录
log_dir = Path(__file__).parent / "monitor_logs"
log_dir.mkdir(exist_ok=True)

timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
log_file = log_dir / f"monitor_{timestamp}.txt"
error_summary_file = log_dir / f"error_summary_{timestamp}.txt"

# 配置日志
logging.basicConfig(
    level=logging.DEBUG,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler(log_file, encoding='utf-8'),
        logging.StreamHandler(sys.stdout)
    ]
)

logger = logging.getLogger(__name__)

# 错误收集器
class ErrorCollector:
    def __init__(self):
        self.errors = []
        self.warnings = []
        self.exceptions = []
        self.original_stderr = sys.stderr
        self.buffer = StringIO()
        self.lock = threading.Lock()
        
    def write(self, text):
        if text.strip():
            with self.lock:
                self.errors.append({
                    'timestamp': datetime.now().isoformat(),
                    'message': text.strip()
                })
                logger.error(f"STDERR: {text.strip()}")
        self.original_stderr.write(text)
        self.buffer.write(text)
        
    def flush(self):
        self.original_stderr.flush()
        
    def add_exception(self, exc_type, exc_value, exc_traceback):
        error_msg = ''.join(traceback.format_exception(exc_type, exc_value, exc_traceback))
        with self.lock:
            self.exceptions.append({
                'timestamp': datetime.now().isoformat(),
                'type': str(exc_type.__name__),
                'message': str(exc_value),
                'traceback': error_msg
            })
        logger.critical(f"异常捕获:\n{error_msg}")
        
    def get_summary(self):
        with self.lock:
            return {
                'errors': self.errors,
                'warnings': self.warnings,
                'exceptions': self.exceptions,
                'total_errors': len(self.errors),
                'total_exceptions': len(self.exceptions)
            }

error_collector = ErrorCollector()
sys.stderr = error_collector

# 捕获所有未处理的异常
def handle_exception(exc_type, exc_value, exc_traceback):
    if issubclass(exc_type, KeyboardInterrupt):
        sys.__excepthook__(exc_type, exc_value, exc_traceback)
        return
    
    error_collector.add_exception(exc_type, exc_value, exc_traceback)

sys.excepthook = handle_exception

# 监控线程
def monitor_thread():
    """后台监控线程，定期记录状态"""
    while True:
        time.sleep(30)  # 每30秒记录一次状态
        summary = error_collector.get_summary()
        if summary['total_errors'] > 0 or summary['total_exceptions'] > 0:
            logger.info(f"监控状态: {summary['total_errors']} 个错误, {summary['total_exceptions']} 个异常")

# 生成错误报告
def generate_error_report():
    """生成详细的错误报告"""
    summary = error_collector.get_summary()
    
    with open(error_summary_file, 'w', encoding='utf-8') as f:
        f.write("=" * 80 + "\n")
        f.write(f"程序运行错误报告\n")
        f.write(f"生成时间: {datetime.now()}\n")
        f.write("=" * 80 + "\n\n")
        
        f.write(f"总错误数: {summary['total_errors']}\n")
        f.write(f"总异常数: {summary['total_exceptions']}\n\n")
        
        if summary['exceptions']:
            f.write("=" * 80 + "\n")
            f.write("异常列表:\n")
            f.write("=" * 80 + "\n\n")
            for i, exc in enumerate(summary['exceptions'], 1):
                f.write(f"\n异常 #{i}:\n")
                f.write(f"时间: {exc['timestamp']}\n")
                f.write(f"类型: {exc['type']}\n")
                f.write(f"消息: {exc['message']}\n")
                f.write(f"堆栈跟踪:\n{exc['traceback']}\n")
                f.write("-" * 80 + "\n")
        
        if summary['errors']:
            f.write("\n" + "=" * 80 + "\n")
            f.write("错误消息列表:\n")
            f.write("=" * 80 + "\n\n")
            for i, err in enumerate(summary['errors'], 1):
                f.write(f"错误 #{i} [{err['timestamp']}]: {err['message']}\n")
    
    logger.info(f"错误报告已保存到: {error_summary_file}")

logger.info("=" * 80)
logger.info(f"开始监控程序运行 - {datetime.now()}")
logger.info(f"日志文件: {log_file}")
logger.info("=" * 80)

# 启动监控线程
monitor = threading.Thread(target=monitor_thread, daemon=True)
monitor.start()

try:
    # 导入并运行主程序
    logger.info("正在导入主程序模块...")
    from main import main
    
    logger.info("正在启动主程序...")
    main()
    
except KeyboardInterrupt:
    logger.info("程序被用户中断")
except Exception as e:
    error_collector.add_exception(type(e), e, e.__traceback__)
    logger.critical(f"程序启动失败")
finally:
    logger.info("=" * 80)
    logger.info(f"程序运行结束 - {datetime.now()}")
    
    # 生成错误报告
    generate_error_report()
    
    summary = error_collector.get_summary()
    logger.info(f"共捕获 {summary['total_errors']} 个错误, {summary['total_exceptions']} 个异常")
    logger.info("=" * 80)
    
    # 恢复stderr
    sys.stderr = error_collector.original_stderr
