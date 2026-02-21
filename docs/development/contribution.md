# 贡献指南

感谢您对项目的贡献！

## 如何贡献

### 1. Fork和克隆

1. Fork项目仓库
2. 克隆您的fork:
```bash
git clone <your-fork-url>
cd KinBenchTool2025_neu
```

### 2. 创建功能分支

```bash
git checkout develop
git pull origin develop
git checkout -b feature/您的功能名
```

### 3. 开发

1. 编写代码
2. 编写测试
3. 确保所有测试通过
4. 更新文档

### 4. 提交

遵循 [Conventional Commits](https://www.conventionalcommits.org/) 规范：

```bash
git commit -m "feat(data): 添加新功能"
```

### 5. 推送和创建Pull Request

```bash
git push origin feature/您的功能名
```

然后在GitHub上创建Pull Request。

## 代码审查流程

1. 提交PR后，代码将被自动检查（CI）
2. 等待代码审查
3. 根据反馈修改代码
4. 审查通过后合并

## 代码质量标准

提交的代码必须：

- [ ] 通过所有测试
- [ ] 代码覆盖率 > 80%
- [ ] 通过pylint检查
- [ ] 通过mypy类型检查
- [ ] 遵循编码规范
- [ ] 有完整的文档字符串
- [ ] 更新了相关文档

## 报告问题

使用GitHub Issues报告问题，包括：

- 问题描述
- 重现步骤
- 预期行为
- 实际行为
- 环境信息（Python版本、操作系统等）

## 功能请求

欢迎提出功能请求！请在Issue中详细描述：

- 功能需求
- 使用场景
- 可能的实现方案

## 编码规范

请遵循项目的 [编码规范](coding_standards.md)。

## 测试要求

- 新功能必须包含测试
- 修复bug必须包含回归测试
- 测试覆盖率不能降低

## 文档要求

- 新功能必须更新用户文档
- API变更必须更新API文档
- 重大变更必须更新CHANGELOG

## 问题？

如有疑问，请：
- 查看文档
- 搜索已有Issue
- 创建新Issue询问

感谢您的贡献！
