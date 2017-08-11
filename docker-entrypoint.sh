#!/bin/bash

# ensure latest tor
apt-get update -y
apt-get upgrade -y tor

# create nick
echo "Nickname mapic$(head -c 16 /dev/urandom  | sha1sum | cut -c1-10)" >> /etc/torrc

# start tor
/usr/bin/tor -f /etc/torrc
