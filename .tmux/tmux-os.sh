#!/usr/bin/env bash
#{{{ MARK:Header
#**************************************************************
##### Author: MenkeTechnologies
##### GitHub: https://github.com/MenkeTechnologies
##### Date: Sat Sep  7 01:37:02 EDT 2019
##### Purpose: bash script to
##### Notes:
#}}}***********************************************************

logg(){
    echo "$(date) $1 " >> ~/updaterlog.txt
}
set -x
if uname | grep -q Darwin; then
    tmux source-file "$HOME/.tmux/tmux-mac"
elif uname | grep -q Linux; then
    pyv=$(python3 --version)
    logg "python version: $pyv"
    if echo "$pyv" | grep -q 3.4; then
        tmux source-file "$HOME/.tmux/tmux-linux-34"
        logg "done 34"
    elif echo "$pyv" | grep -q 3.5; then
        tmux source-file "$HOME/.tmux/tmux-linux-35"
        logg "done 35"
    elif echo "$pyv" | grep -q 3.6; then
        tmux source-file "$HOME/.tmux/tmux-linux-36"
        logg "done 36"
    elif echo "$pyv" | grep -q 3.7; then
        tmux source-file "$HOME/.tmux/tmux-linux-37"
        logg "done 37"
    fi
fi

