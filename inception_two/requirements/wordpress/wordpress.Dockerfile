#install alpine

FROM	alpine:edge

RUN <<EOF
apk update \
&& apk add --no-cache \
php php-fpm php-mysqli php-json php-session php-curl php-gd \
php-xml php-mbstring php-zip php-dom php-opcache php-phar \
php-tokenizer php-exif php-fileinfo mariadb-client curl tar;  \
adduser -S nginx; \
addgroup -S nginx; \
mkdir -p /var/log/php8 \
&& chown -R nginx:nginx /var/log/php8 \
EOF

WORKDIR /var/www/html

RUN <<EOF
curl -O https://wordpress.org/latest.tar.gz \
&& tar -xzf latest.tar.gz \
&& rm latest.tar.gz \
&& mv wordpress/* . \
&& rmdir wordpress \
&& chown -R nginx:nginx /var/www \
&& find /var/www -type d -exec chmod 755 {} \; \
&& find /var/www -type f -exec chmod 644 {} \; \
EOF

COPY ./conf/php.conf /etc/php8/php-fpm.conf

EXPOSE	9000

CMD ["php-fpm83", "-F", "--nodaemonize"]
