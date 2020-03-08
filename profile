# mkaz bash init
# vim: syntax=sh ts=4 sw=4 sts=4 sr et

HOSTNAME=`hostname -s`

export TZ='America/Los_Angeles'
export TERM='xterm-256color'
export HISTFILE="$HOME/.bash_history"
export HISTCONTROL="ignoredups:erasedups"
export HISTSIZE=99999
export HISTFILESIZE=99999
shopt -s histappend
export PROMPT_COMMAND="history -a"

export HOSTNAME="`hostname`"
export PAGER='less'
export EDITOR='vim'
export SVN_EDITOR='vim'

# fix gpg
export GPG_TTY=$(tty)

# Go
export GOPATH="$HOME/.golang"

# Use user dir for npm global
PATH=".:$HOME/bin:$HOME/.local/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:$PATH"

# default command options
alias aspell='aspell --dont-backup'
alias curl='curl --silent'
alias df='df -h -x tmpfs'
alias ffmpeg='ffmpeg -hide_banner'
alias grep='grep -i'
alias less='less -r'
alias ls='ls -h -N --group-directories-first --color'
alias ll='ls -lhG '
alias make='make --quiet'
alias rg='rg -i'
alias screen='screen -R -U -A '
alias wget='wget -q'
alias xps='ps -aef '
alias xpsg='ps -aef | grep -i'

# shortcuts
apache() {
    sudo systemctl $1 apache2
}
alias tailoge='sudo tail -f /var/log/apache2/error.log'

alias apt='sudo apt'
alias ff='find . | grep'
alias mtr='sudo mtr'
alias o='xdg-open'
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias python='python3'
alias svnig='svn --ignore-externals'
alias svnd='svn --config-option config:helpers:diff-cmd=colordiff diff'
alias top='htop'
alias vihosts='sudo vim /etc/hosts'
alias visudo='sudo visudo'
alias vaconf='vim ~/sites/vhosts.conf'
alias vim='vim'

# moving around
alias cd..='cd ..'
alias cd...='cd ../../'
alias cd....='cd ../../../'
alias cdt='cd ~/tmp/'

# typos
alias ls-l='ls -l'

# Prompt
source ~/dotfiles/prompt

# load autojump
if [[ -e /usr/share/autojump/autojump.bash ]]; then
    source /usr/share/autojump/autojump.bash
fi

if [[ -e /usr/lib/git-core/git-sh-prompt ]]; then
    source /usr/lib/git-core/git-sh-prompt
fi

if [[ -e /usr/share/bash-completion/completions/git ]]; then
    source /usr/share/bash-completion/completions/git
fi


if [[ -e /usr/share/bash-completion/completions/pass ]]; then
    source /usr/share/bash-completion/completions/pass
fi

# dircolors
eval $(dircolors /home/mkaz/dotfiles/extras/dircolors)

# run host specific profile
if [[ -e ~/dotfiles/profile.$HOSTNAME ]]; then
    source ~/dotfiles/profile.$HOSTNAME
fi

if [[ -e ~/dotfiles/rcfiles/.fzf.bash ]]; then
    source ~/dotfiles/rcfiles/.fzf.bash
fi

if [[ -e ~/.nvm/nvm.sh ]]; then
    source ~/.nvm/nvm.sh
fi

if [[ -e ~/dotfiles/zk.sh ]]; then
    source ~/dotfiles/zk.sh
fi

unset command_not_found_handle
