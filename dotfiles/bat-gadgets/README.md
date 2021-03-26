# Bat Gadgets

There are a number of things I find useful to have on the command line.
For my own tools, I've tried to reduce the dependencies to just plain sh/bash so that they'll be easily-installed without root access.

  * `tree` for looking at directory trees
  * `lolcat` for fun
  * [`technicolor`](https://github.com/Zankoku-Okuno/technicolor) for colorizing
  * `gitstat` (see below)


## `gitstat`

Check if a git repository has been fetched since midnight today
    (recall: midnight is the first moment of the day, not the last).
Alternately, pass a `-d` argument to specify a different time reference
    using the same language from `date`.
If no repo is given, then check the present working directory.

E.g. `gitstat -d'15 min ago' ../other-project` exits successfully if and only
    if `../other-project` is a git repository which had been fetched within
    the last 15 minutes.
E.g. `gitstat` is equivalent to `gitstat -d'00:00 today' .`.
