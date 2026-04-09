#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Ensure the target directory exists
TARGET_DIR="target"
mkdir -p "$TARGET_DIR"
rm -rf "$TARGET_DIR"/*

# Export resouces
cp resources/logo.png "$TARGET_DIR/logo.png"
cp resources/frontcover.png "$TARGET_DIR/frontcover.png"
cp resources/backcover.png "$TARGET_DIR/backcover.png"
cp LICENSE "$TARGET_DIR/LICENSE"

# Compile the LaTeX document (print version)
LATEX_MODE="PRINT" latexmk
cp main.pdf "$TARGET_DIR/print.pdf"
latexmk -C

# Compile the LaTeX document (online version)
LATEX_MODE="ONLINE" latexmk
cp main.pdf "$TARGET_DIR/online.pdf"
latexmk -C

# Output the target directory path
echo "Build complete. Output files are located in: $TARGET_DIR"
