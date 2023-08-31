# Use the Alpine Linux 3.17 base image
FROM alpine:3.17

# Update and upgrade package repositories, and install MySQL and MySQL client without caching package indexes
RUN apk update && apk upgrade && \
	apk add --no-cache mysql mysql-client

# Copy the configuration script into the container's temporary directory
COPY ./tools/configure.sh /tmp/configure.sh

# EXPOSE 3306

# Set the entrypoint to run the configuration script when the container starts
ENTRYPOINT ["sh", "/tmp/configure.sh"]
