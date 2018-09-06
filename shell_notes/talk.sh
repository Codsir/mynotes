#!/bin/sh

echo "Please talk to me ..."
while :
do
  read INPUT_STRING
  case $INPUT_STRING in
	hello)
		echo "Hello yourself!"
		;;
	"how are you")
		echo "fine,how are you"
		;;
	"what is your name")
		echo "tiger machine, how about you"	      
		;;
	"i am tired")
		echo "take a rest"
		;;		    
	bye)
		echo "See you again!"
		break
		;;
	*)
		echo "Sorry, I don't understand"
		;;
  esac
done
echo 
echo "That's all folks!"
