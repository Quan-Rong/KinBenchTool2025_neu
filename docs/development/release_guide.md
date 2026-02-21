# 发布指南

## 概述

本指南说明如何准备和发布新版本的 KinBenchTool。

## 版本号管理

### 语义化版本

项目使用 [语义化版本](https://semver.org/) (SemVer)：

- **主版本号** (MAJOR): 不兼容的 API 修改
- **次版本号** (MINOR): 向后兼容的功能性新增
- **修订号** (PATCH): 向后兼容的问题修正

格式: `MAJOR.MINOR.PATCH` (例如: `1.2.3`)

### 版本文件

版本号存储在以下位置：

1. `Python_Target/VERSION` - 版本号文件
2. `Python_Target/src/__init__.py` - Python 模块版本
3. `CHANGELOG.md` - 变更日志

### 更新版本号

使用脚本更新版本号：

```bash
python scripts/update_version.py 1.2.3
```

或手动更新：

1. 编辑 `Python_Target/VERSION`
2. 编辑 `Python_Target/src/__init__.py`
3. 更新 `CHANGELOG.md`

---

## 发布前检查清单

### 代码质量

- [ ] 所有测试通过
- [ ] 代码覆盖率 > 80%
- [ ] 通过 pylint 检查
- [ ] 通过 mypy 类型检查
- [ ] 代码已格式化（black）

### 文档

- [ ] README.md 已更新
- [ ] CHANGELOG.md 已更新
- [ ] API 文档已更新
- [ ] 用户文档已更新
- [ ] 开发文档已更新

### 功能验证

- [ ] 所有功能正常工作
- [ ] 图表与 MATLAB 版本一致
- [ ] 性能测试通过
- [ ] 兼容性测试通过

### 依赖管理

- [ ] requirements.txt 已更新
- [ ] requirements-dev.txt 已更新
- [ ] 依赖版本已锁定
- [ ] 无安全漏洞

### 构建和打包

- [ ] 可以成功构建
- [ ] 可以成功安装
- [ ] 可以成功运行
- [ ] 打包文件已准备

---

## 发布流程

### 1. 准备发布分支

```bash
# 从 develop 创建 release 分支
git checkout develop
git pull origin develop
git checkout -b release/v1.2.3
```

### 2. 更新版本号

```bash
python scripts/update_version.py 1.2.3
```

### 3. 更新 CHANGELOG

编辑 `CHANGELOG.md`，将 `[Unreleased]` 改为新版本号：

```markdown
## [1.2.3] - 2025-01-27

### Added
- 新功能1
- 新功能2

### Changed
- 改进1
- 改进2

### Fixed
- 修复1
- 修复2
```

### 4. 最终测试

```bash
# 运行所有测试
pytest tests/

# 代码检查
black Python_Target/src
pylint Python_Target/src
mypy Python_Target/src

# 功能测试
python Python_Target/src/main.py
```

### 5. 提交更改

```bash
git add .
git commit -m "chore: 准备发布 v1.2.3"
git push origin release/v1.2.3
```

### 6. 创建 Pull Request

在 GitHub 上创建从 `release/v1.2.3` 到 `main` 的 Pull Request。

### 7. 代码审查

等待代码审查通过。

### 8. 合并到 main

```bash
git checkout main
git pull origin main
git merge release/v1.2.3
git push origin main
```

### 9. 创建标签

```bash
git tag -a v1.2.3 -m "Release version 1.2.3"
git push origin v1.2.3
```

### 10. 合并回 develop

```bash
git checkout develop
git merge main
git push origin develop
```

### 11. 发布说明

在 GitHub 上创建 Release，包含：

- 版本号
- 发布说明（从 CHANGELOG 复制）
- 下载链接
- 已知问题

---

## 发布后任务

### 1. 更新文档

- [ ] 更新在线文档（如果有）
- [ ] 发布公告（如果有邮件列表或论坛）

### 2. 监控

- [ ] 监控错误报告
- [ ] 收集用户反馈
- [ ] 跟踪下载量

### 3. 后续版本规划

- [ ] 规划下一个版本
- [ ] 创建新的功能分支

---

## 热修复发布

对于紧急修复，可以创建热修复版本：

### 1. 从 main 创建 hotfix 分支

```bash
git checkout main
git pull origin main
git checkout -b hotfix/v1.2.4
```

### 2. 修复问题

```bash
# 修复代码
# 添加测试
# 更新文档
```

### 3. 更新版本号

```bash
python scripts/update_version.py 1.2.4
```

### 4. 更新 CHANGELOG

```markdown
## [1.2.4] - 2025-01-28

### Fixed
- 紧急修复：问题描述
```

### 5. 测试和发布

按照正常发布流程进行。

### 6. 合并到 main 和 develop

```bash
git checkout main
git merge hotfix/v1.2.4
git push origin main

git checkout develop
git merge main
git push origin develop
```

---

## 版本发布历史

### v0.1.0 - 2025-01-27

**初始版本**

- 基础架构搭建
- 数据解析模块
- K&C 计算模块
- 绘图模块
- GUI 界面
- 测试框架

---

## 自动化发布

### GitHub Actions

可以配置 GitHub Actions 自动执行发布流程：

```yaml
# .github/workflows/release.yml
name: Release

on:
  push:
    tags:
      - 'v*'

jobs:
  release:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Set up Python
        uses: actions/setup-python@v2
        with:
          python-version: '3.11'
      - name: Install dependencies
        run: |
          pip install -r requirements.txt
          pip install -r requirements-dev.txt
      - name: Run tests
        run: pytest
      - name: Build package
        run: python setup.py sdist bdist_wheel
      - name: Publish to PyPI
        # 配置 PyPI 发布
```

---

## 常见问题

### Q: 如何回滚发布？

**A**: 

1. 删除标签：
   ```bash
   git tag -d v1.2.3
   git push origin :refs/tags/v1.2.3
   ```

2. 回滚 main 分支：
   ```bash
   git checkout main
   git reset --hard <previous-commit>
   git push origin main --force
   ```

### Q: 如何跳过某个版本号？

**A**: 可以跳过，但建议保持连续性。如果必须跳过，在 CHANGELOG 中说明原因。

### Q: 发布后发现严重问题怎么办？

**A**: 

1. 立即创建 hotfix 分支
2. 修复问题
3. 发布热修复版本
4. 通知用户

---

## 参考资源

- [语义化版本](https://semver.org/)
- [Keep a Changelog](https://keepachangelog.com/)
- [Git Flow](https://nvie.com/posts/a-successful-git-branching-model/)

---

**最后更新**: 2025-01-27
