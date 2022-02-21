#!/usr/bin/env sh

docker-compose -f ./docker-compose.yaml up

echo "Cleanup images/caches/layers/sources...."
docker-compose -f ./docker-compose.yaml down
docker image rm 4-app_web-app-go:latest
docker image prune -f
docker builder prune -f
