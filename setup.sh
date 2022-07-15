#!/bin/bash

tmp_file_name=tmp.txt
task_file_name=task-file.txt
config_file_name=.task-list

if [ -f "$HOME/$config_file_name" ]
then 
	echo "$config_file_name was already found in your home directory, are you sure you want to run this script again an over write everything (y/n)"
	read input
while [[ "$input" != "y" && "$input" != "n" ]]; do
  echo 'that is not an option please enter either y or n'
  read input
  done

if [ "$input" == "y" ]
then
	rm "$HOME/$config_file_name" 
	echo 'starting setup'   
else
	exit
fi
fi

write_config(){

echo "LOCATE=$DIR_PATH" > $HOME/$config_file_name
echo "CurrentFilePath=$DIR_PATH/$task_file_name" >> $HOME/$config_file_name
echo "TmpStore=$DIR_PATH/$tmp_file_name" >> $HOME/$config_file_name


echo 'setup complete'
exit
}
get_path(){
echo 'enter path to desired directory of install'
  read -e INIT_DIR_PATH 
   while [ ! -d $INIT_DIR_PATH ]
   do     
          echo 'this is not a valid path, please re-enter a valid directory path'
          read INIT_DIR_PATH

done 


# removing / from path so that wrong path is not written into config file when $task_file_name & $tmp_file are appended to $DIR_PATH 
if [[ $INIT_DIR_PATH == */ ]]
then 
	num_char=$(echo $INIT_DIR_PATH | wc -c)
	cut_num=`expr "$num_char" - 2` 
	DIR_PATH=$(echo $INIT_DIR_PATH | cut -c 1-$cut_num)	 

else 

DIR_PATH=$INIT_DIR_PATH	
	
fi



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


echo "a config file will  be installed in your home directory"	
touch "$HOME/$config_file_name" 

write_config



