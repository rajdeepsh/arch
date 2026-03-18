#!/usr/bin/env bash
set -euo pipefail

# Verify needed deps are installed
programs=(gum sha256sum b2sum gpg)
for prog in "${programs[@]}"; do
  if ! command -v "$prog" >/dev/null 2>&1; then
    echo "Error: $prog is not installed. Please install it first."
    exit 1
  fi
done

# This assumes that all required files are in the same subdirectory in $HOME
dir=$(find "$HOME" -mindepth 1 -maxdepth 1 -type d ! -name ".*" | sort -f | gum choose --header "Select the directory that contains the Arch (1) *.iso, (2) *.sig, (3) sha256sums.txt, and (4) b2sums.txt files")
cd "$dir"
sha256_file="sha256sums.txt"
b2_file="b2sums.txt"
iso_file=$(find . -type f -name "*.iso" -exec basename {} \; | sort -f | gum choose --header "Select the ISO file to verify")
sig_file="$iso_file.sig"
fingerprint=3E80CA1A8B89F69CBA57D98A76A5EF9054449A5C

gum spin --spinner dot --title "Verifying sha256sums..." --show-output -- sha256sum -c "$sha256_file" --ignore-missing
gum spin --spinner dot --title "Verifying b2sums..." --show-output -- b2sum -c "$b2_file" --ignore-missing
gum spin --spinner dot --title "Downloading Pierre's gpg key..." -- gpg --auto-key-locate clear,wkd -v --locate-external-key pierre@archlinux.org
gum spin --spinner dot --title "Trusting Pierre's gpg key..." -- echo "$fingerprint:6:" | gpg --import-ownertrust
gum spin --spinner dot --title "Verifying signature..." --show-output -- gpg --verify "$sig_file" "$iso_file"

gum spin --spinner globe --title "Done! Press any key to close..." -- bash -c 'read -n 1 -s'