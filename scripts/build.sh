#!/bin/bash

# Current script directory
SCRIPT_DIR=$(dirname $(readlink -f $0))

# Network configuration
NETWORK_NAME="virtuoworks_network"

# Create network if it doesn't exist
docker network inspect $NETWORK_NAME >/dev/null 2>&1 || docker network create $NETWORK_NAME

# Image names
NGINX_NAME="local/virtuoworks/nginx"

# Image tagging configuration
TAG=$(git log -1 --pretty=%h)
NGINX_LATEST="$NGINX_NAME:latest"
NGINX_TAGGED="$NGINX_NAME:$TAG"

# Removing old Nginx images
docker image rm "$NGINX_LATEST" "$NGINX_TAGGED" 2> /dev/null

# Build Nginx
docker build -t "$NGINX_LATEST" -t "$NGINX_TAGGED" ${SCRIPT_DIR}
