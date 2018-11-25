# QEMU-renice
renice bash script for qemu processes

Usage:
1. Change the line `taskset --cpu-list --all-tasks --pid 1,5,2,6,3,7 $QEMUPID` according to your cores
2. make the script executable
3. vfio_renice.sh -15
