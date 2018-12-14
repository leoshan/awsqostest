#!/bin/bash

#rm -rf fio_res*

#mount /dev/sdb1/ /home/vm_env/vm_share_ext3/
#cp /home/vm_env/vm_share_ext3/fio_res_* .
#umount /dev/sdb1/

#sh /home/dragon_test/fioA/pm_collect_result.sh
#sh /home/dragon_test/fioB/pm_collect_result.sh 

iops=0
bw=0
bwdata=0
bwunit=0
delaydata=0
delayunit=0

rm -rf fio_res_output.txt
for i in `ls fio_res*_0_*`
do
	#printf "%-50s" $i >> fio_res_output.txt
	#printf "%-20s" `grep iops $i | awk -F',' '{print $3}'` >> fio_res_output.txt
	#printf "%-20s" `grep iops $i | awk -F',' '{print $2}'` >> fio_res_output.txt
	#printf "%20s" "`grep -w lat $i | grep -w avg | awk -F',' '{print $3}'`" >> fio_res_output.txt
	#printf "%s" "`grep -w lat $i | head -n 1 | awk -F'(' '{print $2}' |  awk -F')' '{print $1}'`" >> fio_res_output.txt
	iops=`grep iops $i | awk -F',' '{print $3}' |awk -F'=' '{print $2}'`
	bw=`grep iops $i | awk -F',' '{print $2}' |awk -F'=' '{print $2}'`
	bwdata=`grep iops $i | awk -F',' '{print $2}' |awk -F'=' '{print $2}'|awk -F"[KM]" '{print $1}'`
	bwunit=${bw:0-4:4}
        
	time=`grep err $i | awk -F' ' '{print $10}'`

	delaydata=`grep -w lat $i | grep -w avg | awk -F',' '{print $3}'|awk -F'=' '{print $2}'`
	delayunit=`grep -w lat $i |head -n 1 | awk -F'(' '{print $2}' |  awk -F')' '{print $1}'`

	clatunit=`grep 'clat percentile' $i | awk -F'(' '{print $2}' |  awk -F')' '{print $1}'`
	clat_50=`grep 50.00th $i | awk -F',' '{print $3}' |awk -F'[' '{print $2}'|awk -F']' '{print $1}'`
	clat_90=`grep 90.00th $i | awk -F',' '{print $3}' |awk -F'[' '{print $2}'|awk -F']' '{print $1}'`
	clat_99=`grep 99.00th $i | awk -F',' '{print $1}' |awk -F'[' '{print $2}'|awk -F']' '{print $1}'`
	clat_9995=`grep 99.95th $i | awk -F',' '{print $4}' |awk -F'[' '{print $2}'|awk -F']' '{print $1}'`
	if [ $bwunit = "MB/s" ];then
		bwdata=`echo "$bwdata*1000"|bc`;
	fi
	if [ "$delayunit" = "msec" ];then
		delaydata=`echo "$delaydata*1000"|bc`;
	fi
	if [ $clatunit = "msec" ];then
		clat_50=`echo "$clat_50*1000"|bc`;
	fi
	if [ $clatunit = "msec" ];then
		clat_90=`echo "$clat_90*1000"|bc`;
	fi
	if [ $clatunit = "msec" ];then
		clat_99=`echo "$clat_99*1000"|bc`;
	fi
	if [ $clatunit = "msec" ];then
		clat_9995=`echo "$clat_9995*1000"|bc`;
	fi

	
	printf "%-15s %-15s %-15s %-8s %-8s %-8s %-8s %-8s   " $iops $bwdata $delaydata $clat_50 $clat_90 $clat_99 $clat_9995 $time >> fio_res_output.txt	
	printf "%-50s" $i >> fio_res_output.txt

	echo  >> fio_res_output.txt
done

cat fio_res_output.txt
