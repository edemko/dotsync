#!/bin/sh
set -e

pdflatex -halt-on-error @@@NAME@@@.tex
biber @@@NAME@@@
pdflatex -halt-on-error @@@NAME@@@.tex
