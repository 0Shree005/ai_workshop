
# 🚀 AI Workshop — Build a Transformer From Scratch

This workshop guides you through implementing core transformer components from first principles using Python and Jupyter.

You’ll set up a reproducible environment, install dependencies, and run interactive notebooks to understand how modern LLMs actually work internally.

---

# 📂 Project Structure

```
ai_workshop/
│
├── data/               # Dataset (auto-downloaded)
├── day/                # Notebooks
├── material/           # Theory PDFs
├── reference/          # Reference implementations
│
├── linux/              # Fedora setup scripts
│   ├── setup.sh
│   ├── verify.sh
│   └── reset.sh
│
├── windows/            # Windows setup scripts
│   ├── setup.ps1
│   ├── verify.ps1
│   └── reset.ps1
│
└── README.md
```

---

# 🐧 Fedora Setup

## Requirements

* Python **3.11 or newer**
* Internet connection

Check version:

```bash
python3 --version
```

If missing:

```bash
sudo dnf install python3 python3-pip
```

---

## Run Setup

From project root:

```bash
chmod +x linux/setup.sh
./linux/setup.sh
```

This automatically:

* installs `uv`
* creates virtual environment
* installs dependencies
* downloads dataset
* verifies everything
* launches Jupyter Notebook

If setup succeeds, you’re ready.

---

## Manual Verify (optional)

```bash
./linux/verify.sh
```

---

## Reset Environment

If something breaks:

```bash
./linux/reset.sh
./linux/setup.sh
```

---

# 🪟 Windows Setup

⚠ Use **PowerShell**, not Command Prompt.

---

## Requirements

Install Python 3.11+ from:

[https://www.python.org/downloads/](https://www.python.org/downloads/)

During install:

✔ Check **Add Python to PATH**

Verify:

```powershell
python --version
```

---

## Run Setup

From project root:

```powershell
powershell -ExecutionPolicy Bypass -File windows/setup.ps1
```

This automatically:

* installs uv
* creates environment
* installs packages
* downloads dataset
* verifies setup

---

## Manual Verify

```powershell
powershell -ExecutionPolicy Bypass -File windows/verify.ps1
```

---

## Reset Environment

```powershell
powershell -ExecutionPolicy Bypass -File windows/reset.ps1
```

Then rerun setup.

---

# 📊 Dataset

Downloaded automatically to:

```
data/names.txt
```

Used for character-level transformer experiments.

---

# ▶ Running Notebook

After setup finishes:

```
jupyter notebook
```

Open:

```
day/day1.ipynb
```

---

# 🛠 Troubleshooting

### Python version unsupported

Supported versions:

* 3.11
* 3.12
* 3.14

Install correct version → reset → setup again.

---

### Graphviz visualization errors

Install system package:

**Fedora**

```
sudo dnf install graphviz
```

**Windows**
Install from:
[https://graphviz.org/download/](https://graphviz.org/download/)

Restart terminal afterward.

---

### Setup fails midway

Run reset, then setup again:

Linux

```
./linux/reset.sh
./linux/setup.sh
```

Windows

```
powershell -ExecutionPolicy Bypass -File windows/reset.ps1
powershell -ExecutionPolicy Bypass -File windows/setup.ps1
```

---

# 🎯 Workshop Goal

By the end, you’ll understand:

* how attention actually works
* why masking is needed
* how positional encoding functions
* what a transformer block really does internally

Not surface-level theory — actual implementation understanding.
