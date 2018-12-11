#!/bin/bash

sight=$1
index=$2
rwtype=$3
rwmixread=$4
bs=$5
iodep=$6
runtime=$7
numjobs=$8
case $sight in
 aws_single_lun)
        echo "aws_single_lun" $index
	cp fio_aws_1lun.fio fio_work.fio
        ;;
 aws_multi_luns)
        echo "aws_multi_luns" $index
	cp fio_aws_luns.fio fio_work.fio
        ;;
 ali_single_lun)
        echo "ali_single_lun" $index
	cp fio_aws_1lun.fio fio_work.fio
        ;;
 ali_multi_luns)
        echo "ali_multi_luns" $index
	cp fio_aws_luns.fio fio_work.fio
        ;;
 B_single_queue)
        echo "B_single_queue" $index
	cp fio_aws_1lun.fio fio_work.fio
        ;;
 B_single_vbs)
        echo "B_single_vbs" $index
	cp fio_aws_4lun.fio fio_work.fio
        ;;
 *)
        echo "Usage: $name [aws/ali/B_single_lun/multi_luns rwtype blocksize iodep runtime numjobs]"
        exit 1
        ;;
esac

sed -i "s/rw=rwxxx/rw=$rwtype/g" fio_work.fio
sed -i "s/bs=bsxxx/bs=$bs/g" fio_work.fio
sed -i "s/iodepth=iodepxxx/iodepth=$iodep/g" fio_work.fio
sed -i "s/runtime=runtimexxx/runtime=$runtime/g" fio_work.fio
sed -i "s/rwmixread=rwmixreadxxx/rwmixread=$rwmixread/g" fio_work.fio
sed -i "s/numjobs=numjobsxxx/numjobs=$numjobs/g" fio_work.fio

rm -rf fio_res_${index}_${sight}_${rwtype}_${bs}_${rwmixread}_${iodep}_${runtime}_${numjobs}
fio fio_work.fio | tee fio_res_${index}_${sight}_${rwtype}_${bs}_${rwmixread}_${iodep}_${runtime}_${numjobs}
