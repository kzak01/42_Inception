FROM alpine:3.17

RUN apk update && apk upgrade && apk add --no-cache \
		php8 \
		# php8-fpm\
		# php8-mysqli\
		# php8-opcache\
		# php8-curl\
		# php8-mbstring\
		# php8-intl\
		# php8-xml\
		# php8-zip\
		# php8-openssl\
		# php8-phar\
		mariadb-client \
		fcgi \
		curl \
		wget

RUN adduser -S nginx && addgroup -S nginx
COPY ./conf/www.conf /etc/php8/php-fpm.d/www.conf

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp && \
	chmod +x /usr/local/bin/wp

RUN	mkdir -p /var/log/php-fpm && \
	touch /var/log/php-fpm/error.log && \
	touch /var/log/php-fpm/access.log && \
	chown -R nginx:nginx /var/log/php-fpm && \
	chmod -R 777 /var/log/php-fpm

COPY ./tools/configure.sh /tmp/configure.sh
RUN	chmod +x /tmp/configure.sh

ENTRYPOINT ["sh", "/tmp/configure.sh"]

CMD ["php-fpm8", "--nodaemonize"]
