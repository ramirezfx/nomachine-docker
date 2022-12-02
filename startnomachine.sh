#!/bin/bash

HOME="$(echo ~)"

set -e

if [[ -n "$(docker ps -qaf 'name=ramirezfx/nomachine:latest-en')" ]]; then
	docker restart ramirezfx/nomachine:latest-en
else
	USER_UID=$(id -u)
	USER_GID=$(id -g)
	xhost +local:docker

	docker run --shm-size=2g --rm \
                --security-opt seccomp=unconfined \
		--env=USER_UID=$USER_UID \
		--env=USER_GID=$USER_GID \
		--env=DISPLAY=unix$DISPLAY \
		-v ${HOME}/docker/nomachine-home:/home/nomachine \
		--volume=/tmp/.X11-unix:/tmp/.X11-unix:ro \
		--volume=/run/user/$USER_UID/pulse:/run/pulse:ro \
		--name nomachine \
		ramirezfx/nomachine:latest-en
fi
