#!/bin/bash

#By: Abel Thomas - abelt22@vt.edu
#ECE 3524 Project-01
#5/1/2021

#function to recursively traverse dirs and files
#$1 - input dir; $2 - output html file
function traverse {
	#adds dir to html ul
	echo "<ul>" >> $2
	#loops through items in current dir
	for dir in $1/* ; do	
		# checks if each file is readable or not to add to html
		if [ ! -r $i ]; then
			echo "file or dir not readable"
			exit
		fi
		#takes base name and prints into html li
		out=$(basename $dir)
		echo "<li> $out </li>" >> $2
		#if current item is a dir then traverse it
		if [ -d "${dir}" ] ; then
			traverse $dir $2	
		fi
	done 
	echo "</ul>" >> $2
}

set ".." "filetree.html" 

#only traverses if args = 2
if [ "$#" -ne 2 ]; then
	echo "Illegal number of args!"
else
	#only traverses if valid dir
	if [ -d "$1" ]; then
		# only traverses if non empty dir
		if [ "$(ls -A $1)" ]; then
			#only traverses if output file ends in .html
			if [ ${2: -5} == ".html" ]; then
				#formats html and traverses given dir
				echo "<!DOCTYPE html>" > $2
				echo "<html>" >> $2
				echo "<body>" >> $2
				traverse $1 $2
				echo "<html>" >> $2
				echo "<body>" >> $2
			else
				echo "$2 must be html file!"
			fi
		else
			echo "dir: $1 is empty!"
		fi
	else
		echo "Illegal directory!"
	fi

fi
