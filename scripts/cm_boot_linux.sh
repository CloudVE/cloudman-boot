#!/bin/sh
docker run -v /var/run/docker.sock:/var/run/docker.sock -e RANCHER_SERVER=127.0.0.1 --net=host galaxy/cloudman-boot
