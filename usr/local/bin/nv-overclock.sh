#!/usr/bin/env bash

#Set overclock on Nvidia GPU

#Make sure nvidia-settings exists
command -v nvidia-settings -v &> /dev/null || { echo >&2 "nvidia-settings not found ... exiting."; exit 1; }

/usr/bin/nvidia-settings -a GpuGraphicsClockOffsetAllPerformanceLevels=100 -a GpuMemoryTransferRateOffsetAllPerformanceLevels=3000 -w

exit 0
