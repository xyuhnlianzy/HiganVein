#!/usr/bin/env bash
# ==============================================================================
# HIGANVEIN OS — VOID LINUX LIVE ISO BUILDER
# ==============================================================================
set -e

BUILD_ROOT="/home/yahn/void-builder"
MKLIVE_DIR="$BUILD_ROOT/void-mklive"
XBPS_DIR="$BUILD_ROOT/xbps-tools/usr/bin"
PROFILE_DIR="/home/yahn/HiganveinOS/profiles/void-core"
OUT_DIR="/home/yahn/HiganveinOS/profiles/void-core/out"

export PATH="$XBPS_DIR:$PATH"

mkdir -p "$OUT_DIR"

echo "=== [1/3] Validating XBPS and mklive toolchain ==="
which xbps-install
which xbps-query

# Flatten package list
PKGS=$(grep -v '^#' "$PROFILE_DIR/packages.list" | grep -v '^$' | tr '\n' ' ')

echo "=== [2/3] Assembling Sovereign HiganveinOS packages ==="
echo "Target packages: $PKGS"

echo "=== [3/3] Building Live ISO via mklive.sh ==="
cd "$MKLIVE_DIR"
sudo env PATH="$PATH" ./mklive.sh \
    -a x86_64 \
    -p "$PKGS" \
    -S "seatd dbus NetworkManager" \
    -T "HiganveinOS Sovereign Linux (Void Base)" \
    -I "$PROFILE_DIR/include" \
    -o "$OUT_DIR/higanveinos-void-2026.10-x86_64.iso"

echo "=== BUILD COMPLETED ==="
ls -lh "$OUT_DIR"/*.iso
