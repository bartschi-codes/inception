#!/bin/sh

# Check if mariadb is already installed
if [ -d "/var/lib/mysql/mysql" ]; 
then
    # Upgrade mariadb
    mariadb-upgrade --user=mysql
else
    # Install mariadb
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql --init-file="/usr/local/bin/init.sql"
fi

exec "$@"


