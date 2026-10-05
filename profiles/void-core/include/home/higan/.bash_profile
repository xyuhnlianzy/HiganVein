#
# ~/.bash_profile for Void live environment
#

if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# Auto-launch Higanvein Sovereign Compositor on tty1
if [ "$(tty)" = "/dev/tty1" ] && [ -z "$WAYLAND_DISPLAY" ]; then
    exec /usr/local/bin/higan-compositor
fi
