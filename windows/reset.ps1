$ErrorActionPreference = "Stop"

if (!(Test-Path "pyproject.toml")) {
    Write-Host " Run this from project root."
    exit 1
}

Write-Host "⚠ This will delete environment + generated files."
$confirm = Read-Host "Continue? (y/N)"

if ($confirm -notin @("y","Y")) {
    Write-Host "Cancelled."
    exit 0
}

Write-Host " Removing virtual environment..."
Remove-Item ".venv" -Recurse -Force -ErrorAction SilentlyContinue

Write-Host " Removing uv lock + local cache..."
Remove-Item "uv.lock" -Force -ErrorAction SilentlyContinue
Remove-Item ".uv" -Recurse -Force -ErrorAction SilentlyContinue

Write-Host " Removing Python cache..."
Get-ChildItem -Recurse -Directory -Filter "__pycache__" | Remove-Item -Recurse -Force
Get-ChildItem -Recurse -Filter "*.pyc" | Remove-Item -Force

Write-Host " Removing VSCode workspace settings..."
Remove-Item ".vscode" -Recurse -Force -ErrorAction SilentlyContinue

Write-Host " Project reset complete."
Write-Host "Run .\setup.ps1 to reinstall everything."