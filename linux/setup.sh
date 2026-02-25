#!/usr/bin/env bash
set -e

echo "🚀 Setting up workshop environment..."

# -------------------------
# CHECK PYTHON
# -------------------------
if ! command -v python3 &> /dev/null; then
    echo "❌ Python3 is not installed."
    echo "Install Python 3.11+ and rerun."
    exit 1
fi

echo "🐍 Python detected."

# -------------------------
# CHECK PIP
# -------------------------
echo "Ensuring pip is available..."
python3 -m ensurepip --upgrade >/dev/null 2>&1 || true

# -------------------------
# CHECK UV
# -------------------------
if ! command -v uv &> /dev/null; then
    echo "📦 Installing uv..."
    python3 -m pip install --user uv
    export PATH="$HOME/.local/bin:$PATH"
fi

echo "✅ uv ready."

# -------------------------
# PROJECT INIT
# -------------------------
[ -f pyproject.toml ] || uv init --python 3.14 .

if [ ! -f uv.lock ]; then
    echo "📦 Installing dependencies..."
    uv add notebook ipykernel matplotlib graphviz numpy
fi

# -------------------------
# FOLDERS
# -------------------------
echo "📂 Creating folders..."
mkdir -p day data

# -------------------------
# DATASET
# -------------------------
echo "⬇ Downloading dataset..."
if [ ! -f data/names.txt ]; then
    curl -L https://raw.githubusercontent.com/karpathy/makemore/master/names.txt -o data/names.txt
fi

# -------------------------
# SYNC ENV
# -------------------------
echo "🐍 Syncing env..."
uv sync

# -------------------------
# VERIFY
# -------------------------
echo "🔎 Verifying install..."
if ! ./linux/verify.sh; then
    echo "❌ Setup verification failed"
    exit 1
fi

echo "✅ Environment ready!"
echo "Run: jupyter notebook"
jupyter notebook
