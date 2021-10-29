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
export EDITOR='nvim'
export SVN_EDITOR='nvim'

# fix gpg
#export GPG_TTY=$(tty)

# Build PATH
PATH=".:$HOME/bin:$HOME/.local/bin:$HOME/dotfiles/bin:$PATH"
export PATH

# default command options
alias curl='curl --silent'
alias df='df -h -x tmpfs'
alias fd='fdfind'
alias ffmpeg='ffmpeg -hide_banner'
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
alias grep='rg -i'
alias cat='batcat'
alias less='batcat'
alias ls='exa --time-style long-iso -l -h --group-directories-first'
alias ll='ls -a --git'
alias o='xdg-open'
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias python='python3'
alias svnig='svn --ignore-externals'
alias top='htop'
alias vihosts='sudo nvim /etc/hosts'
alias visudo='sudo visudo'
alias vaconf='nvim ~/sites/vhosts.conf'
alias vim='nvim'

alias vimmod='git ls-files -m | fzf --multi | xargs --no-run-if-empty nvim'

# moving around
alias cd..='cd ..'
alias cd...='cd ../../'
alias cd....='cd ../../../'
alias cdt='cd ~/tmp/'

# typos
alias ls-l='ls -l'

# load autojump
if [[ -e /usr/share/autojump/autojump.sh ]]; then
    source /usr/share/autojump/autojump.sh
fi

if [[ -e /home/mkaz/.config/tealdeer-completion.bash ]]; then
    source /home/mkaz/.config/tealdeer-completion.bash
fi

if [[ -e /usr/share/bash-completion/completions/git ]]; then
    source /usr/share/bash-completion/completions/git
fi

if [[ -e /usr/share/bash-completion/completions/pass ]]; then
    source /usr/share/bash-completion/completions/pass
fi

# ubuntu nag
unset command_not_found_handle

# run host specific profile
if [[ -e ~/dotfiles/profile.$HOSTNAME ]]; then
    source ~/dotfiles/profile.$HOSTNAME
fi

export STARSHIP_CONFIG=~/dotfiles/configs/starship/config.toml
eval "$(starship init bash)"

. "$HOME/.cargo/env"
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
