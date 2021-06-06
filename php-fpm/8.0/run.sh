#!/bin/sh

#####################################
# set timezone
#####################################

timezone="${TIMEZONE:-Etc/UTC}";
ln -fs /usr/share/zoneinfo/$timezone /etc/localtime
dpkg-reconfigure -f noninteractive tzdata

timezone="${TIMEZONE:-UTC}";
sed -i "s|%TIMEZONE%|$timezone|g" /usr/local/etc/php/conf.d/php.ini

#####################################
# set max file upload (in MB)
#####################################

max_file_upload="${MAX_FILE_UPLOAD:-2}";

sed -i "s|%MAX_FILE_UPLOAD%|$max_file_upload|g" /usr/local/etc/php/conf.d/php.ini

#####################################
# enable/disable opcache
#####################################

opcache="${OPCACHE:-0}";

sed -i "s|%OPCACHE%|$opcache|g" /usr/local/etc/php-fpm.d/www.conf

#####################################
# run additional entrypoints
#####################################

shopt -s nullglob
for f in /entrypoints/*.sh; do
  gosu smoothy sh "$f" -H 
done
shopt -u nullglob

#####################################
# start php fpm
#####################################

gosu smoothy ${@}