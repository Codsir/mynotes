#!/bin/sh

# A resursion program to implement fibonacci sequence
fibonacci()
{
    if [ "$1" -gt "2" ]; then
	i=`expr $1 - 1`
	j=`expr $1 - 2`
	f_i=`fibonacci $i`
	f_j=`fibonacci $j`
	k=`expr $f_i + $f_j`
	echo $k
    elif [ "$1" -eq "1" ]; then
	 echo 0
    elif [ "$1" -eq "2" ];then
	 echo 1
    fi
    

}

INPUT_STRING=1
while [ "$INPUT_STRING" -gt "0" ]
do
    echo "What is the order of the fibonacci number you want to know?(type number<=0 to exit)"
    read x
    INPUT_STRING="${x}"
    if [ "$INPUT_STRING" -gt "0" ];then
	echo "The ${x}th fibonacci number is `fibonacci $x`"
    else
	echo "Goodbye, you can take a rest now"
    fi
    #fibonacci $x
done
