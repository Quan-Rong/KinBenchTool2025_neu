"""自定义异常类。

定义项目中使用的所有自定义异常。
"""


class KnCToolError(Exception):
    """K&C工具基础异常类。"""
    pass


class FileParseError(KnCToolError):
    """文件解析错误。"""
    pass


class DataValidationError(KnCToolError):
    """数据验证错误。"""
    pass


class CalculationError(KnCToolError):
    """计算错误。"""
    pass


class PlotGenerationError(KnCToolError):
    """图表生成错误。"""
    pass


class ConfigurationError(KnCToolError):
    """配置错误。"""
    pass
