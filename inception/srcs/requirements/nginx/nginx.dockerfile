#install alpine
FROM	alpine:3.21.0

#Install NGINX and create folder with permissions for ssl
RUN	<<EOF 
apk update;
apk add --no-cache nginx gettext-envsubst openssl;
mkdir -p /etc/nginx/ssl /run/nginx /etc/nginx/conf.d;
chmod -R 744 /etc/nginx/ssl /run/nginx
EOF

# copy config and entrypointscript
COPY conf/nginx.temp /etc/nginx/nginx.temp
COPY --chmod=744 tools/entrypoint.sh /usr/local/bin/nx_entrypoint.sh

# expose port connecting
EXPOSE	443

# set entrypoint and start command
ENTRYPOINT [ "/usr/local/bin/nx_entrypoint.sh" ]

CMD	[ "nginx", "-g", "daemon off;" ]
