#!/bin/sh

#variables
ebco_tmp="/home/homepage/tmp/flashtmp"
fga_tmp="/home/homepage.la-z-boyga.com/tmp/flashtmp"

#Input user/pw
. /opt/ftp/variables.txt

#monthly purge of flash Reports
rm -rf $ebco_tmp/*
rm -rf $fga_tmp/*

#Re-populate the flash reports for EBCO
eval /opt/lamp-server/scripts/flash

#Re-populate the flash reports for FGA
eval /opt/lamp-server/scripts/flash_atl
