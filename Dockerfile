FROM debian:jessie

MAINTAINER https://keybase.io/knutole

EXPOSE 9001
ENV DEBIAN_FRONTEND noninteractive

ADD apt-pinning /etc/apt/preferences.d/pinning
RUN echo 'deb http://deb.torproject.org/torproject.org jessie main' > /etc/apt/sources.list.d/tor.list && \
    gpg --keyserver keys.gnupg.net --recv 886DDD89 && \
    gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | apt-key add -
RUN apt-get update && apt-get install -y \
    deb.torproject.org-keyring \
    obfsproxy \
    openssl \
    tor

WORKDIR /var/lib/tor

ADD ./torrc /etc/torrc
# Allow you to upgrade your relay without having to regenerate keys
# VOLUME /var/lib/tor

VOLUME /.tor

# Generate a random nickname for the relay
RUN echo "Nickname mapic$(head -c 16 /dev/urandom  | sha1sum | cut -c1-10)" >> /etc/torrc

ADD ./docker-entrypoint.sh docker-entrypoint.sh
CMD bash docker-entrypoint.sh
# CMD /usr/bin/tor -f /etc/torrc
