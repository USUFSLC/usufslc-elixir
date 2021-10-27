#!/bin/bash

chsum1=""

while [[ true ]]
do
    chsum2=`find ./ -type f -exec md5 {} \;`
    if [[ $chsum1 != $chsum2 ]] ; then           
        if [ -n "$chsum1" ]; then
            make all
        fi
        chsum1=$chsum2
    fi
    sleep 2
done
