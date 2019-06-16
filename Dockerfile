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

ENTRYPOINT ["/usr/local/legendsock/docker_run.sh"]

CMD ["tail", "-f", "/dev/null"]
