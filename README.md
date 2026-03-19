# arch

## Download, Verify, and Flash Arch ISO

> [!IMPORTANT]
> You need to have `gum`, `sha256sum`, `b2sum`, and `gpg` installed.

1. [Download](https://archlinux.org/download/) the Arch (1) \*.iso, (2) \*.sig, (3) sha256sums.txt, and (4) b2sums.txt files.
2. Place the downloaded files in a single subdirectory within `$HOME` (e.g., `$HOME/Downloads`).
3. Execute `verify.sh`:

   ```bash
   bash verify.sh
   ```

4. Flash the Arch ISO into an external drive and boot into the live environment.

## Install Arch

1. Connect to the internet with `iwctl`:

   ```bash
   # Start iwctl
   iwctl
   # List interfaces
   device list
   # Set interface to scanning mode
   station wlan0 scan
   # Get networks
   station wlan0 get-networks
   # Connect to network
   station wlan0 connect 'Network'
   # Check if interface is connected to network
   station wlan0 show
   # Exit
   exit
   # Check if you have network access
   ping ping.archlinux.org
   ```

2. Install `gum` and `git`:

   ```bash
   pacman -Sy gum git --noconfirm
   ```

3. Clone this repository:

   ```bash
   git clone https://github.com/rajdeepsh/arch.git
   ```

4. Execute `install.sh`:

   ```bash
   bash arch/install.sh
   ```

5. Execute the following command to create the `.ssh` folder with authorized keys:

   ```bash
   mkdir -p $HOME/.ssh && wget -qO- https://github.com/rajdeepsh.keys >>/home/rajdeep/.ssh/authorized_keys
   ```

6. Download your `ssh` config, public, and private keys, place it in the `.ssh` folder, and execute the following command:

   ```bash
   chmod 600 $HOME/.ssh/config && chmod 600 $HOME/.ssh/rajdeepsh && chmod 644 $HOME/.ssh/rajdeepsh.pub
   ```

7. Execute the following command to setup `git`:

   ```bash
   git config --global user.name "Rajdeep Singh Hundal" && git config --global user.email "rajd33psh@gmail.com" && git config --global gpg.format ssh && git config --global user.signingkey $HOME/.ssh/rajdeepsh.pub && git config --global commit.gpgsign true
   ```

8. Execute the following to enable and start `ssh-agent`:

   ```bash
   systemctl --user enable --now ssh-agent.service
   ```

9. Clone this repository and set everything else up:

   ```bash
   git -C $HOME clone git@github.com:rajdeepsh/arch.git && bash $HOME/arch/install_user.sh
   ```
