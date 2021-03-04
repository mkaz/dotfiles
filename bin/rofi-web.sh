#!/usr/bin/bash

# Requires shyaml
# python3 -m pip install shyaml

YML_FILE="/home/mkaz/dotfiles/bin/rofi-web.yml"

## Check if parameter passed in
if [ -n "$1" ]
then
	# parse param into key/value
	key=${1%%\ *}
	val=${1:$((${#key}+1))}
	url=$(cat $YML_FILE | shyaml get-value $key)
	xdg-open "${url}${val}"
	exit 0
fi

# # show menu
# for key in ${!ENGINES[@]}
# do
# 	echo "$key ${ENGINES[$key]}"
# done

cat $YML_FILE | shyaml keys
