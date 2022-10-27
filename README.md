# Retroroms
Retroroms scripts for automate ROMs and CHDs downloads.

# Requisites:
    `wget`, `curl` and `xmllint`

# Usage:

* Edit the 'auth.config' script and update the variables 'username' and 'password' with your https://www.retroroms.info account

## ROMs

*  Edit and 'roms.sh' script and set the 'URL' variable of desired files to download.

`./roms.sh`

## CHDs

* Edit and 'chd_list.txt' script with the list of CHDs (one per line)

`./chds.sh`
