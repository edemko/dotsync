#!/bin/bash

# I don't really care about login vs. non-login shells.
# http://www.joshstaiger.org/archives/2005/07/bash_profile_vs.html
# this might screw up scp if bashrc produces any output, but sftp is more recommended anyway
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
