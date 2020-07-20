# docker-smokeping-speedtest

[![Docker Build Status](https://img.shields.io/docker/cloud/build/jwigley/smokeping-speedtest.svg)](https://hub.docker.com/r/jwigley/smokeping-speedtest/)
[![Docker Pulls](https://img.shields.io/docker/pulls/jwigley/smokeping-speedtest.svg)](https://hub.docker.com/r/jwigley/smokeping-speedtest/)
[![Docker Automated build](https://img.shields.io/docker/cloud/automated/jwigley/smokeping-speedtest.svg)](https://hub.docker.com/r/jwigley/smokeping-speedtest/)

Smokeping docker image with [smokeping-speedtest](https://github.com/mad-ady/smokeping-speedtest) probe and [speedtest-cli](https://github.com/sivel/speedtest-cli), built upon linuxserver's [docker-smokeping](https://github.com/linuxserver/docker-smokeping) image.

## docker repository

[jwigley/smokeping-speedtest](https://hub.docker.com/r/jwigley/smokeping-speedtest)

## usage

```bash
docker run \
  -d \
  --name=smokeping-speedtest \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/London \
  -p 80:80 \
  -v /path/to/smokeping/config:/config \
  -v /path/to/smokeping/data:/data \
  --restart unless-stopped \
  jwigley/smokeping-speedtest
```

The default speedtest configuration will poll downloads/uploads every hour to your closest speedtest.net server.
Results are displayed under the 'Speed Tests' menu in Smokeping.
This can be modified by via the Probes and Targets config files as per the instructions at https://github.com/mad-ady/smokeping-speedtest.

## credits

This docker image just pieces the bits together. The real work is all done by:
  - [mad-ady](https://github.com/mad-ady)'s [smokeping-speedtest](https://github.com/mad-ady/smokeping-speedtest)
  - [sivel](https://github.com/sivel)'s [speedtest-cli](https://github.com/sivel/speedtest-cli)
  - [linuxserver](https://github.com/linuxserver)'s [docker-smokeping](https://github.com/linuxserver/docker-smokeping)
