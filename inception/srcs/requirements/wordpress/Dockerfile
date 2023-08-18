FROM alpine:3.17

RUN apk update && apk upgrade && \
	apk add --no-cache \
	wget \
	tar \
	mysql-client \
	redis \
	php php8 php8-curl php8-mysqli && \
	addgroup -S nginx && adduser -S nginx && \ 
	mkdir -p /var/www/html && \
	chown -R nginx:nginx /var/www/html && \
	cd /var/www/html && find . -type d -exec chmod 755 {} \; && find . -type f -exec chmod 644 {} \; && \
	mkdir -p /run/php && chown nginx:nginx /run/php

COPY tools/configure.sh /tmp/configure.sh
COPY conf/www.conf /etc/php8/php-fpm.d/

ENTRYPOINT [ "sh", "/tmp/configure.sh" ]

# -D -H -h /var/www/html -s /sbin/nologin -G nginx inazanf
