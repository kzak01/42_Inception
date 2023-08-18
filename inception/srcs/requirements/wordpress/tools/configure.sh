#!/bin/sh

CONF=/var/www/html/wordpress/wp-config.php
if [ -f "$CONF" ]; then
    echo "wordpress already configured"
else
    # Avvia il servizio PHP-FPM
    php-fpm8 -D

    # Attendi per consentire l'avvio di PHP-FPM
    sleep 5

    # Configura WordPress
    cd /var/www/html/
    wp core download --allow-root
    wp config create --dbname=$MARIADB_NAME --dbuser=$MARIADB_USER --dbpass=$MARIADB_PASS --dbhost=$MARIADB_HOST --dbcharset="utf8" --dbcollate="utf8_general_ci" --allow-root
    wp db create --allow-root
    wp core install --url=$DOMAIN_NAME --title="Inception" --admin_user=$WORDPRESS_ADMIN_USER --admin_password=$WORDPRESS_ADMIN_PASS --admin_email=$WORDPRESS_ADMIN_MAIL --skip-email --allow-root
    wp user create $WORDPRESS_USER $WORDPRESS_MAIL --role=author --user_pass=$WORDPRESS_PASS --allow-root
    wp theme activate twentytwentythree --allow-root

    # Arresta il servizio PHP-FPM
    pkill php-fpm8
fi

echo "Wordpress-PHP starting"
# Avvia PHP-FPM in modalità foreground
php-fpm8 -F
