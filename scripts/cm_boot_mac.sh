#!/bin/sh
VM_MEMORY=${1:-6000}   
docker-machine create --driver virtualbox --virtualbox-memory $VM_MEMORY cloudman
eval $(docker-machine env cloudman)
DOCKER_VM_IP=$(echo $DOCKER_HOST| awk -F/  '{print $3}' | cut -d: -f1)
echo $DOCKER_VM_IP
docker run -v /var/run/docker.sock:/var/run/docker.sock -e RANCHER_SERVER=$DOCKER_VM_IP galaxy/cloudman-boot
