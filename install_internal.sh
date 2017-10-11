#!/bin/bash

########################################################################
# You should not directly execute this script. Run install.sh instead.
########################################################################

# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "You should not directly execute this script. Run install.sh instead." 1>&2
   exit 1
fi

user=$1
script_directory="$2"

# Get user's home directory
if [ $user = "root" ]; then
	home="/root"
else
	home="/home/$user"
fi

mkdir -p $home/.qcd
chown $user:$user $home/.qcd

cat $script_directory/bashrc >> $home/.bashrc

cp $script_directory/qcd.sh /usr/local/bin/

if [[ $? == 0 ]]; then
	echo "Success"
	echo "To be able to use qcd run:"
	echo "$ source ~/.bashrc"
	echo "Have a nice day :D"
else
	echo "something went wrong :("
fi
