FROM debian:buster

RUN apt update -y && apt upgrade -y  && \
	apt install php php-fpm php-mysql php-gd php-curl php-zip wget mariadb-client -y \
	# wget \
	# tar \
	# mysql-client \
	# redis \
	# php && \
	# addgroup -S nginx && adduser -S nginx && \ 
	mkdir -p /var/www/html && \
	chown -R nginx:nginx /var/www/html && \
	cd /var/www/html && find . -type d -exec chmod 755 {} \; && find . -type f -exec chmod 644 {} \; && \
	mkdir -p /run/php && chown nginx:nginx /run/php

COPY tools/configure.sh /tmp/configure.sh
COPY conf/www.conf /etc/php7/php-fpm.d/

ENTRYPOINT [ "sh", "/tmp/configure.sh" ]

# -D -H -h /var/www/html -s /sbin/nologin -G nginx inazanf
