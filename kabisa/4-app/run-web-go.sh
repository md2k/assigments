#!/usr/bin/env sh

docker-compose -f ${DOCKER_TARGET}/docker-compose.yaml up

echo "Cleanup images/caches/layers/sources...."
docker-compose -f ${DOCKER_TARGET}/docker-compose.yaml down
docker image rm docker_flask:latest
docker image prune -f
docker builder prune -f
rm -rf ${DOCKER_TARGET}/src
