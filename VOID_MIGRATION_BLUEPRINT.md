# HiganveinOS — Void Transition Blueprint (Phase 1)
**Architect**: D-P & Reznou  
**Target Base**: Void Linux (`xbps` + `runit`)  
**Target UI**: Higanvein Unified Shell (`higan-compositor` / C wlroots)  
**Target Browser**: Lycoris Browser (`lycoris-bin`)  
**Target RAM**: < 50 MiB Idle

---

## 1. Toolchain Setup (On Current CachyOS Host)
- Need `xbps` static / native tools to build Void rootfs.
- Need `void-mklive` (Void's official live ISO generator, equivalent to `mkarchiso`).

## 2. Core Components to Port
1. **Kernel**: Linux 6.x + BORE scheduler patch + 1000Hz + ZRAM (ZSTD).
2. **Init**: `runit` core services (`/etc/sv/`).
3. **Session & Power**: `elogind` + `dbus` (without systemd).
4. **Shell/WM**: `/usr/local/bin/higan-compositor` (C wlroots) auto-launched on `tty1`.
5. **Browser**: `lycoris-bin` placed into rootfs with WebKitGTK runtime.
6. **Installer**: Adapt `higan-core-installer` from `pacman/arch-install-scripts` to `xbps-install`.
