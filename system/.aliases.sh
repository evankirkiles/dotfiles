# Shortcuts
alias reload="source ~/.zprofile; source ~/.zshrc"

# Editors
alias vi="nvim"
alias vim="nvim"

# QoL things
alias mux="tmuxinator"

# Colorized Directory listing/traversal
LS_COLORIZED=$(is-supported "ls --color" --color -G)
LS_TIMESTYLEISO=$(is-supported "ls --time-style=long-iso" --time-style=long-iso)
LS_GROUPDIRSFIRST=$(is-supported "ls --group-directories-first" --group-directories-first)
alias ls="ls $LS_COLORIZED"
alias l="ls -lahA $LS_TIMESTYLEISO $LS_GROUPDIRSFIRST"
alias ll="ls -lA"
alias lt="ls -lhAtr $LS_TIMESTYLEISO $LS_GROUPDIRSFIRST"
alias ld="ls -ld */"
alias lp="stat -c '%a %n' *"

# List declared aliases, functions, paths
alias aliases="alias | sed 's/=.*//'"
alias functions="declare -f | grep '^[a-z].* ()' | sed 's/{$//'"
alias paths='echo -e ${PATH//:/\\n}'

# Miscellaneous
alias hosts='$EDITOR /etc/hosts'
alias quit="exit"
alias week="date +%V"
alias speedtest="wget -O /dev/null http://speed.transip.nl/100mb.bin"
alias grip='grip --browser --pass=$GITHUB_TOKEN'
