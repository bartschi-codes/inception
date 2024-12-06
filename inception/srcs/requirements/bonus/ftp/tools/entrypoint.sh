#!/bin/sh

if [ ! -f "/etc/vsftpd/vsftpd.tru" ] > /dev/null 2>&1;
then
	# substitute env variable in conf file
	envsubst "$(printf '${%s} ' $(env | sed 's/=.*//'))" \
		< /etc/vsftpd/vsftpd.temp >> /etc/vsftpd.conf
	
	# create file to check for process
	mv /etc/vsftpd/vsftpd.temp /etc/vsftpd.tru > /dev/null 2>&1

	#create user and give ownership of directories
	adduser -D -h $WORDPRESS_PATH $FTP_USER > /dev/null 2>&1
	echo "$FTP_USER:$FTP_PASS" | chpasswd > /dev/null 2>&1
	addgroup $FTP_USER www-data
	
	chown -R $FTP_USER:$FTP_USER $WORDPRESS_PATH
	chmod -R 755 $WORDPRESS_PATH
fi

exec "$@"
