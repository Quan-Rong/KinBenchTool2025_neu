"""图表一致性验证工具。

用于对比MATLAB和Python生成的图表，确保1:1一致性。
"""

import numpy as np
from pathlib import Path
from typing import Tuple, Dict, Any, Optional
import matplotlib.pyplot as plt
from PIL import Image
import imageio


def compare_plot_data(
    matlab_data: np.ndarray,
    python_data: np.ndarray,
    tolerance: float = 1e-6,
) -> Tuple[bool, Dict[str, Any]]:
    """对比MATLAB和Python图表的数据点。
    
    Args:
        matlab_data: MATLAB图表的数据点数组
        python_data: Python图表的数据点数组
        tolerance: 数值容差，默认1e-6
        
    Returns:
        (是否一致, 对比结果字典)
        对比结果包含：
        - 'max_diff': 最大差异
        - 'mean_diff': 平均差异
        - 'rms_diff': 均方根差异
        - 'is_close': 是否在容差范围内
    """
    if matlab_data.shape != python_data.shape:
        return False, {
            "error": "数据形状不匹配",
            "shape_mismatch": True,
            "matlab_shape": matlab_data.shape,
            "python_shape": python_data.shape,
        }

    diff = np.abs(matlab_data - python_data)
    max_diff = np.max(diff)
    mean_diff = np.mean(diff)
    rms_diff = np.sqrt(np.mean(diff**2))

    is_close = np.allclose(matlab_data, python_data, rtol=tolerance, atol=tolerance)

    result = {
        "max_diff": float(max_diff),
        "mean_diff": float(mean_diff),
        "rms_diff": float(rms_diff),
        "is_close": bool(is_close),
    }

    return is_close, result


def compare_plot_images(
    matlab_image_path: str,
    python_image_path: str,
    similarity_threshold: float = 0.95,
) -> Tuple[bool, Dict[str, Any]]:
    """对比MATLAB和Python生成的图表图像。
    
    Args:
        matlab_image_path: MATLAB图表图像路径
        python_image_path: Python图表图像路径
        similarity_threshold: 相似度阈值，默认0.95（95%）
        
    Returns:
        (是否一致, 对比结果字典)
        对比结果包含：
        - 'similarity': 相似度（0-1）
        - 'diff_pixels': 不同像素数量
        - 'total_pixels': 总像素数量
    """
    matlab_img = Image.open(matlab_image_path)
    python_img = Image.open(python_image_path)

    # 转换为numpy数组
    matlab_array = np.array(matlab_img)
    python_array = np.array(python_img)

    # 确保尺寸一致
    if matlab_array.shape != python_array.shape:
        # 调整尺寸
        python_img = python_img.resize(matlab_img.size, Image.Resampling.LANCZOS)
        python_array = np.array(python_img)

    # 计算差异
    diff = np.abs(matlab_array.astype(float) - python_array.astype(float))
    diff_pixels = np.sum(diff > 10)  # 阈值10，允许渲染差异
    total_pixels = diff.size

    # 计算相似度
    similarity = 1.0 - (diff_pixels / total_pixels)

    result = {
        "similarity": float(similarity),
        "diff_pixels": int(diff_pixels),
        "total_pixels": int(total_pixels),
        "is_similar": similarity >= similarity_threshold,
    }

    return result["is_similar"], result


def compare_plot_styles(
    matlab_style: Dict[str, Any],
    python_style: Dict[str, Any],
) -> Tuple[bool, Dict[str, Any]]:
    """对比MATLAB和Python图表的样式。
    
    Args:
        matlab_style: MATLAB图表样式字典
        python_style: Python图表样式字典
        
    Returns:
        (是否一致, 对比结果字典)
    """
    differences = []

    # 检查关键样式属性
    style_keys = [
        "font_family",
        "font_size",
        "line_style",
        "line_width",
        "marker_style",
        "marker_size",
        "color",
        "xlabel",
        "ylabel",
        "title",
        "xlim",
        "ylim",
    ]

    for key in style_keys:
        matlab_val = matlab_style.get(key)
        python_val = python_style.get(key)

        if matlab_val != python_val:
            differences.append(
                {
                    "key": key,
                    "matlab": matlab_val,
                    "python": python_val,
                }
            )

    is_consistent = len(differences) == 0

    result = {
        "is_consistent": is_consistent,
        "differences": differences,
        "num_differences": len(differences),
    }

    return is_consistent, result


def save_reference_plot(
    figure: plt.Figure,
    file_path: str,
    plot_name: str,
) -> None:
    """保存参考图表（用于后续对比）。
    
    Args:
        figure: matplotlib Figure对象
        file_path: 保存路径
        plot_name: 图表名称
    """
    output_dir = Path(file_path).parent
    output_dir.mkdir(parents=True, exist_ok=True)

    figure.savefig(file_path, dpi=150, bbox_inches="tight")
    print(f"✓ 保存参考图表: {plot_name} -> {file_path}")


def validate_plot_consistency(
    matlab_data: Optional[np.ndarray] = None,
    python_data: Optional[np.ndarray] = None,
    matlab_image: Optional[str] = None,
    python_image: Optional[str] = None,
    matlab_style: Optional[Dict[str, Any]] = None,
    python_style: Optional[Dict[str, Any]] = None,
    data_tolerance: float = 1e-6,
    image_similarity: float = 0.95,
) -> Dict[str, Any]:
    """综合验证图表一致性。
    
    Args:
        matlab_data: MATLAB数据（可选）
        python_data: Python数据（可选）
        matlab_image: MATLAB图像路径（可选）
        python_image: Python图像路径（可选）
        matlab_style: MATLAB样式字典（可选）
        python_style: Python样式字典（可选）
        data_tolerance: 数据容差
        image_similarity: 图像相似度阈值
        
    Returns:
        验证结果字典，包含所有对比结果
    """
    results = {
        "data_consistent": None,
        "image_consistent": None,
        "style_consistent": None,
        "overall_consistent": False,
    }

    # 数据对比
    if matlab_data is not None and python_data is not None:
        is_consistent, data_result = compare_plot_data(
            matlab_data, python_data, tolerance=data_tolerance
        )
        results["data_consistent"] = is_consistent
        results["data_comparison"] = data_result

    # 图像对比
    if matlab_image and python_image:
        is_consistent, image_result = compare_plot_images(
            matlab_image, python_image, similarity_threshold=image_similarity
        )
        results["image_consistent"] = is_consistent
        results["image_comparison"] = image_result

    # 样式对比
    if matlab_style and python_style:
        is_consistent, style_result = compare_plot_styles(matlab_style, python_style)
        results["style_consistent"] = is_consistent
        results["style_comparison"] = style_result

    # 综合判断
    consistency_flags = [
        results["data_consistent"],
        results["image_consistent"],
        results["style_consistent"],
    ]
    consistency_flags = [f for f in consistency_flags if f is not None]

    if consistency_flags:
        results["overall_consistent"] = all(consistency_flags)

    return results
