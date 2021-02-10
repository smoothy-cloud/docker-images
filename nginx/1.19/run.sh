#!/bin/bash

#####################################
# set max file upload (in MB)
#####################################

max_file_upload="${MAX_FILE_UPLOAD:-2}";

sed -i "s|%MAX_FILE_UPLOAD%|$max_file_upload|g" /etc/nginx/nginx.conf

#####################################
# run additional entrypoints
#####################################

shopt -s nullglob
for f in /entrypoints/*.sh; do
  sh "$f" -H 
done
shopt -u nullglob

#####################################
# start nginx
#####################################

gosu smoothy /usr/sbin/nginx -c /etc/nginx/nginx.conf