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
		if [ -f "$line.md5" ]; then
			echo skipped
		else
			trap "rm \"$line.md5\"" 0
			touch "$line.md5"
			md5sum < "$line" | cut -d" " -f 1 >  "$line.md5"
			trap - 0
			cat "$line.md5"
		fi
	done

