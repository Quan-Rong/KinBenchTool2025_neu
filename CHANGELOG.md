# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.3.4] - 2026-02-24

### Changed
- **UI字体大小优化**：全面提升界面文字可读性
  - 主窗口通用字号从11px/13px提高到12px/14px（菜单、GroupBox标题、按钮、输入框、下拉框、标签等）
  - 车辆参数面板字体从10提升到11（标题、参数标签、输入框）
  - START/INFO标签页作者信息字号加大（标题14→16，姓名12→14，邮箱11→13）
  - 保持绘图区域字号不变，确保图表显示一致性

## [0.3.3] - 2026-02-24

### Changed
- 对比结果的曲线颜色从灰色调整为橙色，提高多曲线对比时的可读性
- 优化拟合区间的默认选择与过滤策略，在典型工况下提供更稳定、更加符合工程直觉的拟合结果

### Fixed
- 修复拟合区间过滤过度严格导致对比图右侧拟合线可能完全不显示的问题
- 修复多文件对比与拟合计算过程中，数据索引可能发生漂移，导致曲线错位或特征点位置不准确的问题

## [0.3.2] - 2026-02-22

### Fixed
- 修复quasiStatic数据段解析问题，支持多种格式（带引号、不带引号、XML格式）
- 修复plot_validator中形状不匹配时缺少'shape_mismatch'键的问题
- 修复测试中Mock对象解包错误，为extract_wheel_travel_left_right添加正确的返回值

## [0.3.1] - 2026-02-22

### Fixed
- 修复Windows上Perl不可用时的行数统计警告问题
- 优化数据行长度警告信息，提供更详细的说明
- 添加Side Swing Arm Angle异常值检测和验证

## [0.3.0] - 2026-02-22

### Added
- **数据验证模块** (`src/utils/data_validator.py`)
  - 数据范围验证功能
  - 异常值检测（IQR和Z-score方法）
  - 数据一致性检查（左右轮数据对比）
  - 综合数据质量验证
  - 拟合质量检查（R²值、RMSE、MAE计算）
- **错误处理工具模块** (`src/utils/error_handler.py`)
  - 统一的错误处理机制
  - 用户友好的中英文错误消息
  - 错误类型自动识别
  - 错误恢复建议
- **配置管理模块** (`src/utils/config_manager.py`)
  - 配置文件的保存和加载
  - 自动保存功能
  - 嵌套配置键支持
  - 默认配置管理

### Changed
- **增强错误处理**
  - 所有关键操作添加了完善的try-except块
  - 使用统一的ErrorHandler处理所有错误
  - 改进的错误消息，包含详细信息和解决建议
  - 区分不同类型的错误（文件错误、数据错误、计算错误等）
- **增强数据验证**
  - 在数据加载时进行完整性检查
  - 验证数据格式和范围
  - 检查必需参数是否存在
  - 提供详细的验证错误信息
- **增强拟合质量检查**
  - `linear_fit`函数现在支持返回R²值
  - 自动检测拟合质量并给出警告
  - 拟合失败时提供详细错误信息
- **改进用户体验**
  - 更友好的错误提示消息
  - 更详细的日志记录
  - 改进的进度反馈

### Fixed
- 修复了数据处理错误处理不够完善的问题
- 修复了计算过程中的异常可能未完全捕获的问题
- 修复了用户友好的错误提示不够详细的问题
- 修复了缺少数据范围验证的问题
- 修复了缺少异常值检测的问题
- 修复了缺少数据一致性检查的问题
- 修复了拟合失败时缺少警告的问题

## [0.2.0] - 2025-02-15

### Added
- START/INFO 标签页改进
  - 左右分栏布局（左侧显示 README，右侧显示作者信息）
  - 左侧：显示项目 README.md 内容（支持 Markdown 渲染）
  - 右侧上方：显示猴子图片（带圆角和边框样式）
  - 右侧下方：显示作者信息卡片（Quan Rong, quan.rong@de.gestamp.com）
  - 改进的 Markdown 转 HTML 转换函数（更好的代码块和列表处理）

### Changed
- 优化 START/INFO 标签页的用户体验
- 改进版本号显示机制（统一从 __version__ 或 VERSION 文件读取）

## [0.1.1] - 2025-01-27

### Added
- 漂亮的滑块控件替代SpinBox用于Fit Range设置
  - 支持整数和浮点数两种模式
  - 实时显示当前数值
  - 现代化的UI样式（蓝色渐变滑块、圆形手柄、悬停效果）
- 自动更新功能：当Fit Range改变时自动重新计算和绘制图表

