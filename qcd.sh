#!/bin/bash

handle_options() {
local OPTIND

mkdir -p ~/.qcd
favourite_locations=~/.qcd/favourite_locations
touch "$favourite_locations"

local OPTIND

echo "$@"
# Parse options to the `pip` command
while getopts ":hlsd:" opt; do
  case $opt in
    h )
      echo "Usage:"
      echo "    qcd [-h|--help]                      Display this help message."
      echo "    qcd [-l|--list]                      List all bookmarked locations."
      echo "    qcd [-s|--save]                      Save current location to bookmarks."
      echo "    qcd [-d|--delete] <directory-name>   Deletes the specified directory from bookmarks."
      echo "    qcd <directory-name>                 Changes working directory to the specified bookmarked directory."
      ;;
    l )
      # list
      echo list
      cat $favourite_locations | cut -d ':' -f 2
    ;;
    s )
      # save
      echo save
      dir="$(pwd)"
	  name=$(echo $dir | sed "s|[0-9A-Za-z/\-\_.\!@#$%^&*()+=]*/||g")
	  echo "$dir:$name" >> $favourite_locations
    ;;
    d )
      # delete
      echo delete
      echo "$OPTARG"
      sed -i "/$OPTARG/Id" $favourite_locations
    ;;
   \? )
     echo "Invalid option: $OPTARG" 1>&2
     ;;
  esac
done

location=$1
[[ ! -v location ]] && cd "$(cat $favourite_locations | grep -i $1 | cut -d ':' -f 1)"

}

handle_options "$@"
