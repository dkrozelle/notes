#! /bin/awk -f

# append filename column to table and remove header
find dir -name "*.tsv" | xargs -I{} awk -v fn={} 'NR>1 {print $0,fn}' {}

# print only selected lines
# header row and lines 5,6,7,8,9
awk 'NR==1||(NR<10&&NR>=5)'

# split a file ~50,000 into half with both getting a header row
awk 'NR==3||(NR>3&&NR<20000)' <GTEx_Analysis_2017-06-05_v8_RNASeQCv1.1.9_gene_tpm.gct >gtex-part1.tsv
awk 'NR==3||(NR>=20000&&NR<40000)' <GTEx_Analysis_2017-06-05_v8_RNASeQCv1.1.9_gene_tpm.gct >gtex-part2.tsv
awk 'NR==3||(NR>=40000)' <GTEx_Analysis_2017-06-05_v8_RNASeQCv1.1.9_gene_tpm.gct >gtex-part3.tsv

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
