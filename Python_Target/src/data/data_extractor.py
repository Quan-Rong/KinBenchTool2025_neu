"""数据提取模块

根据参数ID从quasiStatic数据矩阵中提取所需数据。
"""

from typing import List, Union

import numpy as np

from .res_parser import ResParser
from .unit_converter import convert_angle_array, convert_length_array
from ..utils.logger import get_logger

logger = get_logger(__name__)


class DataExtractor:
    """数据提取器
    
    从解析后的.res文件中提取所需参数的数据。
    """
    
    def __init__(self, parser: ResParser):
        """初始化数据提取器
        
        Args:
            parser: ResParser实例，已完成文件解析
        """
        self.parser = parser
        if parser.quasi_static_data is None:
            raise ValueError("解析器尚未解析数据，请先调用parser.parse()")
    
    def extract_by_name(self, param_name: str, 
                        convert_angle: bool = False,
                        convert_length: bool = False) -> np.ndarray:
        """根据参数名称提取数据
        
        Args:
            param_name: 参数名称
            convert_angle: 是否将角度从弧度转换为度
            convert_length: 是否将长度从毫米转换为米
            
        Returns:
            数据数组
        """
        param_id = self.parser.get_param_id(param_name)
        data = self.parser.get_data_column(param_id)
        
        # 单位转换
        if convert_angle:
            data = convert_angle_array(data, from_unit='rad', to_unit='deg')
        if convert_length:
            data = convert_length_array(data, from_unit='mm', to_unit='m')
        
        logger.debug(f"提取参数 {param_name}: 形状 {data.shape}")
        return data
    
    def extract_by_id(self, param_id: Union[int, List[int]],
                      convert_angle: bool = False,
                      convert_length: bool = False) -> np.ndarray:
        """根据参数ID提取数据
        
        Args:
            param_id: 参数ID（单个值或列表）
            convert_angle: 是否将角度从弧度转换为度
            convert_length: 是否将长度从毫米转换为米
            
        Returns:
            数据数组
        """
        data = self.parser.get_data_column(param_id)
        
        # 单位转换
        if convert_angle:
            data = convert_angle_array(data, from_unit='rad', to_unit='deg')
        if convert_length:
            data = convert_length_array(data, from_unit='mm', to_unit='m')
        
        logger.debug(f"提取参数ID {param_id}: 形状 {data.shape}")
        return data
    
    def extract_multiple(self, param_names: List[str],
                        convert_angle: bool = False,
                        convert_length: bool = False) -> np.ndarray:
        """提取多个参数的数据
        
        Args:
            param_names: 参数名称列表
            convert_angle: 是否将角度从弧度转换为度
            convert_length: 是否将长度从毫米转换为米
            
        Returns:
            数据数组，形状为 (n_steps, n_params)
        """
        data_list = []
        for param_name in param_names:
            data = self.extract_by_name(param_name, convert_angle, convert_length)
            # 如果是多维参数，展平
            if data.ndim > 1:
                data = data.flatten()
            data_list.append(data)
        
        # 堆叠为二维数组
        result = np.column_stack(data_list)
        logger.debug(f"提取多个参数: {param_names}, 形状 {result.shape}")
        return result
    
    def filter_data(self, data: np.ndarray, 
                   condition: np.ndarray) -> np.ndarray:
        """根据条件筛选数据
        
        Args:
            data: 数据数组
            condition: 布尔数组，True表示保留该行
            
        Returns:
            筛选后的数据
        """
        if len(condition) != len(data):
            raise ValueError(f"条件数组长度({len(condition)})与数据长度({len(data)})不匹配")
        
        filtered = data[condition]
        logger.debug(f"数据筛选: {len(data)} -> {len(filtered)}")
        return filtered
    
    def extract_wheel_travel_left_right(self, convert_length: bool = False) -> tuple:
        """提取左右轮的wheel_travel数据
        
        在bump测试中，左右轮的wheel_travel应该相同（都使用wheel_travel_ID(1)的数据）
        
        Args:
            convert_length: 是否将长度从毫米转换为米
            
        Returns:
            (wheel_travel_left, wheel_travel_right): 左右轮的wheel_travel数据（相同）
        """
        wheel_travel_ids = self.parser.get_param_id('wheel_travel')
        if isinstance(wheel_travel_ids, list) and len(wheel_travel_ids) >= 1:
            # 左右轮都使用第一个ID的数据（wheel_travel_ID(1)）
            wheel_travel_data = self.extract_by_id(wheel_travel_ids[0], convert_length=convert_length)
            # 确保是一维数组
            if wheel_travel_data.ndim > 1:
                # 如果是多维的，取vertical分量（第二列）
                wheel_travel_data = wheel_travel_data[:, 1] if wheel_travel_data.shape[1] > 1 else wheel_travel_data[:, 0]
            if wheel_travel_data.ndim > 1:
                wheel_travel_data = wheel_travel_data.flatten()
            # 左右轮使用相同的数据
            wheel_travel_left = wheel_travel_data
            wheel_travel_right = wheel_travel_data
        else:
            # 如果只有一个ID，则左右轮使用相同的数据
            wheel_travel_data = self.extract_by_name('wheel_travel', convert_length=convert_length)
            if wheel_travel_data.ndim > 1:
                # 如果是多维的，取vertical分量（第二列）
                wheel_travel_left = wheel_travel_data[:, 1] if wheel_travel_data.shape[1] > 1 else wheel_travel_data[:, 0]
                wheel_travel_right = wheel_travel_left  # 左右轮相同
            else:
                wheel_travel_left = wheel_travel_data
                wheel_travel_right = wheel_travel_data
            
            # 确保是一维数组
            if wheel_travel_left.ndim > 1:
                wheel_travel_left = wheel_travel_left.flatten()
            if wheel_travel_right.ndim > 1:
                wheel_travel_right = wheel_travel_right.flatten()
        
        return wheel_travel_left, wheel_travel_right