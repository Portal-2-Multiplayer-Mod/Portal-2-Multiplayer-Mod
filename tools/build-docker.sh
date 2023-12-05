#!/bin/bash

docker buildx build -t p2mm:1 .
# https://stackoverflow.com/a/49021109/12429279
docker run --name p2mm-build --device /dev/fuse --cap-add SYS_ADMIN --security-opt apparmor:unconfined p2mm:1 bash -c "/app/tools/build-appimage.sh"

echo "--------------------- done"

mkdir -p build

docker cp p2mm-build:/app/build/. build/.