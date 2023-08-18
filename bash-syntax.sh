#!/bin/bash

# The set -e (exit) option causes a script to exit if any of the processes it calls generate a non-zero return code.
set -e

##################################################
# element operations


# $variable is actually a simplified form of ${variable}
hello="A B  C   D"
echo $hello   # A B C D
echo "$hello" # A B  C   D, Quoting a variable preserves whitespace.

a=`ls -l`
echo $a   #whitespace removed
echo "$a" #nicely formatted as original

# array initialization.
Array=(element1 element2 element3)


##################################################
# flow control and functions

if [ condition 1 ]
then
   command 1
   command 2
   ...
elif [ condition 2 ]
then
   command 3
   command 4
   ...
else 
   default command
fi

# if can use any conditional test including integer values, command return values and equalities.
(( ... )) # constructs evaluates and tests numerical expressions
(( 5 > 4 )) 
(( 5 == 5 )) 

var1=5 var2=4
if (( var1 > var2 ))

# binary tests on two items
if [ "$a" -eq "$b" ]
	-eq # integer equivalency
	-ne # not equal
	-gt, -lt, -ge, -le # greater, less, greater/equal, less/equal
	 >,   <,   >=,  <= # same as above
	 -z # string is null
	 -n # string is NOT null

# test expressions
 [ ] and [[]]

#multiple test expressions
[[ condition1 && condition2 ]]
[[ condition1 || condition2 ]]
[ "$expr1" -a "$expr2" ]
[ $condition1 ] && [ $condition2 ]


# A listing of commands within parentheses starts a subshell.
# Variables inside parentheses, within the subshell, are not visible to the rest of the script.
(a=hello; echo $a)

# A command followed by an & will run in the background.

# $? reads the exit command of a previous function/script
[ $# -eq 0 ] # check for function arguments

##################################################
#string manupulation
stringZ=abcABC123ABCabc

#get string length
${#stringZ}  #15

#match returns the number of matching characters **from the beginning**
expr match "$stringZ" 'abc[A-Z]*1' #7

# index returns the starting position of a match, this is 1-based indexing
expr index "$stringZ" '1' #6

#however is multiple lookup chars are given, it returns the first
expr index "$stringZ" '1c' #3

#string extraction using an index (and length)
${stringZ:2:2}  #cA
${stringZ:7}    #23ABCabc
${stringZ:(-4)} #Cabc, reverse indexing requires a space 
${stringZ: -4}  #Cabc        or parenthesis
${stringZ:-4}   #abcABC123ABCabc, incorrect!



 
##################################################
# Math

# bash variables do not have type, a character string containing numbers 
# will act as expected under arithmetic context
# variables that are obviously strings have an arithmetic value of 0
# undeclared and null variables also have a integer value of 0

a=35
b=BB35
let "a += 1"
echo $a   # 36
let "b += 1"
echo $b   # 1

# Bash does not understand floating point arithmetic. 
# It treats numbers containing a decimal point as strings.

# use the `let` command or (( )) to permit arithmetic evaluation

(( a = 23 ))
(( a++ ))
echo $a # 24

# condition?result-if-true:result-if-false
(( t = a<45?7:11 ))
echo $t # 7

#easy way to get a random integer in a certain range (0-100)
(( t = $RANDOM % 100 )); echo $t

##################################################
# File IO
# brace expansion can be used for files
cat {file1,file2,file3} > combined_file
echo file{1..4}.txt      # file1.txt file2.txt file3.txt file4.txt
cp file22.{txt,backup}   # Copies "file22.txt" to "file22.backup"

# use {} as a placeholder for text, use -i option in xargs to replace strings
ls . | xargs -i -t cp ./{} $1

# file test operators
if [ -e "~/file.txt" ]
if [ ! -f "~/file.txt" ]
	-e  # file exists
	    -f  # regular file
	    -d  # directory
    -r, -w, -x # read, write or execute permission
