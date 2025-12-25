#!/bin/bash
set -e

# Setup APT repository in ferr0x GitHub repo
# This script generates the APT repository metadata

VERSION="${1:-1.0.0}"
REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"
POOL_DIR="$REPO_ROOT/pool/main/f/ferr0x"
DISTS_DIR="$REPO_ROOT/dists/stable"

echo "Setting up APT repository for ferr0x v${VERSION}"

# Step 1: Copy .deb package to pool
echo "Step 1: Copying .deb package to pool..."
DEB_FILE="../packaging/debian/build/ferr0x_${VERSION}_amd64.deb"

if [ ! -f "$DEB_FILE" ]; then
    echo "Error: .deb file not found at $DEB_FILE"
    echo "Please build it first with: cd packaging/debian && ./build-deb.sh ${VERSION}"
    exit 1
fi

cp "$DEB_FILE" "$POOL_DIR/"
echo "✓ Copied to $POOL_DIR/"

# Step 2: Generate Packages file
echo "Step 2: Generating Packages file..."
cd "$REPO_ROOT"

# Create Packages file
dpkg-scanpackages --arch amd64 pool/main > dists/stable/main/binary-amd64/Packages
gzip -k -f dists/stable/main/binary-amd64/Packages

echo "✓ Packages file generated"

# Step 3: Generate Release file
echo "Step 3: Generating Release file..."
cd "$DISTS_DIR"

cat > Release << EOF
Origin: insomn14
Label: insomn14 APT Repository
Suite: stable
Codename: stable
Version: 1.0
Architectures: amd64
Components: main
Description: APT repository for ferr0x security testing tool
Date: $(date -Ru)
EOF

# Generate checksums for Release file
echo "MD5Sum:" >> Release
find main -type f | while read file; do
    echo " $(md5sum "$file" | awk '{print $1, "'"$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file")"'", "'"$file"'"}')" >> Release
done

echo "SHA1:" >> Release
find main -type f | while read file; do
    echo " $(shasum -a 1 "$file" | awk '{print $1, "'"$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file")"'", "'"$file"'"}')" >> Release
done

echo "SHA256:" >> Release
find main -type f | while read file; do
    echo " $(shasum -a 256 "$file" | awk '{print $1, "'"$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file")"'", "'"$file"'"}')" >> Release
done

echo "✓ Release file generated"

# Step 4: Optional - Sign with GPG
if command -v gpg &> /dev/null; then
    echo ""
    echo "Step 4: GPG signing (optional)"
    read -p "Do you want to sign the repository with GPG? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        read -p "Enter your GPG email: " GPG_EMAIL

        # Sign the Release file
        gpg --default-key "$GPG_EMAIL" -abs -o Release.gpg Release
        gpg --default-key "$GPG_EMAIL" --clearsign -o InRelease Release

        # Export public key
        gpg --armor --export "$GPG_EMAIL" > "$REPO_ROOT/ferr0x-archive-keyring.gpg"

        echo "✓ Repository signed with GPG"
        echo "✓ Public key exported to ferr0x-archive-keyring.gpg"
    else
        echo "⊘ Skipping GPG signing (users will need to use [trusted=yes])"
    fi
else
    echo "⊘ GPG not found - skipping signing"
fi

echo ""
echo "════════════════════════════════════════════════════════════════"
echo "✓ APT Repository setup complete!"
echo "════════════════════════════════════════════════════════════════"
echo ""
echo "Repository structure:"
echo "  apt-repo/"
echo "  ├── pool/main/f/ferr0x/ferr0x_${VERSION}_amd64.deb"
echo "  └── dists/stable/main/binary-amd64/Packages[.gz]"
echo ""
echo "Next steps:"
echo "  1. Commit and push to GitHub:"
echo "     git add apt-repo/"
echo "     git commit -m 'Add APT repository'"
echo "     git push origin main"
echo ""
echo "  2. Users can install with:"
if [ -f "$REPO_ROOT/ferr0x-archive-keyring.gpg" ]; then
    echo "     # With GPG signature (recommended)"
    echo "     curl -fsSL https://raw.githubusercontent.com/insomn14/ferr0x/main/apt-repo/ferr0x-archive-keyring.gpg | \\"
    echo "       sudo gpg --dearmor -o /usr/share/keyrings/ferr0x-archive-keyring.gpg"
    echo ""
    echo "     echo 'deb [signed-by=/usr/share/keyrings/ferr0x-archive-keyring.gpg] https://raw.githubusercontent.com/insomn14/ferr0x/main/apt-repo stable main' | \\"
    echo "       sudo tee /etc/apt/sources.list.d/ferr0x.list"
else
    echo "     # Without GPG signature (not signed)"
    echo "     echo 'deb [trusted=yes] https://raw.githubusercontent.com/insomn14/ferr0x/main/apt-repo stable main' | \\"
    echo "       sudo tee /etc/apt/sources.list.d/ferr0x.list"
fi
echo ""
echo "     sudo apt update"
echo "     sudo apt install ferr0x"
echo ""
echo "════════════════════════════════════════════════════════════════"
