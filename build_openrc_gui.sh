#!/usr/bin/env bash
# HiganveinOS Automated Builder (OpenRC GUI Lightweight Edition)
set -e

PROFILE="openrc-gui"
WORK_DIR="/home/yahn/HiganveinOS/profiles/$PROFILE/work-$PROFILE"
OUT_DIR="/home/yahn/HiganveinOS/profiles/$PROFILE/out"

echo "=== [1/2] Purging corrupted package cache & previous workdir ==="
rm -rf "$WORK_DIR" "$OUT_DIR"
mkdir -p "$OUT_DIR"

# Purge incomplete / corrupted packages
rm -f /var/cache/pacman/pkg/*.part
rm -f /var/cache/pacman/pkg/{serd,zix,sord,lv2,sratom,lilv,sbc,spandsp,abseil-cpp,webrtc-audio-processing-1,pipewire-audio,libwireplumber,lua,wireplumber,pipewire-pulse}* 2>/dev/null || true

# Refresh database with up-to-date checksums
pacman -Syy --noconfirm

echo "=== [2/2] Running mkarchiso for $PROFILE ==="
cd "/home/yahn/HiganveinOS/profiles/$PROFILE"
mkarchiso -v -w "$WORK_DIR" -o "$OUT_DIR" .

echo "=== BUILD FINISHED ==="
ls -lh "$OUT_DIR"/*.iso
