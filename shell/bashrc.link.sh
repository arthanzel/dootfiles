# Martin's Bash
# =============

export DOOTFILES=`cat ~/.dootfiles`

source ~/.bash_functions
addpath ~/Applications
addpath ~/bin
addpath $DOOTFILES/bin

source $DOOTFILES/shell/sdks.sh # SDK paths and bootstraps for RVM etc. are defined here
source $DOOTFILES/shell/prompt.sh # Git-enabled shell prompt

# Frequently-visited places
export CODE="$HOME/Code/"
alias cdc="cd $CODE"
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
alias cddf="cd $DOOTFILES"
alias editbash="$EDITOR ~/.bashrc ; source ~/.bashrc"
alias rebash="source ~/.bashrc"
alias doot="cd '$DOOTFILES'; '$DOOTFILES'/install.sh"
