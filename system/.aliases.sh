# Shortcuts
alias reload="source ~/.zprofile"

# Editors
alias vi="nvim"
alias vim="nvim"

# List declared aliases, functions, paths
alias aliases="alias | sed 's/=.*//'"
alias functions="declare -f | grep '^[a-z].* ()' | sed 's/{$//'"
alias paths='echo -e ${PATH//:/\\n}'

# Miscellaneous
alias hosts="sudo $EDITOR /etc/hosts"
alias quit="exit"
alias week="date +%V"
alias speedtest="wget -O /dev/null http://speed.transip.nl/100mb.bin"
alias grip="grip --browser --pass=$GITHUB_TOKEN"
