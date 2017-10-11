#!/bin/bash

mkdir -p ~/.qcd
favourite_locations=~/.qcd/favourite_locations
touch "$favourite_locations"

usage() {
	echo "Usage:"
	echo "    qcd [-h|--help]                      Display this help message."
	echo "    qcd [-l|--list]                      List all bookmarked locations."
	echo "    qcd [-s|--save]                      Save current location to bookmarks."
	echo "    qcd [-d|--delete] <directory-name>   Deletes the specified directory from bookmarks."
	echo "    qcd <directory-name>                 Changes working directory to the specified bookmarked directory."
}

list() {
	cat $favourite_locations | cut -d ':' -f 2
}

save() {
	dir="$(pwd)"
	name=$(echo $dir | sed "s|[0-9A-Za-z/\-\_.\!@#$%^&*()+=]*/||g")
	echo "$dir:$name" >> $favourite_locations
}

delete() {
	sed -i "/$1/Id" $favourite_locations
}

first_arg="$1"
second_arg="$2"

if [[ ! -v first_arg ]]; then
	usage
elif [[ $first_arg == "--help"   ]] || [[ $first_arg == "-help"   ]] || [[ $first_arg == "-h" ]]; then
	usage
elif [[ $first_arg == "--list"   ]] || [[ $first_arg == "-list"   ]] || [[ $first_arg == "-l" ]]; then
	list
elif [[ $first_arg == "--save"   ]] || [[ $first_arg == "-save"   ]] || [[ $first_arg == "-s" ]]; then
	save
elif [[ $first_arg == "--delete" ]] || [[ $first_arg == "-delete" ]] || [[ $first_arg == "-d" ]]; then
	[[ -v second_arg ]] && delete "$second_arg" || usage
else
	echo $favourite_locations
	cd "$(cat $favourite_locations | grep -i $first_arg | cut -d ':' -f 1)"
fi









