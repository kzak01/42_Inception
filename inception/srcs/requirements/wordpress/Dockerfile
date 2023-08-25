# Use Alpine Linux version 3.17 as the base image.
FROM alpine:3.17

# Update package repositories, upgrade existing packages, and install required packages
RUN apk update && apk upgrade && apk add --no-cache \
		php81 \
		php81-fpm\
		php81-mysqli\
		php81-opcache\
		php81-curl\
		php81-mbstring\
		php81-intl\
		php81-xml\
		php81-zip\
		php81-openssl\
		php81-phar\
		mariadb-client \
		fcgi \
		curl \
		wget

# Add a new system user 'nginx' and a group 'nginx'
RUN adduser -S nginx && addgroup -S nginx

# Copy the PHP-FPM configuration file to the appropriate directory
COPY ./conf/www.conf /etc/php81/php-fpm.d/www.conf

# Download and set up WP-CLI for managing WordPress from the command line
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp && \
	chmod +x /usr/local/bin/wp

# Create directories and adjust permissions for PHP-FPM logs
RUN	mkdir -p /var/log/php-fpm && \
	touch /var/log/php-fpm/error.log && \
	touch /var/log/php-fpm/access.log && \
	chown -R nginx:nginx /var/log/php-fpm && \
	chmod -R 777 /var/log/php-fpm

# Copy the configuration script and make it executable
COPY ./tools/configure.sh /tmp/configure.sh
RUN	chmod +x /tmp/configure.sh

# Set the entry point for the container to execute the configuration script
ENTRYPOINT ["sh", "/tmp/configure.sh"]

# Set the default command for the container to run PHP-FPM with specific options
# CMD ["php-fpm81", "--nodaemonize"]
