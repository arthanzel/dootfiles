# Go
export GOPATH="$HOME/Code/go"
addpath $GOPATH/bin

# RVM
addpath ~/.rvm/bin # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
