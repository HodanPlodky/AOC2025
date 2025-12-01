#!/bin/bash

gcc -static -nostdlib ${1} -c -o main.o
gcc -static -nostdlib main.o -o main
