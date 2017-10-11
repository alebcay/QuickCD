#!/bin/bash

mkdir -p ~/.qcd
favourite_locations=~/.qcd/favourite_locations
touch "$favourite_locations"

# Transform long options to short ones
for arg in "$@"; do
  shift
  case "$arg" in
    "--help")   set -- "$@" "-h" ;;
    "-help")    set -- "$@" "-h" ;;
    "--list")   set -- "$@" "-l" ;;
    "-list")    set -- "$@" "-l" ;;
    "--save")   set -- "$@" "-s" ;;
    "-save")    set -- "$@" "-s" ;;
    "--delete") set -- "$@" "-d" ;;
    "-delete")  set -- "$@" "-d" ;;
    *)          set -- "$@" "$arg"
  esac
done

# Parse options to the `pip` command
while getopts ":hlsd" opt; do
  case ${opt} in
    h )
      echo "Usage:"
      echo "    qcd [-h|--help]                      Display this help message."
      echo "    qcd [-l|--list]                      List all bookmarked locations."
      echo "    qcd [-s|--save]                      Save current location to bookmarks."
      echo "    qcd [-d|--delete] <directory-name>   Deletes the specified directory from bookmarks."
      echo "    qcd <directory-name>                 Changes working directory to the specified bookmarked directory."
      exit 0
      ;;
    l )
      # list
      cat $favourite_locations | cut -d ':' -f 2
      exit 0
    ;;
    s )
      # save
      dir="$(pwd)"
	  name=$(echo $dir | sed "s|[0-9A-Za-z/\-\_.\!@#$%^&*()+=]*/||g")
	  echo "$dir:$name" >> $favourite_locations
	  exit 0
    ;;
    d )
      # delete
      echo "$2"
      sed -i "/$2/Id" $favourite_locations
      exit 0
    ;;
   \? )
     echo "Invalid option: $OPTARG" 1>&2
     exit 1
     ;;
  esac
done
shift $((OPTIND -1))

echo "$1"
cd "$(cat $favourite_locations | grep -i $1 | cut -d ':' -f 1)"
