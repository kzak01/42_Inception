# #!/bin/sh

# CONF=/var/www/html/wordpress/wp-config.php
# if [ -f "$CONF" ]; then
#     echo "wordpress already configured"
# else 
#   echo "[Inception-Wordpress] Downloading Wordpress"
#   curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
#   php wp-cli.phar core download --allow-root

#   echo "[Inception-Wordpress] Setting up basic Wordpress settings"
#   mv wp-config-sample.php wp-config.php

#   sed "s/database_name_here/$MARIADB_DATABASE_NAME/1" -i -r wp-config.php
#   sed "s/username_here/$MARIADB_USER/1" -i -r wp-config.php
#   sed "s/password_here/$MARIADB_PASS/1" -i -r wp-config.php
#   sed "s/localhost/mariadb/1" -i -r wp-config.php

#   echo "[Inception-Wordpress] Waiting MariaDB..."
#   while ! nc -z mariadb 3306; do   
#     sleep 0.1
#   done
#   echo "[Inception-Wordpress] MariaDB is online"

#   echo "[Inception-Wordpress] Setting up Wordpress website and users"
#   php wp-cli.phar core install --url=$DOMAIN_NAME/ --title='$WORDPRESS_TITLE' --admin_user=$WORDPRESS_ADMIN_USER --admin_password=$WORDPRESS_ADMIN_PASS --admin_email=$WORDPRESS_ADMIN_MAIL --skip-email --allow-root
#   php wp-cli.phar user create $WORDPRESS_USER $WORDPRESS_MAIL --role=author --user_pass=$WORDPRESS_PASS --allow-root
  
#   echo "[Inception-Wordpress] Installing WP Statistics"
#   php wp-cli.phar plugin install wp-statistics --activate

#   rm wp-cli.phar
# fi

# echo "[Inception-Wordpress] Updating PHP-FPM configuration"
# sed "s/127.0.0.1:9000/0.0.0.0:9000/1" -i -r /etc/php81/php-fpm.d/www.conf

# echo "[Inception-Wordpress] Starting PHP-FPM"
# /usr/sbin/php-fpm81 -F
#!/bin/sh
#db conection
while ! mariadb -h $MYSQL_HOST -u $WP_DB_USER -p$WP_DB_PASSWORD $WP_DB_NAME --silent; do
	sleep 1 
done 

#wordpress
mkdir -p /var/www
mkdir -p /var/www/html
cd /var/www/html
wp core download --allow-root

wp config create \
	--dbname="wordpress" \
	--dbuser=$WP_DB_USER \
	--dbpass=$WP_DB_PASSWORD \
	--dbhost=$MYSQL_HOST 
wp core install \
	--url=$WP_ADMIN_EMAIL \
	--title=$WP_TITLE \
	--admin_user=$WP_USER \
	--admin_password=$WP_PASSWORD \
	--admin_email=$WP_EMAIL 
wp user create \
	$WP_TMP_USER \
	$WP_TMP_EMAIL \
	--user_pass=$WP_PASSWORD \

exec "$@"
