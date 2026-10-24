/*
 * HiganveinOS Native Rust CLI Installer
 * - Full Disk Wipe (Clean Replacement of Windows / macOS)
 * - Alongside Multi-Boot (Dual / Triple / Quad-Boot with Windows & macOS preservation)
 * - Native SystemD + CachyOS LTS Kernel + GRUB with os-prober
 * - Zero heavy runtime dependencies, instant execution, low RAM
 */

use std::fs;
use std::io::{self, Write};
use std::path::Path;
use std::process::{exit, Command};
use std::thread::sleep;
use std::time::Duration;

const CRIMSON: &str = "\x1b[38;2;225;29;72m";
const CYAN: &str    = "\x1b[38;2;6;182;212m";
const EMERALD: &str = "\x1b[38;2;16;185;129m";
const YELLOW: &str  = "\x1b[38;2;234;179;8m";
const DIM: &str     = "\x1b[38;2;100;116;139m";
const BOLD: &str    = "\x1b[1m";
const RESET: &str   = "\x1b[0m";

extern "C" {
    fn geteuid() -> u32;
}

fn banner() {
    println!("{CRIMSON}{BOLD}
      O       /\\       O
      |      /  \\      |
      | *o* /    \\ *o* |
      | /* /      \\ *\\ |
  *o* |/  /  //\\\\  \\  \\| *o*
   *\\ |  /  //  \\\\  \\  | /*
     \\| /  //    \\\\  \\ |/
      |/__//      \\\\__\\|
{RESET}{BOLD}   HIGANVEIN FLAGSHIP INSTALLER (RUST NATIVE CLI){RESET}
{DIM}   SystemD · CachyOS BORE LTS · Multi-Boot Architecture{RESET}
");
}

fn sh(cmd: &str) -> bool {
    Command::new("sh")
        .arg("-c")
        .arg(cmd)
        .status()
        .map(|s| s.success())
        .unwrap_or(false)
}

fn sh_output(cmd: &str) -> String {
    Command::new("sh")
        .arg("-c")
        .arg(cmd)
        .output()
        .map(|o| String::from_utf8_lossy(&o.stdout).trim().to_string())
        .unwrap_or_default()
}

struct Disk {
    dev: String,
    size: String,
    model: String,
}

fn list_disks() -> Vec<Disk> {
    let out = sh_output("lsblk -d -n -o NAME,SIZE,MODEL,TYPE");
    let mut disks = Vec::new();

    for line in out.lines() {
        let parts: Vec<&str> = line.split_whitespace().collect();
        if parts.len() >= 2 && parts.last() == Some(&"disk") {
            let name = parts[0];
            if name.starts_with("loop") || name.starts_with("sr") || name.starts_with("airootfs") || name.starts_with("nbd") || name.starts_with("zram") {
                continue;
            }
            let size = parts[1].to_string();
            let model = if parts.len() > 3 {
                parts[2..parts.len() - 1].join(" ")
            } else {
                "Generic Drive".to_string()
            };
            disks.push(Disk {
                dev: format!("/dev/{name}"),
                size,
                model,
            });
        }
    }
    disks
}

fn find_existing_esp(disk: &str) -> Option<String> {
    let out = sh_output(&format!("lsblk -n -l -o NAME,FSTYPE,PARTTYPE,PARTTYPENAME {disk} 2>/dev/null"));
    for line in out.lines() {
        let parts: Vec<&str> = line.split_whitespace().collect();
        if parts.is_empty() { continue; }
        let part_name = parts[0];
        let line_lower = line.to_lowercase();
        if line_lower.contains("vfat") || line_lower.contains("fat32") || line_lower.contains("efi") || line_lower.contains("c12a7328-f81f-11d2-ba4b-00a0c93ec93b") {
            return Some(format!("/dev/{part_name}"));
        }
    }
    None
}

fn prompt(msg: &str, default_val: &str) -> String {
    print!("{msg} [{default_val}]: ");
    let _ = io::stdout().flush();
    let mut buf = String::new();
    let _ = io::stdin().read_line(&mut buf);
    let trimmed = buf.trim();
    if trimmed.is_empty() {
        default_val.to_string()
    } else {
        trimmed.to_string()
    }
}

fn install_system(target_disk: &str, is_alongside: bool, fs_type: &str, username: &str, userpass: &str, hostname: &str) {
    let sep = if target_disk.chars().last().map_or(false, |c| c.is_ascii_digit()) { "p" } else { "" };
    let mut p_esp = String::new();
    let mut p_root = String::new();

    if is_alongside {
        println!("\n{CYAN}:: [Mode: Alongside / Multi-Boot]{RESET} Preserving existing Windows, macOS, and Linux partitions.");
        let existing_esp = find_existing_esp(target_disk);
        if let Some(esp) = existing_esp {
            println!("{EMERALD}:: Found existing EFI System Partition: {esp} (Will preserve Windows/Mac bootloader){RESET}");
            p_esp = esp;
        }

        // Find available partition or free space
        println!("{CYAN}:: Enter target ROOT partition to install HiganveinOS (e.g. {target_disk}{sep}4):{RESET} ");
        print!(":: Partition path: ");
        let _ = io::stdout().flush();
        let mut part_input = String::new();
        let _ = io::stdin().read_line(&mut part_input);
        p_root = part_input.trim().to_string();

        if p_root.is_empty() || !Path::new(&p_root).exists() {
            eprintln!("{CRIMSON}[!] Error: Invalid or non-existent partition path: '{p_root}'{RESET}");
            return;
        }

        if p_esp.is_empty() {
            println!("{CYAN}:: Enter EFI System Partition path (e.g. {target_disk}{sep}1):{RESET} ");
            print!(":: ESP path: ");
            let _ = io::stdout().flush();
            let mut esp_input = String::new();
            let _ = io::stdin().read_line(&mut esp_input);
            p_esp = esp_input.trim().to_string();
        }
    } else {
        println!("\n{CRIMSON}{BOLD}:: WARNING: ERASE DISK MODE!{RESET}");
        println!(":: This will PERMANENTLY ERASE all partitions on {BOLD}{target_disk}{RESET}!");
        print!("{CYAN}:: Type 'YES' in all capitals to wipe and install: {RESET}");
        let _ = io::stdout().flush();

        let mut confirm = String::new();
        let _ = io::stdin().read_line(&mut confirm);
        if confirm.trim() != "YES" {
            println!("{DIM}:: Operation cancelled.{RESET}");
            return;
        }

        println!("\n{EMERALD}:: [1/5] Wiping signatures & creating GPT partitions on {target_disk}...{RESET}");
        sh(&format!("wipefs -af {target_disk}"));
        sh(&format!("sgdisk --zap-all {target_disk}"));
        sh(&format!("parted -s {target_disk} mklabel gpt"));
        sh(&format!("parted -s {target_disk} mkpart bios_boot 1MiB 5MiB"));
        sh(&format!("parted -s {target_disk} set 1 bios_grub on"));
        sh(&format!("parted -s {target_disk} mkpart ESP fat32 5MiB 517MiB"));
        sh(&format!("parted -s {target_disk} set 2 esp on"));
        sh(&format!("parted -s {target_disk} mkpart primary {fs_type} 517MiB 100%"));
        sleep(Duration::from_secs(2));
        sh(&format!("partprobe {target_disk}"));
        sleep(Duration::from_secs(1));

        p_esp = format!("{target_disk}{sep}2");
        p_root = format!("{target_disk}{sep}3");

        println!("{EMERALD}:: Formatting EFI Partition {p_esp} (FAT32)...{RESET}");
        sh(&format!("mkfs.vfat -F32 {p_esp}"));
    }

    println!("{EMERALD}:: Formatting Root Partition {p_root} as {fs_type}...{RESET}");
    sh(&format!("umount -l {p_root} 2>/dev/null || true"));
    if fs_type == "btrfs" {
        sh(&format!("mkfs.btrfs -f -L HIGAN_ROOT {p_root}"));
    } else {
        sh(&format!("mkfs.ext4 -F -L HIGAN_ROOT {p_root}"));
    }

    println!("{EMERALD}:: [2/5] Mounting filesystem structure to /mnt/target...{RESET}");
    let _ = fs::create_dir_all("/mnt/target");
    sh(&format!("mount {p_root} /mnt/target"));
    let _ = fs::create_dir_all("/mnt/target/boot/efi");
    if !p_esp.is_empty() {
        sh(&format!("mount {p_esp} /mnt/target/boot/efi"));
    }

    println!("{EMERALD}:: [3/5] Deploying HiganveinOS RootFS...{RESET}");
    let mut sfs_mount = "/run/archiso/airootfs";
    if !Path::new(sfs_mount).join("usr").exists() {
        sfs_mount = "/run/archiso/bootmnt/arch/x86_64/airootfs";
    }
    if !Path::new(sfs_mount).join("usr").exists() {
        sfs_mount = "/";
    }

    println!("{DIM}:: Syncing system files from {sfs_mount}...{RESET}");
    if sfs_mount == "/" {
        sh("rsync -aAX --exclude=/mnt --exclude=/proc --exclude=/sys --exclude=/dev --exclude=/run --exclude=/tmp / /mnt/target/");
    } else {
        sh(&format!("cp -a {sfs_mount}/. /mnt/target/ 2>/dev/null || true"));
    }

    for d in &["proc", "sys", "dev", "run", "tmp", "mnt", "root"] {
        let _ = fs::create_dir_all(format!("/mnt/target/{d}"));
    }
    sh("chmod 1777 /mnt/target/tmp");

    println!("{EMERALD}:: [4/5] Configuring Users, Hostname & Services...{RESET}");
    let _ = fs::write("/mnt/target/etc/hostname", format!("{hostname}\n"));

    let uuid_root = sh_output(&format!("blkid -s UUID -o value {p_root}"));
    let uuid_esp = if !p_esp.is_empty() {
        sh_output(&format!("blkid -s UUID -o value {p_esp}"))
    } else {
        String::new()
    };

    let mut fstab = format!("UUID={uuid_root} / {fs_type} rw,relatime 0 1\n");
    if !uuid_esp.is_empty() {
        fstab.push_str(&format!("UUID={uuid_esp} /boot/efi vfat rw,relatime,fmask=0022,dmask=0022 0 2\n"));
    }
    let _ = fs::write("/mnt/target/etc/fstab", fstab);

    // Bind mounts for chroot
    for fs_type in &["/dev", "/proc", "/sys"] {
        sh(&format!("mount --bind {fs_type} /mnt/target{fs_type}"));
    }

    // User Setup
    sh(&format!("arch-chroot /mnt/target useradd -m -G wheel,audio,video,storage,input -s /bin/bash {username} 2>/dev/null || true"));
    sh(&format!("echo '{username}:{userpass}' | arch-chroot /mnt/target chpasswd"));
    sh(&format!("echo 'root:{userpass}' | arch-chroot /mnt/target chpasswd"));

    // Enable Daemons in target system
    sh("arch-chroot /mnt/target systemctl enable NetworkManager.service 2>/dev/null || true");
    sh("arch-chroot /mnt/target systemctl enable systemd-resolved.service 2>/dev/null || true");
    sh("arch-chroot /mnt/target systemctl enable sddm.service 2>/dev/null || true");
    sh("arch-chroot /mnt/target systemctl enable bluetooth.service 2>/dev/null || true");

    println!("{EMERALD}:: [5/5] Installing Multi-Boot Bootloader (GRUB + os-prober)...{RESET}");
    let grub_default = "/mnt/target/etc/default/grub";
    if Path::new(grub_default).exists() {
        if let Ok(content) = fs::read_to_string(grub_default) {
            let mut patched = content.replace("GRUB_DISABLE_OS_PROBER=true", "GRUB_DISABLE_OS_PROBER=false");
            if !patched.contains("GRUB_DISABLE_OS_PROBER=false") {
                patched.push_str("\nGRUB_DISABLE_OS_PROBER=false\n");
            }
            let _ = fs::write(grub_default, patched);
        }
    }

    // Install BIOS MBR
    sh(&format!("arch-chroot /mnt/target grub-install --target=i386-pc --recheck {target_disk} 2>/dev/null || true"));

    // Install UEFI ESP if available
    if !p_esp.is_empty() {
        sh("arch-chroot /mnt/target grub-install --target=x86_64-efi --efi-directory=/boot/efi --boot-directory=/boot --bootloader-id=HiganveinOS --recheck 2>/dev/null || true");
    }

    println!("{CYAN}:: Probing for other Operating Systems (Windows / macOS / Linux)...{RESET}");
    sh("arch-chroot /mnt/target grub-mkconfig -o /boot/grub/grub.cfg");

    sh("sync");
    sh("umount -R /mnt/target 2>/dev/null || true");

    println!("\n{EMERALD}{BOLD}:: [SUCCESS] HiganveinOS Flagship Installation Complete!{RESET}");
    println!("{CYAN}:: Drive        : {BOLD}{target_disk}{RESET} (Root: {p_root})");
    println!("{CYAN}:: Multi-Boot   : {BOLD}{}{RESET}", if is_alongside { "Active (Windows & macOS Preserved)" } else { "Full Disk Clean Install" });
    println!("{CYAN}:: User Account : {BOLD}{username}{RESET}");
    println!("{CYAN}:: You may now reboot your computer ({BOLD}sudo reboot{RESET}).\n");
}

fn main() {
    unsafe {
        if geteuid() != 0 {
            eprintln!("{CRIMSON}[!] Error:{RESET} Root privilege required. Run with {BOLD}sudo higan-installer --cli{RESET}");
            exit(1);
        }
    }

    banner();

    let disks = list_disks();
    if disks.is_empty() {
        eprintln!("{CRIMSON}[!] No suitable target disks found!{RESET}");
        exit(1);
    }

    println!("{BOLD}SELECT TARGET INSTALLATION DISK:{RESET}");
    for (idx, d) in disks.iter().enumerate() {
        println!("  {CYAN}[{}]{RESET} {BOLD}{}{RESET} ({}) - {}", idx + 1, d.dev, d.size, d.model);
    }

    let d_choice = prompt("\n:: Select disk number", "1");
    let d_idx = d_choice.parse::<usize>().unwrap_or(1).saturating_sub(1);
    let target_disk = if d_idx < disks.len() { &disks[d_idx].dev } else { &disks[0].dev };

    println!("\n{BOLD}CHOOSE INSTALLATION SCENARIO:{RESET}");
    println!("  {CYAN}[1]{RESET} {BOLD}Install Alongside (Dual / Triple / Multi-Boot){RESET}");
    println!("      {DIM}Safe mode: Preserves existing Windows, macOS, or other Linux partitions.{RESET}");
    println!("  {CYAN}[2]{RESET} {BOLD}Erase Entire Disk (Full OS Replacement){RESET}");
    println!("      {DIM}Wipes all partitions on target disk, cleans BitLocker/APFS signatures.{RESET}\n");

    let m_choice = prompt(":: Select scenario [1/2]", "1");
    let is_alongside = m_choice != "2";

    println!("\n{BOLD}FILESYSTEM TYPE:{RESET}");
    println!("  {CYAN}[1]{RESET} Ext4 (Fast, classic stability)");
    println!("  {CYAN}[2]{RESET} Btrfs (Advanced subvolumes & snapshots)");
    let fs_choice = prompt(":: Select filesystem [1/2]", "1");
    let fs_type = if fs_choice == "2" { "btrfs" } else { "ext4" };

    println!("\n{BOLD}USER & SYSTEM CONFIGURATION:{RESET}");
    let username = prompt(":: Enter primary username", "higan");
    let userpass = prompt(":: Enter password", "higan");
    let hostname = prompt(":: Enter system hostname", "higanvein");

    install_system(target_disk, is_alongside, fs_type, &username, &userpass, &hostname);
}
