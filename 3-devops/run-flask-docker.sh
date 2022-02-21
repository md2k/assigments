#!/usr/bin/env sh

source ./values.sh

echo "Cloning ${REPO} into ${DOCKER_TARGET} dir..."
mkdir -p ${DOCKER_TARGET}
git clone ${REPO} ${DOCKER_TARGET}/src


echo "Running Docker compose..."
docker-compose -f ${DOCKER_TARGET}/docker-compose.yaml up

echo "Cleanup images/caches/layers/sources...."
docker-compose -f ${DOCKER_TARGET}/docker-compose.yaml down
docker image rm docker_flask:latest
docker image prune -f
docker builder prune -f
rm -rf ${DOCKER_TARGET}/src
