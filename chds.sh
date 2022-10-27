#!/bin/bash

source auth.config

# Variables
tmp_file="index.tmp"

URL="https://bda.retroroms.info:82/downloads/mame/CHDs"
report_name='chd_list.txt' # CHD Folders inside URL Path

# Retrieve the CHD list
for CHD in $(cat $report_name) ; do

	# List the disk files (.chds) inside each CHD folder and download
	curl $URL/$CHD/ > $tmp_file

	for FILE_NAME in $( xmllint --html $tmp_file | grep -i \\.chd  | grep -o "title=\".*\"" | awk -F'"' '{ print $2 }' ) ; do
		wget -r -np -nc  --http-user=$username --http-password=$password -A chd $URL/$CHD/$FILE_NAME 
	done

done

rm -rf $tmp_file
