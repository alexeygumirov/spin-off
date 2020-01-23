#####################################################
#           _    ____                   __          #
#          / \  / ___|  ___ ___  _ __  / _|         #
#         / _ \| |  _  / __/ _ \| '_ \| |_          #
#        / ___ \ |_| || (_| (_) | | | |  _|         #
#       /_/   \_\____(_)___\___/|_| |_|_|           #
#                                                   #
#       Alexey Gumirov's generic config for         #
#       Ubuntu based operating systems.             #
#####################################################
#
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# Powerline
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. /usr/share/powerline/bindings/bash/powerline.sh 

# my environment variables ------
export PATH=~/.scripts:~/.local/bin:/usr/local/go/bin:$PATH
export PROMPT_DIRTRIM=6
export PAGER=less
export LANG=en_US.UTF-8
export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket
export VISUAL=$(which nvim)
export EDITOR="$VISUAL"
export YOUTUBEDLDIR="~/downloads/youtube-dl/"

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=1000
export HISTFILESIZE=2000
export HISTTIMEFORMAT="%F %T: "

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# enable vi keys for command line
set -o vi

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# Git prompt enabled
if [ -f /etc/bash_completion.d/git-prompt ]; then
    . /etc/bash_completion.d/git-prompt
fi
export GIT_PS1_SHOWDIRTYSTATE=1

if [ "$color_prompt" = yes ]; then
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
	PS1='\n'
	case "$LOGNAME" in
		root)
			PS1+='[\[\033[31m\]\u@\h in \w\[\033[00m\]]'
			PS1+='\n'
			PS1+='${debian_chroot:+($debian_chroot)}\[\033[00m\][\[\033[30;41m\]\D{%F}\[\033[00m\] '
			PS1+='\[\033[30;41m\]\t\[\033[00m\]] \$ '
			;;
		*)
                        PS1+='[\u at \[\033[1;32m\]\h \[\033[00m\] in \[\033[31m\]\w\[\033[00m\]]'
                        PS1+='\n'
                        PS1+='${debian_chroot:+($debian_chroot)}\[\033[00m\][\[\033[30;45m\]\D{%F}\[\033[00m\] '
                        PS1+='\[\033[30;42m\]\t\[\033[00m\]]'
                        PS1+='$(__git_ps1 " \[\033[1;30;44m\]{%s}\[\033[00m\]") \$ '
                        ;;
	esac		
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# maintenance of the ssh-agent
ssh-add -l &>/dev/null
if [ "$?" == 2 ]; then
  test -r ~/.ssh-agent && eval "$(<~/.ssh-agent)" >/dev/null
  ssh-add -l &>/dev/null
  if [ "$?" == 2 ]; then
    (umask 066; ssh-agent > ~/.ssh-agent)
    eval "$(<~/.ssh-agent)" >/dev/null
    ssh-add
  fi
fi

# if [[ -z $SSH_AUTH_SOCK ]]; then
# 	eval `ssh-agent -s` > /dev/null 2>&1
# fi

function tmux() {
    local tmux=$(type -fp tmux)
    case "$1" in
        update-environment|update-env|env-update)
            local v
            while read v; do
                if [[ $v == -* ]]; then
                    unset ${v/#-/}
                else
                    # Add quotes around the argument
                    v=${v/=/=\"}
                    v=${v/%/\"}
                    eval export $v
                fi
            done < <(tmux show-environment)
            ;;
        *)
            $tmux "$@"
            ;;
    esac
}

# my dir list function
function lsdr() {
	if [[ ! -z $1 ]]; then
		# OLD_PATH_ORIGIN="$OLDPWD"
		# cd "$1"
                pushd "$1"
		ls -dlLahH */ \.*/
		# cd "$OLDPWD"
                popd
		# OLDPWD="$OLD_PATH_ORIGIN"
	else
		ls -dlLahH */ \.*/
	fi
}

# Tmux all windows update .bashrc
function tmux_source_bashrc() {
	sessions=$(tmux list-windows)
	while IFS= read -r LINE ; do
		INDX=$(echo "$LINE" | cut -d':' -f1)
		tmux send-keys -t "$INDX" " source ~/.bashrc && clear" C-m
	done <<< "$sessions"
}

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bashrc_aliases ]; then
    . ~/.bashrc_aliases
fi

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
