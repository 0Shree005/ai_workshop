#!/usr/bin/env bash
set -e

echo "🔎 Running environment checks..."

fail() {
  echo "❌ $1"
  exit 1
}

pass() {
  echo "✅ $1"
}

# -------------------------
# must be run from project root
# -------------------------
[ -f pyproject.toml ] || fail "Run from project root."

# -------------------------
# venv exists
# -------------------------
[ -d .venv ] || fail ".venv missing. Run ./setup.sh"

pass "Virtual environment exists"

# -------------------------
# python version check
# -------------------------
PYVER=$(.venv/bin/python -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')")

if [[ "$PYVER" != "3.11" && "$PYVER" != "3.12" && "$PYVER" != "3.14" ]]; then
    fail "Unsupported Python version: $PYVER"
fi

pass "Python version OK ($PYVER)"

# -------------------------
# dependency test
# -------------------------
.venv/bin/python - <<EOF || fail "Dependencies missing"
import numpy
import matplotlib
import graphviz
import IPython
EOF

pass "Dependencies import successfully"

# -------------------------
# dataset test
# -------------------------
[ -f data/names.txt ] || fail "Dataset missing (data/names.txt)"

pass "Dataset exists"

# -------------------------
# kernel test
# -------------------------
.venv/bin/python - <<EOF || fail "Kernel import failed"
import ipykernel
EOF

pass "Kernel launches"

echo
echo "🎉 All checks passed. Environment ready."
