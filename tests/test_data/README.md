# 测试数据说明

## 目录结构

```
tests/test_data/
├── matlab_references/    # MATLAB生成的参考图表
│   ├── bump_test_toe_angle_left.png
│   └── ...
├── python_outputs/       # Python生成的图表（用于对比）
│   └── ...
└── .gitkeep
```

## 测试数据管理

### 小数据

小数据可以直接放在测试文件中使用fixtures。

### 大数据

大型测试数据文件（如.res文件）应：
1. 放在此目录
2. 添加到`.gitignore`
3. 在CI中使用模拟数据或下载脚本

### 参考图表

MATLAB生成的参考图表应保存在`matlab_references/`目录，用于对比验证。

## 注意事项

- 不要提交大型数据文件到Git
- 参考图表应定期更新
- 测试数据应包含正常情况和边界情况
