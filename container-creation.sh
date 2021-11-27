#!/usr/bin/env bash
function print_usage() {

echo "\
Usage: demo [OPTIONS]
Starts a demo with the based on the supplied options.
    --name    Mandatory:* Pass the hostname.
    --image   Mandatory:* Pass the image name.
    --cport   Mandatory:* Pass the acontainer port
    --hport   Mandatory:* Pass the host port
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
                address=*)
                    IMAGE_NAME=${OPTARG##*=}
                    ;;
                cport=*)
                    CONTAINER_PORT=${OPTARG##*=}
                    ;; 
                hport=*)
                    HOST_PORT=${OPTARG##*=}
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


container=`docker ps -a -f name=$CONTAINER_NAME -q`

if [[ "$container" ]]
then
    docker rm -f $container
else
    echo "Container was not found"
fi

# docker container start -> $1
docker run -d --name $CONTAINER_NAME -p $HOST_PORT:$CONTAINER_PORT $IMAGE_NAME

if [ "$( docker container inspect -f '{{.State.Running}}' $CONTAINER_NAME )" == "true" ]; then 
    echo "container running now"
else 
    exit 0
fi
