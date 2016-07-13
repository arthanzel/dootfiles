#!/bin/bash

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

# For each *.link file in dootfiles
for LINE in $(find . -name *.link); do
	# This is the file to which the link points.
	LINKTGT=$(resolve $LINE)
	
	# This is the bare filename of the linkable.
	# E.g. shell/bashrc.link -> bashrc
	NAME=$(basename $LINE | sed 's/\.link$//')

	# This is the actual file of the link.
	LINKFILE=$(resolve ~)/.$NAME
	
	# If the link already exists, regardless of type.
	# User can choose to skip, overwrite, or backup the existing file.
	if [[ -e $LINKFILE ]]; then
		echo "File already exists: ~/.$NAME"

		while true; do
			printf "[s]kip, [o]verwrite, [b]ackup? "
			read -n 1 CHAR
			case $CHAR in
				s)  echo skip
					continue 2 # Break and continue on next linkable
					;;
				o)  echo overwrite
					break
					;;
				b)  echo backup
					mv $LINKFILE "${LINKFILE}.backup"
					break
					;;
				*) echo default;;
			esac
		done
	fi

	# Link the file. The -f switch overwrites if $LINKFILE exists.
	ln -sf $LINKTGT $LINKFILE
done

# Echo the quoted variable to preserve newlines. Not quoting replaces whitespace
# with a single space.
# Loop over every linkable and call process_linkable on it.
# echo "$LINKABLES" | while read line; do process_linkable $line; done
