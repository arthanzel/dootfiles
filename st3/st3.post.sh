source "install-functions.sh"

if osx; then
    FILE="/Users/martin/Library/Application Support/Sublime Text 3/Packages/User/Preferences.sublime-settings"
else
    FILE="~/.config/sublime-text-3/Packages/User/Preferences.sublime-settings"
fi

if [[ $1 == "install" ]]; then
    echo "Linking ST3..."
    dootinstall $(pwd)/st3/Preferences.sublime-settings "$FILE"
fi

if [[ $1 == "uninstall" ]]; then
    echo "Removing ST3..."
    dootuninstall "$FILE"
fi