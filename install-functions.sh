# Resolves a relative path into an absolute one.
resolve() {
    echo "$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
}

# Outputs the path to which a link points. If the given file is not a link, outputs blank.
getLinkTarget() {
    echo $(readlink "$1")
}

# Determines if a given file is a dootfile-created link.
isDootfileLink() {
    if [[ -L $1 && "$(getLinkTarget $1)" == "${CURDIR}"* ]]; then return 0; else return 1; fi
}

# Installs a dootfile, prompting the user to skip, overwrite, or backup existing files.
dootinstall() {
    LINKTGT=$1 # File to which the link points
    LINKFILE=$2 # File of the symbolic link to be created

    # If the linkfile is a directory, warn the user and skip.
    if [[ -d $LINKFILE ]]; then
        echo "Warning: $LINKFILE is a directory! Skipping."
        continue
    fi

    # If the linkfile exists and is a regular file.
    # User can choose to skip, overwrite, or backup the existing file.
    if [[ $3 != "force" && -f "$LINKFILE" ]] && ! isDootfileLink "$LINKFILE"; then
        echo "File already exists: $LINKFILE"

        while true; do
            printf "[s]kip, [o]verwrite, [b]ackup? "
            read -n 1 CHAR && echo
            case $CHAR in
                s)  return 2 # Break and continue on next linkable
                    ;;
                o)  break
                    ;;
                b)  mv "$LINKFILE" "${LINKFILE}.backup"
                    break
                    ;;
            esac
        done
    fi

    ln -sf "$LINKTGT" "$LINKFILE"
}

# Removes a given dootfile symlink and restores its backup, if applicable.
dootuninstall() {
    LINKFILE=$1
    BACKUPFILE="${LINKFILE}.backup"

    # Check if the linkfile is a symlink and remove.
    if isDootfileLink "$LINKFILE"; then
        rm "$LINKFILE"

        # Restore the backup
        if [[ -f $BACKUPFILE ]]; then
            mv "$BACKUPFILE" "$LINKFILE"
        fi
    fi
}