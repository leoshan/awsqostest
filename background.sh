fio --filename=/dev/nvme1n1 --rw=write --bs=128k --iodepth=32 --ioengine=libaio --direct=1 --name=volume-initialize | tee nvme1n1-init.txt &
