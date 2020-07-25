 #If not running interactively, don't do anything
[[ $- != *i* ]] && return

# gtest option
export GTEST_COLOR=1

# to set xfce-terminal use of xresources
if [ -e /usr/share/terminfo/x/xterm-256color ] && [ "$COLORTERM" == "xfce4-terminal" ]; then
	    export TERM=xterm-256color
fi

if [ -f /usr/share/fzf/key-bindings.bash ] && [ -f /usr/share/fzf/completion.bash ]; then
   source /usr/share/fzf/key-bindings.bash
   source /usr/share/fzf/completion.bash
fi

alias ls='ls --color=auto'
alias ll='ls -all'


PS1='\[\e[1;104;37m\] \u\[\e[1;40;34m\]\[\e[1;40;37m\] \w\[\e[0;49;30m\]\[\e[m\]\] '
