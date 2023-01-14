# mkaz bash init
# vim: syntax=sh ts=4 sw=4 sts=4 sr et
SYS=$(uname -s | awk '{print tolower($0)}')
export EDITOR='nvim'
export GPG_TTY=$(tty)
PATH=".:$HOME/bin:$HOME/.local/bin:$HOME/dotfiles/bin:$PATH"

# aliases
function cat() {
    if [ -x "$(command -v bat)" ]; then
        bat --theme TwoDark $@
    elif [ -x "$(command -v batcat)" ]; then
        batcat --theme TwoDark $@
    else
        cat $@
    fi
}

alias curl='curl --silent'
alias grep='rg -i'
alias ls='exa --time-style long-iso -l -h --group-directories-first'
alias ll='ls -a --git'
alias o='open'
alias rg='rg -i'
alias sc='sc-im'
alias wget='wget -q'
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

# run host system specific profile
if [[ -e ~/dotfiles/profile.$SYS ]]; then
    source ~/dotfiles/profile.$SYS
fi

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
. "$HOME/.cargo/env"
