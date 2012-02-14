#!/bin/sh

IFS="
"

dirs=(`ls`)

for i in "${dirs[@]}"
  do :
    echo $i
  done

#echo -n "Which dir? : "
#read dir
#echo "You entered: $dir"
#cd $dir

