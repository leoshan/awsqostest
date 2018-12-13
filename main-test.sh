#!/bin/bash
n=1
iodepth=1
#block=4
#jobs=1
#times=180
while [ $iodepth -le 4 ]
do
    ./fio_single_test.sh aws_multi_luns $n randwrite 0 4K $iodepth 180 1
    ./fio_single_test.sh aws_multi_luns $n randread 0 4K $iodepth 180 1
    ./fio_single_test.sh aws_multi_luns $n randwrite 0 8K $iodepth 180 1
    ./fio_single_test.sh aws_multi_luns $n randread 0 8K $iodepth 180 1
    ./fio_single_test.sh aws_multi_luns $n randwrite 0 16K $iodepth 180 1
    ./fio_single_test.sh aws_multi_luns $n randread 0 16K $iodepth 180 1 
    ./fio_single_test.sh aws_multi_luns $n randwrite 0 32K $iodepth 180 1
    ./fio_single_test.sh aws_multi_luns $n randread 0 32K $iodepth 180 1
    let n++ 
    let iodepth++
done

n=10
iodepth=1
while [ $iodepth -le 5 ]
do
    ./fio_single_test.sh aws_multi_luns $n write 0 64K $iodepth 180 1
    ./fio_single_test.sh aws_multi_luns $n read 0 64K $iodepth 180 1
    ./fio_single_test.sh aws_multi_luns $n write 0 128K $iodepth 180 1
    ./fio_single_test.sh aws_multi_luns $n read 0 128K $iodepth 180 1
    ./fio_single_test.sh aws_multi_luns $n write 0 256K $iodepth 180 1
    ./fio_single_test.sh aws_multi_luns $n read 0 256K $iodepth 180 1 
    let n++ 
    let iodepth++
done
