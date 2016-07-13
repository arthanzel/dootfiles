#!/bin/bash

process_linkable() {
    FILENAME="${'foobar.link'/'.link'/'foo'}"

}

# Get a list of all linkables
LINKABLES=$(find . -name *.link)

# Echo the quoted variable to preserve newlines. Not quoting replaces whitespace
# with a single space.
# Loop over every linkable and call process_linkable on it.
echo "$LINKABLES" | while read line; do process_linkable $line; done
