#!/usr/bin/env bash
set -euo pipefail

# Verify needed deps are installed
programs=(gum git)
for prog in "${programs[@]}"; do
  if ! command -v "$prog" >/dev/null 2>&1; then
    echo "Error: $prog is not installed. Please install it first."
    exit 1
  fi
done

while true; do
    disk=$(lsblk -dpno NAME,SIZE,ROTA,TYPE | awk '$3==0 && $4=="disk" {print $1, $2}' | gum choose --header "Select the disk to format:" | awk '{print $1}')
    if gum confirm "Disk to format: $disk"; then
        echo -e "label: gpt\n,1G,U\n,8G,S\n,+,L" | sfdisk --wipe=always "$disk"
        break
    fi
done