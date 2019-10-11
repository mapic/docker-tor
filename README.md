# Docker Image for Tor Relay.

## Usage

### Build

```bash

# download
git clone git@github.com:mapic/docker-tor.git
cd docker-tor

# edit relay config (not necessary)
nano torrc 

# build iamge
bash build.sh
```

### Start
```bash

# start tor-relay
bash run-relay.sh
```
