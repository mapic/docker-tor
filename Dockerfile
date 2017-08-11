FROM debian:jessie

MAINTAINER https://keybase.io/knutole

# open ports
EXPOSE 9001 

ENV DEBIAN_FRONTEND noninteractive

ADD apt-pinning /etc/apt/preferences.d/pinning

# get keys
RUN echo 'deb http://deb.torproject.org/torproject.org jessie main' > /etc/apt/sources.list.d/tor.list && \
    gpg --keyserver keys.gnupg.net --recv 886DDD89 && \
    gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | apt-key add -

# install
RUN apt-get update && apt-get install -y \
    deb.torproject.org-keyring \
    obfsproxy \
    openssl \
    tor

# set workdir
WORKDIR /var/lib/tor

# config
ADD ./torrc /etc/torrc

# Allow you to upgrade your relay without having to regenerate keys
# VOLUME /var/lib/tor
VOLUME /.tor

# entrypoint
ADD ./docker-entrypoint.sh docker-entrypoint.sh
CMD bash docker-entrypoint.sh
