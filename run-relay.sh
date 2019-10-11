#!/bin/bash

docker run -d --restart=always --name tor-relay mapic/tor-relay:latest 

docker logs tor-relay -f