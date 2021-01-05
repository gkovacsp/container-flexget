FROM lsiobase/alpine:arm32v7-3.12
LABEL maintainer "wiserain"

RUN apk add --no-cache python3
RUN apk add --no-cache --virtual=build-deps gcc libxml2-dev libxslt-dev libc-dev python3-dev jpeg-dev
RUN if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi
RUN python3 -m ensurepip
RUN	rm -r /usr/lib/python*/ensurepip
RUN	pip3 install --no-cache --upgrade pip setuptools wheel
RUN	if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip; fi
RUN	pip install --upgrade transmission-rpc

RUN echo "**** install flexget ****"
RUN	pip install --upgrade --force-reinstall flexget
RUN apk del --purge --no-cache build-deps python3-dev
RUN apk add --no-cache libxml2 libxslt jpeg 

RUN \
	echo "**** system configurations ****" && \
	apk add --no-cache bash bash-completion tzdata

RUN \
	echo "**** cleanup ****" && \
	rm -rf \
		/tmp/* \
		/root/.cache

# RUN echo "3"

# copy local files
COPY root/ /

# add default volumes
VOLUME /config
WORKDIR /config

# expose port for flexget webui
EXPOSE 5051 5051/tcp
EXPOSE 5050 5050/tcp
