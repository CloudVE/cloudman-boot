#!/bin/sh
HOST_NAME=${1:-127.0.0.1}
if [ $HOST_NAME = '--use-public-ip' ]
then
   HOST_NAME=$(curl http://whatismyip.akamai.com)
fi
docker run -v /var/run/docker.sock:/var/run/docker.sock -e "RANCHER_SERVER=$HOST_NAME" --net=host almahmoud/cloudman-boot:test
