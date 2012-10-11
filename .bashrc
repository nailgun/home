# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
if [ -x /usr/bin/lesspipe ]; then
    eval "$(SHELL=/bin/sh lesspipe)" 2> /dev/null
    if [ $? -ne 0 ]; then
        export LESSOPEN="|lesspipe %s"
    fi
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
# ubuntu
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
# gentoo
[[ -f /etc/profile.d/bash-completion.sh ]] && . /etc/profile.d/bash-completion.sh

# Interactive python startup script.
export PYTHONSTARTUP=~/.pythonrc

# set color prompt
export GIT_PS1_SHOWDIRTYSTATE=1
g='\[\033[01;32m\]'
b='\[\033[01;34m\]'
y='\[\033[01;33m\]'
reset='\[\033[00m\]'
git='$(__git_ps1 " %s")'
#PS1="${g}\u@\h${b} \w${y}${git}${b}\n\$${reset} "
PS1="\n${g}\u@\h${b} \w\n\$${reset} "
unset g b y reset git

# set terminal title
case ${TERM} in
xterm*|rxvt*|Eterm|aterm|kterm|gnome*|interix)
	PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'
	;;
screen)
	PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\033\\"'
	;;
esac

# enable color support of ls
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# aliases
if [ "$OSTYPE" == 'linux-gnu' ]; then
    alias ls='ls --color=auto'
else
    alias ls='ls -G'
fi
alias scr='screen -xRR'
alias ll='ls -al'
alias la='ls -A'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias gvimm='gvim --remote'
alias home='git --git-dir=$HOME/.home --work-tree=$HOME'

# include local bashrc
[[ -f "$HOME/.bashrc_local" ]] && . "$HOME/.bashrc_local"
