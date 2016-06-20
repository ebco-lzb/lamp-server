#!/bin/sh
#monthly purge of flash Reports
rm -rf /home/homepage/public_html/files/rank/flash/tmpdownload
rm -rf /home/homepage.la-z-boyga.com/public_html/files/rank/flash/tmpdownload

#Re-populate the flash reports for EBCO
/opt/lamp-server/scripts/flash

#Re-populate the flash reports for FGA
/opt/lamp-server/scripts/flash_atl
