[TOC]

### Shell script notes

I used this tutorial to learn shell scripting: [Shell Scripting Tutorial-Steve Parker](https://www.shellscript.sh/index.html). I given my executing result for almost every program, and sometimes I alternated the original program or wrote some new program.

#### Escape Characters

", $, ` and \ are still  interpreted by the shell, even when they're in double quotes. 

```sh
$echo "A quote is \", backslash is \\, backtick is \`."
A quote is ", backslash is \, backtick is `.
$X=5
$echo "A few spaces are    ; dollar is \$. \$X is ${X}."
A few spaces are    ; dollar is $. $X is 5.
```

#### Loops

##### For

```sh
#!/bin/sh
for i in 1 2 3 4 5
do
  echo "Looping ... number $i"
done
```

```sh
OUTPUT
Looping .... number 1
Looping .... number 2
Looping .... number 3
Looping .... number 4
Looping .... number 5
```

```sh
#!/bin/sh
for i in hello 1 * 2 goodbye 
do
  echo "Looping ... i is set to $i"
done

OUTPUT:
Looping ... i is set to hello
Looping ... i is set to 1
Looping ... i is set to anaconda3
Looping ... i is set to bin
Looping ... i is set to config_hicpro.txt
Looping ... i is set to dead.letter
Looping ... i is set to Desktop
Looping ... i is set to Documents
Looping ... i is set to Downloads
Looping ... i is set to examples.desktop
Looping ... i is set to ftp
Looping ... i is set to Music
Looping ... i is set to opt
Looping ... i is set to Pictures
Looping ... i is set to Public
Looping ... i is set to Software
Looping ... i is set to Templates
Looping ... i is set to Videos
Looping ... i is set to 2
Looping ... i is set to goodbye
```

##### while

What happens here, is that the echo and read statements will run indefinitely until you type "bye" when prompted. 

```sh
#!/bin/sh
INPUT_STRING=hello
while [ "$INPUT_STRING" != "bye" ]
do
  echo "Please type something in (bye to quit)"
  read INPUT_STRING
  echo "You typed: $INPUT_STRING"
done
```

This example uses the [case](https://www.shellscript.sh/case.html) statement. It reads from the file *myfile*, and for each line, tells you what language it thinks is being used. Each line must end with a LF (newline) - if `cat myfile` doesn't end with a blank line, that final line will not be processed.

```sh
#!/bin/sh
while read f
do
  case $f in
	hello)		echo English	;;
	howdy)		echo American	;;
	gday)		echo Australian	;;
	bonjour)	echo French	;;
	"guten tag")	echo German	;;
	*)		echo Unknown Language: $f
		;;
   esac
done < myfile
```

```
while.txt:
hello
darkness my old friend
bonjour
I've come to talk with you

```

```
tiger@tiger-OptiPlex-990:/media/tiger/Tiger_Passport/Documents/shell_notes$ ./while_loop2.sh 
English
Unknown Language: darkness my old friend
French
Unknown Language: I've come to talk with you
Unknown Language:
```



##### Tips

The following codes have the same effect

```sh
mkdir rc{0,1,2,3,4,5,6,S}.d
```

```sh
for runlevel in 0 1 2 3 4 5 6 S
do
  mkdir rc${runlevel}.d
done
```

```
tiger@tiger-OptiPlex-990:/media/tiger/Tiger_Passport/Documents/shell_notes/test$ tree
.
├── rc0.d
├── rc1.d
├── rc2.d
├── rc3.d
├── rc4.d
├── rc5.d
├── rc6.d
├── rcdir
└── rcS.d

