arthanzel does dootfiles
=====================
Hello! These are my dootfiles. There are many others like them, but these ones are mine.

This is a rather new repo and I'm still in the process of consolidating everything on my many development machines, so I'll be adding dootfiles quite often. Until then, do not be alarmed if the repo seems empty. There's still some neat stuff, especially in the `shell` folder.

Most files are written in Bash, which can be quite cryptic. But don't worry - most files are liberally commented.

If you're looking for a good place to start reading the code, `shell/bashrc.link` would be a good start.


Installation
------------
Dootfiles comes with a convenient installer. It writes dootfiles to your home directory and runs some arbitrary scripts. **Never use this tool if you do not trust the repository or its author.** Review all of the code if you have the slightest doubt of its authenticity.

`./install.sh` creates symlinks to all your dootfiles and adds a file called `.dootfiles` to your home folder with the location of this repo, so you can do a `cat ~/.dootfiles` to find it anytime. The environment variable `$DOOTFILES` defined in `shell/bashrc.link` will also reflect this location.

The installer will prompt you to skip, overwrite, or backup existing files. Symlinks pointing outside of dootfiles will never be touched. So if you have a non-doot dotfile link that points elsewhere, it's safe.

`./install.sh uninstall` removes all symlinks and restores all backups, hopefully returning your home directory to what is was before. Again, non-dootfiles aren't changed.

The installer also supports post-install hooks with *.post.sh scripts. See the next section for more information.

Post-install hooks
------------------
Files ending in `.post.sh` will be executed after the installer has finished linking all dootfiles. They are given one argument: `install` or `uninstall`. They do what you expect them to.

Post-install scripts are run *from the dootfiles directory*, the same one that contains `install.sh` and this README. The install script sources the `.bashrc` before running post-install hooks, so they also have access to all your custom bash goodness. Don't forget to export functions if you want them available!

You can invoke the post-install scripts without running the whole install process with `./install.sh postinstall install` or `./install.sh post uninstall`.

Where (the wild) things are
----------------
- **bin/** : This directory will be added to the `$PATH` via `.bashrc`.
- **\*.fn.sh** : These files will be automatically sourced by `.bashrc` first. Put any prerequisite functions or logic here.
- **topic/*.fn.sh** : These files will be automatically sourced by `.bashrc`. Use these to set up topic-related functions, aliases, etc. **Achtung!** These files are sourced in series, and many files will slow down the startup of the shell.
- **\*.link** or **topic/*.link** : These will be symbolically linked to your home folder. No need to put a dot in front of these. The dot will be added for you.
- **\*.post.sh** or topic/*.post.sh** : These are post-install scripts that are run after the installer has finished doing its thing. See the **Post-install hooks** section for more info.

Using
-----
Clone the repo and make some changes.

While I tried to make my dootfiles as unopinionated as possible, a lot of it probably won't work for you out of the box. Read through `shell/bashrc.link` to begin with.

MIT licensed
------------
Please use the code.
