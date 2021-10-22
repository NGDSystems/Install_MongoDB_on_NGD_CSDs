# Three NGD drive setup
# Preparation
# 1. On each node, mount the data partition file-system to /mnt/mongo
# 2. Create directory /mnt/mongo/localdata
# 3. Create ssh shorthands for n1..3 (or replace with ngd@nodeX)

DATADIR=/home/ngd
HOST=kapapa
HOST_IP=10.20.28.10
HOST_rPORT=27051
# Number of NGD drives 
N=3
# Number of Routers 
R=3

mkdir ${DATADIR}/mongo
mkdir ${DATADIR}/mongo/cfg

echo "Start mongo servers"
# Start config server
sudo mongod --configsvr --replSet rscfg --dbpath ${DATADIR}/mongo/cfg --bind_ip ${HOST_IP} --port 27001 --fork --logpath=${DATADIR}/mongo/cfg.log

sleep 2
# Start data server on each node
for ((i=1; i<=$N; i++ )) do 
  echo " -------- Start mongo on ngd$i -------"; 
  ssh -t 10.1.$i.2 "sudo mongod --shardsvr --replSet set$i --dbpath /mnt/mongo/localdata --bind_ip 10.1.$i.2 --port 27018 --fork --logpath=/home/ngd/mongo.log;sleep 2"; 
  ssh -t 10.1.$((i+3)).2 "sudo mongod --shardsvr --replSet set$i --dbpath /mnt/mongo/localdata --bind_ip 10.1.$((i+3)).2 --port 27018 --fork --logpath=/home/ngd/mongo.log;sleep 2"; 
  ssh -t 10.1.$((i+6)).2 "sudo mongod --shardsvr --replSet set$i --dbpath /mnt/mongo/localdata --bind_ip 10.1.$((i+6)).2 --port 27018 --fork --logpath=/home/ngd/mongo.log;sleep 2"; 
done


echo "Initiate config servers"
# Initiate config server
mongo ${HOST_IP}:27001 --eval "printjson(rs.initiate())"

# Initiate data servers
for ((i=1; i<=$N; i++ )) do echo " -------- Initiate data server on ngd$i -------"; mongo 10.1.$i.2:27018 --eval "printjson(rs.initiate())"; done

# add replications servers 
for ((i=1; i<=$N; i++ )) do 
  echo " -------- add replications servers ngd$i -------"; 
  mongo 10.1.$i.2:27018 --eval "printjson(rs.add({ host: \"10.1.$((i+3)).2:27018\", priority: 0, votes: 0 }))";
  mongo 10.1.$i.2:27018 --eval "printjson(rs.add({ host: \"10.1.$((i+6)).2:27018\", priority: 0, votes: 0 }))";
done


#---------------------
sleep 2

# Initiate query server (on host)
for ((i=51; i<$((51+R)); i++ )) do 
  echo " -------- Initiate query server on port 270$i -------"; 
  sudo mongos --configdb rscfg/${HOST_IP}:27001 --bind_ip ${HOST_IP} --port 270$i --fork --logpath=${DATADIR}/mongo/mongos$i.log; 
done

sleep 2

echo "Add shards"
for ((i=1; i<=$N; i++ )) do echo " -------- Add shard on ngd$i -------"; mongo ${HOST_IP}:${HOST_rPORT}  --eval "printjson(sh.addShard(\"set$i/10.1.$i.2:27018\"))"; done

echo "Enable Sharding"
for ((i=1; i<=$R; i++ )) do 
  echo " -------- Enable Sharding  on ycsb$i -------"; 
  #mongo ${HOST_IP}:${HOST_rPORT} --eval "printjson(use ycsb$i)"
  #mongo ${HOST_IP}:${HOST_rPORT} --eval "printjson(sh.enableSharding(use ycsb$i))"
  mongo ${HOST_IP}:${HOST_rPORT}/ycsb$i --eval "printjson(sh.enableSharding(\"ycsb$i\"))"
  mongo ${HOST_IP}:${HOST_rPORT}/ycsb$i --eval "printjson(db.usertable.ensureIndex( { _id : \"hashed\" } ))"
  mongo ${HOST_IP}:${HOST_rPORT}/ycsb$i --eval "printjson(sh.shardCollection( \"ycsb$i.usertable\", { \"_id\" : \"hashed\" } ))"
done

echo Done







