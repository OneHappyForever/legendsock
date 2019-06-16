FROM alpine:edge

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

RUN apk --no-cache add python \
    py-pip \
    py-m2crypto \
    libsodium \
    git&& \
    pip install cymysql

RUN git clone -b docker https://github.com/OneHappyForever/legendsock.git /usr/local/legendsock && chmod -R 777 /usr/local/legendsock && mv /usr/local/legendsock/legendsock /usr/bin/legendsock && chmod -R 777 /usr/bin/legendsock

WORKDIR /usr/local/legendsock

ENTRYPOINT [ "sh", "-c", "sed -i \"s#\"_DATABASE_\"#\"$MYSQL_DB\"#g\" /usr/local/legendsock/usermysql.json && sed -i \"s#\"_USERNAME_\"#\"$MYSQL_USER\"#g\" /usr/local/legendsock/usermysql.json && sed -i \"s#\"_PASSWORD_\"#\"$MYSQL_PASS\"#g\" /usr/local/legendsock/usermysql.json && sed -i \"s#\"_HOSTNAME_\"#\"$MYSQL_HOST\"#g\" /usr/local/legendsock/usermysql.json && sed -i \"s#\"_PORT_\"#\"$MYSQL_PORT\"#g\" /usr/local/legendsock/usermysql.json && legendsock start" ]

RUN ["tail", "-f", "/dev/null"]
