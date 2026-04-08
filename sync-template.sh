#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

TEMPLATE_REPO="git@github.com:XXCC-Unicorn-Press/journal-template.git"

# Check if the current directory is clean (no uncommitted changes)
if [[ -n $(git status --porcelain) ]]; then
  echo "Error: You have uncommitted changes. Please commit or stash them before running this script."
  exit 1
fi

# Add the remote template repository if it doesn't exist
git remote get-url template > /dev/null 2>&1 || git remote add template "$TEMPLATE_REPO"

# Fetch the latest changes from the template repository
echo "Fetching latest changes from the template repository..."
git fetch template

# Merge the latest changes from the template repository into the current branch
echo "Merging latest changes from the template repository..."
git merge template/main --allow-unrelated-histories --no-commit || true

# Reset protected files to their original state
echo "Resetting protected files to their original state..."
PROTECTED_FILES=(
    "content/"
    "figures/"
    "preamble/meta.tex"
    "preamble/custom.tex"
    "references.bib"
)
for file in "${PROTECTED_FILES[@]}"; do
    rm -rf "$file"
    git checkout HEAD -- "$file"
done
