FROM alpine:3.17

# Update package repositories, upgrade existing packages, and install nginx and openssl
RUN	apk update && apk upgrade && apk add --no-cache nginx openssl

# Copy the nginx configuration file to the appropriate directory
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# Create SSL certificates using OpenSSL
RUN	mkdir -p /etc/nginx/ssl && cd /etc/nginx/ssl && \
	openssl req -x509 \
		-nodes \
		-subj "/C=IT/L=Rome/O=42Roma/OU=student/CN=$USERNAME.42.fr" \
		-out nginx.crt \
		-keyout nginx.key \
	&& chmod +r nginx.crt nginx.key

# Create a directory for nginx runtime data
RUN	mkdir -p /run/nginx

# Set the working directory for the container to /var/www/html
WORKDIR /var/www/html

# Set the entry point for the container to start nginx with a specific configuration
ENTRYPOINT ["nginx" , "-g" , "daemon off;"]
