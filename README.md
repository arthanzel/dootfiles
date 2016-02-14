arthanzel does dotfiles
=====================
These are my dotfiles. There are many others like them, but these ones are mine.

Installation
------------
`rake install` creates symlinks to all your dotfiles and adds a file called `.dootfiles` to your home folder with the location of this repo, so you can do a `cat ~/.dootfiles` to find it anytime. The environment variable `$DOOTFILES` defined in `shell/bashrc.link` will also reflect this location.

The installer will prompt you to skip, overwrite, or backup existing files.

`rake uninstall` removes all symlinks and restores all backups, hopefully returning your home directory to what is was before.

Where things are
----------------
- **bin/** : This directory will be added to the `$PATH` via `.bashrc`.
- **\*.fn.sh** or **topic/*.fn.sh** : These files will be automatically sourced by `bashrc`. Put your commonly-used functions, aliases, and setup here. **Achtung!** These files are sourced in series, and many files will slow down the startup of the shell. Files in the root will be sourced first, so if you have files that depend on other files, put the prereqs in the root.
- **\*.link** or **topic/*.link** : These will be symbolically linked to your home folder. No need to put a dot in front of these. The dot will be added for you.

MIT licensed
------------
Please use the code.

Todo
----
- Add a facility to source OSX-specific files on OSX because Apple is stupid for doing things Their Own Way&trade;
