#./fio_single_test.sh luns exeindex rwtype mixrate blocksize iodepth time numjobs
./fio_single_test.sh	aws_single_lun  1 randwrite	0	4K	1	180	1
./fio_single_test.sh	aws_single_lun	2	randwrite	0	4K	2	180	2
./fio_single_test.sh	aws_single_lun	3	randwrite	0	4K	4	180	4
./fio_single_test.sh	aws_single_lun	4	randwrite	0	4K	6	180	8
