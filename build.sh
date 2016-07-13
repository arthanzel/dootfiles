#!/bin/bash

# TODO: Local variables

# Make sure we are in the dootfiles directory so the build doesn't do screwey things.
# Do this by testing the presence of a random string guaranteed to be in this file.
if ! grep -q "IyEvYmluL2Jhc2gKCiMgTWF" build.sh; then
	echo "Must be in the dootfiles directory to run this script."
	exit 1
fi

# Resolves a relative path into an absolute one.
resolve() {
 	echo "$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
}

# TODO
fileNotLink() {}


# Install task
# Use build.sh install force to force overwriting
if [[ -z $1 || $1 == "install" ]]; then
	echo "Installing dootfiles to home..."

	# For each *.link file in dootfiles
	for LINE in $(find . -name *.link); do
		# This is the file to which the link points.
		LINKTGT=$(resolve $LINE)
		
		# This is the bare filename of the linkable.
		# E.g. shell/bashrc.link -> bashrc
		NAME=$(basename $LINE | sed 's/\.link$//')

		# This is the actual file of the link.
		LINKFILE=$(resolve ~)/.$NAME

		# If the linkfile is a directory, warn the user and skip.
		if [[ -d $LINKFILE ]]; then
			echo "Warning: ~/.$NAME is a directory! Skipping."
			continue
		fi
		
		# If the linkfile exists and is a regular file.
		# User can choose to skip, overwrite, or backup the existing file.
		if [[ $2 != "force" && -f $LINKFILE ]]; then
			echo "File already exists: ~/.$NAME"

			while true; do
				printf "[s]kip, [o]verwrite, [b]ackup? "
				read -n 1 CHAR && echo
				case $CHAR in
					s)  continue 2 # Break and continue on next linkable
						;;
					o)  break
						;;
					b)  mv $LINKFILE "${LINKFILE}.backup"
						break
						;;
				esac
			done

		fi

		# Link the file. The -f switch overwrites if $LINKFILE exists.
		ln -sf $LINKTGT $LINKFILE
	done

	echo "Done!"

elif [[ $1 == "uninstall" ]]; then
	echo "Removing dootfiles and restoring backups..."

	for LINE in $(find . -name *.link); do
		NAME=$(basename $LINE | sed 's/\.link$//')
		LINKFILE=$(resolve ~)/.$NAME
		BACKUPFILE="${LINKFILE}.backup"

		# Check if the linkfile is a symlink and remove.
		# TODO: Read the link destination and remove only if it points to dootfiles
		if [[ -L $LINKFILE ]]; then
			rm $LINKFILE
		fi

		# Restore the backup
		if [[ -f $BACKUPFILE ]]; then
			mv $BACKUPFILE $LINKFILE
		fi
	done

	echo "Done!"
fi
