#!/bin/bash

mkdir progetto_finale

cp -r environments parser visitors Main.java progetto_finale

/home/inkeaton/.jdks/openjdk-20.0.1/bin/javac -d progetto_finale/progetto_finale progetto_finale/Main.java

java -classpath progetto_finale/progetto_finale progetto_finale/Main.java $1 $2 $3 $4 $5

rm -rf progetto_finale
