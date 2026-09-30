# HiganveinOS Core CLI Fish Greeting & Setup
function fish_greeting
    if type -q fastfetch
        fastfetch
    end
    # Display installer prompt if in live mode
    if test -f /run/archiso/bootmnt/arch/boot/x86_64/vmlinuz-linux-cachyos -o -d /run/archiso
        echo -e "\e[1;31m[HiganveinOS Core CLI Live]\e[0m Type \e[1;32msudo higan-core-installer\e[0m to install to disk.\n"
    end
end

# Default aliases
alias ll='ls -la'
alias la='ls -A'
alias l='ls -CF'
alias cls='clear'
alias update='sudo pacman -Syu'
alias install-core='sudo higan-core-installer'
