# 文档编写规范

## 文档类型

### 1. 代码文档（Docstrings）

所有公共函数、类、方法必须有文档字符串。

### 2. 架构文档

描述系统设计、模块关系、数据流等。

### 3. API文档

描述公共API的使用方法。

### 4. 用户文档

面向最终用户的使用指南。

## 文档字符串规范

### Google Style格式

```python
def function_name(param1: Type1, param2: Type2 = default) -> ReturnType:
    """函数简短描述（一行）。
    
    详细描述（可选，多行）。
    可以包含更多信息。
    
    Args:
        param1: 参数1的描述
        param2: 参数2的描述，默认值为default
        
    Returns:
        返回值的描述，包括类型和含义
        
    Raises:
        ValueError: 什么情况下抛出此异常
        FileNotFoundError: 什么情况下抛出此异常
        
    Example:
        >>> result = function_name("value1", param2=42)
        >>> print(result)
        'output'
        
    Note:
        重要说明或注意事项。
        
    See Also:
        :func:`related_function` - 相关函数
        
    Todo:
        - 待完成的功能
        - 待优化的部分
    """
    pass
```

### 类文档

```python
class MyClass:
    """类的简短描述。
    
    详细描述类的用途和主要功能。
    
    Attributes:
        attribute1: 属性1的描述
        attribute2: 属性2的描述
        
    Example:
        >>> obj = MyClass(param1="value")
        >>> obj.method()
        'result'
    """
    
    def __init__(self, param1: str):
        """初始化类实例。
        
        Args:
            param1: 参数1的描述
        """
        self.attribute1 = param1
```

## 架构文档规范

### 文件结构

- `system_overview.md`: 系统概览
- `module_design.md`: 模块设计
- `data_flow.md`: 数据流图
- `api_design.md`: API设计

### 内容要求

每个架构文档应包含：

1. **概述**: 模块/系统的目的和职责
2. **设计**: 详细设计说明
3. **接口**: 主要接口定义
4. **依赖**: 依赖关系
5. **示例**: 使用示例

## API文档规范

### 格式

```markdown
## 函数名

**签名**: `function_name(param1: Type1, param2: Type2) -> ReturnType`

**描述**: 函数的详细描述

**参数**:
- `param1` (Type1): 参数1的描述
- `param2` (Type2, 可选): 参数2的描述，默认值

**返回**: 返回值的描述

**异常**:
- `ValueError`: 什么情况下抛出

**示例**:
```python
result = function_name("value1", param2=42)
```
```

## 用户文档规范

### 结构

1. **简介**: 功能概述
2. **快速开始**: 基本使用
3. **详细说明**: 功能详解
4. **示例**: 使用示例
5. **常见问题**: FAQ

### 语言要求

- 使用清晰、简洁的语言
- 避免技术 jargon（除非必要）
- 提供足够的上下文
- 包含截图或示例（如适用）

## Markdown规范

### 标题层级

```markdown
# 一级标题（文档标题）
## 二级标题（主要章节）
### 三级标题（子章节）
#### 四级标题（小节）
```

### 代码块

使用语法高亮：

````markdown
```python
def example():
    pass
```
````

### 列表

使用有序列表表示步骤，无序列表表示要点。

### 链接

使用相对路径链接到其他文档：

```markdown
[链接文本](relative/path/to/file.md)
```

## 文档维护

### 更新时机

- 代码变更时更新相关文档
- 功能添加时更新用户文档
- API变更时更新API文档
- 架构变更时更新架构文档

### 审查流程

- 代码审查时同时审查文档
- 确保文档与代码一致
- 检查拼写和语法

## 文档模板

### 函数文档模板

```python
def function_name(param: Type) -> ReturnType:
    """[一句话描述函数功能]。
    
    [详细描述，说明函数的作用、使用场景等]
    
    Args:
        param: [参数描述，包括类型、含义、约束等]
        
    Returns:
        [返回值描述，包括类型、含义、可能的值等]
        
    Raises:
        ValueError: [什么情况下抛出，为什么]
        
    Example:
        >>> result = function_name("example")
        >>> print(result)
        'output'
        
    Note:
        [重要说明、注意事项、限制等]
        
    See Also:
        :func:`related_function` - [相关函数说明]
        
    Todo:
        - [待完成的功能]
    """
    pass
```

### 模块文档模板

```markdown
# 模块名

## 概述

[模块的简要描述]

## 功能

[主要功能列表]

## 主要类和函数

### ClassName

[类描述]

### function_name

[函数描述]

## 使用示例

[代码示例]

## 依赖

[依赖的其他模块]
```

## 检查清单

编写文档时检查：

- [ ] 所有公共API有文档字符串
- [ ] 文档字符串格式正确（Google Style）
- [ ] 包含类型提示
- [ ] 包含使用示例
- [ ] 文档与代码一致
- [ ] 拼写和语法正确
- [ ] 链接有效
- [ ] 代码示例可运行
