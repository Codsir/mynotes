#!/bin/sh
INPUT_STRING=hello
while [ "$INPUT_STRING" != "bye" ]
do
    echo "Please type something in (bye to quit)"
    read INPUT_STRING
    echo "You just typed: $INPUT_STRING"
done


#!/bin/sh
while read f
do
    case $f in
	hello)echo English;;
	howdy)echo American;;
	gday)echo Australian;;
	bonjour)echo French;;
	"guten tag")echo German;;
	*)echo Unknown Language: $f
	  ;;
    esac
done < while.txt
