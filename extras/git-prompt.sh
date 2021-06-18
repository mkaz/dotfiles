
# define __git_ps1 function
source /etc/bash_completion.d/git-prompt


PS1='\n'                  # new line
PS1="$PS1"'\[\033[35m\]'  # change to purple
PS1="$PS1"'\w'            # current working directory
PS1="$PS1"'\[\033[31m\]'  # change color to cyan
PS1="$PS1"'`__git_ps1`'   # bash function
PS1="$PS1"'\[\033[0m\]'   # change color
PS1="$PS1"'\n'            # new line
PS1="$PS1"'$ '            # prompt: always $

