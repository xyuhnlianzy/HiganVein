# HiganveinOS Fish Greeting & Setup
function fish_greeting
    if type -q fastfetch
        fastfetch
    end
end

# Fish default keybindings & aliases
alias ll='ls -la'
alias la='ls -A'
alias l='ls -CF'
alias cls='clear'
alias update='sudo pacman -Syu'
