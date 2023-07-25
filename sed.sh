# SED Stream EDitor
# http://www.grymoire.com/Unix/Sed.html#uh-15

sed 's/one/ONE/' <input >out

# you can use any character as a delimiter, this is helpful for file names with lots of slashes
sed 's|one|ONE|' <input >out
sed 's:one:ONE:' <input >out

# you can also use one for the pattern region if you preceed with a backslash
sed '\_#_ s/pattern/replacement/g' replaces words on comment lines

# Probably should always use "sed -r" in GNU or "sed -E" in OSX for extended regex patterns
# Otherwise you need to escape capture parenthesis (, ),  and quantity + symbols

# s// format operated by line, only matching the first matched instnace
# s//g will globally match multiple items per line
sed 's/[a-zA-Z]* /DELETED /2' or to replace the 2nd instance on a line with DELETED
sed 's/[a-zA-Z]* /DELETED /2g' and put it all together to DELETED all but the first

# use regex to parse key=value pairs that are semicolon/colon delimited
# ([^=]+)=([^=]+)(?:;|$)


# Parameters to restrict where to perform a substitution
# ---
# Similarly to awk we can define a pattern to delete the first number on comment lines 
sed '/^#/ s/[0-9][0-9]*//'

# or specify range for action by number(*hint: this number is cumulative when multiple files are edited)
sed '1,100 s/A/a/' #first 100 lines
sed '101,$ s/A/a/' #from line 101 to the end of file

# if you need help finding the line, you can print the matching line numbers with "=" first
sed -n '/PATTERN/ =' file

# to find the LAST line number of a file, match the last line ($) and print the line number (=)
lines=`sed -n '$=' file

# or use a pattern to select the range(or ranges if the pattern is matched again)
sed '/start/,/stop/ s/#.*//'

# Actions other than sustitution

# Deleting lines
# delete all comment lines individually
sed '/^#/ d' 

#delete up to the first blank line
sed '1,/^$/ d'

# Delete a range of lines and replace with new line
sed '
/begin/,/end/ c\
***DELETED***
'

# Insert lines
# Insert a single line before the matched line with the "i" command, 
# the new line must be on a line by itself
sed '
/WORD/ i\
Add this line before every line with WORD
'
# Append a line after the matched line
sed '
/WORD/ a\
Add this line after every line with WORD\
and another line with another backslash
'

# Replace the matched line
sed '
/WORD/ c\
Replace the current line with the line
'

# Insert the contents *file* in the file *in* at the word "INCLUDE" and save as *out*
sed '/INCLUDE/ r file' <in >out

# sort unique identifier strings (NM0000_0000) from AWS ls 
aws s3 ls s3://bucket/path/ | sed -r 's/^.*(NM[0-9]+_[0-9]+)_.*$/\1/g' | sort -u

# convert fastq to fasta
cat test.fq | sed 's/^@/>/' | awk "(NR % 4 == 1) || (NR % 4 == 2)"


