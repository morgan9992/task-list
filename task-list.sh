#!/bin/bash 

#global variables  
CurrentFilePath=/home/morgan/list/current-textfile.txt
TmpStore=/home/morgan/list/tmp.txt
input=NULL

percent(){

	completed_tasks=$(grep -c '|done' $CurrentFilePath)
	total_tasks=$(grep -c ':' $CurrentFilePath)
	
	  	
	percent=$(awk "BEGIN {print ($completed_tasks/$total_tasks)*100}")  
	
	
	int_percent=$(printf "%.*f\n" "0" "$percent")
	 
	echo $int_percent 
	if [ "$int_percent" == "100" ] 
	then
		echo "$int_percent% - hurray, you have completed all your tasks!! - add some more with the *add* parameter"	
	else 
	echo "your at $int_percent% completed - keep going, your doing well"
	fi
}

remove(){

	echo 'enter line numbers of tasks to remove from list (q to quit)'  
	
	while [[ "$input" != "q"  ]]; do       		 
		read input 
		if [ "$input" == "q" ]
              then
                      echo '--Updated Task File--' && cat $CurrentFilePath |  grep -n '^:.*'
                        exit
            fi

		
		echo "sed '$input'd'' $CurrentFilePath > $TmpStore" | bash 
                cat $TmpStore > $CurrentFilePath

	done
		
exit

}
#add parameter function prototype 
add(){
if [ "$ADD" == "TRUE" ]
then
	 
	echo 'type tasks (0 to exit)'
	while [[ "$input" != "0"  ]]; do 
		
	 read input 
	 if [ "$input" != "0" ] 
then
	echo ":$input" >> $CurrentFilePath	 
fi	
done             


echo '--new task file--'  
cat $CurrentFilePath | grep -n '^:.*'

fi 
}
#complete parameter function prototype
c0mplete(){
if [ "$COMPLETE" == "TRUE" ]
  then    
          echo 'enter line numbers of  tasks you have completed (q to quit)' 
	  while [[ "$input" != "q"  ]]; do 
                  read input 
		  if [ "$input" == "q" ]
		   then
                      echo '--Updated Task File--' && cat $CurrentFilePath |  grep -n '^:.*'
                        exit
            fi
		  echo "sed '$input!d' current-textfile.txt | grep -o '.....$'" | bash > $TmpStore
		  complete_status=$(cat $TmpStore)
		  if [ "$complete_status" == "|done" ]
		  then 
		  	echo ' this task has already been marked completed you can remove the task with the *remove* paramter'
            	  	c0mplete
		  fi     	

          s_prefix="s" 
          sedprefix="$input$s_prefix"
          echo sed "'$sedprefix/$/|done/' $CurrentFilePath > $TmpStore" | bash  
          #use $TmpStore to store most recent changes which are then wrote into $CurrentFilePath so that above sed command  can be executed again 
          cat $TmpStore > $CurrentFilePath
          done
fi
}




if [ "$1" == "" ] 
then 
	HELP="TRUE"
fi

if [ $# -gt 1 ]
then
    echo "too many argumennts, for help use the *help* parameter"
exit         
fi     

while [[ $# -gt 0 ]]; do   	
case $1 in
	ls)
	echo '--Tasks--' && cat $CurrentFilePath | grep -n '^:.*'
	shift
;;
	add)
	ADD="TRUE"	
	shift
	add
;;
	complete) 
        COMPLETE="TRUE" 
	shift
	c0mplete
;;
	help)
        HELP="TRUE"  
	shift	
;;

	remove)
	remove
	shift
;;

	left)
	percent
	shift
;;

	*)
	echo ' this is not a valid paramter, please use *help*'
	shift
;;

esac

done
 
if [ "$HELP" == "TRUE" ]
then

echo 'syntax - updater [argument]
      arguments:
      help - displays this message
      ls - lists all current tasks 
      add - allows you to add new tasks to declared task file 
      complete - marks specificed task as completed  
      remove - removes tasks from your list
      left - returns % of tasks completed so far'      

fi
