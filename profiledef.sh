iso_name="higanveinos"
iso_label="HIGANVEINOS_$(date +%Y%m)"
iso_version="$(date +%Y.%m.%d)"
install_dir="arch"
buildmodes=('iso')
bootmodes=('bios.syslinux' 'uefi.grub')
arch="x86_64"
pacman_conf="pacman.conf"
airootfs_image_type="squashfs"
airootfs_image_tool_options=('-comp' 'zstd' '-Xcompression-level' '3')
file_permissions=(
  ["/etc/shadow"]="0:0:400"
)
