#install Debian

FROM alpine:edge

#Install NGINX 
RUN 	apk update && \
	apk add \
	nginx \
	openssl

Run	mkdir -p /etc/ssl/private && \
	mkdir -p /etc/ssl/certs 

RUN	openssl req \
	-x509 \
	-sha256 \
	-nodes \
	-days 365 \
	-newkey rsa:4096 \
	-subj "/C=DE/ST=Berlin/O=42 School/CN=mbartsch.42.fr" \
	-addext "subjectAltName=DNS:mbartsch.42.fr" \
	-keyout /etc/ssl/private/nginx_inception.key \
	-out /etc/ssl/certs/nginx-inception_selfsigned.crt

COPY conf/nginx.conf /etc/conf/nginx.conf

COPY index.html /usr/share/nginx/html/index.html

EXPOSE	443

CMD	["nginx", "-g", "daemon off;"]
