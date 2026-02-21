# Git工作流程文档

## 分支策略（Git Flow）

```
main (生产分支)
  └── develop (开发分支)
      ├── feature/模块名-功能名 (功能分支)
      ├── bugfix/问题描述 (修复分支)
      └── release/v版本号 (发布分支)
```

### 分支说明

- **main**: 生产环境代码，只接受来自release分支的合并
- **develop**: 开发主分支，所有功能开发都合并到这里
- **feature/**: 新功能开发分支，从develop创建，完成后合并回develop
- **bugfix/**: 紧急bug修复分支，从main或develop创建
- **release/**: 发布准备分支，从develop创建，用于版本发布前的最终测试

## 提交信息规范（Conventional Commits）

### 格式

```
<type>(<scope>): <subject>

<body>

<footer>
```

### 类型（type）

- `feat`: 新功能
- `fix`: 修复bug
- `docs`: 文档更新
- `style`: 代码格式（不影响代码运行的变动）
- `refactor`: 重构（既不是新增功能，也不是修复bug的代码变动）
- `test`: 添加测试
- `chore`: 构建过程或辅助工具的变动
- `perf`: 性能优化
- `ci`: CI配置文件和脚本的变动

### 范围（scope）

可选，表示影响的范围，如：
- `data`: 数据处理模块
- `plot`: 绘图模块
- `gui`: GUI模块
- `config`: 配置模块
- `utils`: 工具模块
- `test`: 测试相关

### 主题（subject）

简短描述，不超过50个字符，使用中文或英文

### 正文（body）

详细描述，可以多行，说明：
- 变更的动机
- 与之前行为的对比

### 页脚（footer）

可选，用于：
- 关闭Issue: `Closes #123`
- 破坏性变更: `BREAKING CHANGE: 描述`

### 示例

```
feat(data): 实现.res文件解析器

- 支持参数ID提取
- 支持quasiStatic数据段解析
- 添加单元测试

Closes #123
```

```
fix(plot): 修复Bump测试图表坐标轴范围错误

修复了当数据范围超出预期时坐标轴显示不正确的问题。

Fixes #456
```

```
docs: 更新API文档

更新了数据处理模块的API文档，添加了更多示例。
```

## 开发工作流程

1. **需求分析** → 创建Issue/任务
2. **创建功能分支** → `git checkout -b feature/模块名-功能名`
3. **编写测试** → TDD方式，先写测试
4. **实现功能** → 编写代码
5. **代码审查** → 自检 + 他人审查
6. **运行测试** → 确保所有测试通过
7. **更新文档** → 更新相关文档
8. **提交代码** → 遵循提交规范
9. **合并到develop** → 通过CI后合并
10. **发布版本** → 从develop创建release分支

## 版本发布流程

1. **创建release分支** → `git checkout -b release/v1.0.0`
2. **更新版本号** → 更新所有相关文件
3. **更新CHANGELOG** → 记录所有变更
4. **最终测试** → 完整功能测试
5. **合并到main** → 打tag: `git tag -a v1.0.0 -m "Release version 1.0.0"`
6. **合并回develop** → 同步变更
7. **创建发布说明** → 生成Release Notes

## 常用命令

### 创建功能分支
```bash
git checkout develop
git pull origin develop
git checkout -b feature/data-res-parser
```

### 提交代码
```bash
git add .
git commit -m "feat(data): 实现.res文件解析器"
```

### 合并到develop
```bash
git checkout develop
git pull origin develop
git merge feature/data-res-parser
git push origin develop
```

### 创建发布分支
```bash
git checkout develop
git checkout -b release/v1.0.0
# 更新版本号和CHANGELOG
git commit -m "chore: 准备发布v1.0.0"
git push origin release/v1.0.0
```

### 打标签
```bash
git checkout main
git merge release/v1.0.0
git tag -a v1.0.0 -m "Release version 1.0.0"
git push origin main --tags
```
