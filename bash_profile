export LIME='\[\e[0;32m\]'

export MAGENTA
export ORANGE
export GREEN
export PURPLE='\[\e[1;35m\]' #git branch

export WHITE
export BLUE
export BOLD
export RESET


function parse_git_dirty() {
  [[ $(git status 2> /dev/null | tail -n1) != *"working tree clean"* ]] && echo "*"
}

function parse_git_branch() {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

alias bashReload=' . ~/.bash_profile'

export PS1="\[✨ lilian ✨\]:\[$PURPLE\]\[$WHITE\]\$([[ -n \$(git branch 2> /dev/null) ]] && echo [)\[$PURPLE\]\[💜\]\$(parse_git_branch)\[💜\]\[$WHITE\]\$([[ -n \$(git branch 2> /dev/null) ]] && echo ])(/\w) \[$BLUE\]"

