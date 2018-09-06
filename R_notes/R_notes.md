[TOC]

# R

### 基本操作

#### 对象的产生，排除及删除

```R
n <- 10
10 -> n

# rnorm(1) 将产生一个服从平均数为0标准差为1的标准正态分布的随机变量
rnorm(1)

# 函数ls的功能是显示所有在内存中的对象： 只会列出对象名
ls()

# 如果只要显示出在名称中带有某个指定字符的对象， 则通过设定选项pattern 来实现(可简写为pat) )
ls(pat = "d")
# 名称以某个字母开头的对象
ls(pat = "^m")

# ls.str()将会展示内存中所有对象的详细信息
ls.str()
# ls.str()有max.level参数它将规定显示所有关对象信息的详细级别。 缺省情况下， ls.str 将会列出关于对象的所有信息， 包括数据框， 矩阵， 数据列表的列数信息。 因此展示结果可能会很长。 但如果设定max.level =-1 就可以避免这种情况了
ls.str(pat="M", max.level=-1)

# rm(x)删除对象x, rm(x,y)删除x,y对象
rm(list=ls())
rm(list=ls(pat="^m"))
```

#### 在线帮助

```R
# ？加要查的对象
？lm
?+
help("+")
# help(lm)可以，但是help(+),help(*)不可以
help(lm)

> help(*)
Error: unexpected '*' in "help(*"

> help(+)
Error: unexpected ')' in "help(+)"
# 参数try.all.packages用于设置查找包的范围，false为只在载入的包中查找
> help("bs",try.all.packages = TRUE)
Help for topic ‘bs’ is not in any loaded package but can be found in
the following packages:

  Package               Library
  splines               /usr/lib/R/library

# 想要显示bs的帮助界面需要使用package选项
> help("bs", package = "splines")

# help.start() 启动html格式帮助
help.start()

# 关键词搜索
help.search('tree')

# 如果有一些包是最近才安装的， 应该首先使用函数help.search中的rebuild选项来刷新数据库
help.search("tree", rebuild = TRUE)

#函数apropos能找出所有在名字中含有指定字符串的函数， 但只会在被载入内存中的包中进行搜索: 注意要加引号！
apropos(time) #这是不对的
apropos('time')
```

### 数据操作

#### 对象

所有的对象都有两个内在属性： 类型和长度。 类型是对象元素的基本种类， 共有四种： 数值型， 字符型， 复数型和逻辑型(FALSE或TRUE)， 虽然也存在其它的类型， 但是并不能用来表示数据， 例如函数或表达式； 长度是对象中元素的数目。 对象的类型和长度可以分别通过函数mode和length得到。

```R
x <- 10
mode(x) # 对象类型
length(x)
> A <- "god"; istrue <- TRUE; z <- 1+2i;x <- 10.0
> mode(A);mode(istrue);mode(z);mode(x)
[1] "character"
[1] "logical"
[1] "complex"
[1] "numeric"
NA # 缺失数据,不可用，注意不同于NaN
1.2e+29 #科学计数
Inf 
-Inf
NaN
> cat(x) #输出显示

# 转义符的问题：单引号内双引号不用加反斜杠
```

