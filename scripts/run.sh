#!/bin/bash

# Current script directory
SCRIPT_DIR=$(dirname $(readlink -f $0))

# Network configuration
NETWORK_NAME="virtuoworks_network"

# Image names
NGINX_NAME="local/virtuoworks/nginx"

# Container names
NGINX_CONTAINER_NAME="nginx.virtuoworks.local"

# Get the latest git tag for the image
TAG=$(git log -1 --pretty=%h)
NGINX_LATEST="$NGINX_NAME:latest"
NGINX_TAGGED="$NGINX_NAME:$TAG"

# Stopping any old Nginx containers
docker stop "$NGINX_CONTAINER_NAME" 2> /dev/null;
docker rm "$NGINX_CONTAINER_NAME" 2> /dev/null;

# Running Nginx container
docker run -d \
  --name "$NGINX_CONTAINER_NAME" \
  --network $NETWORK_NAME \
  -p 80:80\
  "$NGINX_TAGGED"

