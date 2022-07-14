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
 # checking if task-file.txt has already been created 
if [ -f "$task_file_name" ]   
 then
	 echo "file ($task_file_name) already exists in $DIR_PATH, should it be overwritten? (y/n)" 	 
	 read input
while [[ "$input" != "y" && "$input" != "n" ]]; do
 echo 'that is not an option please enter either y or n'
 read input 
done 

estab_task_list="TRUE" #  used to stop touch commands from being executed - we have already decdided the outcome of task-file.txt if the nested if statements are executed 

if [ "$input" == "y" ]
then 
	rm $task_file_name	
	touch $task_file_name && echo "file $task_file_name overwritten"
else 
      echo "file not changed , old $task_file_name still exists"  	
fi
fi   


# checking if tmp.txt has already been created 
if [ -f "$tmp_file_name" ]
then
	echo "file ($tmp_file_name) already exists in $DIR_PATH, should it be overwritten? (y/n)"     
        read input
  while [[ "$input" != "y" && "$input" != "n" ]]; do
   echo 'that is not an option please enter either y or n'
   read input
  done
  
estab_tmp_list="TRUE" #same purpouse as in the previosu nested if statements but for the tmp file this time 

  if [ "$input" == "y" ]
  then
          rm $tmp_file_name 
          touch $tmp_file_name && echo "file $tmp_file_name overwritten"
  else
        echo "file not changed , old $tmp_file_name still exists"        
  fi
  fi

touch $task_file_name
touch $tmp_file_name

 
 }

get_path
 
create_files

if [ -f "$HOME/$config_file_name" ]
then 
	echo "$config_file_name already exists under $HOME, would you like to replace it? (y/n)" 
read input
 
while [[ "$input" != "y" && "$input" != "n" ]]; do
   echo 'that is not an option please enter either y or n'
    read input
    done

    


echo "a config file will also be installed in your home directory: $HOME"	
sleep 3
touch "$HOME/$config_file_name" && echo "creating $config_file_name"


echo 'setup done'

exit 
