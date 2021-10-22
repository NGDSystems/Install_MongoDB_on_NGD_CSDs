#!/bin/bash

# Preparation
# Mount data partition from NGD device to /media/newport_[0-N] (the drives that we use for this experiment)

DATADIR=/media/newport_
CONFIGDIR=/home/ngd
HOST=kapapa
HOST_IP=10.20.28.11
HOST_rPORT=27031
# Number of host threads 
N=20
# Number of Routers 
R=20

sudo killall mongod mongos

sleep 2

# Delete all shard databases 
for ((i=1; i<=$N; i++ )) do echo " -------- Delete mongo dir  $i -------"; rm -r ${DATADIR}$i/*; done
#for ((i=1; i<=$N; i++ )) do echo " -------- Make mono dir  $i -------"; mkdir  ${DATADIR}$i; done
# Delete configuration database
rm -r ${CONFIGDIR}/mongof

echo Done





