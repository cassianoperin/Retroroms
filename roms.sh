#!/bin/bash

# Variables
URL="https://bda.retroroms.info:82/downloads/mame/mame-0220/"
#URL="https://bda.retroroms.info:82/downloads/mame/update-packs/mame-0219/"
username=''
password=''


# Retrieve game list and download
for FILE_NAME in $(curl $URL | grep -i zip | cut -d' ' -f3 | cut -d '"' -f2) ; do
    wget -r -np -nc  --http-user=$username --http-password=$password -A zip $URL/$FILE_NAME
done