9 directories, 0 files
```

This can be done recursively

```
$ cd /
tiger@tiger-OptiPlex-990:/$ ls -ld {,usr,usr/local}/{bin,sbin,lib}
drwxr-xr-x   2 root root  4096 8月  20 09:31 /bin
drwxr-xr-x  22 root root  4096 3月  31 13:07 /lib
drwxr-xr-x   2 root root 12288 8月  21 06:50 /sbin
drwxr-xr-x   2 root root 69632 8月  30 06:15 usr/bin
drwxr-xr-x 171 root root 12288 8月  29 21:26 usr/lib
drwxr-xr-x   2 root root  4096 8月   9 09:15 usr/local/bin
drwxr-xr-x   8 root root  4096 8月  28 19:04 usr/local/lib
drwxr-xr-x   2 root root  4096 8月   1  2017 usr/local/sbin
drwxr-xr-x   2 root root 12288 8月  29 19:47 usr/sbin
```

#### Test

Test is used by virtually every shell script written. It may not seem that way, because `test` is not often called directly. `test` is more frequently called as `[`. `[` is a symbolic link to `test`, just to make shell programs more readable. It's actually a program.

```sh
tiger@tiger-OptiPlex-990:~$ type [
[ is a shell builtin
tiger@tiger-OptiPlex-990:~$ which [
/usr/bin/[
tiger@tiger-OptiPlex-990:~$ whereis [
[: /usr/bin/[ /usr/share/man/man1/[.1.gz
tiger@tiger-OptiPlex-990:~$ ls -l /usr/bin/[
-rwxr-xr-x 1 root root 51920 3月   3  2017 /usr/bin/[
tiger@tiger-OptiPlex-990:~$ ls -l /usr/bin/test
-rwxr-xr-x 1 root root 47824 3月   3  2017 /usr/bin/test

```

NOTICE:  just like `ls` and other programs, so it must be surrounded by spaces!!!

```sh
if SPACE [ SPACE "$foo" SPACE = SPACE "bar" SPACE ] # work
if [$foo = "bar" ]                                  # not work
```

NOTICE: Some shells also accept "`==`" for string comparison; this is not portable, a single "`=`" should be used for strings, or "`-eq`" for integers.

##### If...then...else...

```sh
if [ ... ]
then
  # if-code
else
  # else-code
fi


if [ ... ]; then
  # do something
fi


if  [ something ]; then
 echo "Something"
 elif [ something_else ]; then
   echo "Something else"
 else
   echo "None of the above"
fi

```

Note that `fi` is `if` backwards! This is used again later with [case](https://www.shellscript.sh/case.html) and `esac`. 

test.sh

```sh
#!/bin/sh
if [ "$X" -lt "0" ]
then
  echo "X is less than zero"
fi
if [ "$X" -gt "0" ]; then
  echo "X is more than zero"
fi
[ "$X" -le "0" ] && \
      echo "X is less than or equal to  zero"
[ "$X" -ge "0" ] && \
      echo "X is more than or equal to zero"
[ "$X" = "0" ] && \
      echo "X is the string or number \"0\""
[ "$X" = "hello" ] && \
      echo "X matches the string \"hello\""
[ "$X" != "hello" ] && \
      echo "X is not the string \"hello\""
[ -n "$X" ] && \
      echo "X is of nonzero length"
[ -f "$X" ] && \
      echo "X is the path of a real file" || \
      echo "No such file: $X"
[ -x "$X" ] && \
      echo "X is the path of an executable file"
[ "$X" -nt "/etc/passwd" ] && \
      echo "X is a file which is newer than /etc/passwd"

```

```
tiger@tiger-OptiPlex-990:/media/tiger/Tiger_Passport/Documents/shell_notes$ ./test.sh
X is more than zero
X is more than or equal to zero
X is not the string "hello"
X is of nonzero length
No such file: 5

```

Simpler way of writing **IF** statements:The `&&` and `||` commands give code to run if the result is true, or false, respectively.

```sh
#!/bin/sh
[ $X -ne 0 ] && echo "X isn't zero" || echo "X is zero"
[ -f $X ] && echo "X is a file" || echo "X is not a file"
[ -n $X ] && echo "X is of non-zero length" || \
      echo "X is of zero length"
```

##### Some characters and their meanings

| characters | meaning                                |
| :--------- | -------------------------------------- |
| -lt        | less than                              |
| -gt        | greater than                           |
| -nt        | newer than                             |
| -n "$X"    | if X is of nonzero length              |
| -f "$X"    | if X is the path of a real file        |
| -x "$X"    | if X is the path of an executable file |
| -a -e      | both meaning "file exists"             |
| -S         | file is a Socket                       |
| -ot        | file is older than                     |
| -ef        | paths refer to the same file           |
| -O         | file is owned by my user               |
|            |                                        |
|            |                                        |

```sh
echo -en "Please guess the magic number: "
read X
echo $X | grep "[^0-9]" > /dev/null 2>&1
if [ "$?" -eq "0" ]; then
  # If the grep found something other than 0-9
  # then it's not an integer.
  echo "Sorry, wanted a number"
else
  # The grep found only 0-9, so it's an integer. 
  # We can safely do a test on it.
  if [ "$X" -eq "7" ]; then
    echo "You entered the magic number!"
  fi
fi
```



test in while loops

```sh
#!/bin/sh
X=0
while [ -n "$X" ]
do
  echo "Enter some text (RETURN to quit)"
  read X
  echo "You said: $X"
done
```

```sh
#!/bin/sh
X=0
while [ -n "$X" ]
do
  echo "Enter some text (RETURN to quit)"
  read X
  if [ -n "$X" ]; then
    echo "You said: $X"
  fi
done
```

#### Case

talk.sh

```sh
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

```

```
tiger@tiger-OptiPlex-990:/media/tiger/Tiger_Passport/Documents/shell_notes$ ./talk.sh
Please talk to me ...
i am tired
take a rest
how are you
fine,how are you
what is your name
tiger machine, how about you
tiger
Sorry, I don't understand
bye
See you again!

That's all folks!

```



#### Variables

- The first set of variables we will look at are `$0 .. $9` and `$#`.  
- The variable `$0` is the *basename* of the program as it was called.  
- `$1 .. $9` are the first 9 additional parameters the script was called with.  The variable `$@` is all parameters `$1 .. whatever`. The variable `$*`, is similar, but does not preserve any whitespace, and quoting, so "File with spaces" becomes "File" "with" "spaces". This is similar to the `echo` stuff we looked at in [A First Script](https://www.shellscript.sh/first.html). As a general rule, use `$@` and avoid `$*`.  
- `$#` is the number of parameters the script was called with. 

var3.sh

```sh
#!/bin/sh
echo "I was called with $# parameters"
echo "My name is $0"
echo "My first parameter is $1"
echo "My second parameter is $2"
echo "All parameters are $@"
```



```
tiger@tiger-OptiPlex-990:/media/tiger/Tiger_Passport/Documents/shell_notes$ ./var3.sh 
I was called with 0 parameters
My name is ./var3.sh
My first parameter is 
My second parameter is 
All parameters are 
tiger@tiger-OptiPlex-990:/media/tiger/Tiger_Passport/Documents/shell_notes$ ./var3.sh  hello darkeness my old friend
I was called with 5 parameters
My name is ./var3.sh
My first parameter is hello
My second parameter is darkeness
All parameters are hello darkeness my old friend

```

What is the function of **shift**?

var4.sh

```sh
#!/bin/sh
while [ "$#" -gt "0" ]
do
  echo "\$1 is $1"
  shift
done      
```

```
tiger@tiger-OptiPlex-990:/media/tiger/Tiger_Passport/Documents/shell_notes$ ./var4.sh 1 2 3 4 5 6 7 8 9 10 11 
$1 is 1
$1 is 2
$1 is 3
$1 is 4
$1 is 5
$1 is 6
$1 is 7
$1 is 8
$1 is 9
$1 is 10
$1 is 11

```

Another special variable is **`$?`**. This contains the exit value of the last run command. 

```sh
#!/bin/sh
/usr/local/bin/my-command
if [ "$?" -ne "0" ]; then
  echo "Sorry, we had a problem there!"
fi
```

will attempt to run `/usr/local/bin/my-command` which should exit with a value of zero if all went well, or a nonzero value on failure. We can then handle this by checking the value of `$?` after calling the command. This helps make scripts robust and more intelligent. Well-behaved applications should return zero on success. 

> One of the main causes of the fall of the Roman Empire was that, lacking zero, they had no way to indicate successful termination of their C Programs.                           -----Robert Firth



The other two main variables set for you by the environment are `$$` and `$!`. These are both process numbers.  The `$$` variable is the PID (Process IDentifier) of the currently running shell. This can be useful for creating temporary files, such as `/tmp/my-script.$$` which is useful if many instances of the script could be run at the same time, and they all need their own temporary files.

The `$!` variable is the PID of the last run background process. This is useful to keep track of the process as it gets on with its job.

Another interesting variable is `IFS`. This is the *Internal Field Separator*. The default value is `SPACE TAB NEWLINE`, but if you are changing it, it's easier to take a copy.

var5.sh

```sh
#!/bin/sh
old_IFS="$IFS"
IFS=:
echo "Please input some data separated by colons ..."
read x y z
IFS=$old_IFS
echo "x is $x y is $y z is $z"
```

```
tiger@tiger-OptiPlex-990:/media/tiger/Tiger_Passport/Documents/shell_notes$ ./var5.sh
Please input some data separated by colons ...
hello:darkness:my old friend
x is hello y is darkness z is my old friend
```

name.sh

```sh
#!/bin/sh
echo -en "What is your name [ `whoami` ] "
read myname
if [ -z "$myname" ]; then
  myname=`whoami`
fi
echo "Your name is : $myname"
```

```
tiger@tiger-OptiPlex-990:/media/tiger/Tiger_Passport/Documents/shell_notes$ ./name.sh
-en What is your name [ tiger ] 

Your name is : tiger
tiger@tiger-OptiPlex-990:/media/tiger/Tiger_Passport/Documents/shell_notes$ ./name.sh
-en What is your name [ tiger ] 
tiger zhang
Your name is : tiger zhang
tiger@tiger-OptiPlex-990:/media/tiger/Tiger_Passport/Documents/shell_notes$ whoami
tiger

```

Passing the "`-en`" to echo tells it not to add a linebreak (for bash and csh). 

This could be done better using a shell variable feature. By using curly braces and the special ":-" usage, you can specify a default value to use if the variable is unset:

```sh
echo -en "What is your name [ `whoami` ] "
read myname
echo "Your name is : ${myname:-`whoami`}"
```

The more canonical example is to use fixed text, like this:

```sh
echo "Your name is :${myname:-Tiger Zhang}"
```

There is another syntax, ":=", which sets the variable to the default if it is undefined: 

```sh
echo "Your name is :${name:=Tiger Zhang}"
```

#### External Programs

##### backtick(`)

The backtick (`)is also often associated with external commands. Because of this, we will discuss the backtick first.  The backtick is used to indicate that the enclosed text is to be executed as a command. 

```sh
tiger@tiger-OptiPlex-990:~$ grep "^${USER}:" /etc/passwd | cut -d: -f5
Tiger Zhang,,,
tiger@tiger-OptiPlex-990:~$ MYNAME=`grep "^${USER}:" /etc/passwd | cut -d: -f5`
tiger@tiger-OptiPlex-990:~$ echo $MYNAME
Tiger Zhang,,,
tiger@tiger-OptiPlex-990:~$ whoami
tiger

```

It can also improve performance if you want to run a slow command or set of commands and parse various bits of its output. I executed the two following programs, and the second is really much faster than the first one.

backtick.sh

```sh
#!/bin/sh
find / -name "*.html" -print | grep "/index.html$"
find / -name "*.html" -print | grep "/contents.html$"
```

backtick1.sh

```sh
#!/bin/sh
HTML_FILES=`find / -name "*.html" -print`
echo "$HTML_FILES" | grep "/index.html$"
echo "$HTML_FILES" | grep "/contents.html$"
```

Output:

```sh
root@tiger-OptiPlex-990:/media/tiger/Tiger_Passport/Documents/shell_notes# time ./backtick.sh

...
real	0m6.331s
user	0m2.457s
sys	0m2.673s

root@tiger-OptiPlex-990:/media/tiger/Tiger_Passport/Documents/shell_notes# time ./backtick1.sh


...
real	0m3.132s
user	0m1.177s
sys	0m1.360s

```

Note: the quotes around `$HTML_FILES` are essential to preserve the newlines between each file listed. Otherwise, `grep` will see one huge long line of text, and not one line per file.

#### Functions

A function may return a value in one of four different ways:

- Change the state of a variable or variables
- Use the `exit` command to end the shell script
- Use the `return` command to end the function, and return the supplied value to the calling section of the shell script
- echo output to stdout, which will be caught by the caller just as c=`expr $a + $b` is caught

NOTE:a shell function cannot change its parameters, though it can change global parameters.

function.sh

```sh
#!/bin/sh
# A simple script with a function...

add_a_user()
{
  USER=$1
  PASSWORD=$2
  shift; shift;
  # Having shifted twice, the rest is now comments ...
  COMMENTS=$@
  echo "Adding user $USER ..."
  echo useradd -c "$COMMENTS" $USER
  echo passwd $USER $PASSWORD
  echo "Added user $USER ($COMMENTS) with pass $PASSWORD"
}

###
# Main body of script starts here
###
echo "Start of script..."
add_a_user bob letmein Bob Holness the presenter
add_a_user fred badpassword Fred Durst the singer
add_a_user bilko worsepassword Sgt. Bilko the role model
echo "End of script..."
```

```
tiger@tiger-OptiPlex-990:/media/tiger/Tiger_Passport/Documents/shell_notes$ ./function.sh
Start of script...
Adding user bob ...
useradd -c Bob Holness the presenter bob
passwd bob letmein
Added user bob (Bob Holness the presenter) with pass letmein
Adding user fred ...
useradd -c Fred Durst the singer fred
passwd fred badpassword
Added user fred (Fred Durst the singer) with pass badpassword
Adding user bilko ...
useradd -c Sgt. Bilko the role model bilko
passwd bilko worsepassword
Added user bilko (Sgt. Bilko the role model) with pass worsepassword
End of script...

```

##### Scope of variables

scope.sh

```sh
#!/bin/sh

myfunc()
{
  echo "I was called as : $@"
  x=2
}

### Main script starts here 

echo "Script was called with $@"
x=1
echo "x is $x"
myfunc 1 2 3
echo "x is $x"
```

```sh
tiger@tiger-OptiPlex-990:/media/tiger/Tiger_Passport/Documents/shell_notes$ ./scope.sh a b c d
Script was called with a b c d
x is 1
I was called as : 1 2 3
x is 2
```

Functions cannot change the values they have been called with, either - this must be done by changing the variables themselves, not the parameters as passed to the script.

function1.sh

```sh
#!/bin/sh

myfunc()
{
  echo "\$1 is $1"
  echo "\$2 is $2"
  # cannot change $1 - we'd have to say:
  # 1="Goodbye Cruel"
  # which is not a valid syntax. However, we can
  # change $a:
  a="Goodbye Cruel"
}

### Main script starts here 

a=Hello
b=World
myfunc $a $b
echo "a is $a"
echo "b is $b"

```

```
tiger@tiger-OptiPlex-990:/media/tiger/Tiger_Passport/Documents/shell_notes$ ./function1.sh
$1 is Hello
$2 is World
a is Goodbye Cruel
b is World
```

##### Recursion

factorial.sh

```sh
#!/bin/sh

factorial()
{
  if [ "$1" -gt "1" ]; then
    i=`expr $1 - 1`
    j=`factorial $i`
    k=`expr $1 \* $j`
    echo $k
  else
    echo 1
  fi
}


while :
do
  echo "Enter a number:"
  read x
  factorial $x
done                      

```

```
tiger@tiger-OptiPlex-990:/media/tiger/Tiger_Passport/Documents/shell_notes$ ./factorial.sh 
Enter a number:
10
3628800
Enter a number:
11
39916800
Enter a number:
20
2432902008176640000

```

fibonacci.sh

```sh
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

```

```
tiger@tiger-OptiPlex-990:/media/tiger/Tiger_Passport/Documents/shell_notes$ ./fibonacci.sh
What is the order of the fibonacci number you want to know?(type number<=0 to exit)
10
The 10th fibonacci number is 34
What is the order of the fibonacci number you want to know?(type number<=0 to exit)
-1
Goodbye, you can take a rest now
What is the order of the fibonacci number you want to know?(type number<=0 to exit)
0
Goodbye, you can take a rest now

```

Library file is end with .lib and 

```sh
# common.lib
# Note no #!/bin/sh as this should not spawn 
# an extra shell. It's not the end of the world 
# to have one, but clearer not to.
#
STD_MSG="About to rename some files..."

rename()
{
  # expects to be called as: rename .txt .bak 
  FROM=$1
  TO=$2

  for i in *$FROM
  do
    j=`basename $i $FROM`
    mv $i ${j}$TO
  done
}
```

```sh
#!/bin/sh
# function2.sh
. ./common.lib
echo $STD_MSG
rename .txt .bak
```

##### Return Codes

```sh
#!/bin/sh

adduser()
{
  USER=$1
  PASSWORD=$2
  shift ; shift
  COMMENTS=$@
  useradd -c "${COMMENTS}" $USER
  if [ "$?" -ne "0" ]; then
    echo "Useradd failed"
    return 1
  fi
  passwd $USER $PASSWORD
  if [ "$?" -ne "0" ]; then
    echo "Setting password failed"
    return 2
  fi
  echo "Added user $USER ($COMMENTS) with pass $PASSWORD"
}

## Main script starts here

adduser bob letmein Bob Holness from Blockbusters
ADDUSER_RETURN_CODE=$?
if [ "$ADDUSER_RETURN_CODE" -eq "1" ]; then
  echo "Something went wrong with useradd"
elif [ "$ADDUSER_RETURN_CODE" -eq "2" ]; then 
   echo "Something went wrong with passwd"
else
  echo "Bob Holness added to the system."
fi

```

```
tiger@tiger-OptiPlex-990:/media/tiger/Tiger_Passport/Documents/shell_notes$ sudo ./return_code.sh 
[sudo] password for tiger: 
Usage: passwd [options] [LOGIN]

Options:
  -a, --all                     report password status on all accounts
  -d, --delete                  delete the password for the named account
  -e, --expire                  force expire the password for the named account
  -h, --help                    display this help message and exit
  -k, --keep-tokens             change password only if expired
  -i, --inactive INACTIVE       set password inactive after expiration
                                to INACTIVE
  -l, --lock                    lock the password of the named account
  -n, --mindays MIN_DAYS        set minimum number of days before password
                                change to MIN_DAYS
  -q, --quiet                   quiet mode
  -r, --repository REPOSITORY   change password in REPOSITORY repository
  -R, --root CHROOT_DIR         directory to chroot into
  -S, --status                  report password status on the named account
  -u, --unlock                  unlock the password of the named account
  -w, --warndays WARN_DAYS      set expiration warning days to WARN_DAYS
  -x, --maxdays MAX_DAYS        set maximum number of days before password
                                change to MAX_DAYS

Setting password failed
Something went wrong with passwd

```



This script checks the two external calls it makes (`useradd` and `passwd`), and lets the user know if they fail. The function then defines a return code of 1 to indicate any problem with `useradd`, and 2 to indicate any problem with `passwd`. That way, the calling script knows where the problem lay.

You have to save `$?`, because as soon as you run another command, such as `if`, its value will be replaced. That is why we save the `adduser` return value in the `$ADDUSER_RETURN_CODE`variable, before acting on its content. `$ADDUSER_RETURN_CODE` is certain to remain the same; `$?` will change with every command that is executed.

#### Hints and Tips

[Shell File Test Operators Example](https://www.tutorialspoint.com/unix/unix-file-operators.htm)

[cut(unix)](https://en.wikipedia.org/wiki/Cut_(Unix))

[All Shell Scripting Tips](https://www.shellscript.sh/tips/)

#### Interactive Shell

A very useful tip: Ctrl+r will do a reverse-search, matching any part of the command line. Hit ESC and the selected command will be pasted into the current shell for you to edit as required.

#### Exercises

#### References

[Shell Scripting Tutorial-Steve Parker](https://www.shellscript.sh/index.html)

For  operators:

	[some of the less easily guessed commands and codes of shell scripts](https://www.shellscript.sh/quickref.html)



