#!/bin/bash
n=1
while [ $n -le 1000 ]
do
    date >> exetimes.txt
    ./vol-init.sh
    let n++
done
