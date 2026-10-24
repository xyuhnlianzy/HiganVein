#!/usr/bin/env bash
# HiganveinOS Flagship Arch SystemD ISO Builder
# Storage Protection: Workdir and Output strictly enforced on HDD mount (/home/yahn/storage/builds)
set -e

WORK_DIR="/home/yahn/storage/builds/archiso-work"
OUT_DIR="/home/yahn/storage/builds/archiso-out"

if [ "$EUID" -ne 0 ]; then
    echo "[!] Error: Root privileges required. Run with: sudo ./build_flagship_iso.sh"
    exit 1
fi

echo "=== [1/3] Preparing build environment on HDD storage ==="
mkdir -p "$WORK_DIR" "$OUT_DIR"
rm -rf "$WORK_DIR"
mkdir -p "$WORK_DIR"

echo "=== [2/3] Building HiganveinOS Flagship ISO (mkarchiso) ==="
cd /home/yahn/HiganveinOS
mkarchiso -v -w "$WORK_DIR" -o "$OUT_DIR" .

echo "=== [3/3] Build Finished Successfully ==="
ls -lh "$OUT_DIR"/*.iso
echo "ISO generated at: $OUT_DIR"
