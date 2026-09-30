# HiganveinOS Fish Greeting & Setup
function fish_greeting
    if type -q fastfetch
        fastfetch
    end

    # Display active Init & Filesystem info
    set -l init_name "unknown"
    if test -f /proc/1/comm
        set init_name (cat /proc/1/comm)
    end
    set -l root_fs (df -T / | awk 'NR==2 {print $2}')
    echo -e "\e[1;30m─────────────────────────────────────────────────────────────────\e[0m"
    echo -e "\e[1;36m[Stack]\e[0m Init Engine: \e[1;32m$init_name\e[0m  ·  Root Filesystem: \e[1;33m$root_fs\e[0m"

    # Display installer prompt if in live mode
    if test -f /run/archiso/bootmnt/arch/boot/x86_64/vmlinuz-linux-cachyos -o -d /run/archiso
        echo -e "\e[1;31m[HiganveinOS Live Session]\e[0m Launch \e[1;32mhigan-installer\e[0m from desktop or terminal to install.\n"
    end
end

# Default aliases
alias ll='ls -la'
alias la='ls -A'
alias l='ls -CF'
alias cls='clear'
alias update='sudo pacman -Syu'
alias install-os='sudo higan-installer-launcher'
alias install-core='sudo higan-core-installer'
