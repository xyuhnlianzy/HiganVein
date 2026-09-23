# Phase 2 Architecture: HiganveinOS Core (CLI Edition)
Status: Planned / Staged
Target Size: ~800 MB - 1.1 GB (ZSTD-19)
Base: Arch Linux / CachyOS (BORE Kernel)
Profile Directory: profiles/core-cli (Isolated from main GUI profile)

## 1. Design Principles
- Isolated archiso profile to ensure the flagship GUI profile (`airootfs`) is NEVER touched or overwritten.
- Target hardware floor: 1 Core x86-64, 512 MB RAM, 10 GB disk.
- Pure TTY / CLI environment with Fish shell, Ptyxis fallback, ZRAM 2.5x, and CachyOS BORE optimizations.
- Gateway to test alternative init systems (OpenRC & Runit) in isolation before desktop porting.

## 2. Package Separation Matrix
### Included in Core CLI:
- Kernel: `linux-cachyos`, `linux-cachyos-headers`, `cachyos-settings`
- Bootloaders: `grub`, `efibootmgr`, `limine`, `systemd-boot`
- Filesystem: `btrfs-progs`, `e2fsprogs`, `dosfstools`, `snapper`
- Network: `networkmanager`, `iwd`, `curl`, `wget`, `openssh`
- System Tools: `fish`, `fastfetch`, `htop`, `tmux`, `paru`, `earlyoom`, `zram-generator`
- Text Editors: `neovim`, `nano`

### Excluded (GUI / Desktop):
- Plasma 6, Wayland, SDDM, Qt6 GUI libs, Breeze themes, Audio daemons (Pipewire/Wireplumber GUI frontends), Web browsers.

## 3. Storage & Hugging Face Release Target
- Isolated output path: `out/higanveinos-core-x86_64.iso`
- Hugging Face target: `fryss/Higanvein-ISO` -> `higanveinos-core-x86_64.iso`

## 4. Execution Workflow (Ready for Next Session)
1. `mkdir -p profiles/core-cli`
2. Duplicate base config without GUI packages.
3. Configure CLI installer wizard (`higan-cli-installer`).
4. Build isolated ISO test.
