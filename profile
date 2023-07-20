# mkaz bash init
# vim: syntax=sh ts=4 sw=4 sts=4 sr et
SYS=$(uname -s | awk '{print tolower($0)}')
export EDITOR='nvim'
#export GPG_TTY=$(tty)
PATH=".:$HOME/bin:$HOME/.local/bin:$HOME/dotfiles/bin:$PATH"

alias curl='curl --silent'
alias grep='rg -i'
alias ls='gls --hyperlink=auto -lh --group-directories-first --color'
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
alias cdvim='cd ~/.config/nvim'

# shh
export BASH_SILENCE_DEPRECATION_WARNING=1

# Configure FZF to use fd
export FZF_DEFAULT_COMMAND='fd'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
bind -x '"\C-p": open $(fzf);'
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# run host system specific profile
if [[ -e ~/dotfiles/profile.$SYS ]]; then
    source ~/dotfiles/profile.$SYS
fi

