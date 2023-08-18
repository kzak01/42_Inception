FROM alpine:3.17

RUN apk update && apk upgrade && \
    apk add --no-cache php7 php7-fpm wget mysql-client && \
    addgroup -S nginx && adduser -S -D -H -h /var/www/html -s /sbin/nologin -G nginx nginx && \ 
    mkdir -p /var/www/html && \
    chown -R nginx:nginx /var/www/html && \
    cd /var/www/html && find . -type d -exec chmod 755 {} \; && find . -type f -exec chmod 644 {} \; && \
    mkdir -p /run/php && chown nginx:nginx /run/php

COPY tools/configure.sh /tmp/configure.sh
COPY conf/www.conf /etc/php7/php-fpm.d/

# Remove the entrypoint since we'll start services differently
# ENTRYPOINT [ "sh", "/tmp/configure.sh" ]
