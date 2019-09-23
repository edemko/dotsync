# Shell Profiles

It honestly pisses me off that people use `sh` to mean `bash`.
They aren't the same language, no more than C means C++.
Get it together people.

To that end, I want my dotfiles for Bourne Shell to be completely ignorant of Bash.
If there's a picture next to the dictionary entry of "reducing complexity", that should be it.
Configuring `sh` should not require also configuring some `bash` stuff.

Conversely, if Bash is meant to be an extension of Bourne Shell, then when Bash sets itself up, it should make use of the user's Bourne Shell configuration.
That is, configuring `bash` means recognizing `sh` as a thing that it relies on, and not only for its history.


# Login vs Non-login

It seems that `.bashrc` is run each time you type `bash` at the prompt, but `.profile` and `.bash_profile` are run only once on startup.
The idea is that the profiles configure the system, whereas the rc file configures one particular shell.
So what is all this stuff in my bashrc, and should it actually be there, or is it more like system configuration?
It also raises the question of why I need a separate Bash profile when the profile sets up the system rather than any particular shell.
