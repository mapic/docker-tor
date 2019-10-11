#!/bin/bash

# create nick
echo "Nickname mapic000$(head -c 16 /dev/urandom | sha1sum | cut -c1-5)" >> /etc/tor/torrc

cat /etc/tor/torrc

# start tor
/usr/bin/tor -f /etc/tor/torrc
