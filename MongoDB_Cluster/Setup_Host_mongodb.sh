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

mkdir ${CONFIGDIR}/mongof
mkdir ${CONFIGDIR}/mongof/log


echo "Starting mongo servers"

# Start Config Server
mongod --configsvr --replSet rscfg --dbpath ${CONFIGDIR}/mongof --bind_ip ${HOST_IP} --port 27000 --fork --logpath=${CONFIGDIR}/mongof/log/cfg.log;

# Start Shards
for ((i=1; i<=$N; i++ )) do 
  echo " -------- Start Shards $i -------"; 
  mongod --shardsvr --replSet set$i --dbpath ${DATADIR}$i --bind_ip ${HOST_IP} --port 270$((10+i)) --fork --logpath=${CONFIGDIR}/mongof/log/db$i.log; 
done


echo "Configure Mongo Servers"
# Initiate Config Server
mongo ${HOST_IP}:27000 --eval "printjson(rs.initiate())"

# Initiate Shards
for ((i=1; i<=$N; i++ )) do 
  echo " -------- Initiate Shards $i -------"; 
  mongo ${HOST_IP}:270$((10+i)) --eval "printjson(rs.initiate())"; 
done

sleep 2


# Initiate query servers (on host)
for ((i=31; i<$((31+R)); i++ )) do 
  echo " -------- Initiate query server on port 270$i -------"; 
  mongos --configdb rscfg/${HOST_IP}:27000 --bind_ip ${HOST_IP} --port 270$i --fork --logpath=${CONFIGDIR}/mongof/log/mongos$i.log; 
done




sleep 2

echo "Add Shards"
# Add data server shards (one data server per replica set
for ((i=1; i<=$N; i++ )) do 
  echo " -------- Add Shards $i -------"; 
  mongo ${HOST_IP}:${HOST_rPORT} --eval "printjson(sh.addShard(\"set$i/${HOST_IP}:270$((10+i))\"))";
done


echo "Enable Sharding"
for ((i=1; i<=$R; i++ )) do 
  echo " -------- Enable Sharding  on ycsb$i -------"; 
  mongo ${HOST_IP}:${HOST_rPORT}/ycsb$i --eval "printjson(use ycsb$i)"
  mongo ${HOST_IP}:${HOST_rPORT}/ycsb$i --eval "printjson(sh.enableSharding(\"ycsb$i\"))"
  mongo ${HOST_IP}:${HOST_rPORT}/ycsb$i --eval "printjson(db.usertable.ensureIndex( { _id : \"hashed\" } ))"
  mongo ${HOST_IP}:${HOST_rPORT}/ycsb$i --eval "printjson(sh.shardCollection( \"ycsb$i.usertable\", { \"_id\" : \"hashed\" } ))"
done

echo Done





