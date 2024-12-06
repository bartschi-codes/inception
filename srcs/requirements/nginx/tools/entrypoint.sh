#!bin/sh

#check if key and cert exists, if not create
if [ ! -f "$SSL_CERT" ] || [ ! -f "$SSL_KEY" ]
then
	openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout $SSL_KEY \
	-out $SSL_CERT \
	-subj "/C=DE/ST=Berlin/L=Berlin/O=42/CN=mbartsch.42.fr"
fi

#convert conf template to conf file
envsubst "$(printf '${%s} ' $(env | sed 's/=.*//'))" < /etc/nginx/nginx.temp > /etc/nginx/nginx.conf

#execute cmd from dockerfile
exec "$@"
