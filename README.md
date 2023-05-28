# docker-smokeping-speedtest
![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/jwigley/docker-smokeping-speedtest/main.yml?branch=main&label=build%20%28main%29)
![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/jwigley/docker-smokeping-speedtest/daily.yml?branch=main&label=build%20%28nightly%29)
![Docker Image Size (tag)](https://img.shields.io/docker/image-size/jwigley/smokeping-speedtest/latest)
[![Docker Pulls](https://img.shields.io/docker/pulls/jwigley/smokeping-speedtest.svg)](https://hub.docker.com/r/jwigley/smokeping-speedtest/)

Smokeping docker image with [smokeping-speedtest](https://github.com/mad-ady/smokeping-speedtest) probe and [speedtest-cli](https://github.com/sivel/speedtest-cli), built upon linuxserver's [docker-smokeping](https://github.com/linuxserver/docker-smokeping) image.

## docker repositories

[jwigley/smokeping-speedtest](https://hub.docker.com/r/jwigley/smokeping-speedtest) (docker hub)

[ghcr.io/jwigley/smokeping-speedtest](https://github.com/jwigley/docker-smokeping-speedtest/pkgs/container/smokeping-speedtest) (github)

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

## ssh probe

This image also contains a working version of the [SSH Probe](https://oss.oetiker.ch/smokeping/probe/SSH.en.html), which is [currently broken](https://github.com/linuxserver/docker-smokeping/issues/142) in the underlying linuxserver image.

If you add an SSH probe to your configuration, you must also set the `SSH_PROBE_INIT_TARGET` environment variable to a valid host running SSH. During initialisation, the probe will ask the target for its public key and verify it can parse the output.

eg.
```bash
docker run \
  -d \
  --name=smokeping-speedtest \
  -e SSH_PROBE_INIT_TARGET=my.host \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/London \
  -p 80:80 \
  -v /path/to/smokeping/config:/config \
  -v /path/to/smokeping/data:/data \
  --restart unless-stopped \
  jwigley/smokeping-speedtest
```

## credits

This docker image just pieces the bits together. The real work is all done by:
  - [mad-ady](https://github.com/mad-ady)'s [smokeping-speedtest](https://github.com/mad-ady/smokeping-speedtest)
  - [sivel](https://github.com/sivel)'s [speedtest-cli](https://github.com/sivel/speedtest-cli)
  - [linuxserver](https://github.com/linuxserver)'s [docker-smokeping](https://github.com/linuxserver/docker-smokeping)
