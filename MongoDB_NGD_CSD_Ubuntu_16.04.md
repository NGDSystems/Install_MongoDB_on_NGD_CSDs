# Installing MongoDB on NGD CSDs with Ubuntu 16.04 OS
Here are some simple commands to install MongoDB on NGD Systems CSD (Computational Storage Drive) when using Ubuntu 16.04 as its OS.

```
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.6 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.6.list
sudo apt-get update
sudo apt-get install -y mongodb-org
sudo apt-get -f install
sudo service mongod start
```

Entering the MongoDB environment:
```
mongo localhost:27017
>help
>exit
```

Changing CSD IP address:

```
sudo service mongod stop
sudo vim /etc/mongod.conf
```

```
# ---- Start of mongod.conf ------
# for documentation of all options, see:
#   http://docs.mongodb.org/manual/reference/configuration-options/
# Where and how to store data.
storage:
  dbPath: /var/lib/mongodb
  journal:
    enabled: true
#  engine:
#  mmapv1:
#  wiredTiger:
# where to write logging data.
systemLog:
  destination: file
  logAppend: true
  path: /var/log/mongodb/mongod.log
# network interfaces
net:
  port: 27017
  bindIp: 127.0.0.1
# how the process runs
processManagement:
  timeZoneInfo: /usr/share/zoneinfo
#security:
#operationProfiling:
#replication:
#sharding:
## Enterprise-Only Options:
#auditLog:
#snmp:
#---- End of mongod.conf ------------------
```
In the above file, change the bindIp from 127.0.0.1 to 10.1.1.2 (assuming that the IP address of CSD is 10.1.1.2)

