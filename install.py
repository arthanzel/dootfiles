#!/usr/bin/env python

import os
import os.path as path
import shlex
import subprocess
import sys

# Resolves a path into an absolute path, replacing ~ with the user's home directory
def resolve(file):
    return path.abspath(path.expanduser(file))

def install(sourceFile, linkFile, force):
    subprocess.call(["python", "doot.py", "install", sourceFile, linkFile, force])

def uninstall(sourceFile, linkFile):
    subprocess.call(["python", "doot.py", "uninstall", sourceFile, linkFile])

# Make sure we're in the dootfiles directory by searching for a random string guaranteed to be in this file
try:
    if not 'CB7uY$90LFs&' in open('install.py').read():
        raise Exception()
except:
    print "install.py must be called from the dootfiles directory."
    sys.exit(1)

dootFile = path.expanduser("~/.dootfiles")
mode = sys.argv[1] if len(sys.argv) > 1 else ""
force = sys.argv[2] if len(sys.argv) > 2 else ""

# ~/.dootfiles contains the location of the dootfiles directory
if mode == "install":
    print "Instaling dootfiles..."
    with open(dootFile, "w+") as file:
        file.write(os.getcwd())
elif mode == "uninstall":
    print "Uninstalling dootfiles and restoring backups"
    if path.exists(dootFile):
        os.unlink(dootFile)
else:
    print "Usage: install.py install|uninstall|help"
    sys.exit(0)

# manifest.txt contains a list of scrips to run and files to link when installing the dootfiles
with open("manifest.txt") as manifestFile:
    for line in manifestFile.readlines():
        if line[0] == "#":
            # Lines starting with # are comments
            continue
        
        # shlex.split splits on whitespace, preserving quoted values, just like a shell
        tokens = shlex.split(line)
        
        if line[0] == "!" and len(tokens) > 1:
            # Lines starting with ! provide a script to be run
            # Call the script with the mode (install, uninstall) as the last parameter
            cmd = tokens[1:] + [mode] 
            subprocess.call(cmd, shell = True)
        elif len(tokens) == 2:
            # Lines with two tokens give the arguments to make a link i.e. `ln -s first-arg second-arg`
            sourceFile = resolve(tokens[0])
            linkFile = resolve(tokens[1])
            
            if mode == "install":
                install(sourceFile, linkFile, force)
            elif mode == "uninstall":
                uninstall(sourceFile, linkFile)

# Python can't source files :(
print "Done!"
if mode == "install":
    print "Run `source ~/.bashrc` to update your environment."
