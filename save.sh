#!/bin/bash

rm -rf version/*

cp *.v version/
cp *.sv version/
cp *.tcl version/

cp run version/run.sh
cp save version/save.sh

cd version
