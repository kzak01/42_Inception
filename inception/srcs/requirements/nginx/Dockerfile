FROM alpine:3.17

RUN apk update && apk upgrade && apk add --no-cache nginx

COPY ./conf/nginx.conf /etc/nginx/conf.d

RUN apk add openssl \
	&& mkdir -p /etc/nginx/ssl \
	&& cd /etc/nginx/ssl \
	&& openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/$USERNAME.42.fr.key -out /etc/ssl/$USERNAME.42.fr.crt -subj "/C=IT/L=Rome/O=42Roma/OU=student/CN=$USERNAME.42.fr"
	# && chmod +r nginx.crt nginx.key

RUN	mkdir -p /run/nginx
RUN	mkdir -p /var/www/html

WORKDIR /var/www/html

ENTRYPOINT [ "nginx", "-g", "daemon off;" ]
