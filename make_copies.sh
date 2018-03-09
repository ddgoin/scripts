#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

timestamp=$(date +%F_%T)
dir=$(pwd)                   # dotfiles directory
olddir="$dir/backup/$timestamp"            # old dotfiles backup directory
copy_dirs="bin sbin"    # list of files/folders to copy in homedir

##########

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing scripts in $HOME"
mkdir -p $olddir

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir

# move any existing dotfiles in homedir to dotfiles_old directory, then copy files
for copy_dir in $copy_dirs; do
	echo "copying $copy_dir"
	if [[ -e "${HOME}/${copy_dir}" ]]; then
		echo "  backing up ${HOME}/${copy_dir} => ${OLDDIR}/${copy_dir}"
		mv $HOME/$copy_dir $olddir/$copy_dir
	fi
	mkdir $HOME/$copy_dir
	cp $dir/$copy_dir/* $HOME/$copy_dir/
done
