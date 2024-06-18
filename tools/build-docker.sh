#!/bin/bash

docker rm p2mm-build # Remove the container in order for a fresh one to be created
docker buildx build -t p2mm:1 .
# https://stackoverflow.com/a/49021109/12429279
docker run --name p2mm-build --device /dev/fuse --cap-add SYS_ADMIN --security-opt apparmor:unconfined p2mm:1 bash -c "/app/tools/build-appimage.sh"

echo "--------------------- done"

mkdir -p dist

docker cp p2mm-build:/app/dist/. dist/.