#install Alpine

FROM alpine:edge

RUN <<EOF
apk update \
&& apk add --no-cache \
mariadb mariadb-client mariadb-server-utils; \
mkdir -p /var/lib/mysql \
&& chown -R mysql:mysql /var/lib/mysql \
&& chmod 777 /var/lib/mysqld; \
mariadb-install-db --user=mysql
EOF

COPY	./conf/my.cnf /etc/mysql/

EXPOSE	3306

ENTRYPOINT	["mariadbd-safe"]
