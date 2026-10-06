#
# ~/.bash_profile for Void live environment
#

if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

export PATH="/usr/local/bin:$PATH"

# Ensure user runtime directory
export XDG_RUNTIME_DIR="/run/user/$(id -u)"
if [ ! -d "$XDG_RUNTIME_DIR" ]; then
    mkdir -m 0700 -p "$XDG_RUNTIME_DIR" 2>/dev/null || true
fi

# Void non-systemd seatd backend config
export LIBSEAT_BACKEND=seatd

# Fallback software renderer for virtual environments without hardware 3D
export WLR_RENDERER=pixman
export WLR_NO_HARDWARE_CURSORS=1
export GDK_BACKEND=wayland
export QT_QPA_PLATFORM=wayland

# Auto-launch Higanvein Sovereign Compositor on tty1
if [ "$(tty)" = "/dev/tty1" ] && [ -z "$WAYLAND_DISPLAY" ]; then
    exec /usr/local/bin/higan-compositor
fi
