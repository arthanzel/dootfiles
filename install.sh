#!/bin/bash

# Make sure we are in the dootfiles directory so the build doesn't do screwey things.
# Do this by testing the presence of a random string guaranteed to be in this file.
if ! grep -q "IyEvYmluL2Jhc2gKCiMgTWF" install.sh; then
	echo "You must be in the dootfiles directory to run this script."
	exit 1
fi

DOOTFILES="$(pwd)"
echo "Dootfiles directory is $DOOTFILES"
echo

# Helper functions for the install process
source "install-functions.sh"

# Finds all files in the dootfiles directory that shall be linked.
findLinkFiles() {
	echo $(find "$(pwd)" \( -name *.link -o -name *.link.* \) )
}

# Runs post-install hooks.
# See the README for info.
postinstall() {
	# Run custom install hooks
	for FILE in $(find "$(pwd)" -name *.post.sh); do
		echo "Running postinstall for $FILE..."

		if [[ ! -x "$FILE" ]]; then chmod +x "$FILE"; fi
		
		# Run the file from its own directory in a subshell
		(cd $(dirname "$FILE") && "$FILE" "$1")
	done
}

# Install task
# Use install.sh install force to force overwriting
if [[ $1 == "install" ]]; then
	echo "Installing dootfiles..."

	# ~/.dootfiles holds the location of the dootfiles repo.
	echo "$DOOTFILES" > ~/.dootfiles

	# For each *.link file in dootfiles (absolute paths)
	for FILE in $(findLinkFiles); do
		# End result: ~/.$LINKFILE will point to $FILE.
		NAME="$(dootBasename "$FILE")"
		LINKFILE=$(resolve ~)/.$NAME

		echo "Linking $LINKFILE"
		if [[ $2 == "force" ]]; then
			dootinstall "$FILE" "$LINKFILE" force
		else
			dootinstall "$FILE" "$LINKFILE"
		fi
	done

	# Allow postinstall scripts to access bashrc goodness
	source ~/.bashrc
	postinstall "install"

	echo "Done!"

elif [[ $1 == "uninstall" ]]; then
	echo "Removing dootfiles and restoring backups..."

	if [[ -f ~/.dootfiles ]]; then
		rm ~/.dootfiles
	fi

	for FILE in $(findLinkFiles); do
		NAME="$(dootBasename "$FILE")"
		LINKFILE=$(resolve ~)/.$NAME
		echo "Removing $LINKFILE"
		dootuninstall "$LINKFILE"
	done

	postinstall "uninstall"

	echo "Done!"

elif [[ $1 == "post" && -n $2 ]]; then
	postinstall "$2"

# Prints a help message
else
	echo -e \
"""Usage:
	doot [command]

Commands:
	install        Installs dootfiles by symlinking to ~ and runs
	               post-install hooks.
	uninstall      Unlinks dootfiles and optionally restores files.
	post [target]  Runs only post-install scripts for the given target.
	help           Shows this help message.
"""
fi
