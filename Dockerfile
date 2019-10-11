# Base docker image
FROM debian:buster

# LABEL maintainer="Philipp Winter <phw@torproject.org>"

# Install dependencies
RUN apt-get update && apt-get install -y \
    tor \
    tor-geoipdb \
    obfs4proxy \
    --no-install-recommends

# add torrc file (Nickname is auto-generated on launch)
RUN rm /etc/tor/torrc
ADD torrc /etc/tor/torrc
RUN chown debian-tor:debian-tor /etc/tor
RUN chown debian-tor:debian-tor /etc/tor/torrc
RUN chown debian-tor:debian-tor /var/log/tor

ADD docker-entrypoint.sh /usr/local/bin
RUN chown debian-tor:debian-tor /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

USER debian-tor

CMD [ "/bin/bash", "-c", "/usr/local/bin/docker-entrypoint.sh" ]
