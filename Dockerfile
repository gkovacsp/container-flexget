FROM lsiobase/alpine:arm32v7-3.12
LABEL maintainer "wiserain"

RUN apk add --no-cache python3
RUN apk add --no-cache --virtual=build-deps gcc libxml2-dev libxslt-dev libc-dev python3-dev jpeg-dev g++
RUN python3 -m ensurepip
RUN	pip3 install --no-cache --upgrade pip setuptools wheel
RUN	pip3 install --upgrade transmission-rpc

RUN apk add --no-cache bash bash-completion tzdata

# install dev packages again, otherwise might not work
RUN apk add --no-cache --virtual=build-deps gcc libxml2-dev libxslt-dev libc-dev python3-dev jpeg-dev g++

RUN pip3 install --no-cache --upgrade brotli

# copy local files
COPY root/ /

# add default volumes
VOLUME /config
WORKDIR /config

# expose port for flexget webui
EXPOSE 5051 5051/tcp
EXPOSE 5050 5050/tcp
