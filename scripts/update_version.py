#!/usr/bin/env python3
"""版本号更新脚本。

用于统一更新项目中的版本号。
"""

import re
import sys
from pathlib import Path


def update_version_file(version: str) -> None:
    """更新VERSION文件。"""
    version_file = Path("Python_Target/VERSION")
    version_file.write_text(f"{version}\n", encoding="utf-8")
    print(f"✓ 更新 {version_file}")


def update_init_file(version: str) -> None:
    """更新__init__.py中的版本号。"""
    init_file = Path("Python_Target/src/__init__.py")
    if init_file.exists():
        content = init_file.read_text(encoding="utf-8")
        content = re.sub(
            r'__version__\s*=\s*["\']([^"\']+)["\']',
            f'__version__ = "{version}"',
            content,
        )
        init_file.write_text(content, encoding="utf-8")
        print(f"✓ 更新 {init_file}")


def update_changelog(version: str, date: str = None) -> None:
    """更新CHANGELOG.md。"""
    from datetime import datetime

    if date is None:
        date = datetime.now().strftime("%Y-%m-%d")

    changelog_file = Path("CHANGELOG.md")
    if not changelog_file.exists():
        return

    content = changelog_file.read_text(encoding="utf-8")
    # 检查是否已有该版本
    if f"## [{version}]" in content:
        print(f"⚠ CHANGELOG.md中已存在版本 {version}")
        return

    # 在[Unreleased]后插入新版本
    unreleased_pattern = r"## \[Unreleased\]"
    new_version_section = f"""## [Unreleased]

## [{version}] - {date}

### Added
- 

### Changed
- 

### Fixed
- 

"""
    if re.search(unreleased_pattern, content):
        content = re.sub(
            unreleased_pattern,
            new_version_section,
            content,
            count=1,
        )
        changelog_file.write_text(content, encoding="utf-8")
        print(f"✓ 更新 {changelog_file}")


def main():
    """主函数。"""
    if len(sys.argv) < 2:
        print("用法: python scripts/update_version.py <version> [date]")
        print("示例: python scripts/update_version.py 1.0.0 2025-02-15")
        sys.exit(1)

    version = sys.argv[1]
    date = sys.argv[2] if len(sys.argv) > 2 else None

    # 验证版本号格式（语义化版本）
    if not re.match(r"^\d+\.\d+\.\d+", version):
        print(f"错误: 版本号格式不正确，应为 MAJOR.MINOR.PATCH (如 1.0.0)")
        sys.exit(1)

    print(f"更新版本号到 {version}...")
    update_version_file(version)
    update_init_file(version)
    update_changelog(version, date)
    print("✓ 版本号更新完成")


if __name__ == "__main__":
    main()
