#!/usr/bin/env bash

# Set power limits on all NVIDIA GPUs

# Make sure nvidia-smi exists 
command -v nvidia-smi &> /dev/null || { echo >&2 "nvidia-smi not found ... exiting."; exit 1; }

POWER_LIMIT=100
MAX_POWER_LIMIT=$(nvidia-smi -q -d POWER | grep 'Max Power Limit' | tr -s ' ' | cut -d ' ' -f 6)

if [[ ${POWER_LIMIT%.*}+0 -le ${MAX_POWER_LIMIT%.*}+0 ]]; then
    /usr/bin/nvidia-smi --persistence-mode=1
    /usr/bin/nvidia-smi --power-limit=${POWER_LIMIT}
else
    echo 'FAIL! POWER_LIMIT set above MAX_POWER_LIMIT ... '
    exit 1
fi

exit 0
