#!/bin/bash

#By: Abel Thomas - abelt22@vt.edu
#ECE 3524 Project-03 EC
#5/1/2021

#function to recieve :q as an input to stop reading info and go to submenu
contproc(){
	read -p "Press :q to continue " press
	while [ "$press" != ":q" ]
	do
		read -p "Press :q to continue " press
	done
	runsub
}


#submenu which allows to show, kill process or bring up top else return to menu

runsub(){
printf "(Please enter the number of your selection below)\n\n"
	printf "1. Show all processes\n"
	printf "2. Kill a process\n"
	printf "3. Bring up top\n"
	printf "4. Return to main menu\n"
	read -p "" opt
	printf "4. \n"
	#takes an input if empty quits otherwise contiues
	if [ -z "$opt" ]
	then 
		exit
	fi
	#if found calls respective command to show, kill, bring up top or go to menu or exit 		#if command is unknown
	if [ $opt = 1 ]
	then
		echo "$(ps aux | less)\n"
		contproc
		
	elif [ $opt = 2 ]
	then
		read -p "Please enter the PID process you would like to kill: " PID 
		kill $"${PID}"
		contproc
		
	elif [ $opt = 3 ]
	then
		top
		contproc
		
	elif [ $opt = 4 ]
	then
		sh ./proj3.sh
	else
		exit
		
	fi
}

runsub
