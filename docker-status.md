```bash

#!/usr/bin/env bash
running_containers=$(docker ps -a --filter status=running --format "{{.Names}}")
for i in $running_containers; do
    if [ $i == 'otp-server' ]; then
        echo "$i container is Running"
    elif [ $i == 'pd-servers' ]; then
        echo "$i container is Running"
    else
        echo "$i container is not Running"
    fi
done

# bash docker-status.sh

```
