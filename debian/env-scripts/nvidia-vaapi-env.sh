#! /bin/bash

# Check system for NVIDIA card and set vaapi env vars

nvkernmod=$(lspci -k | grep -iEA3 '^[[:alnum:]]{2}:[[:alnum:]]{2}.*VGA|3D|DISPLAY' | grep -i nvidia)

if [[ ! -z $nvkernmod ]]
then
    if switcherooctl list | awk 'ORS = $1 ~/Name/ ? " " : "\n"' | grep Default | grep yes | grep -E -i 'intel|amd|radeon|advanced' > /dev/null 2>&1
    then
        export MOZ_DISABLE_RDD_SANDBOX=1
        export NVD_BACKEND=direct
        export EGL_PLATFORM=$XDG_SESSION_TYPE
    else
        export LIBVA_DRIVER_NAME=nvidia
        export MOZ_DISABLE_RDD_SANDBOX=1
        export NVD_BACKEND=direct
        export EGL_PLATFORM=$XDG_SESSION_TYPE
    fi 
fi

