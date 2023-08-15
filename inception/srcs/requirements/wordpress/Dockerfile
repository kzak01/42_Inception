FROM	debian:buster

RUN	apk update -y && apk upgrade -y && apk add --no-cache && \
	apt install php php-fpm php-mysql php-gd php-curl php-zip -y && \
	apt install wget -y && \
	apt install mariadb-client -y && \
	mkdir -p /var/www/html && \
	chown -R nginx:nginx /var/www/html && \
	cd /var/www/html && find . -type d -exec chmod 755 {} \; && find . -type f -exec chmod 644 {} \; \
	mkdir -p /run/php && chown nginx:nginx /run/php

COPY tools/configure.sh /tmp/configure.sh
COPY conf/www.conf /etc/php/7.3/fpm/pool.d
COPY conf/index.html /tmp/index.html

RUN	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/bin/wp

WORKDIR /var/www/html

EXPOSE 9000
EXPOSE 3306

ENTRYPOINT [ "sh" , "/tmp/configure.sh" ]
