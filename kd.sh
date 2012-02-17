#!/bin/sh

#Temporarily (at least I hope it's temporary) set the
#Internal Field Seperator (IFS) to new lines only, so
#we can handle file and folder names that have spaces
#in them.
IFS="
"

#Check if dir is readable by you.
if [ -r "./" ]; then
  dirContent=(`ls -a`)
else
  #if not then we'll sudo in.
  dirContent=(`sudo ls -a`)
fi

lenDirContent=${#dirContent[@]}

dirs=()
files=()
dirsAndFiles=()

for (( i = 0 ; i < lenDirContent ; i++ ))
do
	if [ -d "./${dirContent[$i]}" ]; then
		#echo "dirContent ${dirContent[$i]}"
		#echo "it's a dir"
		dirs[$[${#dirs[@]}+1]]=${dirContent[$i]}
	else
		#echo "dirContent ${dirContent[$i]}"
		#echo "it's a file"
		files[$[${#files[@]}+1]]=${dirContent[$i]}
	fi
done

dirsAndFiles=(${dirs[@]} ${files[@]})

#We only want to do stuff if > 2, b/c if there's 2,
#that means it's just "." and ".."
if [ $lenDirContent -gt 2 ]; then

  #Start at 2 so that we bypass "." and ".."
  for (( i = 2 ; i < $lenDirContent ; i++ ))
  do
    if [ $i -lt ${#dirs[@]} ]; then
      echo -ne "\033[1m"
      echo -n "$(($i+1 - 2))) "
      echo -n "/"
      echo -e "${dirsAndFiles[$i]}\033[0m"
    else
      echo -ne "\033[2m"
      #echo -n "$(($i+1 - 2))) "
      #echo -n "F "
      echo -e "${dirsAndFiles[$i]}\033[0m"
    fi
  done

  #Only bother showing dir entry prompt if there are
  #actually dirs to enter.
  if [ ${#dirs[@]} -gt 2 ]; then
    echo -n "Which dir? > "
    read dir
    #TODO validate input
    echo -ne "\033[1m"
    echo -e "Entering /${dirsAndFiles[($dir-1+2)]}\033[0m"
    cd ${dirsAndFiles[($dir-1+2)]}
  fi
fi
