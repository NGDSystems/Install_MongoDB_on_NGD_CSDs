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

# Kill data servers, config server (on host) and query server (on host)
echo "Kill data servers"
sudo killall mongod mongos

for ((i=1; i<=$((N*3)); i++ )) do echo " -------- Kill mongod on ngd$i -------"; ssh -t 10.1.$i.2 "sudo killall mongod"; done

sleep 2

# Delete databases
for ((i=1; i<=$((N*3)); i++ )) do echo " -------- Delete databases on ngd$i -------"; ssh -t 10.1.$i.2 "sudo rm -r /mnt/mongo/localdata/*;sudo rm /home/ngd/mongo.log"; done


# Delete config database (on host)
echo "Delete config database (on host)"
sudo rm -r ${DATADIR}/mongo


echo Done







