#!/bin/sh

src="$dotdir"
systarget="$HOME/.local/share/fonts"
humantarget="$HOME/Fonts"

basenames='EexprReferenceMono SourceCodePro ComicNeue unifont'

fonts=""
for font in $basenames; do
  for ext in otf ttf woff woff2; do
    fonts="$fonts $font/$font.$ext"
    for style in Regular Bold It; do
      fonts="$fonts $font/$font-$style.$ext"
    done
  done
done

dotsync_depsgood() { return 0; }

dotsync_newest() {
  [ -d "$systarget" ] || return 1
  [ -d "$humantarget" ] || return 1
  ret=0
  for font in $fonts; do
    if [ -e "$src/$font" ]; then
      diff -q "$src/$font" "$systarget/$font" || ret=1
    fi
  done
  return $ret
}

dotsync_setup() {
  # make sure the target directories exist
  if [ ! -e "$systarget" ] && [ ! -e "$humantarget" ]; then
    mkdir "$systarget"
    ln -svf "$systarget" "$humantarget"
  elif [ ! -e "$systarget" ]; then
    [ -d "$humantarget" ] || return 1
    ln -svf "$humantarget" "$systarget"
  elif [ ! -e "$humantarget" ]; then
    [ -d "$systarget" ] || return 1
    ln -svf "$systarget" "$humantarget"
  fi
  # now we copy fonts
  for font in $fonts; do
    if [ -e "$src/$font" ]; then
      mkdir -p "$(dirname "$systarget/$font")"
      ln -svf "$src/$font" "$systarget/$font"
    fi
  done
}

dotsync_teardown() {
    [ -L "${humantarget}" ] && rm -v "${humantarget}"
    return 0
}
