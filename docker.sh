#!/bin/bash

# Stop and remove any existing container with the same name
docker stop forum-container
docker rm forum-container

# Build the Docker image
docker build -t my-forum-image .

# Run the Docker container
docker run --name forum-container -detach -p 8080:8080 my-forum-image
