I hope you are safe at home with your family.

Here is simple command to install MongodB on InSitu when running Ubuntu 16.04

# install arm Ubuntu 16

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5

echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.6 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.6.list

sudo apt-get update

sudo apt-get install -y mongodb-org

sudo apt-get -f install

sudo service mongod start

// entering to mongodb environment:

mongo localhost:27017

>help

>exit

 

 

// changing inSitu ip address:

sudo service mongod stop

sudo vim /etc/mongod.conf