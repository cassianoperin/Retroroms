#!/bin/bash

# The list is the output of Romcenter 4 Miss report with only the disk option selected

## To add a the password to Mac Keychain
# security add-generic-password -T "" -a $LOGNAME -l Retroroms -s <username> -w

source auth.config

# Variables
tmp_file="index.tmp"
tml_folder="CHDs"
report_name="romcenter_report_miss_chds.txt"
URL="https://bda.retroroms.info:82/downloads/mame/CHDs/"
wget_options="-r --no-parent -nH --cut-dirs=2 --timeout=5 -t 1"
wget_reject='*.js,*.css,*.ico,*.txt,*.gif,*.jpg,*.jpeg,*.png,*.mp3,*.pdf,*.tgz,*.flv,*.avi,*.mpeg,*.iso,*.chd,*.md5,index.html?*'

# Convert report to Unix
dos2unix $report_name

# Donwload all the index of CHD folders
wget $wget_options --reject $wget_reject --ignore-tags=img,link,script --header="Accept: text/html" $URL

# Retrieve the missing CHDs
for CHD in $( cat $report_name | grep -Ev '^$|^//' ) ; do

	echo "################" $CHD
	folder_name=$( grep -ir $CHD CHDs/* | cut -d'/' -f2 )
	echo "FOLDER: " $folder_name
	wget -r -np -nc --timeout=5 -t 2 --http-user=$username --http-password=$password -A chd $URL$folder_name/$CHD

done

rm -rf $tmp_file
rm -rf $tml_folder
