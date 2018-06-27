#!/bin/sh
HOST_NAME=${1:-127.0.0.1}
docker run -v /var/run/docker.sock:/var/run/docker.sock -e "RANCHER_SERVER=$HOST_NAME" --net=host galaxy/cloudman-boot
