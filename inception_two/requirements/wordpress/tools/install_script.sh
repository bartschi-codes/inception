#!/bin/sh

#while ! mariadb-admin ping -h ${MYSQL_HOST}; do
#	# --silent
#	sleep 10
#done

#if ! wp core is-installed --allow-root; then
#	wp core install --url=${DOMAIN_NAME} --title=${WORDPRESS_TITLE} --admin_user=${WORDPRESS_ADMIN_USER} --admin_password=${WORDPRESS_ADMIN_PASSWORD} --skip-email --allow-root
#fi
#
#if [ ! -f wp-config.php ]; then
#	wp config create --dbname=${MYSQL_DATABASE} --dbuser=${MYSQL_USER} --dbpass=${MYSQL_PASSWORD} --dbhost=${MYSQL_HOST}  --allow-root
#fi

if [ ! -f "/var/www/html/wp-config.php" ];
then
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar
	mv wp-cli.phar /usr/local/bin/wp
	wp core download --path=/$WP_PATH --allow-root
	wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=$MYSQL_HOST --path=/$WP_PATH --skip-check --allow-root
	 wp core install --path=/$WP_PATH --url=$DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_USER --admin_password=$WP_PASSWORD --admin_email=$WP_MAIL --skip-email --allow-root
fi

exec "$@"
