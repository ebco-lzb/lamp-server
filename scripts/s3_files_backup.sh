#!/bin/sh

#Copy FGA files to S3
echo "Copying FGA site files to s3"
aws s3 sync /home/d8-fga/public_html/sites/default/files s3://ebco-backup/fga_files

#Copy EBCO files to S3
echo "Copying EBCO site files to s3"
aws s3 sync /home/d8-ebco/public_html/sites/default/files s3://ebco-backup/ebco_files
