# 工具脚本

## update_version.py

版本号更新脚本，用于统一更新项目中的版本号。

### 用法

```bash
python scripts/update_version.py <version> [date]
```

### 示例

```bash
# 更新到1.0.0版本
python scripts/update_version.py 1.0.0

# 更新到1.0.0版本并指定日期
python scripts/update_version.py 1.0.0 2025-02-15
```

### 功能

- 更新 `Python_Target/VERSION` 文件
- 更新 `Python_Target/src/__init__.py` 中的 `__version__`
- 在 `CHANGELOG.md` 中添加新版本条目
