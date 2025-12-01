#!/bin/bash

gcc -static -nostdlib ${1} -c first.o
gcc -static -nostdlib first.o -o main
