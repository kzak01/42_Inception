#!/bin/sh

CONF=/var/www/html/wp-config.php
if [ -f "$CONF" ]; then
    echo "wordpress already configured"
else
    # Start PHP-FPM service
    php-fpm7.3 -D

    # Delay to allow PHP-FPM to start
    sleep 5

    # Configure WordPress
    cd /var/www/html/
    wp core download --allow-root
    wp config create --dbname=$MARIADB_NAME --dbuser=$MARIADB_USER --dbpass=$MARIADB_PASS --dbhost=$MARIADB_HOST --dbcharset="utf8" --dbcollate="utf8_general_ci" --allow-root
    wp db create --allow-root
    wp core install --url=$DOMAIN_NAME --title="Inception" --admin_user=$WORDPRESS_ADMIN_USER --admin_password=$WORDPRESS_ADMIN_PASS --admin_email=$WORDPRESS_ADMIN_MAIL --skip-email --allow-root
    wp user create $WORDPRESS_USER $WORDPRESS_MAIL --role=author --user_pass=$WORDPRESS_PASS --allow-root
    # wp theme activate twentytwentythree --allow-root

    # Stop PHP-FPM service
    pkill php-fpm7.3
fi

echo "Wordpress-PHP starting"
php-fpm7.3 -F
