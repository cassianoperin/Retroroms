#!/bin/bash

# The list is the output of Romcenter 4 Miss report with unchecked disks, samples and description

## To add a the password to Mac Keychain
# security add-generic-password -T "" -a $LOGNAME -l Retroroms -s <username> -w
source auth.config

# Variables
tmp_file="index.tmp"
URL="https://bda.retroroms.info:82/downloads/mame/"
report_name="romcenter_report_missing_roms.txt"

# List the main download folder to find the current FULL roms folder
curl $URL > $tmp_file
URI=$( xmllint --html $tmp_file | grep full | grep -o "title=\".*\"" | cut -d '"' -f2 )

# Process the Romcenter MISS roms report
dos2unix $report_name

for FILE_NAME in $( cat $report_name | grep -Ev '^$|^//' | sed 's/$/.zip/g' ) ; do
	wget -r -np -nc --timeout=3  -t 1 --http-user=$username --http-password=$password -A zip $URL/$URI/$FILE_NAME
done

rm -rf $tmp_file
