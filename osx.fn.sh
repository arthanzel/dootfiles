# osx - Test for OSX.
# Since OSX is BSD and not Linux-based, some coreutils switches are different (ls, sed, etc.).
#
# Usage:
#   osx [osxvalue] [linuxvalue]

# If no arguments are given, the function returns code 0 if on osx, and code 1 otherwise:
#   osx && echo "I'm OSX!" || echo "I'm Linux!"
#   if osx; then echo "OSX"; else echo "Linux"; fi
#
# If two arguments are given, the function returns the first if on osx, and the second otherwise:
#   SWITCH=$(osx "-osx" "-lin")
osx() {
    if [[ "$1" && "$2" ]]; then
        if [[ $(uname) == "Darwin" ]]; then echo "$1"; else echo "$2"; fi
    else
        if [[ $(uname) == "Darwin" ]]; then return 0; else return 1; fi
    fi
}

# Make this function available to scripts
export -f osx