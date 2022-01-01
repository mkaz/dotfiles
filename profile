# mkaz bash init
# vim: syntax=sh ts=4 sw=4 sts=4 sr et


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
alias rg='rg -i'
alias wget='wget -q'
alias vihosts='sudo nvim /etc/hosts'
alias vim='nvim'

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

# run host specific profile
if [[ -e ~/dotfiles/profile.$HOSTNAME ]]; then
    source ~/dotfiles/profile.$HOSTNAME
fi

# starship
export STARSHIP_CONFIG=~/dotfiles/configs/starship/config.toml
eval "$(/opt/homebrew/bin/starship init bash)"

# homebrew
export HOMEBREW_NO_ENV_HINTS=1
eval "$(/opt/homebrew/bin/brew shellenv)"
