#! /bin/awk -f

# 3 ways to effect tab-delimited sepqration of selected columns
# use the -v variable flag to define environmental variables
awk -v FS=, -v OFS="\t" '{ print $2,$3 }'
# within an expression specifically triggered before first line
awk 'BEGIN { FS=","; OFS="\t";}{ print $2,$3 }'
# using c-style printf formatting
awk -v FS="," {'printf ("%s\t%s\n", $2, $3)'}

# print lines matching a pattern
awk '/li/ { print $0 }' ~/mail-list

# print the total kb for given files by parsing ls -l results
ls -l files | awk '{ x += $5 }
   END { print "total K-bytes:", x / 1024 }'

# split file into top and bottom
awk '
BEGIN      { FS=","; lower=0 }
lower == 0 { print   }
/Desc/     { lower=1 }
' <$1 >${1%*.csv}_meta.csv

sed -i 's/,Description//g' ${1%*.csv}_meta.csv

awk '
BEGIN      { FS=","; lower=0 }
/Desc/     { lower=1 }
lower == 1 {print}
' <$1 >${1%*.csv}_body.csv
