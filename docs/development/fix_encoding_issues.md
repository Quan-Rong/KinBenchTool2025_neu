# 修复 Git 提交消息乱码问题

## 问题说明

如果 GitHub 仓库主页显示提交消息为乱码（如 `鏇存柊鐗堟湰鍙疯嚦0.1.1`），这是因为提交时使用了 GBK 编码，而 GitHub 期望 UTF-8 编码。

## 已完成的修复

✅ **Git 编码配置已设置**（全局配置）：
- `i18n.commitencoding = utf-8`
- `i18n.logoutputencoding = utf-8`
- `core.quotepath = false`

**未来的提交不会再出现乱码问题。**

## 修复已存在的乱码提交（可选）

⚠️ **警告**：修复已存在的提交需要重写 Git 历史，这会影响已推送到远程仓库的提交。只有在以下情况下才建议执行：

1. 仓库是个人项目或团队同意重写历史
2. 没有其他人基于这些提交进行开发
3. 可以接受强制推送（force push）的风险

### 方法 1：使用 git rebase 修复最近的提交

如果只有最近的几个提交有乱码，可以使用交互式 rebase：

```bash
# 查看需要修复的提交范围
git log --oneline -10

# 交互式 rebase（例如修复最近 5 个提交）
git rebase -i HEAD~5

# 在编辑器中，将要修改的提交标记为 "reword" (r)
# 保存并关闭编辑器

# Git 会逐个打开编辑器让你修改提交消息
# 将乱码消息改为正确的中文（使用 UTF-8 编码）
# 保存并关闭编辑器

# 完成 rebase 后，强制推送到远程（谨慎操作！）
git push --force-with-lease origin <branch-name>
```

### 方法 2：使用脚本批量修复（高级）

如果需要修复大量提交，可以使用以下 Python 脚本：

```python
#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
修复 Git 提交消息编码问题的脚本
注意：这会重写 Git 历史，请谨慎使用
"""

import subprocess
import sys
import re

def get_commits():
    """获取所有提交的哈希和消息"""
    result = subprocess.run(
        ['git', 'log', '--format=%H|%s', '--all'],
        capture_output=True,
        text=True,
        encoding='utf-8'
    )
    commits = []
    for line in result.stdout.strip().split('\n'):
        if '|' in line:
            hash_val, message = line.split('|', 1)
            commits.append((hash_val, message))
    return commits

def fix_commit_message(message):
    """
    尝试修复乱码的提交消息
    注意：这需要手动映射，因为无法自动识别原始内容
    """
    # 这里需要根据实际情况手动映射乱码到正确的中文
    # 例如：
    fix_map = {
        '鏇存柊鐗堟湰鍙疯嚦0.1.1': '更新版本号至0.1.1',
        '鍒濆鍖栭」鐩紝寤虹珛寮€鍙戝熀纭€璁炬柦': '初始化项目，建立开发基础设施',
        # 添加更多映射...
    }
    return fix_map.get(message, message)

if __name__ == '__main__':
    print("⚠️  警告：此脚本会重写 Git 历史！")
    print("请确保：")
    print("1. 已备份仓库")
    print("2. 没有其他人基于这些提交工作")
    print("3. 可以接受强制推送")
    response = input("继续？(yes/no): ")
    if response.lower() != 'yes':
        sys.exit(0)
    
    # 这里应该实现实际的修复逻辑
    # 由于涉及 Git 历史重写，建议使用 git filter-branch 或 git rebase
    print("建议使用 git rebase -i 手动修复")
```

### 方法 3：接受现状（推荐）

如果乱码提交已经推送到远程仓库，并且有其他人可能基于这些提交工作，**建议接受现状**：

1. ✅ 已配置 UTF-8 编码，未来提交不会再乱码
2. ✅ 代码本身不受影响，只是提交消息显示问题
3. ✅ 可以在 CHANGELOG.md 中记录正确的变更说明

## 预防措施

### 1. 确保终端使用 UTF-8

**Windows PowerShell:**
```powershell
# 设置 PowerShell 输出编码为 UTF-8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF-8
$PSDefaultParameterValues['*:Encoding'] = 'utf8'
```

**Windows CMD:**
```cmd
chcp 65001
```

### 2. 使用 Git 提交模板

创建提交消息模板，确保使用 UTF-8 编码：

```bash
# 创建模板文件
echo "# 提交消息模板" > ~/.gitmessage

# 配置 Git 使用模板
git config --global commit.template ~/.gitmessage
```

### 3. 使用 Git GUI 工具

使用支持 UTF-8 的 Git GUI 工具（如 GitHub Desktop、SourceTree）可以避免编码问题。

## 验证修复

修复后，验证提交消息是否正确：

```bash
# 查看最近的提交
git log --oneline -5

# 查看完整提交消息
git log -1 --pretty=format:"%H%n%s%n%b"
```

在 GitHub 上查看提交历史，确认消息显示正常。

## 相关资源

- [Git 编码配置文档](https://git-scm.com/book/en/v2/Customizing-Git-Git-Configuration)
- [GitHub 关于编码的说明](https://docs.github.com/en/get-started/getting-started-with-git/configuring-git-to-handle-line-endings)
