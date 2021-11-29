```bash
#!/usr/bin/env bash

function print_usage() {
echo "\
Usage: demo [OPTIONS]
Starts a demo with the based on the supplied options.
    --H or --host      Mandatory:* Pass the hostname.
    --A or --address   Mandatory:* Pass the address
"
}

optspec=":hv-:"
while getopts "$optspec" optchar; do

    case "${optchar}" in
        -)
            case "${OPTARG}" in
                H=*|host=*)
                    HOST=${OPTARG##*=}
                    ;;
                A=*|address=*)
                    ADDRESS=${OPTARG##*=}
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

# OR CONDITION => if [ $ADDRESS ] || [ $HOST ]; then
# AND CONDITION => if [ $ADDRESS ] && [ $HOST ]; then

if [ $ADDRESS ] || [ $HOST ]; then
   echo $HOST $ADDRESS
else
   print_usage
fi


# Run the command bash demo.sh --host=jino  --address="0.0.0.0"
# Run the command ./demo.sh --H=jino  --A="0.0.0.0"

```
