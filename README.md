# dotsync

Sync your dotfiles (or other utilities) using only:

  * ~100 sloc of POSIX sh as a framework
  * a folder for each set of dotfiles
  * a configuration file for each box you manage that has one folder name per line

Seriously, it doesn't take much to do this stuff.


## Usage

Use `bin/dotsync [BASE DIR]`, or make sure `bin/` is on your `PATH` and call simpy as `dotsync`.
The base dir should contain `boxen/` and `dotfiles/` (e.g. it could just point to this repository).
If it is omitted, then it defaults to `~/dotsync`.

You can also `source bin/dotfuncs`, and then call the functions `dotup`, `dotdown`, and `dotsync` manually (but why?).
Thankfully, there's only \~50 sloc in there, so go read the implementation as "documentation".


### Configuration

You may place a number of text files under `boxen/`.
The framework finds `boxen/$(hostname)`, so the file used for your machine is the one with the same name as the host.
These are configs, and come in two flavors---host configs and base configs---which are distinguished by how dotsync finds them, but are otherwise identical.
By convention, included configs should be named in all-caps.

Each line of a host/base config is a command indicating one or more modules to be installed/uninstalled.
See "Writing Dotfiles" coming up next for what a "module" is.
Blank lines, and those starting with `#` are ignored.
Normally, a line names a module to be installed.
If, however, the line starts with `!`, that module is uninstalled.
Lines beginning with `+` include all the directives from the named base config.
If a module/base config doesn't exist, then a warning is emitted, but otherwise the framework carries on installing all the modules it can find.
Thanks to my not being able to get IFS to work as expected, and `read` being silly as usual, apparently we can't have nice things, like any whitespace on the lines.

### Writing Dotfiles

The `dotfiles/` folder should only contain directories.
These are what I'm calling "modules".
Each module name here is what is referenced by the `boxen/*` configuration files.

Each module should have a file `install.sh`.
This file should define four functions:
  * `dotsync_depsgood` --- check that the dotfiles make sense on the system (i.e. don't install X11-related dotfiles if there isn't an X11 install on the system)
  * `dotsync_newest` --- check if the current install is up-to-date with what the module expects
  * `dotsync_setup` --- install from a fresh state
  * `dotsync_teardown` --- uninstall without fail, even if the module isn't currently installed

There's a script `lint.sh` that checks that the scripts in `dotfiles/` are written in particularly safe ways.
(Atm, this just means parameters substitution is always in brackets, and echos are always to stderr.)
