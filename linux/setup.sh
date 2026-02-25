#!/usr/bin/env bash
set -e

echo "🚀 Setting up workshop environment..."

[ -f pyproject.toml ] || uv init --python 3.14 .

if [ ! -f uv.lock ]; then
    echo "📦 Installing dependencies..."
    uv add notebook ipykernel matplotlib graphviz numpy
fi

echo "📂 Creating folders..."
mkdir -p day data

echo "⬇ Downloading dataset..."
if [ ! -f data/names.txt ]; then
    curl -L https://raw.githubusercontent.com/karpathy/makemore/master/names.txt -o data/names.txt
fi

echo "🐍 Syncing env..."
uv sync

echo "🔎 Verifying install..."
if ! ./linux/verify.sh; then
    echo "❌ Setup verification failed"
    exit 1
fi

echo "✅ Environment ready!"
echo "Run: code ."
code .
