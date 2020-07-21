#
# ~/.bashrc
#

# gtest option
export GTEST_COLOR=1



 #If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# to set xfce-terminal use of xresources
if [ -e /usr/share/terminfo/x/xterm-256color ] && [ "$COLORTERM" == "xfce4-terminal" ]; then
	    export TERM=xterm-256color
fi

if [ -f `which powerline-daemon` ]; then
	powerline-daemon -q
	POWERLINE_BASH_CONTINUATION=1
	POWERLINE_BASH_SELECT=1
	. /usr/share/powerline/bindings/bash/powerline.sh
fi

if [ -f /usr/share/fzf/key-bindings.bash ] && [ -f /usr/share/fzf/completion.bash ]; then
   source /usr/share/fzf/key-bindings.bash
   source /usr/share/fzf/completion.bash
fi

