#!/bin/bash

#echo "rs.slaveOk()" > ~/.mongorc.js
x-terminal-emulator -e sudo mongod --port 27017 --dbpath /var/lib/mongodb --replSet rs0 &
x-terminal-emulator -e sudo mongod --port 27018 --dbpath /var/lib/mongodb1 --replSet rs0 &
x-terminal-emulator -e sudo mongod --port 27019 --dbpath /var/lib/mongodb2 --replSet rs0 &

exec $SHELL