alias la="ls -a"
alias ll="ls -l"
alias lla="ls -la"

alias editbash="nano ~/.bashrc ; source ~/.bashrc"
editfn() {
    nano $DOOTFILES/fn/$1.sh;
    source ~/.bashrc
}

alias prolog="/Applications/SWI-Prolog.app/Contents/MacOS/swipl"
