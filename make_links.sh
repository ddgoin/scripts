#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

timestamp=$(date +%F_%T)
dir=$(pwd)                   # dotfiles directory
olddir="$dir/backup/$timestamp"            # old dotfiles backup directory
files="bin sbin"    # list of files/folders to symlink in homedir

##########

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing scripts in $HOME"
mkdir -p $olddir

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
for file in $files; do
	echo " $file:"
	if [[ -f "$HOME/$file" ]]; then
		echo "   backing up old file"
		mv $HOME/$file $olddir
	fi
	echo "   creating symlink"
	ln -sf $dir/$file $HOME/$file
done
