# arch

## Download, Verify, and Flash Arch ISO

1. [Download](https://archlinux.org/download/) the Arch (1) \*.iso, (2) \*.sig, (3) sha256sums.txt, and (4) b2sums.txt files.
2. Place the downloaded files in a single subdirectory within `$HOME` (e.g., `$HOME/Downloads`).
3. Execute `verify.sh`:
   > [!WARNING]
   > Ensure **"OK"** for both sha256sum and b2sum verification and **"Good signature from Pierre Schmitz &lt;pierre@archlinux.org&gt; [ultimate]"** for gpg verification.
   ```bash
   bash verify.sh
   ```
4. Flash Arch ISO into an external drive and boot into the live environment.

## Install Arch
