#!/bin/bash

gcc -static -nostdlib main.s -c main.o
gcc -static -nostdlib main.o -o main
