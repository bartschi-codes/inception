#!bin/sh

#check if key and cert exists, if not create
if [ ! -f "$SSL_CERT" ] || [ ! -f "$SSL_KEY" ];
then
	openssl req -x509 -nodes -days 365 \
	-keyout $SSL_KEY \
	-out $SSL_CERT \
	-subj "/C=DE/ST=Berlin/L=Berlin/O=42/CN=mbartsch.42.fr"
fi

#convert conf template to conf file
envsubst < /etc/nginx/nginx.temp > /etc/nginx/http.d/default.conf

#execute cmd from dockerfile
exec "$@"
