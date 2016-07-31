#!/bin/bash

# Make sure we are in the dootfiles directory so the build doesn't do screwey things.
# Do this by testing the presence of a random string guaranteed to be in this file.
if ! grep -q "IyEvYmluL2Jhc2gKCiMgTWF" install.sh; then
	echo "Must be in the dootfiles directory to run this script."
	exit 1
fi
CURDIR=$(pwd)

# Resolves a relative path into an absolute one.
resolve() {
 	echo "$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
}

# Outputs the path to which a link points. If the given file is not a link, outputs blank.
getLinkTarget() {
	echo $(readlink $1)
}

# Determines if a given file is a dootfile-created link.
isDootfileLink() {
	if [[ -L $1 && "$(getLinkTarget $1)" == "${CURDIR}"* ]]; then return 0; else return 1; fi
}

# Runs post-install hooks.
# See the README for info.
postinstall() {
	# Run custom install hooks
	for FILE in $(find . -name *.post.sh); do
		echo "Running postinstall for $FILE..."

		if [[ ! -x "$FILE" ]]; then chmod +x "$FILE"; fi
		"$FILE" $1
	done
}

# Install task
# Use build.sh install force to force overwriting
if [[ -z $1 || $1 == "install" ]]; then
	echo "Installing dootfiles to home..."

	# ~/.dootfiles holds the location of the dootfiles repo.
	echo $(pwd) > ~/.dootfiles

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
		if [[ $2 != "force" && -f $LINKFILE ]] && ! isDootfileLink $LINKFILE; then
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

	source ~/.bashrc
	postinstall "install"

	echo "Done!"

elif [[ $1 == "uninstall" ]]; then
	echo "Removing dootfiles and restoring backups..."

	if [[ -f ~/.dootfiles ]]; then
		rm ~/.dootfiles
	fi

	for LINE in $(find . -name *.link); do
		NAME=$(basename $LINE | sed 's/\.link$//')
		LINKFILE=$(resolve ~)/.$NAME
		BACKUPFILE="${LINKFILE}.backup"

		# Check if the linkfile is a symlink and remove.
		if isDootfileLink $LINKFILE; then
			rm $LINKFILE

			# Restore the backup
			if [[ -f $BACKUPFILE ]]; then
				mv $BACKUPFILE $LINKFILE
			fi
		fi
	done

	postinstall "uninstall"

	echo "Done!"

elif [[ $1 == "post" ]]; then
	postinstall "$2"
fi
