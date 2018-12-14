#!/bin/bash
n=1
iodepth=1
#block=4
#jobs=1
times=180

./fio_single_test.sh aws_single_lun $n randwrite 0 4K $iodepth $times 1
./fio_single_test.sh aws_single_lun $n randread 0 4K $iodepth $times 1
./fio_single_test.sh aws_single_lun $n randwrite 0 16K $iodepth $times 1
./fio_single_test.sh aws_single_lun $n randread 0 16K $iodepth $times 1 

iodepth=2
while [ $iodepth -le 12 ]
do
    ./fio_single_test.sh aws_single_lun $n randwrite 0 4K $iodepth $times 1
    ./fio_single_test.sh aws_single_lun $n randread 0 4K $iodepth $times 1
    ./fio_single_test.sh aws_single_lun $n randwrite 0 16K $iodepth $times 1
    ./fio_single_test.sh aws_single_lun $n randread 0 16K $iodepth $times 1 
    let n++ 
    let iodepth=$(( $iodepth + 2 ))
done
