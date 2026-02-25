"""
Compare MATLAB vs Python column extraction for parallel travel (.res).

This script prints side-by-side values for:
- MATLAB `Susp_parallel_travel_data1` (left-side only in this repo's MATLAB)
- MATLAB `Susp_parallel_travel_plot_data1` (toe left/right in col 1/2)
- Python `KCCalculator._build_parallel_travel_matrices()` outputs (`data1`/`plot_data1`)

Run (Windows):
  Python_Target\\venv\\Scripts\\python.exe Python_Target\\tools\\compare_parallel_travel.py
"""

from __future__ import annotations

import math
import sys
from pathlib import Path

import numpy as np


def _fmt_arr(a: np.ndarray, n: int = 8) -> str:
    a = np.asarray(a).reshape(-1)
    take = a[:n]
    return np.array2string(take, precision=6, suppress_small=False, separator=", ")


def main() -> int:
    repo_root = Path(__file__).resolve().parents[2]
    py_root = repo_root / "Python_Target"
    sys.path.insert(0, str(py_root))  # so `import src...` works

    from src.data.res_parser import ResParser
    from src.data.data_extractor import DataExtractor
    from src.data.kc_calculator import KCCalculator

    res_path = repo_root / "NRAC_G023_Results" / "NRAC_G023_parallel_travel.res"
    if not res_path.exists():
        print(f"[ERROR] .res file not found: {res_path}")
        return 2

    parser = ResParser(str(res_path))
    param_ids, quasi = parser.parse()

    toe_ids = param_ids.get("toe_angle")
    if not toe_ids or not isinstance(toe_ids, list) or len(toe_ids) < 2:
        print(f"[ERROR] toe_angle ids not found or invalid: {toe_ids}")
        return 3

    toe_l_id, toe_r_id = toe_ids[0], toe_ids[1]

    extractor = DataExtractor(parser)
    calc = KCCalculator(extractor)
    mats = calc._build_parallel_travel_matrices()
    data1: np.ndarray = mats["data1"]
    plot1: np.ndarray = mats["plot_data1"]

    # --- Key facts from this repo's MATLAB ---
    print("=== MATLAB (this repo) key facts ===")
    print(
        "- `KinBenchTool_Bump_Plot.m` builds `Susp_parallel_travel_data1` with IDs:\n"
        "    [toe_left, camber_left, caster_left, kingpin_left, ...]\n"
        "  so `data1` col1 is toe_left, col2 is camber_left (NOT toe_right).\n"
        "- Toe left/right are in `Susp_parallel_travel_plot_data1(:,1:2)`."
    )
    print()

    print("=== Parsed IDs from .res ===")
    print(f"toe_angle ids (left/right): {toe_ids}")
    print(f"quasiStatic_data shape: {quasi.shape}")
    print()

    # --- Build direct columns from quasiStatic_data ---
    rad2deg = 180.0 / math.pi

    quasi_toeL_deg_by_id = quasi[:, toe_l_id] * rad2deg
    quasi_toeR_deg_by_id = quasi[:, toe_r_id] * rad2deg

    # also check the alternative interpretation (MATLAB 1-based index)
    quasi_toeL_deg_by_idm1 = quasi[:, toe_l_id - 1] * rad2deg if toe_l_id > 0 else None
    quasi_toeR_deg_by_idm1 = quasi[:, toe_r_id - 1] * rad2deg if toe_r_id > 0 else None

    # --- Pull Python extracted columns ---
    # Python `data1` follows MATLAB `Susp_parallel_travel_data1`
    py_data1_toeL_deg = data1[:, 0]
    py_data1_col2_deg = data1[:, 1]  # camber_left in MATLAB/Python data1

    # Python `plot_data1` follows MATLAB `Susp_parallel_travel_plot_data1`
    py_plot_toeL_deg = plot1[:, 0]
    py_plot_toeR_deg = plot1[:, 1]

    print("=== Column meaning cross-check ===")
    print(f"Python data1[:,0] = toe_left(deg)   first values: {_fmt_arr(py_data1_toeL_deg)}")
    print(f"Python data1[:,1] = camber_left(deg) first values: {_fmt_arr(py_data1_col2_deg)}")
    print(f"Python plot_data1[:,0] = toe_left(deg)  first values: {_fmt_arr(py_plot_toeL_deg)}")
    print(f"Python plot_data1[:,1] = toe_right(deg) first values: {_fmt_arr(py_plot_toeR_deg)}")
    print()

    # --- Numerical equality checks (which quasi column matches Python) ---
    def max_abs_diff(a: np.ndarray, b: np.ndarray) -> float:
        return float(np.max(np.abs(a - b)))

    diff_plot_L_by_id = max_abs_diff(py_plot_toeL_deg, quasi_toeL_deg_by_id)
    diff_plot_R_by_id = max_abs_diff(py_plot_toeR_deg, quasi_toeR_deg_by_id)
    print("=== Exactness check: Python plot_data1 vs quasiStatic_data ===")
    print(f"max|plot_toe_left - quasi[:, {toe_l_id}]| (deg):  {diff_plot_L_by_id:.6g}")
    print(f"max|plot_toe_right - quasi[:, {toe_r_id}]| (deg): {diff_plot_R_by_id:.6g}")

    if quasi_toeL_deg_by_idm1 is not None and quasi_toeR_deg_by_idm1 is not None:
        diff_plot_L_by_idm1 = max_abs_diff(py_plot_toeL_deg, quasi_toeL_deg_by_idm1)
        diff_plot_R_by_idm1 = max_abs_diff(py_plot_toeR_deg, quasi_toeR_deg_by_idm1)
        print(f"max|plot_toe_left - quasi[:, {toe_l_id - 1}]| (deg):  {diff_plot_L_by_idm1:.6g}")
        print(f"max|plot_toe_right - quasi[:, {toe_r_id - 1}]| (deg): {diff_plot_R_by_idm1:.6g}")

    print()

    # --- Side-by-side sample rows ---
    sample_n = min(10, len(py_plot_toeL_deg))
    rows = np.arange(sample_n, dtype=int)
    side_by_side = np.column_stack(
        [
            rows,
            py_plot_toeL_deg[:sample_n],
            py_plot_toeR_deg[:sample_n],
            quasi_toeL_deg_by_id[:sample_n],
            quasi_toeR_deg_by_id[:sample_n],
        ]
    )
    print("=== First rows (deg) side-by-side ===")
    print("cols: [row, py_plot_toeL, py_plot_toeR, quasi[:,toeL_id], quasi[:,toeR_id]]")
    np.set_printoptions(precision=6, suppress=False)
    print(side_by_side)

    return 0


if __name__ == "__main__":
    raise SystemExit(main())

