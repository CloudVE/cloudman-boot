#!/bin/sh
HOST_NAME=$(curl ifconfig.me)
docker run -v /var/run/docker.sock:/var/run/docker.sock -e "RANCHER_SERVER=$HOST_NAME" --net=host galaxy/cloudman-boot
