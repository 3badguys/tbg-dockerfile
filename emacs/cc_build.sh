#!/usr/bin/env bash

function docker_build() {
    local docker_name="$1"

    docker build -f Dockerfile -t "$docker_name":latest .
}

function docker_run() {
    local docker_name="$1"
    local display_ip="$2"

    docker run -it --name emacs --privileged --pid=host -e DISPLAY="$display_ip":0 -v /tmp/.X11-unix:/tmp/.X11-unix "$docker_name"
}

emacs_docker='chuic456/emacs'

image_id=$(docker images | grep "$emacs_docker" | awk '{print $3}')
if [ -z "$image_id" ]; then
    docker_build "$emacs_docker"
fi

ip=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
xhost + "$ip"

container_id=$(docker ps -a | grep "$emacs_docker" | awk '{print $1}')
if [ -z "$container_id" ]; then
    docker_run "$emacs_docker" "$ip"
else
    container_is_exited=$(docker ps -a | grep "$container_id" | grep Exited)
    display_ip=$(docker inspect "$container_id" | grep DISPLAY | grep -E -o '([0-9]{1,3}.){3}[0-9]{1,3}')
    if [ "$display_ip" != "$ip" ]; then
        if [ -z "$container_is_exited" ]; then
            docker stop "$container_id"
        fi
        docker rm "$container_id"
        docker_run "$emacs_docker" "$ip"
    elif [ -n "$container_is_exited" ]; then
        docker start "$container_id"
    fi
fi
