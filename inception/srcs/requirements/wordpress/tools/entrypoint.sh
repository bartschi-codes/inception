#!bin/sh

# substitute env variable in conf file
envsubst "$(printf '${%s} ' $(env | sed 's/=.*//'))" \
	< /etc/php83/php-fpm.temp > /etc/php83/php-fpm.d/php-fpm.conf

#move to working directory
cd /var/www/html

#wait for mariadb
while ! mariadb -h mariadb -u wpuser -p"wpuser123" -e"SHOW DATABASES;";
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
	--title=$WORDPRESS_TITLE --admin_user=$WORDPRESS_USER \
	--admin_password=$WORDPRESS_PASSWORD --admin_email=$WORDPRESS_MAIL \
	--skip-email --allow-root
else
        wp config create \
	--dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER \
	--dbpass=$MYSQL_PASSWORD --dbhost=$MYSQL_HOST \
	--path=/$WORDPRESS_PATH --skip-check --allow-root

fi

# execute start command
exec "$@"
