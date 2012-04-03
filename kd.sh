#!/bin/sh

#Temporarily (at least I hope it's temporary) set the
#Internal Field Seperator (IFS) to new lines only, so
#we can handle file and folder names that have spaces
#in them.
IFS="
"

#Check if we get an arg for dir to work with
if [ -d "$1" ]; then
  targetDir="$1"
  if [ ${targetDir:(-1)} != "/" ]; then
    targetDir="$targetDir/"
  fi
else
  targetDir="./"
fi

#Check if dir is readable by you.
if [ -r $targetDir ]; then
  dirContent=(`ls -a $targetDir`)
else
  #if not then we'll sudo in.
  dirContent=(`sudo ls -a $targetDir`)
fi

lenDirContent=${#dirContent[@]}

dirs=()
files=()
dirsAndFiles=()

for (( i = 0 ; i < lenDirContent ; i++ ))
do
	if [ -d "$targetDir${dirContent[$i]}" ]; then
		#echo "dirContent $targetDir${dirContent[$i]}"
		#echo "it's a dir"
		dirs[$[${#dirs[@]}+1]]=$targetDir${dirContent[$i]}
	else
		#echo "dirContent $targetDir${dirContent[$i]}"
		#echo "it's a file"
		files[$[${#files[@]}+1]]=$targetDir${dirContent[$i]}
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
      echo -e "${dirsAndFiles[$i]}/\033[0m"
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
    echo -e "Entering ${dirsAndFiles[($dir-1+2)]}/\033[0m"
    cd ${dirsAndFiles[($dir-1+2)]}
  fi
fi
