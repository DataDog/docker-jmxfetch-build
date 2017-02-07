FROM openjdk:8-jdk
MAINTAINER Jaime Fullaondo @truthbk
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt-get update && apt-get install -y \
    curl \
    git \
    maven

COPY build.sh /

VOLUME ["/pkg", "/jmxfetch"]
ENTRYPOINT /bin/bash -l /build.sh
