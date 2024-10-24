#install alpine

FROM alpine:edge

#Install NGINX 
RUN	<<EOF 
apk update \
&& apk add --no-cache nginx openssl; \
mkdir -p /etc/nginx/ssl /run/nginx;
openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:4096 \
-keyout /etc/nginx/ssl/nginx.key \
-out	/etc/nginx/ssl/nginx.crt \
-subj "/C=DE/ST=Berlin/L=Berlin/O=42/CN=mbartsch.42.fr"
EOF

COPY	./conf/nginx-custom.conf /etc/nginx/http.d/nginx.conf

EXPOSE	433:433

CMD	["nginx", "-g", "daemon off;"]
