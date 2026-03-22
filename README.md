# arch-dotfiles

## Download, Verify, and Flash Arch ISO

> [!IMPORTANT]
> You need to have `gum`, `sha256sum`, `b2sum`, and `gpg` installed.

1. [Download](https://archlinux.org/download/) the Arch (1) \*.iso, (2) \*.sig, (3) sha256sums.txt, and (4) b2sums.txt files.
2. Place the downloaded files in a single subdirectory within `$HOME` (e.g., `$HOME/Downloads`).
3. Verify ISO:

   ```bash
   curl -fsSL https://raw.githubusercontent.com/rajdeepsh/arch-dotfiles/main/install/verify | bash
   ```

4. Flash the ISO into an external drive and boot into the live environment.

## Install Arch

> [!TIP]
> You can identify the `<install-disk>` with `lsblk -p`. E.g., `/dev/nvme0n1`.

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

2. Install Arch:

   ```bash
   curl -fsSL https://raw.githubusercontent.com/rajdeepsh/arch-dotfiles/main/install/install | bash -s -- <install-disk> <password>
   ```

3. Download your `.ssh` zip file and execute the following command:

   ```bash
   unzip Downloads/<file-name>.zip -d ~ && rm -rf Downloads/<file-name>.zip
   ```

4. Set everything else up:

   ```bash
   curl -fsSL https://raw.githubusercontent.com/rajdeepsh/arch-dotfiles/main/install/user-install | bash
   ```
