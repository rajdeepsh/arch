#!/usr/bin/env bash
set -euo pipefail

GREEN=10
RED=9
TEAL=6
WHITE=15
export GUM_INPUT_PROMPT_FOREGROUND="$GREEN"
export GUM_INPUT_CURSOR_FOREGROUND=""
export GUM_INPUT_HEADER_FOREGROUND=""
export GUM_CHOOSE_HEADER_FOREGROUND="$GREEN"
export GUM_CHOOSE_SELECTED_FOREGROUND="$GREEN"
export GUM_CHOOSE_CURSOR_FOREGROUND="$GREEN"
export GUM_CONFIRM_PROMPT_FOREGROUND="$GREEN"
export GUM_CONFIRM_SELECTED_BACKGROUND="$GREEN"
export GUM_CONFIRM_UNSELECTED_BACKGROUND=""
export GUM_CONFIRM_UNSELECTED_FOREGROUND=""

# Verify needed deps are installed
programs=(gum git)
for prog in "${programs[@]}"; do
  if ! command -v "$prog" >/dev/null 2>&1; then
    echo "Error: ${prog} is not installed. Please install it first."
    exit 1
  fi
done

# Partition and format the disk
clear
gum style "Using Arch again, Rajdeep? Let's set up your user account..." --foreground "$TEAL"
echo ""
while true; do
    pass=$(gum input --password --placeholder "Used for user + root + encryption" --prompt "Password> ")
    confirm_pass=$(gum input --password --placeholder "Must match the password you just typed" --prompt "Confirm> ")
    if [[ "$pass" != "$confirm_pass" ]]; then
        gum spin --spinner pulse --spinner.foreground "$RED" --title "Passwords must match! Press any key to try again." --title.foreground "$RED" -- bash -c 'read -n 1 -s'
        continue
    fi
    break
done

clear
gum style "Great! Now let's select where to install Arch..." --foreground "$TEAL"
echo ""
while true; do
    disk=$(lsblk -dpno NAME,SIZE,ROTA,TYPE | awk '$3==0 && $4=="disk" {print $1, $2}' | gum choose --header "Select install disk" | awk '{print $1}')
    if gum confirm "Confirm overwriting ${disk}"; then
        echo -e "label: gpt\n,1G,U\n,8G,S\n,+,L" | sfdisk --wipe=always "$disk"
        if [[ "$disk" == *"nvme"* ]]; then
            part_prefix="p"
        else
            part_prefix=""
        fi

        efi="${disk}${part_prefix}1"
        swap="${disk}${part_prefix}2"
        root="${disk}${part_prefix}3"

        mkfs.fat -F 32 "$efi"
        mkswap "$swap"
        mkfs.ext4 -F "$root"

        mount --mkdir "$efi" /mnt/boot
        swapon "$swap"
        mount "$root" /mnt

        break
    fi
done

clear
gum style "Disk overwritten! Installing Arch..." --foreground "$TEAL"
echo ""