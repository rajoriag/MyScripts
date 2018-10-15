# enable some more output
#set -x

echo "ls on empty dir";
time ls;

echo "small writes of bs=1M and count=3000";
#sync; echo 1 > /proc/sys/vm/drop_caches;
time dd if=/dev/zero of=file1.txt bs=1M count=3000 conv=fdatasync;
#sync; echo 1 > /proc/sys/vm/drop_caches;
time dd if=/dev/zero of=file2.txt bs=1M count=3000 conv=fdatasync;
#sync; echo 1 > /proc/sys/vm/drop_caches;
time dd if=/dev/zero of=file3.txt bs=1M count=3000 conv=fdatasync;

echo "large writes of bs=1G and count=3";
sync; echo 1 > /proc/sys/vm/drop_caches;
time dd if=/dev/zero of=file4.txt bs=1G count=3 conv=fdatasync;
sync; echo 1 > /proc/sys/vm/drop_caches;
time dd if=/dev/zero of=file5.txt bs=1G count=3 conv=fdatasync;
sync; echo 1 > /proc/sys/vm/drop_caches;
time dd if=/dev/zero of=file6.txt bs=1G count=3 conv=fdatasync;

echo "creating a file";
time touch file7.txt;
time touch file8.txt;
time touch file9.txt;

echo "only writes of bs=1G and count=3";
#sync; echo 1 > /proc/sys/vm/drop_caches;
time dd if=/dev/zero of=file7.txt bs=1G count=3 conv=fdatasync;
#sync; echo 1 > /proc/sys/vm/drop_caches;
time dd if=/dev/zero of=file8.txt bs=1G count=3 conv=fdatasync;
#sync; echo 1 > /proc/sys/vm/drop_caches;
time dd if=/dev/zero of=file9.txt bs=1G count=3 conv=fdatasync;

#echo "reads on files small data";
#time dd if=file1.txt of=/dev/null bs=64 count=100;
#time dd if=file2.txt of=/dev/null bs=64 count=100;
#time dd if=file3.txt of=/dev/null bs=64 count=100;

echo "reads on files large data"
sync; echo 3 > /proc/sys/vm/drop_caches;
time dd if=file4.txt of=/dev/null bs=1M count=600;
sync; echo 3 > /proc/sys/vm/drop_caches;
time dd if=file5.txt of=/dev/null bs=1M count=600;
sync; echo 3 > /proc/sys/vm/drop_caches;
time dd if=file6.txt of=/dev/null bs=1M count=600;
sync; echo 3 > /proc/sys/vm/drop_caches;

echo "ls on dir with few files";
time ls;

echo "delete 9 file from dir";
time rm -rf file1.txt file2.txt file3.txt file4.txt file5.txt file6.txt file7.txt file8.txt file9.txt;

echo "script completed";
