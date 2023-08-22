FROM alpine:3.17

RUN apk update && apk upgrade && apk add --no-cache nginx

COPY ./conf/nginx.conf /etc/nginx/conf.d

RUN apk add openssl \
	&& mkdir -p /etc/nginx/ssl \
	&& cd /etc/nginx/ssl \
	&& openssl req -x509 \
			-nodes \
			-subj "/C=IT/ST=Italy/L=Rome/O=42Rome/OU=$USER/CN=$USER" \
			-out inception.crt \
			-keyout inception.key \
	&& chmod +r nginx.crt nginx.key

RUN	mkdir -p /run/nginx
RUN	mkdir -p /var/www/html

WORKDIR /var/www/html

ENTRYPOINT [ "nginx", "-g", "daemon off;" ]
