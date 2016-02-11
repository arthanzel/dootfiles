arthanzel's dootfiles
=====================

Installation
------------
`rake install` creates symlinks to all your dotfiles and adds a file called `.dootfiles` to your home folder with the location of this repo, so you can do a `cat ~/.dootfiles` to find it anytime. The environment variable `$DOOTFILES` defined in `shell/bashrc.link` will also reflect this location.

Where things are
----------------
- **bin/** : This directory will be added to the `$PATH` via `.bashrc`.
- **fn/*.sh** : These files will be automatically sourced by `bashrc`. Put your commonly-used functions, aliases, and setup here. **Achtung!** These files are sourced in series, and many files will slow down the startup of the shell.
- **\*.link** or **topic/*.link** : These will be symbolically linked to your home folder. No need to put a dot in front of these. The dot will be added for you.

MIT license
-----------
Please use the code.
