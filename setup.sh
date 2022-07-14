#!/bin/bash

tmp_file_name=tmp.txt
task_file_name=task-file.txt
config_file_name=.task-list

get_path(){
echo 'enter path to desired directory of install'
  read DIR_PATH 
   while [ ! -d $DIR_PATH ]
   do     
          echo 'this is not a valid path, please re-enter a valid directory path'
          read DIR_PATH

done 
}

create_files(){
  cd $DIR_PATH
 
if [ -f "$task_file_name" ]   
 then
	 echo "file already exists, should it be overwritten? (y/n)" 	 
	 read input
while [[ "$input" != "y" && "$input" != "n" ]]; do
 echo 'that is not an option please enter either y or n'
 read input 
done 

if [ "$input" == "y" ]
then 
	rm $task_file_name	
	touch $task_file_name
	echo "file $task_file_name overwritten"
else 
      echo "file not changed , old $task_file_name still exists"  	
fi
fi   

touch task-file.txt
touch tmp.txt
touch .task-list
 
 }

get_path


DIR_CONTENT=$(ls $DIR_PATH)
if [ "$DIR_CONTENT" == ""  ]
then 
create_files
else 
	echo 'this directory is not empty are you sure you want to continue, all previous task-list files will be overwritten (y/n)' 
	read choice  
	
case $choice in
	y)	
	create_files
;;
	n)
	exit 
;;
	


esac
fi 
	








