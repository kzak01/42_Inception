FROM alpine:3.17

RUN	apk update && apk upgrade && \
	apk add --no-cache mysql mysql-client

COPY ./tools/configure.sh /tmp/configure.sh

ENTRYPOINT ["sh", "/tmp/configure.sh"]
