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
   pacman -Sy gum git
   ```

3. Clone this repository:

   ```bash
   git clone https://github.com/rajdeepsh/arch.git
   ```

4. Execute `install.sh`:

   ```bash
   bash install.sh
   ```
