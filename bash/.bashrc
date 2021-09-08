#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Aliases
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'
alias tree='tree -C'
alias ..='cd ..'

# Bash prompt color
PS1="\[\e[32m\][\w] $ \[\e[00m\]"

# Extract file - xf
# Usage: xf <file>
xf ()
{
    if [ -f $1 ] ; then
        case $1 in
            *.tar)      tar xf $1     ;;
            *.tar.gz)   tar xzf $1    ;;
            *.tgz)      tar xzf $1    ;;
            *.tar.bz2)  tar xjf $1    ;;
            *.tbz2)     tar xjf $1    ;;
            *.bz2)      bunzip2 $1    ;;
            *.rar)      unrar x $1    ;;
            *.7z)       7z x $1       ;;
            *.gz)       gunzip $1     ;;
            *.zip)      unzip $1      ;;
            *.Z)        uncompress $1 ;;
            *.lz4)      unlz4 $1      ;;
            *.zst)      unzstd $1     ;;
            *.xz)       unxz $1       ;;
            *)          echo "'$1' cannot be extracted via xf." ;;
        esac
    else
        echo "'$1' is not a valid file."
    fi
}

# Root user bash prompt color
# PS1="\[\e[31m\][\w] # \[\e[00m\]"

# . "$HOME/.cargo/env"
