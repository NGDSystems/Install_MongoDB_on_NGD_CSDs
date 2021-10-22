#!/bin/bash
R=20
for ((i=1; i<=$R; i++ ))
do 
    echo " -------- ycsb$i -------";
    gnome-terminal --tab --active -- bash -c "./bin/ycsb load mongodb -s -P workloads/workloada -p insertorder=ordered -p mongodb.url=mongodb://10.20.28.11:270$((30+i))/ycsb$i?w=0; exec bash"
done

