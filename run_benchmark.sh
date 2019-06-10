#!/bin/bash

cd YCSB
./bin/ycsb load mongodb -s -P ../params.dat > outLoad.txt
./bin/ycsb run mongodb -s -P ../params.dat > outRun.txt

mv outLoad.txt ../
mv outRun.txt ../