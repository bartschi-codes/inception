#install Alpine

FROM alpine:edge

RUN <<EOF
apk update \
&& apk add --no-cache \
mariadb mariadb-client mariadb-server-utils; \
mkdir -p /var/lib/mysql /var/run/mysqld \
&& chown -R mysql:mysql /var/lib/mysql /var/run/mysqld/ \
&& chmod 775 /var/lib/mysql /var/run/mysqld \
EOF

COPY	./conf/my.cnf /etc/mysql/

COPY	--chmod=755 ./conf/entrypoint.sh /usr/local/bin

EXPOSE	3306

CMD	["/usr/local/bin/entrypoint.sh"]
