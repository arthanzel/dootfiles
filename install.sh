#!/bin/bash

# Make sure we are in the dootfiles directory so the build doesn't do screwey things.
# Do this by testing the presence of a random string guaranteed to be in this file.
if ! grep -q "IyEvYmluL2Jhc2gKCiMgTWF" install.sh; then
	echo "Must be in the dootfiles directory to run this script."
	exit 1
fi
CURDIR=$(pwd)

source "install-functions.sh"

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

		if [[ $2 == "force" ]]; then
			dootinstall "$LINKTGT" "$LINKFILE" force
		else
			dootinstall "$LINKTGT" "$LINKFILE"
		fi
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
		dootuninstall "$LINKFILE"
	done

	postinstall "uninstall"

	echo "Done!"

elif [[ $1 == "post" ]]; then
	postinstall "$2"
fi
