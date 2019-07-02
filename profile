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

export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi

# Go
export GOPATH="$HOME"

# Use user dir for npm global
NPM_CONFIG_PREFIX=$HOME/.npm-global
PATH=".:$HOME/bin:$HOME/.npm-global/bin:$HOME/.local/bin:/usr/local/bin:/usr/local/sbin:/sbin:/usr/sbin:$PATH"

# default command options
alias aspell='aspell --dont-backup'
alias curl='curl --silent'
alias df='df -h -x tmpfs'
alias git='hub'
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
    sudo systemctl $1 httpd
}

alias apt='sudo apt'
alias ff='find . | grep'
alias mtr='sudo mtr'
alias o='xdg-open'
alias pacman='sudo pacman'
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias python='python3'
alias svnig='svn --ignore-externals'
alias svnd='svn --config-option config:helpers:diff-cmd=colordiff diff'
alias t='task'
alias top='htop'
alias vihosts='sudo vim /etc/hosts'
alias visudo='sudo visudo'
alias vaconf='sudo vim /etc/httpd/conf/vhosts.conf'

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

if [[ -e /usr/share/git/git-prompt.sh ]]; then
    source /usr/share/git/git-prompt.sh
fi

if [[ -e ~/dotfiles/extras/git-completion.bash ]]; then
    source ~/dotfiles/extras/git-completion.bash
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

if [[ -e ~/dotfiles/extras/pass.bash-completion ]]; then
    source ~/dotfiles/extras/pass.bash-completion
fi

if hash cowsay 2>/dev/null; then
    curl --silent https://icanhazdadjoke.com | cowsay
fi

