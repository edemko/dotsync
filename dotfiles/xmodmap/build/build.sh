#!/bin/sh
set -e

HERE="$(dirname "$0")"
cd "$HERE"

cabal run build-xcompose -- \
  --inFile ../XCompose.d/xin/arrows.xin \
  --inFile ../XCompose.d/xin/astronomy.xin \
  --inFile ../XCompose.d/xin/diacritics.xin \
  --inFile ../XCompose.d/xin/greek.xin \
  --inFile ../XCompose.d/xin/latin.xin \
  --inFile ../XCompose.d/xin/lul.xin \
  --inFile ../XCompose.d/xin/math.xin \
  --inFile ../XCompose.d/xin/music.xin \
  --inFile ../XCompose.d/xin/other.xin \
  --inFile ../XCompose.d/xin/phonetic.xin \
  --inFile ../XCompose.d/xin/punctuation.xin \
  --inFile ../XCompose.d/xin/scripts.xin \
  --outDir ../XCompose.d
