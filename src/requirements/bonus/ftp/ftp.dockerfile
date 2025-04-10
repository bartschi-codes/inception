# syntax=docker/dockerfile:1

#install alpine
FROM	alpine:3.21.0

#install ftp
RUN	<<EOF
apk update;
apk add --no-cache vsftpd lftp gettext-envsubst
EOF

#copy conf file and entrypoint script
COPY	--chmod=744 conf/vsftpd.temp /etc/vsftpd/vsftpd.temp

COPY	--chmod=744 tools/entrypoint.sh /usr/local/bin/entrypoint.sh

#expose port
EXPOSE	21
EXPOSE	21000-21010

#set entrypoint and start command
ENTRYPOINT	[ "/usr/local/bin/entrypoint.sh" ]

#set stopsignal
STOPSIGNAL	SIGQUIT

#startup command
CMD	[ "vsftpd", "/etc/vsftpd.conf" ]
