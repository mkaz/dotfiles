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
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

export HOSTNAME="`hostname`"
export PAGER='less'
export EDITOR='vim'
export SVN_EDITOR='vim'
export GNUTERM=x11
export GPG_TTY=$(tty)

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
alias apache='sudo service apache2'
alias apt='sudo apt'
alias djangoenv='source $HOME/.virtualenvs/djangodev/bin/activate'
alias django='python manage.py'
alias ff='find . | grep'
alias mtr='sudo mtr'
alias o='xdg-open'
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias python='python3'
alias svnig='svn --ignore-externals'
alias svnd='svn --config-option config:helpers:diff-cmd=colordiff diff'
alias t='task'
alias top='htop'
alias vihosts='sudo vim /etc/hosts'
alias visudo='sudo visudo'
alias vaconf='sudo vim /etc/apache2/sites-available/000-default.conf'

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
source /usr/share/autojump/autojump.sh

# dircolors
eval $(dircolors /home/mkaz/dotfiles/extras/dircolors)

# dont bother me
unset command_not_found_handle

# run host specific profile
if [[ -e ~/dotfiles/profile.$HOSTNAME ]]; then
    source ~/dotfiles/profile.$HOSTNAME
fi

if [[ -e ~/dotfiles/rcfiles/.fzf.bash ]]; then
    source ~/dotfiles/rcfiles/.fzf.bash
fi

if [[ -e ~/dotfiles/extras/git-completion.bash ]]; then
    source ~/dotfiles/extras/git-completion.bash
fi

