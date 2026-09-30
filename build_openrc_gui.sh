#!/usr/bin/env bash
# HiganveinOS Automated Builder (OpenRC GUI Lightweight Edition)
set -e

PROFILE="openrc-gui"
WORK_DIR="/home/yahn/HiganveinOS/profiles/$PROFILE/work-$PROFILE"
OUT_DIR="/home/yahn/HiganveinOS/profiles/$PROFILE/out"

echo "=== [1/2] Preparing output and cleaning cache ==="
rm -rf "$WORK_DIR" "$OUT_DIR"
mkdir -p "$OUT_DIR"
rm -f /var/cache/pacman/pkg/*.part
pacman -Syy --noconfirm

echo "=== [2/2] Running mkarchiso for $PROFILE ==="
cd "/home/yahn/HiganveinOS/profiles/$PROFILE"
mkarchiso -v -w "$WORK_DIR" -o "$OUT_DIR" .

echo "=== BUILD FINISHED ==="
ls -lh "$OUT_DIR"/*.iso
