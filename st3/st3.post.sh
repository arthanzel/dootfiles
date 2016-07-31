if [[ $1 == "install" ]]; then
    echo "Linking ST3..."
    if osx; then
        ln -sf $(pwd)/st3/Preferences.sublime-settings "/Users/martin/Library/Application Support/Sublime Text 3/Packages/User/Preferences.sublime-settings"
    else
        ln -sf $(pwd)/st3/Preferences.sublime-settings "~/.config/sublime-text-3/Packages/User/Preferences.sublime-settings"
    fi
fi

if [[ $1 == "uninstall" ]]; then
    if osx; then
        rm "/Users/martin/Library/Application Support/Sublime Text 3/Packages/User/Preferences.sublime-settings"
    else
        rm "~/.config/sublime-text-3/Packages/User/Preferences.sublime-settings"
    fi
fi