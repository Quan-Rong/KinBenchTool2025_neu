#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
MATLAB to Python Plotting Command Converter

This script converts MATLAB plotting commands to Python/matplotlib equivalents.
It handles common MATLAB plotting functions and their parameters to ensure
1:1 conversion for the KnC_Bewertung project.

Usage:
    python matlab_to_python_plot_converter.py <input_file.m> [output_file.py]

Author: Auto-generated for KnC_Bewertung Project
Date: 2025-01-27
"""

import re
import sys
import os
from typing import List, Tuple, Dict


class MATLABPlotConverter:
    """Convert MATLAB plotting commands to Python/matplotlib"""
    
    def __init__(self):
        self.indent_level = 0
        self.axis_var = None  # Track current axis variable (e.g., app.UIAxesLeft_R_B_toe)
        self.converted_lines = []
        
    def convert_file(self, input_file: str, output_file: str = None) -> str:
        """Convert MATLAB file to Python"""
        with open(input_file, 'r', encoding='utf-8') as f:
            lines = f.readlines()
        
        converted = []
        in_plot_section = False
        
        for i, line in enumerate(lines):
            original_line = line
            line = line.strip()
            
            # Skip empty lines and comments (but preserve them)
            if not line or line.startswith('%'):
                if line.startswith('%%'):
                    converted.append(f"# {line[2:].strip()}\n")
                else:
                    converted.append(original_line)
                continue
            
            # Detect plot sections
            if any(keyword in line for keyword in ['plot(', 'hold(', 'xlabel(', 'ylabel(', 'title(', 'text(', 'legend(', 'set(', 'box(']):
                in_plot_section = True
            
            # Convert MATLAB commands
            converted_line = self.convert_line(line, i)
            if converted_line:
                converted.append(converted_line + '\n')
            else:
                converted.append(original_line)
        
        result = ''.join(converted)
        
        if output_file:
            with open(output_file, 'w', encoding='utf-8') as f:
                f.write(result)
            print(f"Converted file saved to: {output_file}")
        
        return result
    
    def convert_line(self, line: str, line_num: int) -> str:
        """Convert a single MATLAB line to Python"""
        
        # Handle hold on/off
        if re.match(r'hold\(([^)]+)\)', line):
            match = re.match(r'hold\(([^)]+)\)', line)
            axis_var = match.group(1)
            if 'on' in line or 'off' not in line:
                return None  # In matplotlib, we don't need explicit hold
            return None
        
        # Handle plot() commands
        if 'plot(' in line:
            return self.convert_plot(line)
        
        # Handle xlabel
        if 'xlabel(' in line:
            return self.convert_xlabel(line)
        
        # Handle ylabel
        if 'ylabel(' in line:
            return self.convert_ylabel(line)
        
        # Handle title
        if 'title(' in line:
            return self.convert_title(line)
        
        # Handle text
        if 'text(' in line:
            return self.convert_text(line)
        
        # Handle legend
        if 'legend(' in line or 'legend_' in line:
            return self.convert_legend(line)
        
        # Handle set() for axis properties
        if 'set(' in line and ('XGrid' in line or 'YGrid' in line or 'XMinorTick' in line or 'YMinorTick' in line):
            return self.convert_set_axis_properties(line)
        
        # Handle box()
        if 'box(' in line:
            return self.convert_box(line)
        
        # Handle axis font size
        if '.YAxis.FontSize' in line or '.XAxis.FontSize' in line:
            return self.convert_axis_fontsize(line)
        
        return None
    
    def convert_plot(self, line: str) -> str:
        """Convert MATLAB plot() to matplotlib plot()"""
        # Extract axis variable
        axis_match = re.search(r'plot\(([^,]+),', line)
        if not axis_match:
            return None
        
        axis_var = axis_match.group(1).strip()
        self.axis_var = axis_var
        
        # Extract plot arguments
        # Pattern: plot(axis, x_data, y_data, 'DisplayName', '...', 'Color', ..., 'LineWidth', ...)
        plot_match = re.search(r'plot\([^,]+,\s*([^)]+)\)', line)
        if not plot_match:
            return None
        
        args_str = plot_match.group(1)
        
        # Parse arguments
        x_data = None
        y_data = None
        kwargs = {}
        
        # Split by commas, but respect string quotes
        parts = self._split_args(args_str)
        
        if len(parts) >= 2:
            x_data = parts[0].strip()
            y_data = parts[1].strip()
        
        # Parse keyword arguments
        i = 2
        while i < len(parts):
            key = parts[i].strip().strip("'\"")
            if i + 1 < len(parts):
                value = parts[i + 1].strip()
                kwargs[key] = value
                i += 2
            else:
                i += 1
        
        # Build Python plot command
        py_line = f"{axis_var}.plot({x_data}, {y_data}"
        
        # Convert MATLAB-specific parameters
        if 'DisplayName' in kwargs:
            py_line += f", label={kwargs['DisplayName']}"
        
        if 'Color' in kwargs:
            color = kwargs['Color']
            # Convert MATLAB color format to Python
            if color.startswith('app.'):
                py_line += f", color={color}"
            elif color.startswith('[') and color.endswith(']'):
                # RGB array [r, g, b] -> tuple
                py_line += f", color={color}"
            else:
                py_line += f", color='{color}'"
        
        if 'LineWidth' in kwargs:
            py_line += f", linewidth={kwargs['LineWidth']}"
        
        if 'Marker' in kwargs:
            marker = kwargs['Marker'].strip("'\"")
            py_line += f", marker='{marker}'"
        
        if 'MarkerSize' in kwargs:
            py_line += f", markersize={kwargs['MarkerSize']}"
        
        if 'MarkerIndices' in kwargs:
            # matplotlib uses markevery instead
            indices = kwargs['MarkerIndices']
            py_line += f", markevery={indices}"
        
        py_line += ")"
        
        return py_line
    
    def convert_xlabel(self, line: str) -> str:
        """Convert MATLAB xlabel() to Python"""
        # Pattern: xlabel(axis, 'text', 'HorizontalAlignment', 'center', 'FontWeight', 'bold')
        match = re.search(r'xlabel\(([^,]+),\s*([^)]+)\)', line)
        if not match:
            return None
        
        axis_var = match.group(1).strip()
        args_str = match.group(2)
        
        # Extract label text
        label_match = re.search(r"'([^']+)'", args_str)
        if not label_match:
            return None
        
        label_text = label_match.group(1)
        
        # Build Python command
        py_line = f"{axis_var}.set_xlabel('{label_text}'"
        
        # Add font properties
        if 'FontWeight' in args_str and 'bold' in args_str:
            py_line += ", fontweight='bold'"
        
        if 'HorizontalAlignment' in args_str:
            py_line += ", ha='center'"
        
        py_line += ")"
        
        return py_line
    
    def convert_ylabel(self, line: str) -> str:
        """Convert MATLAB ylabel() to Python"""
        # Similar to xlabel
        match = re.search(r'ylabel\(([^,]+),\s*([^)]+)\)', line)
        if not match:
            return None
        
        axis_var = match.group(1).strip()
        args_str = match.group(2)
        
        label_match = re.search(r"'([^']+)'", args_str)
        if not label_match:
            return None
        
        label_text = label_match.group(1)
        
        py_line = f"{axis_var}.set_ylabel('{label_text}'"
        
        if 'FontWeight' in args_str and 'bold' in args_str:
            py_line += ", fontweight='bold'"
        
        if 'HorizontalAlignment' in args_str:
            py_line += ", ha='center'"
        
        py_line += ")"
        
        return py_line
    
    def convert_title(self, line: str) -> str:
        """Convert MATLAB title() to Python"""
        match = re.search(r'title\(([^,]+),\s*([^)]+)\)', line)
        if not match:
            return None
        
        axis_var = match.group(1).strip()
        args_str = match.group(2)
        
        title_match = re.search(r"'([^']+)'", args_str)
        if not title_match:
            return None
        
        title_text = title_match.group(1)
        
        py_line = f"{axis_var}.set_title('{title_text}'"
        
        if 'FontWeight' in args_str and 'bold' in args_str:
            py_line += ", fontweight='bold'"
        
        if 'HorizontalAlignment' in args_str:
            py_line += ", ha='center'"
        
        py_line += ")"
        
        return py_line
    
    def convert_text(self, line: str) -> str:
        """Convert MATLAB text() to Python"""
        # Pattern: text(x, y, 'text', 'Units', 'normalized', ...)
        # In matplotlib, we use ax.text() with different parameter names
        
        match = re.search(r'text\(([^)]+)\)', line)
        if not match:
            return None
        
        args_str = match.group(1)
        parts = self._split_args(args_str)
        
        if len(parts) < 3:
            return None
        
        x = parts[0].strip()
        y = parts[1].strip()
        text_content = parts[2].strip().strip("'\"")
        
        # Check for 'Parent' parameter to get axis
        axis_var = None
        for i, part in enumerate(parts):
            if part.strip() == "'Parent'" or part.strip() == '"Parent"':
                if i + 1 < len(parts):
                    axis_var = parts[i + 1].strip()
                    break
        
        if not axis_var:
            # Try to find axis from context
            axis_var = self.axis_var or "ax"
        
        # Build Python command
        py_line = f"{axis_var}.text({x}, {y}, '{text_content}'"
        
        # Handle Units='normalized'
        if "'Units'" in args_str or '"Units"' in args_str:
            py_line += ", transform=ax.transAxes"
        
        # Handle other properties
        if 'FontSize' in args_str:
            fontsize_match = re.search(r"FontSize[,\s]*(\d+)", args_str)
            if fontsize_match:
                py_line += f", fontsize={fontsize_match.group(1)}"
        
        if 'FontName' in args_str:
            fontname_match = re.search(r"FontName[,\s]*'([^']+)'", args_str)
            if fontname_match:
                py_line += f", fontfamily='{fontname_match.group(1)}'"
        
        if 'FontWeight' in args_str and 'bold' in args_str:
            py_line += ", fontweight='bold'"
        
        if 'Color' in args_str:
            color_match = re.search(r"Color[,\s]*([^,)]+)", args_str)
            if color_match:
                color = color_match.group(1).strip()
                py_line += f", color={color}"
        
        if 'HorizontalAlignment' in args_str:
            ha_match = re.search(r"HorizontalAlignment[,\s]*'([^']+)'", args_str)
            if ha_match:
                py_line += f", ha='{ha_match.group(1)}'"
        
        if 'VerticalAlignment' in args_str:
            va_match = re.search(r"VerticalAlignment[,\s]*'([^']+)'", args_str)
            if va_match:
                py_line += f", va='{va_match.group(1)}'"
        
        if 'Rotation' in args_str:
            rot_match = re.search(r"Rotation[,\s]*(\d+)", args_str)
            if rot_match:
                py_line += f", rotation={rot_match.group(1)}"
        
        py_line += ")"
        
        return py_line
    
    def convert_legend(self, line: str) -> str:
        """Convert MATLAB legend() to Python"""
        # Pattern: legend(axis, 'show') or legend_var = legend(axis, 'show')
        if 'legend(' in line:
            match = re.search(r'legend\(([^)]+)\)', line)
            if not match:
                return None
            
            args_str = match.group(1)
            axis_var = args_str.split(',')[0].strip()
            
            py_line = f"{axis_var}.legend()"
            
            if 'show' in args_str:
                py_line += "  # show legend"
            
            return py_line
        
        # Pattern: set(legend_var, 'Location', 'best')
        if 'set(' in line and 'Location' in line:
            match = re.search(r"set\(([^,]+),\s*'Location',\s*'([^']+)'\)", line)
            if match:
                legend_var = match.group(1).strip()
                location = match.group(2)
                return f"{legend_var}.set_loc('{location}')"
        
        return None
    
    def convert_set_axis_properties(self, line: str) -> str:
        """Convert MATLAB set() for axis properties"""
        # Pattern: set(axis, 'XGrid', 'on', 'YGrid', 'on', ...)
        match = re.search(r"set\(([^,]+),\s*([^)]+)\)", line)
        if not match:
            return None
        
        axis_var = match.group(1).strip()
        props_str = match.group(2)
        
        py_lines = []
        
        # Grid properties
        if "'XGrid', 'on'" in props_str or '"XGrid", "on"' in props_str:
            py_lines.append(f"{axis_var}.grid(True, axis='x')")
        
        if "'YGrid', 'on'" in props_str or '"YGrid", "on"' in props_str:
            py_lines.append(f"{axis_var}.grid(True, axis='y')")
        
        if "'XGrid', 'on'" in props_str and "'YGrid', 'on'" in props_str:
            py_lines = [f"{axis_var}.grid(True)"]  # Both grids
        
        # Minor ticks
        if "'XMinorTick', 'on'" in props_str:
            py_lines.append(f"{axis_var}.xaxis.set_minor_locator(AutoMinorLocator())")
        
        if "'YMinorTick', 'on'" in props_str:
            py_lines.append(f"{axis_var}.yaxis.set_minor_locator(AutoMinorLocator())")
        
        return '\n'.join(py_lines) if py_lines else None
    
    def convert_box(self, line: str) -> str:
        """Convert MATLAB box() to Python"""
        match = re.search(r'box\(([^)]+)\)', line)
        if not match:
            return None
        
        axis_var = match.group(1).strip()
        
        if 'on' in line:
            return f"{axis_var}.spines['top'].set_visible(True)\n{axis_var}.spines['right'].set_visible(True)\n{axis_var}.spines['bottom'].set_visible(True)\n{axis_var}.spines['left'].set_visible(True)"
        else:
            return None  # box off is default in matplotlib
    
    def convert_axis_fontsize(self, line: str) -> str:
        """Convert MATLAB axis font size to Python"""
        # Pattern: axis.YAxis.FontSize = 10
        match = re.search(r'([^.]+)\.(X|Y)Axis\.FontSize\s*=\s*(\d+)', line)
        if match:
            axis_var = match.group(1)
            axis_type = match.group(2).lower()
            fontsize = match.group(3)
            return f"{axis_var}.{axis_type}axis.label.set_fontsize({fontsize})"
        
        return None
    
    def _split_args(self, args_str: str) -> List[str]:
        """Split arguments string respecting quotes"""
        parts = []
        current = ""
        in_quotes = False
        quote_char = None
        paren_depth = 0
        
        for char in args_str:
            if char in ["'", '"'] and (not current or current[-1] != '\\'):
                if not in_quotes:
                    in_quotes = True
                    quote_char = char
                elif char == quote_char:
                    in_quotes = False
                    quote_char = None
                current += char
            elif char == '(' and not in_quotes:
                paren_depth += 1
                current += char
            elif char == ')' and not in_quotes:
                paren_depth -= 1
                current += char
            elif char == ',' and not in_quotes and paren_depth == 0:
                if current.strip():
                    parts.append(current.strip())
                current = ""
            else:
                current += char
        
        if current.strip():
            parts.append(current.strip())
        
        return parts


def main():
    """Main function"""
    if len(sys.argv) < 2:
        print("Usage: python matlab_to_python_plot_converter.py <input_file.m> [output_file.py]")
        print("\nThis script converts MATLAB plotting commands to Python/matplotlib equivalents.")
        print("It handles:")
        print("  - plot() with DisplayName, Color, LineWidth, Marker, etc.")
        print("  - xlabel(), ylabel(), title()")
        print("  - text() with various properties")
        print("  - legend() and set(legend, ...)")
        print("  - set() for grid, minor ticks")
        print("  - box()")
        print("  - axis font size")
        sys.exit(1)
    
    input_file = sys.argv[1]
    output_file = sys.argv[2] if len(sys.argv) > 2 else None
    
    if not os.path.exists(input_file):
        print(f"Error: File not found: {input_file}")
        sys.exit(1)
    
    converter = MATLABPlotConverter()
    result = converter.convert_file(input_file, output_file)
    
    if not output_file:
        print(result)
    
    print("\nConversion complete!")
    print("\nNote: This is an automated conversion. Please review and adjust:")
    print("  1. Import statements (matplotlib.pyplot, matplotlib.ticker, etc.)")
    print("  2. Axis variable names (may need to be adjusted for PyQt6)")
    print("  3. Color formats (RGB arrays may need conversion)")
    print("  4. Font family names (Times New Roman -> 'Times New Roman')")
    print("  5. Transform for normalized coordinates (ax.transAxes)")


if __name__ == '__main__':
    main()
