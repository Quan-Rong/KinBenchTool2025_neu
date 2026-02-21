"""配置加载模块

加载和管理应用配置。
"""

import yaml
from pathlib import Path
from typing import Dict, Any, Optional

from ..utils.logger import get_logger
from ..utils.exceptions import FileError

logger = get_logger(__name__)


class ConfigLoader:
    """配置加载器"""
    
    def __init__(self, config_dir: Optional[Path] = None):
        """初始化配置加载器
        
        Args:
            config_dir: 配置文件目录，如果为None则使用默认目录
        """
        if config_dir is None:
            # 默认配置文件目录
            self.config_dir = Path(__file__).parent.parent.parent / "config"
        else:
            self.config_dir = Path(config_dir)
        
        self._app_config: Optional[Dict[str, Any]] = None
        self._kc_params: Optional[Dict[str, Any]] = None
    
    def load_app_config(self, config_file: str = "app_config.yaml") -> Dict[str, Any]:
        """加载应用配置
        
        Args:
            config_file: 配置文件名称
            
        Returns:
            配置字典
            
        Raises:
            FileError: 配置文件不存在或无法读取
        """
        config_path = self.config_dir / config_file
        
        if not config_path.exists():
            raise FileError(f"配置文件不存在: {config_path}")
        
        try:
            with open(config_path, 'r', encoding='utf-8') as f:
                self._app_config = yaml.safe_load(f)
            logger.info(f"加载应用配置: {config_path}")
            return self._app_config
        except Exception as e:
            raise FileError(f"加载配置文件失败: {e}") from e
    
    def load_kc_params(self, config_file: str = "kc_params.yaml") -> Dict[str, Any]:
        """加载K&C参数配置
        
        Args:
            config_file: 配置文件名称
            
        Returns:
            参数配置字典
            
        Raises:
            FileError: 配置文件不存在或无法读取
        """
        config_path = self.config_dir / config_file
        
        if not config_path.exists():
            raise FileError(f"配置文件不存在: {config_path}")
        
        try:
            with open(config_path, 'r', encoding='utf-8') as f:
                self._kc_params = yaml.safe_load(f)
            logger.info(f"加载K&C参数配置: {config_path}")
            return self._kc_params
        except Exception as e:
            raise FileError(f"加载配置文件失败: {e}") from e
    
    def get_app_config(self) -> Dict[str, Any]:
        """获取应用配置（如果未加载则自动加载）
        
        Returns:
            配置字典
        """
        if self._app_config is None:
            self.load_app_config()
        return self._app_config
    
    def get_kc_params(self) -> Dict[str, Any]:
        """获取K&C参数配置（如果未加载则自动加载）
        
        Returns:
            参数配置字典
        """
        if self._kc_params is None:
            self.load_kc_params()
        return self._kc_params
    
    def get(self, key: str, default: Any = None) -> Any:
        """获取配置值（支持点号分隔的嵌套键）
        
        Args:
            key: 配置键，支持点号分隔（如 "plot.colors.left"）
            default: 默认值
            
        Returns:
            配置值
        """
        config = self.get_app_config()
        
        keys = key.split('.')
        value = config
        
        for k in keys:
            if isinstance(value, dict) and k in value:
                value = value[k]
            else:
                return default
        
        return value
