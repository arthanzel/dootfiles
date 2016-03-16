# functions.fn.sh
# 
# This file defines functions to be loaded before anything else. Put common
# helpers and dependencies here.

# addpath adds a path to the current $PATH and exports it.
# If the path is invalid or already exists in the $PATH, it will be ignored.
addpath() {
	if [ -d "$1" ]; then
		if [[ ":$PATH:" != *":$1:"* ]]; then
			export PATH="$1:$PATH"
		fi
	# else
	# 	echo "Cannot find path $1"
	fi
}

# Makes a dir and enters it
mkcd() {
    mkdir -p $1 && cd $1
}
