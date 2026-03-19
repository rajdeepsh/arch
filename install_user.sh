#!/usr/bin/env bash
set -euo pipefail
PURPLE=13

mkdir -p $HOME/.config
cd $HOME/arch
stow --adopt */
git reset --hard HEAD
cd $HOME

git -C $HOME clone https://aur.archlinux.org/paru.git
cd $HOME/paru
makepkg -si
cd $HOME
rm -rf $HOME/paru

sudo -v
paru -Syu --needed google-chrome visual-studio-code-bin

sudo -v
echo ""
for i in {5..1}; do
  gum spin --spinner globe --title.foreground "${PURPLE}" --title "Done! Rebooting in ${i} seconds..." -- sleep 1
done
sudo reboot