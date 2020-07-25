HOME="$(echo ~)"
mkdir -p ${HOME}/docker/nomachine-home
xhost +

docker run -ti \
    --rm \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v ${HOME}/docker/nomachine-home:/home/nomachine \
    --workdir ${HOME} \
    -e DISPLAY=$DISPLAY \
    -e HOME=${HOME} \
    -e USER=${USER} \
    -e USERID=${UID} \
    ramirezfx/nomachine:latest
