# term tips

# create a screen session, list, and reattach
screen -L -S name
	*cmd+a, d to exit
screen -ls
screen -d -r name

# find will execute grep and will substitute {} with the filename(s) found. The difference between ; and + is that with ; a single grep command for each file is executed whereas with + as many files as possible are given as parameters to grep at once.
find . -exec grep chrome {} \;
find . -exec grep chrome {} +
# unzip each file
find /PROJECT/ -type f -name "*gz" -exec gunzip {} \;

# create symlink for all find targets
find /path/with/files -type f -name "*txt*" -exec ln -s {} . ';'

# print size and path for all files
find -printf "%s\t%p\n"

# print readable date and path for all files
find -printf "%Tb %Td%H:%TM\t%p\n"

# Sorted list of all directories modified between 5 and 7 days ago
find ~/rancho -type d -mtime +5 -mtime -7 -printf "%TY-%Tm-%Td %TH:%TM %p\n" | sort -u |less

find dir -maxdepth 1 -type d -iname "string*" -mtime -30

# find and move to a target directory
find path1/ -type f -name "*gz" -exec mv -t path2/ {} +
find path1/ -type f -name "*gz" -exec mv -t path2/ {} \;


realpath

# sort by modification time
ls -rtl

# list just name
ls -1t

# extended grep ignore case, recursive, line numbers
grep -Erin "regex" .
# Recursively use Perl regex to return just the matched pattern +/- 10 characters
grep -ho -P '.{0,10}word.{0,10}' -r dir/

sed -r 's///g'

# create
tar -czvf archive.tar.gz /path
# extract
tar -xzvf archive.tar.gz

# print just the read line from a compressed fastq
zcat file_R1.fastq.gz | awk NR%4==2





