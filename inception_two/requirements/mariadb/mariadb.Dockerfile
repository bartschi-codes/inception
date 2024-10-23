#install Alpine

FROM alpine:edge

RUN <<EOF
apk update; \
apk add --no-cache mariadb mariadb-server-utils mariadb-client; \
mkdir -p /var/lib/mysql /run/mysqld; \
chown -R mysql:mysql /var/lib/mysql /run/mysqld; \
chmod 0775 /var/lib/mysql /run/mysqld \
EOF

COPY	./conf/my.cnf 						/etc/my.cnf
COPY	--chmod=755 ./conf/init.sql ./tools/entrypoint.sh	/usr/local/bin/

ENTRYPOINT [ "usr/local/bin/entrypoint.sh" ]

EXPOSE	3306

CMD	[ "mariadbd" ]
