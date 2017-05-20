# Java and friends
export SDKMAN_DIR="/Users/martin/.sdkman"
[[ -s "/Users/martin/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/martin/.sdkman/bin/sdkman-init.sh"

# Go
export GOROOT=/opt/go/1.8
addpath $GOROOT/bin
export GOPATH="$HOME/Code/go"
addpath $GOPATH/bin

# Node.js
if mac; then
    addpath ~/Applications/node/bin
fi

# Ruby
addpath ~/.rvm/bin
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"