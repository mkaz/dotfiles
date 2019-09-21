# Setup fzf
# ---------
if [[ ! "$PATH" == */home/mkaz/.fzf/bin* ]]; then
  export PATH="$PATH:/home/mkaz/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/mkaz/.fzf/shell/completion.bash" 2> /dev/null

export FZF_DEFAULT_COMMAND='rg --files --follow --glob=!__pycache__/* --glob=!*.pyc'


# Key bindings
# ------------
# source "/home/mkaz/.fzf/shell/key-bindings.bash"

