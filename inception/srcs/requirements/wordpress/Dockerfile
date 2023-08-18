FROM alpine:3.17

RUN apk update && apk upgrade && \
	apk add --no-cache \
	wget \
	tar \
	mysql-client \
	redis \
	php && \
	addgroup -S nginx && adduser -S nginx && \ 
	mkdir -p /var/www/html && \
	chown -R nginx:nginx /var/www/html && \
	cd /var/www/html && find . -type d -exec chmod 755 {} \; && find . -type f -exec chmod 644 {} \; && \
	mkdir -p /run/php && chown nginx:nginx /run/php

COPY tools/configure.sh /tmp/configure.sh
COPY conf/www.conf /etc/php/7.3/fpm/pool.d

# RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
# RUN chmod +x wp-cli.phar
# RUN cp wp-cli.phar /usr/bin/wp

ENTRYPOINT [ "sh", "/tmp/configure.sh" ]

# -D -H -h /var/www/html -s /sbin/nologin -G nginx inazanf
