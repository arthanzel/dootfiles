# Martin's Bash
# =============

export DOOTFILES=`cat ~/.dootfiles`

source $DOOTFILES/shell/bash_functions.sh
addpath ~/Applications
addpath ~/bin
addpath $DOOTFILES/bin

source $DOOTFILES/shell/sdks.sh # SDK paths and bootstraps for RVM etc. are defined here
source $DOOTFILES/shell/prompt.sh # Git-enabled shell prompt
source $DOOTFILES/confidential.sh

# Frequently-visited places
export CODE="$HOME/Code/"
alias cdc="cd $CODE"
alias .="pwd"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ~="cd ~"

# I like Vim.
export EDITOR=vim

# Cross-platform ls
mac && alias ls="ls -G" # Enable colours
alias la="ls -a"
alias ll="ls -l"
alias lla="ls -la"

# Make it easier to edit dootfiles.
alias .cd="cd $DOOTFILES"
alias .bash="$EDITOR ~/.bashrc ; source ~/.bashrc"
alias .src="source ~/.bashrc"
alias .install="cd '$DOOTFILES'; '$DOOTFILES'/install.py"
function .edit() {
    $EDITOR $DOOTFILES/"$1"
    .src
}