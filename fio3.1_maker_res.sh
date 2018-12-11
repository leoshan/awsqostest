#!/bin/bash

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
	jobs=`grep Starting $i | awk -F' ' '{print $2}'`
	iops=`grep IOPS $i | awk -F',' '{print $1}' |awk -F'=' '{print $2}'`
	bw=`grep BW $i | awk -F',' '{print $2}' |awk -F'=' '{print $2}'|awk -F'(' '{printf $1}'`
	#bwdata=`grep BW $i | awk -F',' '{print $2}' |awk -F'=' '{print $2}'|awk -F"[KM]" '{print $1}'`
	#bwunit=${bw:0-4:4}

	delaydata=`head -n 23 $i|grep -w lat  | grep -w avg | awk -F',' '{print $3}'|awk -F'=' '{print $2}'`
	delayunit=`head -n 23 $i|grep -w lat  |head -n 1 | awk -F'(' '{print $2}' |  awk -F')' '{print $1}'`

	clatunit=`grep 'clat percentile' $i | awk -F'(' '{print $2}' |  awk -F')' '{print $1}'`
	clat_50=`grep 50.00th $i | awk -F',' '{print $3}' |awk -F'[' '{print $2}'|awk -F']' '{print $1}'`
	clat_90=`grep 90.00th $i | awk -F',' '{print $3}' |awk -F'[' '{print $2}'|awk -F']' '{print $1}'`
	clat_99=`grep 99.00th $i | awk -F',' '{print $1}' |awk -F'[' '{print $2}'|awk -F']' '{print $1}'`
	clat_9995=`grep 99.95th $i | awk -F',' '{print $4}' |awk -F'[' '{print $2}'|awk -F']' '{print $1}'`
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

	
	printf "%-15s %-15s %-15s %-15s %-8s %-8s %-8s %-8s" $jobs $iops $bw $delaydata $clat_50 $clat_90 $clat_99 $clat_9995 >> fio_res_output.txt	
	printf "%-50s" $i >> fio_res_output.txt

	echo  >> fio_res_output.txt
done

cat fio_res_output.txt
