#!/usr/bin/env bash
set -euo pipefail

WHITE=15
BLACK=0
GREEN=10
BLUE=14
PURPLE=13
RED=9

export GUM_CHOOSE_HEADER_FOREGROUND="$BLUE"
export GUM_CHOOSE_SELECTED_FOREGROUND="$GREEN"
export GUM_CHOOSE_CURSOR_FOREGROUND="$GREEN"

# Verify needed deps are installed
programs=(gum sha256sum b2sum gpg)
for prog in "${programs[@]}"; do
  if ! command -v "$prog" >/dev/null 2>&1; then
    echo "Error: ${prog} is not installed. Please install it first."
    exit 1
  fi
done

gum style --foreground "$BLUE" "Let's verify your ISO..."
gum style --foreground "$BLUE" "Required files: (1) *.iso, (2) *.sig, (3) sha256sums.txt, and (4) b2sums.txt."
echo ""

dir=$(find "$HOME" -mindepth 1 -maxdepth 1 -type d ! -name ".*" | sort -f | gum choose --header "Select directory containing files")
cd "$dir"
sha256_file="sha256sums.txt"
b2_file="b2sums.txt"
iso_file=$(find . -type f -name "*.iso" -exec basename {} \; | sort -f | gum choose --header "Select ISO to verify")
sig_file="${iso_file}.sig"
fingerprint=3E80CA1A8B89F69CBA57D98A76A5EF9054449A5C

# Verify sha256 checksum
sha256_out=$(sha256sum -c "$sha256_file" --ignore-missing 2>&1)
if [[ "$sha256_out" == *"${iso_file}: OK"* ]]; then
  gum style --foreground "$GREEN" "✔ SHA-256 checksum verified successfully!"
else
  gum style --foreground "$RED" "✗ SHA-256 checksum verification failed!"
  exit 1
fi

# Verify b2 checksum
b2sum_out=$(b2sum -c "$b2_file" --ignore-missing 2>&1)
if [[ "$b2sum_out" == *"${iso_file}: OK"* ]]; then
  gum style --foreground "$GREEN" "✔ BLAKE2b checksum verified successfully!"
else
  gum style --foreground "$RED" "✗ BLAKE2b checksum verification failed!"
  exit 1
fi

gum spin --spinner dot --spinner.foreground "$BLUE" --title "Downloading Pierre's gpg key..." -- gpg --auto-key-locate clear,wkd -v --locate-external-key pierre@archlinux.org
gum spin --spinner dot --spinner.foreground "$BLUE" --title "Trusting Pierre's gpg key..." -- echo "${fingerprint}:6:" | gpg --import-ownertrust

gpg_out=$(gpg --verify "$sig_file" "$iso_file" 2>&1)
if [[ "$gpg_out" == *'Good signature from "Pierre Schmitz <pierre@archlinux.org>" [ultimate]'* ]]; then
  gum style --foreground "$GREEN" "✔ GPG signature verified successfully!"
else
  gum style --foreground "$RED" "✗ GPG signature verification failed!"
  exit 1
fi

echo ""
gum spin --spinner globe --title "Done! Press any key to close..." --title.foreground "$PURPLE" -- bash -c 'read -n 1 -s'