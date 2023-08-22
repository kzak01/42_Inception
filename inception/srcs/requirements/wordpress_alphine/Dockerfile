FROM alpine:3.17

RUN	apk update && apk upgrade
RUN	apk add curl php php-fpm php-mysqli php-curl php-dom php-exif php-fileinfo php-xml php-zip php-phar php-tokenizer
RUN	apk add php8-pecl-redis --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing/

RUN	adduser -S nginx && addgroup -S nginx

RUN	mkdir -p /var/www/html
COPY tools/configure.sh /tmp/configure.sh
COPY conf/www.conf	/etc/php8/php-fpm.d/www.conf

RUN	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
		chmod +x wp-cli.phar && \
		mv wp-cli.phar /usr/local/bin/wp

WORKDIR	/var/www/html/wordpress

ENTRYPOINT [ "sh", "/tmp/configure.sh" ]
