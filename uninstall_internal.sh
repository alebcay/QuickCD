#!/bin/bash

########################################################################
# You should not directly execute this script. Run uninstall.sh instead.
########################################################################

# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "You should not directly execute this script. Run uninstall.sh instead." 1>&2
   exit 1
fi

user="$1"

#get user's home directory
if [ $user = "root" ]; then
	home="/root"
else
	home="/home/$user"
fi

if [[ $2 == "--purge" ]]; then
	rm -rf $home/.qcd
fi

#deletes the qcd function out of .bashrc
sed -i "/qcd() {/,/}/d" $home/.bashrc

if rm /usr/local/bin/qcd.sh; then
	echo "Uninstalled successfully!"
else
	echo "Something went wrong; most probably some of the installed files were missing. I removed what I could find."
fi
