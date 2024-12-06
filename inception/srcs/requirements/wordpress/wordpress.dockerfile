# install alpine
FROM	alpine:3.21.0

#install php, mariadb and utilities
RUN	<<EOF
apk update;
apk add --no-cache \
php php-fpm php-mysqli php-json php-session php-curl \
php-gd php-xml php-mbstring php-zip php-dom php-opcache php-phar php-tokenizer \
php-exif php-fileinfo gettext-envsubst mariadb-client curl tar; 
adduser -S www-data -G www-data;
mkdir -p /var/www /var/www/html;
chown -R www-data:www-data /var/www/html;
chmod -R 755 /var/www/html;
>/var/www/php-error.log
EOF

# copy php config file and startup script
COPY ./conf/php-fpm.temp /etc/php83/php-fpm.temp

COPY --chmod=744 ./tools/entrypoint.sh	/usr/local/bin/wp_entrypoint.sh

# expose standart port of wordpress
EXPOSE 9000

# set entrypoint and start cmd
ENTRYPOINT [ "/usr/local/bin/wp_entrypoint.sh" ]

CMD [ "php-fpm83", "-F", "--nodaemonize" ]
