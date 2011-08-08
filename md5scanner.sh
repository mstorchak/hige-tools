#!/bin/bash
[ "$1" ] && where="$@" || where=.
ext_list="avi mkv ogm mp4 wmv"
tmp=""
for i in $ext_list; do
	tmp="$tmp -iname *.$i -o"
done
tmp=$(sed -e 's/ -o$//'<<<$tmp)
set -f
find $where -type f  \( $tmp \) -print \
	| while read line; do
		echo -n "$line... "
		hashfile="$line.md5"
		if [ -f "$hashfile" ]; then
			echo skipped
		else
			trap "rm \"$hashfile\"" 0
			touch "$hashfile"
			md5sum < "$line" | cut -d" " -f 1 >  "$hashfile"
			trap - 0
			cat "$hashfile"
		fi
	done
