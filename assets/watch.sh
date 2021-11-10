#!/bin/bash

mkdir -p ../priv/static/css
mkdir -p ../priv/static/js

hasher=$(which md5 2> /dev/null && echo "md5" || echo "md5sum")
chsum1=""

while [[ true ]]
do
    chsum2=`find ./ -type f -exec $hasher {} \;`
    if [[ $chsum1 != $chsum2 ]] ; then           
        if [ -n "$chsum1" ]; then
            make all
        fi
        chsum1=$chsum2
    fi
    sleep 2
done
