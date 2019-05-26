DEFAULT_USER="niclaseich"
# mounts
_mount () {
    diskutil umount force /Users/niclaseich/mounts/$1;
    sshfs -o reconnect -o defer_permissions -o negative_vncache -o volname=$1 $2 /Users/niclaseich/mounts/$1;
}

## vispa
alias m_vispa_NiclasEich='_mount vispa/home/NiclasEich/ NEvispa-portal:'
alias m_vispa_NiclasEich_scratch='_mount vispa/scratch/NiclasEich/ NEvispa-portal:/net/scratch/NiclasEich'

alias ls='ls -G'
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

# Virtualenvwrapper things
#
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
source /usr/local/bin/virtualenvwrapper.sh

# iterm2 integration
source ~/.iterm2_shell_integration.zsh
