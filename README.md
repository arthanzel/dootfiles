arthanzel does ddotfiles
=====================
These are my dootfiles. There are many others like them, but these ones are mine.

This is a rather new repo and I'm still in the process of consolidating everything on my many development machines, so I'll be adding dootfiles quite often. Until then, do not be alarmed if the repo seems empty. There's still some neat stuff, especially in the `shell` folder.

Installation
------------
`rake install` creates symlinks to all your ddotfiles and adds a file called `.dootfiles` to your home folder with the location of this repo, so you can do a `cat ~/.dootfiles` to find it anytime. The environment variable `$DOOTFILES` defined in `shell/bashrc.link` will also reflect this location.

The installer will prompt you to skip, overwrite, or backup existing files.

`rake uninstall` removes all symlinks and restores all backups, hopefully returning your home directory to what is was before.

Where things are
----------------
- **bin/** : This directory will be added to the `$PATH` via `.bashrc`.
- **\*.fn.sh** or **topic/*.fn.sh** : These files will be automatically sourced by `bashrc`. Put your commonly-used functions, aliases, and setup here. **Achtung!** These files are sourced in series, and many files will slow down the startup of the shell.
- **\*.link** or **topic/*.link** : These will be symbolically linked to your home folder. No need to put a dot in front of these. The dot will be added for you.

Using
-----
Clone the repo and make some changes.

While I tried to make my dootfiles as unopinionated as possible, a lot of it probably won't work for you out of the box. Read through `shell/bashrc.link` to begin with.

MIT licensed
------------
Please use the code.

Todo
----
- Add a facility to source OSX-specific files on OSX because Apple is stupid for doing things Their Own Way&trade;
