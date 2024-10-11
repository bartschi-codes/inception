#install Alpine

FROM alpine:edge

RUN <<EOF
apk update \
&& apk add --no-cache \
mariadb mariadb-client mariadb-server-utils; \
mkdir -p /var/lib/mysql /var/run/mysqld \
&& chown -R mysql:mysql /var/lib/mysql /var/run/mysqld \
EOF

ENV	MYSQL_ROOT_PASSWORD=root_password \
	MYSQL_DATABASE=my_database \
	MYSQL_USER=my_user \
	MYSQL_PASSWORD=password

COPY	./conf/mariadb.conf /etc/conf

EXPOSE	3306

CMD ["sh", "-c", "mariadb-upgrade --user=mysql && /usr/bin/mariadb --user=mysql --console"]
