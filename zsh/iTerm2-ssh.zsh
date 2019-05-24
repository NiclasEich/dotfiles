# taken adn adapted from https://coderwall.com/p/t7a-tq/change-terminal-color-when-ssh-from-os-x
function tabc() {
  NAME=$1; if [ -z "$NAME" ]; then NAME="Niclas"; fi
  # if you have trouble with this, change
  # "Default" to the name of your default theme
  echo -e "\033]50;SetProfile=$NAME\a"
}

function tab-reset() {
    NAME="Niclas"
    echo -e "\033]50;SetProfile=$NAME\a"
}

function colorssh() {
    if [[ -n "$ITERM_SESSION_ID" ]]; then
        trap "tab-reset" INT EXIT
        if [[ "$*" =~ "vispa*" ]]; then
            tabc Vispa 
        #elif [[ "$*" =~ "staging*" ]]; then
            #tabc Staging
        else
            tabc Other
        fi
    fi
    ssh $*
}
compdef _ssh tabc=ssh

alias ssh="colorssh"
