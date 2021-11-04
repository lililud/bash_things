if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
  export TERM=gnome-256color
elif infocmp xterm-256color >/dev/null 2>&1; then
  export TERM=xterm-256color
fi

if tput setaf 1 &> /dev/null; then
  tput sgr0
  if [[ $(tput colors) -ge 256 ]] 2>/dev/null; then
    MAGENTA=$(tput setaf 9)
    ORANGE=$(tput setaf 172)
    GREEN=$(tput setaf 190)
    PURPLE=$(tput setaf 141)
    WHITE=$(tput setaf 46)
    BLUE=$(tput setaf 39)
  else
    MAGENTA=$(tput setaf 5)
    ORANGE=$(tput setaf 4)
    GREEN=$(tput setaf 2)
    PURPLE=$(tput setaf 1)
    WHITE=$(tput setaf 7)
    BLUE=$(tput setaf 4)
  fi
  BOLD=$(tput bold)
  RESET=$(tput sgr0)
else
  MAGENTA="\033[1;31m"
  ORANGE="\033[1;33m"
  GREEN="\033[1;32m"
  PURPLE="\033[1;35m"
  WHITE="\033[1;37m"
  BOLD=""
  RESET="\033[m"
fi

export LIME='\[\e[0;32m\]'

export MAGENTA
export ORANGE
export GREEN
export PURPLE='\[\e[1;35m\]' #git branch

export WHITE
export BLUE
export BOLD
export RESET

export CLICOLOR=1
export LSCOLORS=CxbxCxDxFxegedabagaced

function parse_git_dirty() {
  [[ $(git status 2> /dev/null | tail -n1) != *"working tree clean"* ]] && echo "*"
}

function parse_git_branch() {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

alias bashReload=' . ~/.bash_profile'

export PS1="\[✨ lilian ✨\]:\[$PURPLE\]\[$WHITE\]\$([[ -n \$(git branch 2> /dev/null) ]] && echo [)\[$PURPLE\]\[💜\]\$(parse_git_branch)\[💜\]\[$WHITE\]\$([[ -n \$(git branch 2> /dev/null) ]] && echo ])(/\w) \[$BLUE\]"

