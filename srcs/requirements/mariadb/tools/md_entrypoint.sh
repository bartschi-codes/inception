#!/bin/sh

# substitute env variables and store it as init script for mariadb
envsubst "$(printf '${%s} ' $(env | sed 's/=.*//'))" \
	< /usr/local/bin/init.temp > /usr/local/bin/init.sql

# Check if mariadb is already installed
if [ ! -d "/var/lib/mysql/mysql" ];
then
    # Install mariadb
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
fi


exec "$@"
