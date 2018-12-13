sudo su
yum install -y fio git
fio --filename=/dev/nvme1n1 --rw=write --bs=128k --iodepth=32 --ioengine=libaio --direct=1 --name=volume-initialize | tee nvme1n1-init.txt &
fio --filename=/dev/nvme2n1 --rw=write --bs=128k --iodepth=32 --ioengine=libaio --direct=1 --name=volume-initialize | tee nvme2n1-init.txt &
fio --filename=/dev/nvme3n1 --rw=write --bs=128k --iodepth=32 --ioengine=libaio --direct=1 --name=volume-initialize | tee nvme3n1-init.txt &
fio --filename=/dev/nvme4n1 --rw=write --bs=128k --iodepth=32 --ioengine=libaio --direct=1 --name=volume-initialize | tee nvme4n1-init.txt &
