#!/bin/bash

# ensure latest tor
apt-get update -y
apt-get upgrade -y tor

# start tor
/usr/bin/tor -f /etc/torrc
