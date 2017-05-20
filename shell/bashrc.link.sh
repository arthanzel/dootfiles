# Martin's Bash
# =============

# Dootfile business.
export CODE="$HOME/Code/"
export DOOTFILES=`cat ~/.dootfiles`
for config_file in $DOOTFILES/*.fn.sh; do source $config_file; done
for config_file in $DOOTFILES/*/*.fn.sh; do source $config_file; done
addpath $DOOTFILES/bin

# Make it easier to edit dootfiles.
alias editbash="nano ~/.bashrc ; source ~/.bashrc"
alias rebash="source ~/.bashrc"
alias doot="cd '$DOOTFILES'; '$DOOTFILES'/install.sh"

# Opens an editor to edit a given function file.
# Specify the folder and filename, sans extension.
# Example: editfn shell/aliases.
# If the file is omitted or doesn't exist, lists available function files.
editfn() {
    if [[ -f $DOOTFILES/$1.fn.sh ]]; then
        nano $DOOTFILES/$1.fn.sh;
        rebash
    else
        # Check if string is not blank with -n.
        if [[ -n $1 ]]; then
            echo "File $1 does not exist."
        fi

        echo "Available function files:"

        # List available function files.
        # The first sed removes the path prefix and .fn.sh suffix.
        # The second sed indents each line.
        # The switch enables extended regexes in sed.
        osx && SWITCH="-E" || SWITCH="-r" 
        find $DOOTFILES -name \*.fn.sh \
            | sed $SWITCH -e 's:^'$DOOTFILES'\/|\.fn\.sh$::g' \
                          -e 's/^/  /'
    fi
}