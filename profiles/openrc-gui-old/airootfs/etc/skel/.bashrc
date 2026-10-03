# HiganveinOS interactive bash config
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ll='ls -lah --color=auto'

# Fastfetch autostart on interactive shells
if command -v fastfetch &>/dev/null; then
    fastfetch
fi
