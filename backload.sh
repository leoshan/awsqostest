#!/bin/bash
n=1
while [ $n -le 50 ]
do
    date >> exetimes.txt
    ./fio_single_test.sh aws_multi_luns $n write 0 128K 32 1800 1
    let n++
done
