FROM ubuntu:15.10

MAINTAINER Jake Pelletier <ghjnut@gmail.com>

ENV NOIP_PORT 8425
ENV NOIP_VERSION 2.1.9-1

RUN apt-get update \
 && apt-get install -y \
   wget \
   make \
   gcc \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir -p /usr/src/noip \
	&& cd /usr/src/noip \
	&& wget http://www.no-ip.com/client/linux/noip-duc-linux.tar.gz \
	&& tar -xvzf /usr/src/noip/noip-duc-linux.tar.gz \
	&& cd /usr/src/noip/noip-${NOIP_VERSION} \
	&& make \
	&& ln -s /usr/src/noip/noip-${NOIP_VERSION}/noip2 /bin/noip2

WORKDIR /usr/src/noip/noip-${NOIP_VERSION}

ENTRYPOINT ["noip2"]
