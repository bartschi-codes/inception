#!/bin/sh

if [ ! -d "/var/lib/mysql/mysql" ]; 
then
	mariadb-install-db --user=mysql --datadir=/var/lib/mysql
else
	mariadb upgrade
fi

exec mariadbd --user=mysql 
