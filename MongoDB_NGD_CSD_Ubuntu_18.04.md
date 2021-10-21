# Installing MongoDB on NGD CSDs with Ubuntu 18.04 and Ubuntu 20.04 OS 
Here are some simple commands to install MongoDB on NGD Systems CSD (Computational Storage Drive) when using Ubuntu 18.04 and later as its OS.

```
mkdir ~/mongodb
cd ~/mongodb
wget https://repo.mongodb.org/apt/ubuntu/dists/bionic/mongodb-org/5.0/multiverse/binary-arm64/mongodb-org-database-tools-extra_5.0.3_arm64.deb
wget https://repo.mongodb.org/apt/ubuntu/dists/bionic/mongodb-org/5.0/multiverse/binary-arm64/mongodb-org-database_5.0.3_arm64.deb
wget https://repo.mongodb.org/apt/ubuntu/dists/bionic/mongodb-org/5.0/multiverse/binary-arm64/mongodb-org-mongos_5.0.3_arm64.deb
wget https://repo.mongodb.org/apt/ubuntu/dists/bionic/mongodb-org/5.0/multiverse/binary-arm64/mongodb-org-server_5.0.3_arm64.deb
wget https://repo.mongodb.org/apt/ubuntu/dists/bionic/mongodb-org/5.0/multiverse/binary-arm64/mongodb-org-shell_5.0.3_arm64.deb
wget https://repo.mongodb.org/apt/ubuntu/dists/bionic/mongodb-org/5.0/multiverse/binary-arm64/mongodb-org-tools_5.0.3_arm64.deb
wget https://repo.mongodb.org/apt/ubuntu/dists/bionic/mongodb-org/5.0/multiverse/binary-arm64/mongodb-org_5.0.3_arm64.deb
sudo dpkg -i
```
