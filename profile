# mkaz bash init
# vim: syntax=sh ts=4 sw=4 sts=4 sr et

SYS=$(uname -s | awk '{print tolower($0)}')
echo "SYS = ${SYS}"

export EDITOR='nvim'
export GPG_TTY=$(tty)

PATH=".:$HOME/bin:$HOME/.local/bin:$HOME/dotfiles/bin:$PATH"
export PATH

# aliases
alias cat='bat'
alias curl='curl --silent'
alias grep='rg -i'
alias less='bat'
alias ls='exa --time-style long-iso -l -h --group-directories-first'
alias ll='ls -a --git'
alias o='open'
alias rg='rg -i'
alias wget='wget -q'
alias vihosts='sudo nvim /etc/hosts'
alias vim='nvim'
alias subl='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'

# moving around
alias cd..='cd ..'
alias cd...='cd ../../'
alias cd....='cd ../../../'

# shh
export BASH_SILENCE_DEPRECATION_WARNING=1

# Rust
if [[ -e ~/.cargo/env ]]; then
    source ~/.cargo/env
fi

# run host system specific profile
if [[ -e ~/dotfiles/profile.$SYS ]]; then
    source ~/dotfiles/profile.$SYS
fi

# bash completions
for file in /opt/homebrew/etc/profile.d/*
do
    source "$file"
done

# bash completions
for file in /opt/homebrew/etc/bash_completion.d/*
do
    source "$file"
done

# starship
export STARSHIP_CONFIG=~/dotfiles/configs/starship/config.toml
eval "$(/opt/homebrew/bin/starship init bash)"

# homebrew
export HOMEBREW_NO_ENV_HINTS=1
eval "$(/opt/homebrew/bin/brew shellenv)"

. "$HOME/.cargo/env"
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

