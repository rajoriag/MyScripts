sync; echo 1 > /proc/sys/vm/drop_caches;

echo "writes";
fio --name=write --ioengine=sync --iodepth=1 --rw=write --bs=128k --direct=0 --size=1g --nr_files=1024 --filesize=1m --numjobs=10 --group_reporting --directory=/mnt/nfs/ --create_on_open=1 --fsync_on_close=1 --filename_format=f.\$jobnum.\$filenum --group_reporting;
sync; echo 3 > /proc/sys/vm/drop_caches;

echo "reads";
fio --name=read --ioengine=sync --iodepth=1 --rw=read --direct=0 --bs=128k --directory=/mnt/nfs/ --filename_format=f.\$jobnum.\$filenum --filesize=1m  --nrfiles=1024 --size=1g --numjobs=10 --group_reporting;

echo "deleting files"
time rm -rf w* r* f*;

echo "script complete";
