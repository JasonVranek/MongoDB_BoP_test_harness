#!/bin/bash

# Install dependencies
sudo apt update
sudo apt install build-essentials
sudo apt install python
sudo apt install maven
sudo apt install default-jdk
sudo apt install git

#Download and build latest release of YCSB:
git clone git://github.com/brianfrankcooper/YCSB.git
cd YCSB
# Build the source with the mongoDB binding
mvn -pl com.yahoo.ycsb:mongodb-binding -am clean package
mvn -pl com.yahoo.ycsb:mongodb-binding -am clean install


# Download and install MongoDB (https://docs.mongodb.com/manual/tutorial/install-mongodb-on-ubuntu/#install-mongodb-community-edition-using-deb-packages)
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.0.list
sudo apt update
sudo apt install -y mongodb-org

# Make the directories to run the replicas
sudo mkdir /var/lib/mongodb1
sudo mkdir /var/lib/mongodb2

# Edit the mongorc.js file to run replicas as slaves
echo "rs.slaveOk()" > ~/.mongorc.js

