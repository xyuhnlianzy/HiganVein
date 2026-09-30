#!/usr/bin/env bash
# HiganveinOS Automated Builder (OpenRC GUI Lightweight Edition)
set -e

PROFILE="openrc-gui"
WORK_DIR="/home/yahn/HiganveinOS/profiles/$PROFILE/work-$PROFILE"
OUT_DIR="/home/yahn/HiganveinOS/profiles/$PROFILE/out"
CACHE_DIR="/home/yahn/HiganveinOS/.cache/openrc-gui-pacman"

echo "=== [1/2] Removing previous work and dedicated build cache ==="
rm -rf "$WORK_DIR" "$OUT_DIR" "$CACHE_DIR"
mkdir -p "$OUT_DIR" "$CACHE_DIR"

# ponytail: Dedicated cache isolates ISO builds from host-cache corruption.
# Upgrade path: cache verified artifacts only after repeatable builds.
rm -f /var/cache/pacman/pkg/*.part

# Refresh database with up-to-date checksums
pacman -Syy --noconfirm

echo "=== [2/2] Running mkarchiso for $PROFILE ==="
cd "/home/yahn/HiganveinOS/profiles/$PROFILE"
mkarchiso -v -w "$WORK_DIR" -o "$OUT_DIR" .

echo "=== BUILD FINISHED ==="
ls -lh "$OUT_DIR"/*.iso
