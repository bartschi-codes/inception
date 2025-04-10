# syntax=docker/dockerfile:1

#install alpine
FROM	alpine:3.21.0

#install php and adminer
RUN	<<EOF
apk update;
apk add --no-cache php php-fpm php-pdo php-pdo_mysql php-mbstring php-session mariadb-client wget;
mkdir -p /var/www/html;
wget "https://www.adminer.org/latest.php" -O /var/www/html/index.php;
adduser -D -S -G www-data www-data;
chown -R www-data /var/www/html/index.php;
chmod 755 /var/www/html/index.php
EOF

#expose according ports
EXPOSE	8080

#stopsignal for proper quitting of php
STOPSIGNAL SIGQUIT

#set WORKDIR
WORKDIR	/var/www/html

#run php server for adminer
CMD [ "php", "-S", "0.0.0.0:8080", "-t", "/var/www/html"]
