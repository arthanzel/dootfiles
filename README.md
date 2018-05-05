arthanzel does dootfiles
=====================
Hello! These are my dootfiles. There are many others like them, but these ones are mine.

If you're looking for a good place to start reading the code, `shell/bashrc.link` would be a good start.

Installation
------------
Dootfiles comes with a convenient installer. It writes dootfiles to your home directory and runs some arbitrary scripts. **Never use this tool if you do not trust the repository or its author**. Review all of the code if you have the slightest doubt of its authenticity. It's quite possible that your existing dotfiles will become lost forever.

`./install.py install` creates symlinks to all your dootfiles and adds a file called `.dootfiles` to your home folder with the location of this repo, so you can do a `cat ~/.dootfiles` to find it anytime. The environment variable `$DOOTFILES` defined in `shell/bashrc.sh` will also reflect this location.

The installer will prompt you to skip, overwrite, or backup existing files or links.

`./install.py uninstall` removes all symlinks and restores all backups, hopefully returning your home directory to what is was before. Again, non-dootfiles aren't changed.

The manifest
------------
`manifest.txt` contains instructions for the installer regarding which scripts to run and which links to make.

Using
-----
Clone the repo and make some changes.

While I tried to make my dootfiles as unopinionated as possible, a lot of it probably won't work for you out of the box. Read through `shell/bashrc.sh` to begin with.

MIT licensed
------------
Please use the code.
