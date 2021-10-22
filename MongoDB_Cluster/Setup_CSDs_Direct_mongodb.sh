# N NGD drive setup
# Preparation
# 1. On each node, mount the data partition file-system to /mnt/mongo
# 2. Create directory /mnt/mongo/localdata
# 3. It is assumed that NGD CSDs have IP address from 10.1.1.2 to 10.1.N.2


# Number of NGD drives 
N=20

echo "Start mongo servers"
sleep 2
# Start data server on each node
for ((i=1; i<=$N; i++ )) do 
  echo " -------- Start mongo on ngd$i -------"; 
  ssh -t 10.1.$i.2 "sudo mongod --shardsvr --replSet set$i --dbpath /mnt/mongo/localdata --bind_ip 10.1.$i.2 --port 27018 --fork --logpath=/home/ngd/mongo.log;sleep 2"; 
done


# Initiate data servers
for ((i=1; i<=$N; i++ )) do echo " -------- Initiate data server on ngd$i -------"; mongo 10.1.$i.2:27018 --eval "printjson(rs.initiate())"; done


echo Done




