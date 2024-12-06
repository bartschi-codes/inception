# install alpine
FROM	alpine:3.21.0

# install mariadb and create necassary folders
RUN	<<EOF
apk update;
apk add --no-cache \
mariadb mariadb-server-utils mariadb-client gettext-envsubst coreutils;
mkdir -p /var/lib/mysql /run/mysqld;
chown -R mysql:mysql /var/lib/mysql /run/mysqld;
chmod 0744 /var/lib/mysql /run/mysqld;
EOF

# copy conf file and init.sql and entrypoint script
COPY	./conf/my.cnf	/etc/my.cnf

COPY	--chmod=744 ./tools/md_entrypoint.sh ./conf/init.temp /usr/local/bin/

# expose mariadb port
EXPOSE	3306

#set entrypoint script
ENTRYPOINT	[ "/usr/local/bin/md_entrypoint.sh" ]

#startup command for databse
CMD	[ "mariadbd" ]
