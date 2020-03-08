#!/bin/bash

## open new file, or add entry to new file
zk() {
	DIR="/home/mkaz/Documents/Notes/Zettelkasten/"
	FILE=$(date +"%Y%m%d%H%M%S").md

	TEXT="$@"
	cd $DIR

	if [ -n "$TEXT" ]; then
		echo "$TEXT" >> $FILE
	else
		vim '+normal G$' ${FILE}
	fi
}

## change to directory
zkcd() {
	cd /home/mkaz/Documents/Notes/Zettelkasten/
}

## pipe to new file
zkp() {
	DIR="/home/mkaz/Documents/Notes/Zettelkasten/"
	FILE=$(date +"%Y%m%d%H%M%S").md
	STDIN=$(cat -)
	echo $STDIN >> ${DIR}${FILE}
}
