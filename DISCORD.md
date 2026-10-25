# 🌌 HiganveinOS Discord Community Structure

## 📌 Roles
- **[👑] Overlord / Creator**: Yu Dyan
- **[⚡] Core Developer**: Contributor koding installer, engine, & kernel
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
- `#general` : Ngobrol santai seputar Linux, CachyOS, Limine, & gaming
- `#ricing-showcase` : Pamer screenshot Higanvein-Shell / Ptyxis / Tech-Noir Crimson
- `#off-topic` : Diskusi anime, game, dll

### 3. 🛠️ DEVELOPMENT
- `#dev-chat` : Diskusi source code, Rust (`higan-installer-cli`), & kernel tuning
- `#iso-testing` : Laporan hasil test VirtualBox / QEMU / real hardware (AMD RX, NVIDIA, Intel Arc)
- `#bug-reports` : Laporan error, KMS fallback, atau bootloop

---

## 📢 Announcement Post Template (`#announcements`)

```markdown
@everyone **🌌 HIGANVEIN OS — ARCH SYSTEMD FLAGSHIP & LIMINE UPGRADE RELEASE (2026.10.24)**

Pembaruan arsitektur besar untuk HiganveinOS! Fokus pengembangan kini terkonsolidasi penuh pada **Arch Linux (SystemD) Flagship Tier** dengan performa maksimal, bootloader Limine modern, dan engine eksekusi aplikasi Windows native.

---

### 🚀 Apa yang Baru?

1. ⚡ **Konsolidasi Arch Linux (SystemD) Flagship**
   - Menggunakan basis Arch rolling release dengan kernel **Linux CachyOS BORE LTS**.
   - Stabil, anti-ribet, dengan integrasi driver GPU (NVIDIA, AMD, Intel) dan audio PipeWire sempurna.
   - Jalur Void Linux (Runit) disetel ke status **On Hold** di `sovereign-builder/` untuk fokus total pada kestabilan Flagship.

2. 🪟 **Compact Native Windows Engine (`higan-wine`)**
   - Double-click file `.exe` dan `.msi` Windows langsung jalan tanpa popup installer Gecko/Mono yang mengganggu!
   - Dilengkapi font smoothing (ClearType subpixel rendering) dan integrasi GameMode otomatis.
   - Ditambahkan tombol darurat **`⚡ Terminate Windows Apps`** di desktop menu untuk membersihkan proses Wine yang macet dalam 1 klik.

3. 🔮 **Limine Bootloader Tech-Noir (Default & Recommended)**
   - Bootloader modern super cepat (< 0.2 detik) dengan resolusi native monitor (1080p/2K/4K).
   - Tampilan custom Tech-Noir Spider Lily (`#0b070f`, crimson `#e11d48`, watermark resmi).
   - **Multi-Boot Auto-Detect**: Otomatis mendeteksi Windows 10/11 (`bootmgfw.efi`) dan macOS OpenCore (`OpenCore.efi`) tanpa merusak partisi ESP.
   - Pilihan GRUB dengan `os-prober` tetap disediakan untuk fleksibilitas.

4. 🛡️ **Dual-Engine Installer Anti-Crash (VM & Multi-Boot)**
   - **GUI Launcher (`higan-installer-launcher`)**: Dilengkapi deteksi otomatis VirtualBox/VMware dengan safe software rendering (`LIBGL_ALWAYS_SOFTWARE=1`) dan terminal fallback otomatis jika display server bermasalah.
   - **CLI Engine (`higan-installer-cli`)**: Binary Rust static 419 KB super cepat dengan wizard ramah pemula untuk Full Disk Wipe maupun Dual/Triple/Quad-Boot berdampingan dengan Windows/macOS.

5. 🪶 **Pemangkasan Bobot ISO (Dari 2.8 GB ke ~1.3 GB)**
   - Membuang bloatware paket yang tidak perlu (Firefox digantikan browser native Lycoris Browser).
   - RAM idle live ISO terpangkas menjadi hanya **~220–250 MiB RAM**.

---

🔗 **Download & Changelog:**
- Website & Changelog: https://higanvein.pages.dev/changes.html
- Mirrors: SourceForge Global CDN
- Source Code: https://github.com/xyuhnlianzy/HiganVein
```
