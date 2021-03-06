#!/bin/bash
# Set the variable for bash behavior
shopt -s nullglob
shopt -s dotglob

# Die if dir name provided on command line
#[[ $# -eq 0 ]] && { echo "Usage: $0 dir-name"; exit 1; }

# Check for empty files using arrays
chk_ebco=(/shares/importaz/*)
(( ${#chk_ebco[*]} )) && echo "Files found in $1 EBCO share." || echo "EBCO share $1 is empty."

chk_fga=(/shares/importga/*)
(( ${#chk_fga[*]} )) && echo "Files found in $1 FGA share." || echo "FGA share $1 is empty."

# Unset the variable  for bash behavior
shopt -u nullglob
shopt -u dotglob

#Move files if they exist
if [ -z "$chk_ebco" ]
then
  echo "Not Moving Files"
else
  echo "Moving Files for EBCO"
  mv /shares/importaz/* /home/homepage/public_html/files/import
  chown -R homepage:homepage /home/homepage/public_html/files/import
fi

if [ -z "$chk_fga" ]
then
  echo "Not Moving Files"
else
  echo "Moving Files for FGA"
  mv /shares/importga/* /home/homepage.la-z-boyga.com/public_html/files/import
  chown -R homepage.la-z-boyga.com:homepage.la-z-boyga.com /home/homepage.la-z-boyga.com/public_html/files/import
fi