向量是一个变量， 其意思也即人们通常认为的那样； 因子是一个分类变量； 数组是一个k维的数据表； 矩阵是数组的一个特例， 其维数k = 2。 注意， 数组或者矩阵中的所有元素都必须是同一种类型的； [data.frame](https://www.rdocumentation.org/packages/base/versions/3.5.1/topics/data.frame)是由一个或几个向量和（ 或） 因子构成， 它们必须是等长的， 但可以是不同的数据类型； “ ts” 表示时间序列数据， 它包含一些额外的属性， 例如频率和时间；列表可以包含任何类型的对象， 包括列表。

#### 在文件中读取数据

```R
> getwd() # 获取工作目录
[1] "/media/tiger/Tiger_Passport/Documents/R_notes"
> setwd("/media/tiger/Tiger_Passport/Documents/mailserver") #设置目录
> getwd()
[1] "/media/tiger/Tiger_Passport/Documents/mailserver"
# read.table, scan, read.fwf
```

##### read.table

读取表格形式文件并创建data frame

```R
read.table(file, header = FALSE, sep = "", quote = "\"'",
           dec = ".", numerals = c("allow.loss", "warn.loss", "no.loss"),
           row.names, col.names, as.is = !stringsAsFactors,
           na.strings = "NA", colClasses = NA, nrows = -1,
           skip = 0, check.names = TRUE, fill = !blank.lines.skip,
           strip.white = FALSE, blank.lines.skip = TRUE,
           comment.char = "#",
           allowEscapes = FALSE, flush = FALSE,
           stringsAsFactors = default.stringsAsFactors(),
           fileEncoding = "", encoding = "unknown", text, skipNul = FALSE)
read.csv(file, header = TRUE, sep = ",", quote = "\"",
         dec = ".", fill = TRUE, comment.char = "", …)

read.csv2(file, header = TRUE, sep = ";", quote = "\"",
          dec = ",", fill = TRUE, comment.char = "", …)

read.delim(file, header = TRUE, sep = "\t", quote = "\"",
           dec = ".", fill = TRUE, comment.char = "", …)

read.delim2(file, header = TRUE, sep = "\t", quote = "\"",
            dec = ",", fill = TRUE, comment.char = "", …)
```

Example:

```R
test1 <- "a b\n1 2\n3 6\n7 2\n"
cat(test1, file = "test1.txt")
data = read.table("test1.txt", header=TRUE, sep = ' ')
> data
  a b
1 1 2
2 3 6
3 7 2
```

![readtable](/media/tiger/Tiger_Passport/Documents/R_notes/pic/readtable.png)

[R documentation-read.table](https://www.rdocumentation.org/packages/utils/versions/3.5.1/topics/read.table)

##### scan

从窗口或文件中将数据读成vector或list

```R
scan(file = "", what = double(), nmax = -1, n = -1, sep = "",
     quote = if(identical(sep, "\n")) "" else "'\"", dec = ".",
     skip = 0, nlines = 0, na.strings = "NA",
     flush = FALSE, fill = FALSE, strip.white = FALSE,
     quiet = FALSE, blank.lines.skip = TRUE, multi.line = TRUE,
     comment.char = "", allowEscapes = FALSE,
     fileEncoding = "", encoding = "unknown", text, skipNul = FALSE)
```

Example:

```R
test2 <- "a b\n1 hello\n3 hi\n7 bye\n"
cat(test2, file = "test2.txt")
data <- scan("test2.txt", what =list(0,"") , sep = ' ',skip=1)
> data
[[1]]
[1] 1 3 7

[[2]]
[1] "hello" "hi"    "bye"
> data[1]
[[1]]
[1] 1 3 7

> data[2]
[[1]]
[1] "hello" "hi"    "bye"  
```

![scan](/media/tiger/Tiger_Passport/Documents/R_notes/pic/scan.png)

[R-documentation:scan](https://www.rdocumentation.org/packages/base/versions/3.5.1/topics/scan)

##### read.fwf

将固定长度的表格读取成data.frame

```
read.fwf(file, widths, header = FALSE, sep = "\t",
         skip = 0, row.names, col.names, n = -1,
         buffersize = 2000, fileEncoding = "", …)
```

Example:

```R
test3 <- "1.A90.2\n2.C62.3\n3.B71.4\n4.B89.4\n"
cat(test3, file = "test3.txt")
data <- read.fwf("test3.txt",widths=c(1,2,4),sep="\t")
> data
  V1 V2   V3
1  1 .A 90.2
2  2 .C 62.3
3  3 .B 71.4
4  4 .B 89.4
```

[R documentation-read.fwf](https://www.rdocumentation.org/packages/utils/versions/3.5.1/topics/read.fwf)















