#!/bin/bash
stty -ixon # Disable ctrl-s and ctrl-q.
shopt -s autocd #Allows you to cd into directory merely by typing the directory name.
HISTSIZE= HISTFILESIZE= # Infinite history.
export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\] \[$(tput sgr0)\]"


[ -f "$HOME/.local/bin/aliases/bm/shortcutrc" ] && source "$HOME/.local/bin/aliases/bm/shortcutrc" # Load shortcut aliases
[ -f "$HOME/.local/bin/aliases/aliasrc" ] && source "$HOME/.local/bin/aliases/aliasrc"
#[ -f "$HOME/.local/bin/aliases/git" ] && source "$HOME/.local/bin/aliases/git"
[ -f "$HOME/.local/bin/aliases/pacman" ] && source "$HOME/.local/bin/aliases/pacman"
#add dwm aliases
source ~/.local/bin/aliases/git

if [ -f ~/.aliases ]; then
    . ~/.aliases
fi

export VISUAL=nvim
source <(kitty + complete setup bash)
