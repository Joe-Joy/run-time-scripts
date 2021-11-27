#!/usr/bin/env bash
function print_usage() {

echo "\
Usage: demo [OPTIONS]
Starts a demo with the based on the supplied options.
    --name    Mandatory:* Pass the hostname.
    --image   Mandatory:* Pass the image name.
    --cport   Mandatory:* Pass the acontainer port
    --hport   Mandatory:* Pass the host port
    --username   Mandatory:* Pass the host port
    --version   Mandatory:* Pass the host port
"
}

optspec=":hv-:"
while getopts "$optspec" optchar; do

    case "${optchar}" in
        -)
            case "${OPTARG}" in
                name=*)
                    CONTAINER_NAME=${OPTARG##*=}
                    ;;
                image=*)
                    IMAGE_NAME=${OPTARG##*=}
                    ;;
                cport=*)
                    CONTAINER_PORT=${OPTARG##*=}
                    ;; 
                hport=*)
                    HOST_PORT=${OPTARG##*=}
                    ;;  
                username=*)
                    USERNAME=${OPTARG##*=}
                    ;;  
                version=*)
                    VERSION=${OPTARG##*=}
                    ;;  
                *)
                    echo "Unknown option --${OPTARG}" >&2
                    exit 1
                    ;;
            esac;;
        h)
            print_usage
            exit
            ;;
        v)
            echo "Parsing option: '-${optchar}'" >&2
            ;;
        *)
            if [ "$OPTERR" != 1 ] || [ "${optspec:0:1}" = ":" ]; then
                echo "Non-option argument: '-${OPTARG}'" >&2
            fi
            ;;
    esac
done


container=`sudo docker ps -a -f name=$CONTAINER_NAME -q`

if [[ "$container" ]]
then
    sudo docker rm -f $container
else
    echo "Container was not found"
fi

# docker container start -> $1
sudo docker run -d --name $CONTAINER_NAME -p $HOST_PORT:$CONTAINER_PORT "$USERNAME/$IMAGE_NAME:$VERSION"

if [ "$(sudo docker container inspect -f '{{.State.Running}}' $CONTAINER_NAME )" == "true" ]; then 
    echo "container running now"
else 
    exit 0
fi
