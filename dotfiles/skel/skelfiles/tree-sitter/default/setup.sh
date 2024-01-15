#!/bin/bash
set -e

# Whenever you're about to work on a tree sitter grammar,
# source this script from the root of your parser project.
#
# It will:
# 1) set up the npm environment if needed
# 2) put the tree-sitter cli on the PATH if it isn't there already

if [ ! -f package.json ]; then
  echo >&2 "setting up npm environment"
  npm init
  npm install --save nan
  npm install --save-dev tree-sitter-cli
  echo >&2 "npm environment complete"
fi

if ! echo ":${PATH}:" | grep -q ":$PWD/node_modules/.bin/:"; then
  export PATH="${PATH}:$PWD/node_modules/.bin/"
  echo >&2 "tree-sitter is now on the path"
else
  echo >&2 "tree-sitter is already on the path"
fi
