#!/bin/bash

# Need an exported report from Romcenter (Miss CHDs)

# Variables
URL="https://bda.retroroms.info:82/downloads/mame/CHDs"
report_name='chds_miss.txt' # CHD Folders inside URL Path
username=''
password=''


# Retrieve the CHD list
for CHD in $(cat $report_name) ; do

	# List the rom files (.rar) inside CHD folder and download
	for FILE_NAME in $(curl $URL/$CHD/ | grep -i rar | cut -d' ' -f3 | cut -d '"' -f2 ) ; do
		wget -r -np -nc  --http-user=$username --http-password=$password -A rar $URL/$CHD/$FILE_NAME 
	done

done
