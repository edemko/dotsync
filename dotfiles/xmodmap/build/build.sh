#!/bin/sh
set -e

HERE="$(dirname "$0")"
cd "$HERE"

cabal run build-xcompose -- \
  --inFile ../XCompose.d/xin/arrows.xin \
  --inFile ../XCompose.d/xin/astronomy.xin \
  --inFile ../XCompose.d/xin/circles.xin \
  --inFile ../XCompose.d/xin/diacritics.xin \
  --inFile ../XCompose.d/xin/emoji.xin \
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

cd '../XCompose.d/xin'
echo '# -*- coding: utf-8; mode: conf -*-' >../../XCompose
echo 'include "%H/.XCompose.d/tmp/en_US-scavenged.xcompose"' >>../../XCompose
echo '' >>../../XCompose
for f in *.xin; do
  echo 'include "%H/.XCompose.d/'"${f%.xin}"'.xcompose"' >>../../XCompose
done