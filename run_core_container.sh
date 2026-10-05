#!/bin/bash

CONTAINER=$(docker container ls -a | grep devdkerr | cut -d" " -f1)

docker container stop $CONTAINER
docker container rm $CONTAINER

docker run \
    --detach \
    --name cdar \
    --cap-add=ALL \
    --publish 22 \
    --publish 50051 \
    --privileged \
    --volume /lib/modules:/lib/modules \
    --volume .:/tmp \
    devdkerr/core

# Generar la clave id_rsa.pub mediante este tutorial: https://es.siteground.com/kb/generar-clave-ssh-linux/
docker cp ~/.ssh/id_rsa.pub cdar:/root/.ssh/authorized_keys
docker exec cdar chmod 600 /root/.ssh/authorized_keys
docker exec cdar chown root:root /root/.ssh/authorized_keys
