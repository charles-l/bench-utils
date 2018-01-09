#!/bin/sh
# make ensure CPU's behave deterministically (by isolating a core and disabling CPU scaling)

CSET=~/wrk/cpuset/cset

sudo sh -c 'echo 0 > /proc/sys/kernel/randomize_va_space'
for i in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
do
    sudo sh -c "echo performance > $i"
done
sudo $CSET set -r -d --force root
sudo $CSET shield -c 0,7 -k on
