#install alpine

FROM	alpine:edge

RUN <<EOF
apk update; \
apk add --no-cache \
php php-fpm php-mysqli php-json php-session php-curl php-gd \
php-xml php-mbstring php-zip php-dom php-opcache php-phar \
php-tokenizer php-exif php-fileinfo mariadb-client curl tar;  \
adduser -S nginx; \
addgroup -S nginx; \
mkdir -p /var/log/php8; \
chown -R nginx:nginx /var/log/php8 \
EOF

WORKDIR /var/www/html

#RUN <<EOF
#curl -O https://wordpress.org/latest.tar.gz; \
#tar -xzf latest.tar.gz; \
#rm latest.tar.gz; \
#chown -R nginx:nginx /var/www /var/www/html; \
#chmod -R 755 /var/www/html; \
#curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar; \
#chmod +x wp-cli.phar; \
#mv wp-cli.phar /usr/local/bin/wp \
#EOF

COPY ./conf/php.conf /etc/php8/php-fpm.conf

#COPY --chmod=744 ./conf/wp-config.php /

COPY --chmod=744 ./tools/install_script.sh /usr/local/bin/install_script.sh

EXPOSE	9000

ENTRYPOINT ["/usr/local/bin/install_script.sh"]

CMD	["php-fpm83", "-F", "--nodaemonize"]
