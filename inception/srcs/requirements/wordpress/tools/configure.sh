# #!/bin/sh

while ! mariadb -h $MARIADB_HOST -u $MARIADB_USER -p$MARIADB_PASS $MARIADB_DATABASE_NAME --silent; do
	sleep 1 
done 

cd /var/www/html

if [ -f "wp-config.php" ]; then
	echo "Wordpress good!"
else
	echo "Configuring Wordpress"
	wp core download --allow-root

	wp config create \
		--dbname=$MARIADB_DATABASE_NAME \
		--dbuser=$MARIADB_USER \
		--dbpass=$MARIADB_PASS \
		--dbhost=$MARIADB_HOST \
		--dbcharset="utf8" \
		--dbcollate="utf8_general_ci" \
		--allow-root

	wp core install \
		--url=$DOMAIN_NAME \
		--title="$WORDPRESS_TITLE" \
		--admin_user=$WORDPRESS_ADMIN_USER \
		--admin_password=$WORDPRESS_ADMIN_PASS \
		--admin_email=$WORDPRESS_ADMIN_MAIL \
		--skip-email \
		--allow-root

	wp user create \
		$WORDPRESS_USER \
		$WORDPRESS_MAIL \
		--role=author \
		--user_pass=$WORDPRESS_PASS \
		--allow-root
fi

exec "$@"
# /usr/sbin/php-fpm81 -F
