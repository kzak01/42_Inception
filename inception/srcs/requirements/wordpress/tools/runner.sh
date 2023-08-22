#!/bin/sh

echo "hello from wordpress script!"

CONF=/var/www/html/wp-config.php
if [ -f "$CONF" ]; then
	echo "wordpress already configured"
else
	sleep 5 # mariadb service must configure and restart first
	service php7.3-fpm start
	cd /var/www/html/
	wp core download --allow-root
	wp config create --dbname=$MARIADB_DATABASE_NAME --dbuser=$MARIADB_USER --dbpass=$MARIADB_PASS --dbhost=$MARIADB_HOST --dbcharset="utf8" --dbcollate="utf8_general_ci" --allow-root
    wp core install --url=$DOMAIN_NAME --title="$WORDPRESS_TITLE" --admin_user=$WORDPRESS_ADMIN_USER --admin_password=$WORDPRESS_ADMIN_PASS --admin_email=$WORDPRESS_ADMIN_MAIL --skip-email --allow-root
    wp user create $WORDPRESS_USER $WORDPRESS_MAIL --role=author --user_pass=$WORDPRESS_PASS --allow-root
    #wp theme install inspiro --activate --allow-root
	service php7.3-fpm stop
fi

echo "PHP-FPM7.3 starting"
php-fpm7.3 -F
