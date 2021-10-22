#!/bin/bash
R=20
for ((i=1; i<=$R; i++ ))
do 
    echo " -------- ycsb_d$i -------";
    gnome-terminal --tab --active -- bash -c "./bin/ycsb load mongodb -s -P workloads/workloada -p insertorder=ordered -p mongodb.url=mongodb://10.1.$i.2:27018/ycsb_d$i?w=0; exec bash"
done
