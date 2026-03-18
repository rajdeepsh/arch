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

4. Flash Arch ISO into an external drive and boot into the live environment.

## Install Arch
