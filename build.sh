#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Ensure the target directory exists
TARGET_DIR="target"
mkdir -p "$TARGET_DIR"
rm -rf "$TARGET_DIR"/*

# Export Inkscape figures
cp inkscape/logo.png "$TARGET_DIR/logo.png"
cp inkscape/frontcover.png "$TARGET_DIR/frontcover.png"
cp inkscape/backcover.png "$TARGET_DIR/backcover.png"

# Compile the LaTeX document (print version)
LATEX_MODE="PRINT" latexmk
cp main.pdf "$TARGET_DIR/print.pdf"
latexmk -C

# Compile the LaTeX document (online version)
LATEX_MODE="ONLINE" latexmk
cp main.pdf "$TARGET_DIR/online.pdf"
latexmk -C
