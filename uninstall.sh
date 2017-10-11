#!/bin/bash

# get the path of the script
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
script_directory="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

user="$(whoami)"

if [[ $1 == "--purge" ]]; then
	purge="--purge"
fi

sudo $script_directory/uninstall_internal.sh "$user" $purge
