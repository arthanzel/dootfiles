#!/usr/bin/env python

import os
import os.path as path
import sys

mode = sys.argv[1] # install/uninstall
sourceFile = sys.argv[2] # File the link points to
linkFile = sys.argv[3] # File that is the symbolic link

# Should the user be asked to skip/overwrite/backup when making a link?
def shouldPrompt(file):
    # Prompt only if the linkFile exists and does not point to the dootfile, and we are not forcing.
    force = True if len(sys.argv) > 4 and sys.argv[4] == "force" else False
    linkFile = sys.argv[3]

    return path.lexists(linkFile) and not path.realpath(file) == sourceFile and not force

# Reads a character from stdin, and doesn't wait for a newline
def getch():
    # By chao787 at https://gist.github.com/chao787/2652257
    import sys, tty, termios
    fd = sys.stdin.fileno()
    old_settings = termios.tcgetattr(fd)
    try:
        tty.setraw(sys.stdin.fileno())
        ch = sys.stdin.read(1)
    finally:
        termios.tcsetattr(fd, termios.TCSADRAIN, old_settings)
        return ch

if mode == "install":
    if os.path.isdir(linkFile):
        print "Skipping:", linkFile, "is a directory!"
        sys.exit(0)

    if shouldPrompt(linkFile):
        print "File already exists:", linkFile
        while True:
            print "[s]kip, [o]verwrite, [b]ackup?"
            char = getch()
            print char
            if char == "s":
                sys.exit(0)
            elif char == "o":
                break
            elif char == "b":
                backupFile = linkFile + ".backup"
                if (path.lexists(backupFile)):
                    # This really shouldn't happen unless the user screws with the files,
                    # but removing the backup file prevents errors which leave the dotfiles in
                    # an unknown state.
                    os.unlink(backupFile)
                os.rename(linkFile, linkFile + ".backup")
                break
        
    # Make the link
    print "Linking", linkFile, "->", sourceFile
    if path.lexists(linkFile):
        # lexists returns True for broken symbolic links, unlike exists
        os.unlink(linkFile)
    os.symlink(sourceFile, linkFile)

elif mode == "uninstall":
    if not path.lexists(linkFile):
        print "File doesn't exist:", linkFile
        sys.exit(0)

    # Only uninstall if the link points to where it should be
    # This prevents accidentally removing non-doot files or links
    linkTarget = path.realpath(linkFile)
    if linkTarget == sourceFile:
        print "Removing", linkFile
        os.unlink(linkFile)

        backupFile = linkFile + ".backup"
        if (path.lexists(backupFile)):
            print "Restoring", backupFile
            os.rename(backupFile, linkFile)
    else:
        print "Skipping:", linkFile, "is not a dootfile link."
