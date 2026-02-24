$ErrorActionPreference = "Stop"

function fail($msg){
    Write-Host " $msg"
    exit 1
}

function pass($msg){
    Write-Host " $msg"
}

Write-Host " Running environment checks..."

if (!(Test-Path "pyproject.toml")) {
    fail "Run from project root."
}

if (!(Test-Path ".venv")) {
    fail ".venv missing. Run setup.ps1"
}
pass "Virtual environment exists"

$py = ".\.venv\Scripts\python.exe"

$version = & $py -c "import sys;print(f'{sys.version_info.major}.{sys.version_info.minor}')"

if ($version -notin @("3.11","3.12","3.14")) {
    fail "Unsupported Python version: $version"
}
pass "Python version OK ($version)"

& $py -c "import numpy, matplotlib, graphviz, ipykernel"

if ($LASTEXITCODE -ne 0) { fail "Dependencies missing" }
pass "Dependencies import successfully"

if (!(Test-Path "data/names.txt")) {
    fail "Dataset missing (data/names.txt)"
}
pass "Dataset exists"

& $py -c "import ipykernel"

if ($LASTEXITCODE -ne 0) { fail "Kernel import failed" }
pass "Kernel works"

Write-Host ""
Write-Host " All checks passed. Environment ready."