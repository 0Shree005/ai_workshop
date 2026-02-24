$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "AI Workshop Environment Setup"
Write-Host "--------------------------------"

# -------------------------
# CHECK PYTHON
# -------------------------
$python = Get-Command python -ErrorAction SilentlyContinue

if (!$python) {
    Write-Host ""
    Write-Host "Python is not installed."
    Write-Host ""
    Write-Host "Install Python 3.11 or newer from:"
    Write-Host "https://www.python.org/downloads/"
    Write-Host ""
    Write-Host "IMPORTANT:"
    Write-Host " During install CHECK 'Add Python to PATH'"
    Write-Host ""
    Write-Host "After installing, run this script again."
    exit 1
}

Write-Host "Python detected."


# -------------------------
# CHECK PIP
# -------------------------
Write-Host "Ensuring pip is available..."
python -m ensurepip --upgrade > $null 2>&1

# -------------------------
# CHECK UV
# -------------------------
$uv = Get-Command uv -ErrorAction SilentlyContinue

if (!$uv) {
    Write-Host "Installing uv..."
    python -m pip install uv
}

Write-Host "uv ready."

# -------------------------
# PROJECT SETUP
# -------------------------
Write-Host ""
Write-Host "Setting up project..."

if (!(Test-Path "pyproject.toml")) {
    uv init --python 3.11 .
}

if (!(Test-Path "uv.lock")) {
    Write-Host "Installing dependencies..."
    python -m uv add notebook ipykernel matplotlib graphviz numpy
}

Write-Host "Creating folders..."
New-Item -ItemType Directory -Force day | Out-Null
New-Item -ItemType Directory -Force data | Out-Null

Write-Host "Downloading dataset..."
if (!(Test-Path "data/names.txt")) {
    Invoke-WebRequest `
        -Uri "https://raw.githubusercontent.com/karpathy/makemore/master/names.txt" `
        -OutFile "data/names.txt"
}

Write-Host "Syncing environment..."
python -m uv sync

Write-Host "Running verification..."
powershell -ExecutionPolicy Bypass -File windows/verify.ps1

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "Setup failed. Fix errors above."
    exit 1
}

Write-Host ""
Write-Host "Setup complete!"
Write-Host "Open project with: code ."