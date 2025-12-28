# Troubleshooting Guide

## BUSCO Installation Issues

### Problem: NumPy version incompatibility

**Error encountered:**
```
A module that was compiled using NumPy 1.x cannot be run in
NumPy 2.2.5 as it may crash.
```

**Root cause:**
BUSCO 5.5.0 dependencies were compiled against NumPy 1.x but system had NumPy 2.x installed.

**What I tried (didn't work):**
```bash
# Attempted system installation
sudo apt install busco  # Installed to /usr/bin/busco
# This created conflicts with user-local Python packages
```

**Solution that worked:**
```bash
# Reinstall using conda with correct numpy version
conda create -n longread-assembly python=3.9
conda activate longread-assembly
conda install -c bioconda -c conda-forge busco=5.5.0 "numpy<2"
```

**Lesson learned:**
Conda environments provide better dependency isolation than mixing system packages with user-local Python packages.

---

## Alternative: Use Provided Environment File

The easiest approach for reproduction:
```bash
conda env create -f environment.yml
conda activate longread-assembly
```

This ensures all dependencies (including numpy version) are correct.
