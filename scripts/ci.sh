#!/bin/bash
set -e

IMAGE_NAME=ghcr.io/stuartleeks/dotnet-app-insights-ping/runner

figlet "ghcr.io login"
echo "$GITHUB_TOKEN" | docker login --username stuartleeks --password-stdin ghcr.io


figlet "Build image"
docker build -t "$IMAGE_NAME" -f Dockerfile  .


figlet "Push image"
docker push "$IMAGE_NAME"
