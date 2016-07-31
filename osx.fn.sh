# Test for OSX.
# Since OSX is BSD and not Linux-based, some coreutils switches are different (ls, sed, etc.)
# Usage:
#   osx && echo "I'm OSX!" || echo "I'm Linux!"
# This method has issues - if the OSX command returns a non-zero code, the Linux command will be run.
# 
# More verbose usage:
# if osx; then echo "OSX"; else echo "Linux"; fi
osx() {
    #TODO: Take two values and return one of them
    if [[ $(uname) == "Darwin" ]]; then return 0; else return 1; fi
}

# Make this function available to scripts
export -f osx