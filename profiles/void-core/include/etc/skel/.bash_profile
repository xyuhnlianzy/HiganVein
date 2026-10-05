#
# ~/.bash_profile for Void live environment
#

if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# Void non-systemd seatd backend config
export LIBSEAT_BACKEND=seatd
export XDG_RUNTIME_DIR="/run/user/$(id -u)"
if [ ! -d "$XDG_RUNTIME_DIR" ]; then
    mkdir -p "$XDG_RUNTIME_DIR"
    chmod 0700 "$XDG_RUNTIME_DIR"
fi

# Auto-launch Higanvein Sovereign Compositor on tty1
if [ "$(tty)" = "/dev/tty1" ] && [ -z "$WAYLAND_DISPLAY" ]; then
    exec /usr/local/bin/higan-compositor
fi
