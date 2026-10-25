# HiganveinOS — Arch Linux Flagship (SystemD)

An elite, performance-focused sovereign Linux operating system combining the low-latency speed of the **CachyOS BORE LTS Kernel**, the lightweight elegance of **Higanvein Unified Shell (GTK3/Wayland)**, a native **Windows Compatibility Engine (`higan-wine`)**, and a distinct **Tech-Noir Spider Lily** aesthetic.

```
       O       /\       O
       |      /  \      |
       | *o* /    \ *o* |
       | /* /      \ *\ |
   *o* |/  /  //\\  \  \| *o*
    *\ |  /  //  \\  \  | /*
      \| /  //    \\  \ |/
       |/__//      \\__\|
    HIGANVEIN PROTOCOL · ZERO TELEMETRY
```

---

## Key Architectural Highlights

* **Primary Operating Base**: Arch Linux with native SystemD, providing seamless driver compatibility, comprehensive AUR access (`paru`), and out-of-the-box system stability.
* **Kernel & Latency**: `linux-cachyos-lts` featuring the Burst-Oriented Response Enhancer (BORE) scheduler, x86-64-v3 compiler optimizations, and automated ZRAM compressed swap.
* **Modern Bootloader**: First-class **Limine** integration with native resolution rendering (1080p/2K/4K), Tech-Noir Spider Lily canvas, and automatic zero-overhead chainloading for Windows Boot Manager and macOS (OpenCore). GRUB fallback with `os-prober` also provided.
* **Compact Native Windows Engine (`higan-wine`)**: Seamlessly double-click `.exe` and `.msi` installers without heavy runtime bloatware. Pre-configured with ClearType font smoothing, disabled Gecko/Mono popups, GameMode hooks, and a 1-click desktop process termination tool (`higan-kill-wine`).
* **Dual-Engine Installer**:
  * **GUI (`higan-installer`)**: Desktop installation wizard with automatic VM graphics detection (`LIBGL_ALWAYS_SOFTWARE=1`) and silent crash recovery.
  * **CLI (`higan-installer-cli`)**: High-speed, static 419 KB Rust binary for headless servers, potato hardware, and advanced multi-boot setups.
* **Sovereign Void Linux Track**: Preserved under `sovereign-builder/` in status `On Hold` for ongoing non-systemd research.

---

## Upstream Acknowledgments & Credits

HiganveinOS is an independent sovereign operating system built upon open-source software:
- **Arch Linux**: Core rolling release repositories, packaging toolchains, and archiso engine.
- **CachyOS**: Kernel performance patches, BORE CPU scheduler, and compiler flags.
- **Limine Project**: Ultra-fast, modern, clean UEFI and BIOS bootloader.
- **Illia Miroshnichenko ([ilyamiro](https://github.com/ilyamiro))**: Creator of [Serpantinum Shell](https://github.com/ilyamiro/serpantinum).

### Special Thanks
- **Al-Fajri** — Feature ideas: Out-of-the-box native Windows app (.exe) compatibility, custom bootloader artwork, and installer multi-OS partition preservation (Windows, macOS, BSD family, other Linux distros).  
  [![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=flat&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/muhammad-al-fajri-silmi-9a7a643a2/)
  [![Threads](https://img.shields.io/badge/Threads-000000?style=flat&logo=threads&logoColor=white)](https://threads.net/@mhfajri.silmi)
  [![Instagram](https://img.shields.io/badge/Instagram-E4405F?style=flat&logo=instagram&logoColor=white)](https://instagram.com/mhfajri.silmi)
  [![TikTok](https://img.shields.io/badge/TikTok-000000?style=flat&logo=tiktok&logoColor=white)](https://tiktok.com/@mhfajri.silmi)

---

## Official Links

* **Official Website**: [https://higanvein.pages.dev](https://higanvein.pages.dev)
* **ISO Mirrors**: [SourceForge Global CDN](https://sourceforge.net/projects/higanvein/files/)
* **Community Discord**: [Join Server](https://discord.gg/HQANxjyfKx)
* **License**: Distributed under the MIT License. See `LICENSE` for details.
