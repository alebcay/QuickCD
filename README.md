# QuickCD
Bookmark locations that you visit frequently in your terminal!

## Installation
* Clone this repo: `git clone https://github.com/lordadamson/QuickCD`
* cd into it: `cd QuickCD`
* Run the installation script: `./install.sh`
* Source your .bashrc: `source ~/.bashrc`

## Usage
#### `qcd --save`
`cd` into any of the locations that you use frequently. let's say it's located in `~/projects/horse-fly/` and then run: `git --save` or you could just run `qcd -s`.

#### `qcd <bookmarked-location>`
Now your location has been saved and you can get back to it easily. so let's say you open your terminal and the default working directory is `~`, you can simply run `qcd horse` and it's gonna take you to `~/projects/horse-fly/`. Neat huh? Notice that you didn't have to specify the whole directory name, you just typed a part of the name that is distinguishable from other bookmarked locations.

#### `qcd --list`
You can list all of your bookmarked directories by: `qcd [-l|--list]`

#### `qcd --delete <bookmarked-location>`
You can remove a bookmark by: `qcd [-d|--delete] horse`

## TODO:
* [ ] Create Debian package.
* [ ] Create RPM Package.
* [ ] Create Arch Package.
* [ ] Add a purge option to the `uninstall.sh` that deletes the `~/.qcd` directory.
