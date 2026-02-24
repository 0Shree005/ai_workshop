#!/usr/bin/env bash
set -e

if [ ! -f "pyproject.toml" ]; then
    echo "❌ Run this from project root."
    exit 1
fi

echo "⚠ This will delete environment + generated files."
read -p "Continue? (y/N): " confirm

if [[ $confirm != "y" && $confirm != "Y" ]]; then
    echo "Cancelled."
    exit 0
fi

echo "🧹 Removing local python files..."
rm main.py pyproject.toml .python-version


echo "🧹 Removing virtual environment..."
rm -rf .venv

echo "🧹 Removing uv lock + local cache..."
rm -f uv.lock
rm -rf .uv

echo "🧹 Removing Python cache..."
find . -type d -name "__pycache__" -exec rm -rf {} +
find . -type f -name "*.pyc" -delete

echo "🧹 Removing VSCode workspace settings..."
rm -rf .vscode

echo "✅ Project reset complete."
echo "Run ./setup.sh to reinstall everything."
