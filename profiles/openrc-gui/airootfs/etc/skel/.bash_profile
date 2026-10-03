#
# ~/.bash_profile
#

if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

# Auto-launch Higanvein Unified Shell on tty1
if [ "$(tty)" = "/dev/tty1" ] && [ -z "$WAYLAND_DISPLAY" ]; then
    exec /usr/local/bin/higanvein-shell
fi
