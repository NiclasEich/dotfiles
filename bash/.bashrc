# rscreen (directly jump into ssh sessions screen)
rscreen () {
    ssh $1 -Yt screen -D -RR $2
}
# _rscreen (autocompletion for rscreen)
_rscreen() {
  local cur prev opts
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"
  pprev="${COMP_WORDS[COMP_CWORD-2]}"
  opts=$(grep '^Host' ~/.ssh/config | grep -v '[?*]' | cut -d ' ' -f 2-)
  if [[ $prev == "rscreen"  ]]; then
    COMPREPLY=( $(compgen -W "$opts" -- ${cur}) )
  elif [[ $pprev == "rscreen" ]]; then
    local _cur _prev _opts
    COMPREPLY=()
    _cur="${COMP_WORDS[COMP_CWORD]}"
    _prev="${COMP_WORDS[COMP_CWORD-1]}"
    _opts=$(ssh $prev "screen -ls | grep -E '[0-9]+\.[a-zA-Z0-9]*' | cut -d'.' -f2 | cut -d'(' -f1")
    COMPREPLY=( $(compgen -W "$_opts" -- ${_cur}) )
  fi
  return 0
}
complete -F _rscreen rscreen

rtmux () {
    ssh $1 -Yt tmux attach-session -t $2 || tmux new-session -t $2
}

# Kerberos refresh tmux session
 ktmux(){
     if [[ -z "$1" ]]; then #if no argument passed
             k5reauth -f -i 3600 -p neich -k $HOME/private/neich.keytab -- tmux new-session
     else #pass the argument as the tmux session name
             k5reauth -f -i 3600 -p neich -k $HOME/private/neich.keytab -- tmux new-session -s $1
     fi
}

# convenient directory maneuvering
cds () {
    foo=$1
    path="."
    for (( i=0; i<${#foo}; i++ )); do
        path="$path/${foo:$i:1}*"
    done
    LEN="$(find $path -maxdepth 0 -type d | wc -l)"
    if [ "${LEN}" = 1 ];
        then
            cd $path
    elif [ "${LEN}" -ge 2 ];
    then
        echo "More than one directory: $path"
    fi
}
#
# # for screenrc
# export PROMPT_COMMAND='printf "\033]0;%s\033\134\033k\033\134" "${PWD/#$HOME/~}"'
# get current branch in git repo
function parse_git_branch() {
    BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
    if [ ! "${BRANCH}" == "" ]
    then
        STAT=`parse_git_dirty`
        echo "[${BRANCH}${STAT}]"
    else
        echo ""
    fi
}
# get current status of git repo
function parse_git_dirty {
    status=`git status 2>&1 | tee`
    dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
    untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
    ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
    newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
    renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
    deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
    bits=''
    if [ "${renamed}" == "0" ]; then
        bits=">${bits}"
    fi
    if [ "${ahead}" == "0" ]; then
        bits="*${bits}"
    fi
    if [ "${newfile}" == "0" ]; then
        bits="+${bits}"
    fi
    if [ "${untracked}" == "0" ]; then
        bits="?${bits}"
    fi
    if [ "${deleted}" == "0" ]; then
        bits="x${bits}"
    fi
    if [ "${dirty}" == "0" ]; then
        bits="!${bits}"
    fi
    if [ ! "${bits}" == "" ]; then
        echo " ${bits}"
    else
        echo ""
    fi
}
export PS1="\[\e[32;40m\]\t\[\e[m\]-\u@\h:\w\\$\[\e[31m\]\`parse_git_branch\`\[\e[m\] "

source $HOME/.aliases
. "$HOME/.cargo/env"