### Changed
- 所有测试Tab中的Fit Range控件从SpinBox改为滑块
  - BumpTestTab: 整数滑块（5-50 mm）
  - RollTestTab: 浮点数滑块（0.1-5.0 deg）
  - StaticLoadLateralTab: 浮点数滑块（0.1-10.0 kN）
  - StaticLoadBrakingTab: 浮点数滑块（0.1-10.0 kN）
  - StaticLoadAccelerationTab: 浮点数滑块（0.1-10.0 kN）
- 增强拟合线可见性（增加线宽和zorder）

### Fixed
- 修复Fit Range改变时图表和结果不自动更新的问题
- 统一版本号显示（所有位置统一为0.1.1）

## [0.1.0] - 2025-01-27

### Added

#### 阶段八：文档与发布
- 完整的API文档（数据处理、绘图、GUI、工具模块）
- 用户文档（FAQ、故障排除指南）
- 开发文档（扩展指南、发布指南）
- 更新CHANGELOG和README

#### 阶段一至七：核心功能

#### 阶段一：基础架构搭建
- 初始化Git仓库和Git工作流程
- 建立语义化版本号管理系统
- 创建项目配置文件（.gitignore, requirements.txt等）
- 建立文档目录结构
- 配置代码质量工具（black, pylint, mypy）
- 建立测试框架和测试策略
- 创建图表一致性验证工具框架
- 设计统一异常处理机制
- 建立性能基准测试框架
- 创建风险登记表

#### 阶段二：数据解析模块
- ResParser类：.res文件解析器
- DataExtractor类：数据提取器
- UnitConverter：单位转换工具
- 支持Windows/Linux文件读取
- 正则表达式参数ID提取
- quasiStatic数据段解析
- 数据矩阵构建（n行 x 2751列）

#### 阶段三：K&C计算模块
- KCCalculator类：K&C计算器
- Bump测试计算函数：
  - Bump Steer计算
  - Bump Camber计算
  - Wheel Rate计算
  - Wheel Recession计算
  - Track Change计算
  - Castor Angle计算
  - SVSA计算
- Roll测试计算函数：
  - Roll Steer计算
  - Roll Camber计算
  - Roll Rate计算
  - Roll Center Height计算
- Static Load计算函数：
  - Lateral Compliance计算
  - Braking Compliance计算
  - Acceleration Compliance计算
  - Anti-dive计算
  - Anti-squat计算
- 线性拟合功能
- 特征点定位算法

#### 阶段四：绘图模块
- plot_utils：绘图工具函数
- bump_plot：Bump测试绘图
  - Bump Steer图
  - Bump Camber图
  - Wheel Rate图
  - Wheel Recession图
  - Track Change图
  - Castor Angle图
  - SVSA图
- roll_plot：Roll测试绘图
  - Roll Steer图
  - Roll Camber图
  - Roll Rate图
  - Roll Center Height图
- static_load_plot：Static Load测试绘图
  - Lateral Compliance图
  - Braking Compliance图
  - Acceleration Compliance图
- 与MATLAB版本完全一致的图表样式

#### 阶段五：GUI界面
- MainWindow：主窗口
- VehicleParamsPanel：车辆参数面板
- BaseTestTab：测试Tab基类
- StartInfoTab：启动信息Tab
- BumpTestTab：Bump测试Tab
- RollTestTab：Roll测试Tab
- StaticLoadLateralTab：侧向力测试Tab
- StaticLoadBrakingTab：制动力测试Tab
- StaticLoadAccelerationTab：加速力测试Tab
- MatplotlibWidget：Matplotlib图表Widget
- ComparisonPlotWidget：对比图表Widget
- 文件选择功能
- 结果展示功能
- 图表导出功能

#### 阶段六：功能集成
- 主程序集成（main.py）
- 数据流管理
- 事件处理
- 错误处理机制
- 日志系统
- 配置管理

#### 阶段七：测试与优化
- 单元测试：
  - test_unit_converter.py（单位转换测试）
  - test_math_utils.py（数学工具测试）
  - test_res_parser.py（数据解析测试）
  - test_kc_calculator.py（K&C计算器测试）
- 集成测试：
  - test_data_flow.py（数据流集成测试）
  - test_plot_validation.py（图表一致性验证测试）
- 性能测试：
  - test_file_reading.py（文件读取性能测试）
- 性能优化建议
- 图表一致性验证工具

### Changed
- 从MATLAB迁移到Python
- 使用PyQt6替代MATLAB App Designer
- 使用NumPy和Matplotlib替代MATLAB内置函数

### Fixed
- 文件读取跨平台兼容性问题
- 数据解析错误处理
- 单位转换精度问题
- 图表样式一致性

## [0.0.1] - 2025-01-27

### Added
- 项目初始化
- 基础架构搭建
- 风险分析与改进计划
