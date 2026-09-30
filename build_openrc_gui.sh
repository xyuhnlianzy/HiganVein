#!/usr/bin/env bash
# HiganveinOS Automated Builder (OpenRC GUI Lightweight Edition)
set -e

PROFILE="openrc-gui"
WORK_DIR="/home/yahn/HiganveinOS/profiles/$PROFILE/work-$PROFILE"
OUT_DIR="/home/yahn/HiganveinOS/profiles/$PROFILE/out"
CACHE_DIR="/home/yahn/HiganveinOS/.cache/openrc-gui-pacman"

echo "=== [1/2] Preparing clean workdir and caching valid packages ==="
rm -rf "$WORK_DIR" "$OUT_DIR"
mkdir -p "$OUT_DIR" "$CACHE_DIR"

# Ensure cache directory permissions
chown -R root:root "$CACHE_DIR" 2>/dev/null || true

# Clean broken partial downloads
rm -f "$CACHE_DIR"/*.part

# Copy valid packages from host cache into isolated build cache
echo "Syncing valid host packages into build cache (avoiding slow download)..."
python3 -c "
import glob, shutil, os

src_dir = '/var/cache/pacman/pkg'
dst_dir = '/home/yahn/HiganveinOS/.cache/openrc-gui-pacman'
bad_keywords = ['pipewire', 'wireplumber', 'abseil-cpp', 'spandsp', 'lilv', 'sord', 'serd', 'sbc', 'lua']

count = 0
for f in glob.glob(os.path.join(src_dir, '*.pkg.tar.zst')):
    fname = os.path.basename(f)
    if any(b in fname for b in bad_keywords):
        continue
    target = os.path.join(dst_dir, fname)
    if not os.path.exists(target):
        try:
            shutil.copy2(f, target)
            count += 1
        except Exception:
            pass
print(f'Synced {count} packages locally.')
"

# Refresh database with up-to-date checksums
pacman -Syy --noconfirm

echo "=== [2/2] Running mkarchiso for $PROFILE ==="
cd "/home/yahn/HiganveinOS/profiles/$PROFILE"
mkarchiso -v -w "$WORK_DIR" -o "$OUT_DIR" .

echo "=== BUILD FINISHED ==="
ls -lh "$OUT_DIR"/*.iso
