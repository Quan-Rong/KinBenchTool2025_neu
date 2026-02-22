"""配置管理模块

提供配置的保存和加载功能。
"""

import json
from pathlib import Path
from typing import Dict, Any, Optional
from ..utils.logger import get_logger
from ..utils.exceptions import ConfigurationError

logger = get_logger(__name__)


class ConfigManager:
    """配置管理器
    
    提供配置的保存和加载功能，支持自动保存和恢复。
    """
    
    def __init__(self, config_file: Optional[str] = None):
        """初始化配置管理器
        
        Args:
            config_file: 配置文件路径，如果为None则使用默认路径
        """
        if config_file is None:
            # 使用用户目录下的配置文件
            config_dir = Path.home() / ".kinbench_tool"
            config_dir.mkdir(exist_ok=True)
            config_file = str(config_dir / "config.json")
        
        self.config_file = Path(config_file)
        self.config: Dict[str, Any] = {}
        logger.debug(f"配置管理器初始化: {self.config_file}")
    
    def load(self) -> Dict[str, Any]:
        """加载配置
        
        Returns:
            配置字典
            
        Raises:
            ConfigurationError: 配置文件格式错误或无法读取
        """
        if not self.config_file.exists():
            logger.info(f"配置文件不存在，使用默认配置: {self.config_file}")
            return {}
        
        try:
            with open(self.config_file, 'r', encoding='utf-8') as f:
                self.config = json.load(f)
            logger.info(f"配置加载成功: {self.config_file}")
            return self.config
        except json.JSONDecodeError as e:
            logger.error(f"配置文件格式错误: {e}")
            raise ConfigurationError(f"配置文件格式错误: {e}")
        except Exception as e:
            logger.error(f"加载配置文件失败: {e}")
            raise ConfigurationError(f"无法读取配置文件: {e}")
    
    def save(self, config: Optional[Dict[str, Any]] = None) -> None:
        """保存配置
        
        Args:
            config: 要保存的配置字典，如果为None则保存当前配置
            
        Raises:
            ConfigurationError: 无法保存配置文件
        """
        if config is not None:
            self.config = config
        
        try:
            # 确保目录存在
            self.config_file.parent.mkdir(parents=True, exist_ok=True)
            
            with open(self.config_file, 'w', encoding='utf-8') as f:
                json.dump(self.config, f, indent=2, ensure_ascii=False)
            logger.info(f"配置保存成功: {self.config_file}")
        except Exception as e:
            logger.error(f"保存配置文件失败: {e}")
            raise ConfigurationError(f"无法保存配置文件: {e}")
    
    def get(self, key: str, default: Any = None) -> Any:
        """获取配置值
        
        Args:
            key: 配置键，支持点号分隔的嵌套键（如 'ui.window_width'）
            default: 默认值
            
        Returns:
            配置值
        """
        if not self.config:
            self.load()
        
        keys = key.split('.')
        value = self.config
        
        for k in keys:
            if isinstance(value, dict) and k in value:
                value = value[k]
            else:
                return default
        
        return value
    
    def set(self, key: str, value: Any) -> None:
        """设置配置值
        
        Args:
            key: 配置键，支持点号分隔的嵌套键（如 'ui.window_width'）
            value: 配置值
        """
        if not self.config:
            self.load()
        
        keys = key.split('.')
        config = self.config
        
        # 创建嵌套字典结构
        for k in keys[:-1]:
            if k not in config:
                config[k] = {}
            config = config[k]
        
        # 设置值
        config[keys[-1]] = value
        logger.debug(f"配置值已设置: {key} = {value}")
    
    def save_auto(self) -> None:
        """自动保存当前配置"""
        try:
            self.save()
        except Exception as e:
            logger.warning(f"自动保存配置失败: {e}")
