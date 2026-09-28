#!/usr/bin/env bash
# HiganveinOS Multi-Profile Builder
# Usage: ./build_all_profiles.sh [openrc|runit|dinit|s6]

set -e

PROFILE="${1:-openrc}"
BASE_DIR="/home/yahn/HiganveinOS/profiles/$PROFILE"

if [ ! -d "$BASE_DIR" ]; then
    echo "Error: Profile $PROFILE not found in profiles/!"
    exit 1
fi

WORK_DIR="$BASE_DIR/work-$PROFILE"
OUT_DIR="$BASE_DIR/out"

echo "=== Building HiganveinOS ($PROFILE Edition) ==="
sudo rm -rf "$WORK_DIR" "$OUT_DIR"
mkdir -p "$OUT_DIR"

cd "$BASE_DIR"
sudo mkarchiso -v -w "$WORK_DIR" -o "$OUT_DIR" .

echo "=== $PROFILE BUILD COMPLETE ==="
ls -lh "$OUT_DIR"/*.iso
