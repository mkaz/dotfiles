# mkaz bash init
# vim: syntax=sh ts=4 sw=4 sts=4 sr et
SYS=$(uname -s | awk '{print tolower($0)}')
export EDITOR='nvim'
#export GPG_TTY=$(tty)
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

# Configure FZF to use fd
export FZF_DEFAULT_COMMAND='fd'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
bind -x '"\C-p": nvim $(fzf);'


# run host system specific profile
if [[ -e ~/dotfiles/profile.$SYS ]]; then
    source ~/dotfiles/profile.$SYS
fi

. "$HOME/.cargo/env"
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
