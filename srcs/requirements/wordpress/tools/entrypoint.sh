#!bin/sh

# substitute env variable in conf file
envsubst "$(printf '${%s} ' $(env | sed 's/=.*//'))" \
	< /etc/php83/php-fpm.temp > /etc/php83/php-fpm.d/www.conf

#move to working directory
cd /var/www/html

#wait for mariadb
while ! mariadb -u"$WORDPRESS_ADMIN_USER"  -p"$WORDPRESS_ADMIN_PASSWORD" &> /dev/null;
do
	sleep 3
done

# check if worpress is already installed and install if needed
if [ ! -f "/var/www/html/wp-config.php" ];
then
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
        chmod +x wp-cli.phar

        mv wp-cli.phar /usr/local/bin/wp

        wp core download --path=/$WORDPRESS_PATH --allow-root

        wp config create \
	--dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER \
	--dbpass=$MYSQL_PASSWORD --dbhost=$MYSQL_HOST \
	--path=/$WORDPRESS_PATH --skip-check --allow-root

        wp core install \
	--path=/$WORDPRESS_PATH --url=$DOMAIN_NAME \
	--title=$WORDPRESS_TITLE --admin_user=$WORDPRESS_ADMIN_USER \
	--admin_password=$WORDPRESS_ADMIN_PASSWORD \
	--admin_email=$WORDPRESS_ADMIN_MAIL \
	--skip-email --allow-root

	 # add non admin user
	wp user create $WORDPRESS_USER_USER $WORDPRESS_USER_MAIL \
	--user_pass=$WORDPRESS_USER_PASSWORD

	 #install and configure redis
	 wp config set WP_CACHE true --allow-root
	 wp config set WP_REDIS_HOST $REDIS_HOST --allow-root
	 wp config set WP_REDIS_PORT $REDIS_PORT --allow-root

	 wp plugin install $REDIS_NAME --activate \
	--path=$WORDPRESS_PATH --allow-root

	#enable redis
	wp redis enable --allow-root

	#enable ftp
	wp config set FS_METHOD ftpext --allow-root
	wp config set FTP_HOST $FTP_HOST --allow-root
	wp config set FTP_USER $FTP_USER --allow-root
	wp config set FTP_PASS $FTP_PASS --allow-root
fi

# execute start command
exec "$@"
