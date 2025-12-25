# ferr0x Installation Guide

Multiple installation methods are available for ferr0x.

## Quick Install

### Homebrew (macOS & Linux)

```bash
brew tap insomn14/ferr0x https://github.com/insomn14/ferr0x
brew install ferr0x
```

### APT/Debian (Ubuntu/Debian)

```bash
# Add repository
echo "deb [trusted=yes] https://raw.githubusercontent.com/insomn14/ferr0x/main/apt-repo stable main" | \
  sudo tee /etc/apt/sources.list.d/ferr0x.list

# Install
sudo apt update
sudo apt install ferr0x
```

**Or install .deb directly:**
```bash
wget https://github.com/insomn14/ferr0x/releases/latest/download/ferr0x_1.0.0_amd64.deb
sudo dpkg -i ferr0x_1.0.0_amd64.deb
```

### Manual Download

Download the binary for your platform from the [releases page](https://github.com/insomn14/ferr0x/releases/latest):

- **macOS (Apple Silicon)**: `ferr0x-macos-arm64`
- **macOS (Intel)**: `ferr0x-macos-x86_64`
- **Linux (x86_64)**: `ferr0x-linux-x86_64`
- **Windows (x86_64)**: `ferr0x-windows-x86_64.exe`

---

## Update & Uninstall Instructions

**Updating**:
```bash
brew update
brew upgrade ferr0x
```

**Uninstalling**:
```bash
brew uninstall ferr0x
```

---

### Ubuntu / Debian (APT)

**Option 1: Install .deb package directly**

```bash
# Download the latest release
wget https://github.com/insomn14/ferr0x/releases/download/v1.0.0/ferr0x_1.0.0_amd64.deb

# Install
sudo dpkg -i ferr0x_1.0.0_amd64.deb

# Verify installation
ferr0x --version
```

**Updating**: Download and install the newer .deb file

**Uninstalling**:
```bash
sudo dpkg -r ferr0x
```
---

### Manual Installation (All Platforms)

**1. Download the binary**

Visit the [releases page](https://github.com/insomn14/ferr0x/releases/latest) and download the appropriate binary for your system.

**2. Make it executable (macOS/Linux)**

```bash
# macOS (Apple Silicon)
chmod +x ferr0x-macos-arm64
sudo mv ferr0x-macos-arm64 /usr/local/bin/ferr0x

# macOS (Intel)
chmod +x ferr0x-macos-x86_64
sudo mv ferr0x-macos-x86_64 /usr/local/bin/ferr0x

# Linux
chmod +x ferr0x-linux-x86_64
sudo mv ferr0x-linux-x86_64 /usr/local/bin/ferr0x
```

**3. Verify installation**

```bash
ferr0x --version
ferr0x --banner
```

---

### Windows

**Option 1: Manual installation**

1. Download `ferr0x-windows-x86_64.exe` from [releases](https://github.com/insomn14/ferr0x/releases/latest)
2. Rename to `ferr0x.exe`
3. Add to your PATH or run from the download directory

**Option 2: Scoop** (Coming soon)

```powershell
scoop install ferr0x
```

**Option 3: Chocolatey** (Coming soon)

```powershell
choco install ferr0x
```

---

## Verify Installation

After installation, verify that ferr0x is working:

```bash
# Check version
ferr0x --version

# Display banner
ferr0x --banner

# Get help
ferr0x --help
```

---

## Verifying Downloads (SHA256)

Each release includes SHA256 checksums. To verify your download:

```bash
# macOS/Linux
shasum -a 256 ferr0x-macos-arm64

# Compare with SHA256SUMS file from releases
wget https://github.com/insomn14/ferr0x/releases/download/v1.0.0/SHA256SUMS
cat SHA256SUMS
```

---

## Next Steps

After installation:

1. Read the [README](README.md) for usage examples
2. Check out the [release notes](release/RELEASE_NOTES.md) for features
3. Report issues on [GitHub](https://github.com/insomn14/ferr0x/issues)

---

## Platform Support

| Platform | Architecture | Status |
|----------|-------------|--------|
| macOS    | ARM64 (M1/M2/M3) | ✅ Supported |
| macOS    | x86_64 (Intel) | ✅ Supported |
| Linux    | x86_64 | ✅ Supported |
| Windows  | x86_64 | ✅ Supported |
| Linux    | ARM64 | ❌ Not Support |

---

For more information, visit the [GitHub repository](https://github.com/insomn14/ferr0x).
