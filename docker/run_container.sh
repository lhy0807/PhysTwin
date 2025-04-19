docker rm -f phystwin
DIR=$(pwd)/
DATA_DIR=/mnt/F0B5E92945E64B0D/PhysTwinData/

# Dynamically map every folder under $DATA_DIR to $DIR
VOLUME_MOUNTS=""
for folder in "$DATA_DIR"*/; do
    folder_name=$(basename "$folder")
    VOLUME_MOUNTS="$VOLUME_MOUNTS -v $folder:$DIR$folder_name"
done

xhost + && docker run --gpus all -it --network=host \
    --name phystwin --cap-add=SYS_PTRACE --security-opt seccomp=unconfined \
    -v $DIR:$DIR -v /home:/home -v /tmp/.X11-unix:/tmp/.X11-unix -v /tmp:/tmp \
    $VOLUME_MOUNTS --ipc=host -e DISPLAY=${DISPLAY} -e GIT_INDEX_FILE phystwin:latest bash -c "cd $DIR && bash"