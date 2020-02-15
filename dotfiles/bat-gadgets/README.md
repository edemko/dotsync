# Bat Gadgets

There are a number of things I find useful to have on the command line.

  * `tree` for looking at directory trees
  * [`technicolor`](https://github.com/Zankoku-Okuno/technicolor) for colorizing
  * `lolcat` for fun
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
