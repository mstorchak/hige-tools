#!/bin/bash
[ "$1" ] || exit 0
mkdir ./$1
#mv *$1* ./$1
#mv ~/download/*$1* ./$1
find . -maxdepth 1 -iname "*$1*" -exec mv \{\} $1 \;
find . -maxdepth 1 -iname "~/download/*$1*" -exec mv \{\} $1 \;
#
find ./$1 -type f  \( -iname "*.avi" -o -iname "*.mkv" -o -iname "*.ogm" -o -iname "*.mp4" -o -iname "*.wmv" \) -print  |
 while read line; do echo -n "$line... "; md5sum < "$line" | cut -d" " -f 1 >  "$line.md5"; cat "$line.md5"; done
