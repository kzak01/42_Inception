# #!/bin/sh

while ! mariadb -h $MARIADB_HOST -u $MARIADB_USER -p$MARIADB_PASS $MARIADB_DATABASE_NAME --silent; do
	sleep 1 
done 

mkdir -p /var/www
mkdir -p /var/www/html
cd /var/www/html
wp core download --allow-root

wp config create \
	--dbname="wordpress" \
	--dbuser=$MARIADB_USER \
	--dbpass=$MARIADB_PASS \
	--dbhost=$MARIADB_HOST 
wp core install \
	--url="kzak.42.fr" \
	--title=$WORDPRESS_TITLE \
	--admin_user=$WORDPRESS_ADMIN_USER \
	--admin_password=$WORDPRESS_ADMIN_PASS \
	--admin_email=$WORDPRESS_ADMIN_MAIL 
wp user create \
	$WORDPRESS_USER \
	$WORDPRESS_MAIL \
	--user_pass=$WORDPRESS_PASS \

exec "$@"
