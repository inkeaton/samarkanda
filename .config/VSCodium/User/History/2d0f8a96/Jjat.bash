#!/bin/bash

mkdir lab09_05_11

cp -r environments parser visitors Main.java lab09_05_11

/home/inkeaton/.jdks/openjdk-20.0.1/bin/javac -d lab09_05_11/lab09_05_11 

/home/inkeaton/.jdks/openjdk-20.0.1/bin/javac lab09_05_11/Main.java

java -classpath lab09_05_11/lab09_05_11 lab09_05_11/Main.java $1 $2 $3 $4 $5
