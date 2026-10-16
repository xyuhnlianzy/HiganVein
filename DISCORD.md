# 🌌 HiganveinOS Discord Community Structure

## 📌 Roles
- **[👑] Overlord / Creator**: Yu Dyan
- **[⚡] Core Developer**: Contributor koding installer, hein, & kernel
- **[🧪] Beta Tester**: Tester ISO QEMU/VirtualBox/Real machine
- **[🌸] Higan Citizen**: Member umum

---

## 📁 Channels Layout

### 1. 🌌 WELCOME & INFO
- `#rules` : Aturan server & kode etik
- `#announcements` : Update release ISO & changelog (`changes.html`)
- `#roadmap` : Status Phase 1 - Phase 4 HiganveinOS
- `#downloads` : Link download ISO terbaru

### 2. 💬 COMMUNITY
- `#general` : Ngobrol santai seputar Linux, Void, CachyOS, & tech
- `#ricing-showcase` : Pamer screenshot Labwc / Higanvein-Shell / Ptyxis / Tech-Noir Crimson
- `#off-topic` : Diskusi anime, game, dll

### 3. 🛠️ DEVELOPMENT
- `#dev-chat` : Diskusi source code, Rust (`hein`, `higan-installer`), & initramfs
- `#iso-testing` : Laporan hasil test QEMU / real hardware (AMD RX, NVIDIA GTX/RTX, Intel Arc)
- `#bug-reports` : Laporan error, KMS fallback, atau bootloop

---

## 📢 Announcement Post Template (`#announcements`)

```markdown
@everyone **🌌 HIGANVEIN OS — SOVEREIGN DUAL-EDITION & RUST OVERHAUL RELEASE (2026.10.16)**

Pembaruan besar untuk HiganveinOS telah dirilis! Sekarang HiganveinOS resmi hadir dalam **dua varian sovereign** yang disatukan oleh estetika Spider Lily Crimson (`#0b070f` / `#e11d48`) dan arsitektur anti-telemetri total.

---

### 🚀 Apa yang Baru?

1. ⚡ **Sovereign Void Linux Base (Non-SystemD)**
   - Menggunakan pure Runit init (Stage 1/2/3) dengan kernel **Linux 6.6 LTS**.
   - Custom ash micro-initramfs (3.4 MB) dan zero-bloat daemon.
   - Idle memory footprint luar biasa ramping: **~180 MiB RAM**.
   - Ukuran ISO hanya **800 MB** (terkompresi Zstandard)!

2. 💿 **Unified Dual-Mode ISO (Satu ISO untuk Semua Kebutuhan)**
   - Tidak ada lagi ISO terpisah antara GUI dan CLI!
   - Langsung pilih di menu bootloader (GRUB/Syslinux):
     • `HiganveinOS (GUI Desktop)` — Default Wayland Labwc / Higanvein-Shell
     • `HiganveinOS (CLI Console)` — Pure headless terminal untuk server & potato PC.

3. 🦀 **Installer 100% Native Rust (`higan-installer`)**
   - Menggantikan script Python lawas; ukuran binary cuma 419 KB dengan konsumsi RAM <2 MB.
   - Auto-partitioning disk pintar: NVMe (`nvme0n1p3`), eMMC, SATA, VirtIO, dan hybrid UEFI/BIOS bootloader generation.

4. 🎮 **Full GPU Driver & Firmware Microcode Plug-and-Play**
   - Microcode resmi disuntikkan: AMD Radeon RX (RDNA 1–4, Vega, Polaris), NVIDIA GeForce GTX/RTX (Maxwell s/d Blackwell via Nouveau/NVK), dan Intel Arc/Xe (GuC/HuC).
   - Akselerasi hardware VA-API dan Vulkan aktif out-of-the-box.

5. 🖥️ **HiganTerm & Tech-Noir Wayland Suite**
   - Terminal resmi berganti ke **HiganTerm** (GNOME Ptyxis) dengan Spider Lily Crimson palette.
   - Ditambahkan `higan-lock` (Wayland ext-session-lock-v1 via `Super + L`).
   - Ditambahkan `higan-shot` (screenshot region & full via `Print` / `Super + Shift + S`).
   - Integrasi file manager Thunar (`Super + E`) dan Fn-keys hardware brightness/volume.

6. 📦 **Universal `higan-bundle`**
   - Satu perintah `sudo higan-bundle` untuk memasang profile Gamer, Dev, Ricer, Cyber, atau AI Agent di kedua distro (Void/XBPS & Arch/Pacman).

---

🔗 **Download & Changelog:**
- Website & Changelog: https://higanveinos.org/changes.html
- Mirrors: SourceForge Global CDN
- Source Code: https://github.com/xyuhnlianzy/HiganVein
```
