#!/bin/sh

#By: Abel Thomas - abelt22@vt.edu
#ECE 3524 Project-03
#5/1/2021

#acts as the recursive main menu
selection(){
	#prints all the possible options
	printf -- '\n'
	date
	printf -- '------------------------\n'
	printf "Main Menu\n"
	printf -- '------------------------\n'
	printf "1. Operating system info\n"
	printf "2. Hostname and DNS info\n"
	printf "3. Network Info\n"
	printf "4. Who is online\n"
	printf "5. Last logged in users\n"
	printf "6. My IP address\n"
	printf "7. My disk usage\n"
	printf "8. My home file-tree\n"
	printf "9. Process operations\n"
	printf "10. Exit\n"
	read -p "Enter your choice [ 1 - 10 ] " inp
	printf -- '\n'
	#checks if an input was given
	if [ -z "$inp" ]
	then 
		exit
	fi
	#if input found runs corresponding function otherwise exits 
	if [ $inp = 1 ]
	then
		getos
		
	elif [ $inp = 2 ]
	then
		gethost
	
	elif [ $inp = 3 ]
	then
		getnetwork
		
	elif [ $inp = 4 ]
	then
		getonline
		
	elif [ $inp = 5 ]
	then
		getusers
		
	elif [ $inp = 6 ]
	then
		getmyip
		
	elif [ $inp = 7 ]
	then
		getmydisk
		
	elif [ $inp = 8 ]
	then
		getmytree
		printf "HTML file tree generated!\n"
	
	elif [ $inp = 9 ]
	then
		doprocess
	else
		exit
		
	fi
	
	selection
}

#gets the system info including os
getos(){
	printf -- '------------------------\n'
	printf " System information\n"
	printf -- '------------------------\n'
	printf "Operating System: " $(uname)
	printf "$(/usr/bin/lsb_release -a)\n"
	read -p "Press [Enter] to countinue..." e 
}
#gets the host name, dns domain, network address and dns name servers
gethost(){
	printf -- '------------------------\n'
	printf " Hostname and DNS information\n"
	printf -- '------------------------\n'
	printf "Hostname: $(hostname)\n"
	printf "DNS Domain: $(domainname)\n"
	printf "Network Address (IP): $(hostname -I)\n"
	printf "DNS Name servers (DNS IP): ${dnsips}\n"
	read -p "Press [Enter] to countinue..." e 
}
#gets the network interfaces, network routing and traffic info
getnetwork(){
	printf -- '------------------------\n'
	printf " Network Information\n"
	printf -- '------------------------\n'
	printf "Total network interfaces found: $(ls -A /sys/class/net | wc -l)\n"
	printf "***IP Addresses Information***\n"
	printf "$(ip addr show)\n"
	printf "*********************\n"
	printf "***Network Routing***\n"
	printf "*********************\n"
	printf "$(route)\n"
	printf "***********************************\n"
	printf "***Interface traffic information***\n"
	printf "***********************************\n"
	printf "$(netstat -i)\n"
	read -p "Press [Enter] to countinue..." e 
}
#gets who is online
getonline(){
	printf -- '------------------------\n'
	printf " Who is online\n"
	printf -- '------------------------\n'
	printf "NAME     LINE         TIME       COMMENT\n"
	printf "$(who)\n"
	read -p "Press [Enter] to countinue..." e 
}
#gets the list of the last logged user
getusers(){
	printf -- '------------------------\n'
	printf " List of last logged users\n"
	printf -- '------------------------\n'
	printf "NAME     LINE         TIME       COMMENT\n"
	printf "$(last | awk '{print}' | head -n 1)\n"
	printf "$(last | sort |  uniq -u -w 1)\n"
	read -p "Press [Enter] to countinue..." e 
}
#gets the public ip address
getmyip(){
	printf -- '------------------------\n'
	printf " Public IP information\n"
	printf -- '------------------------\n'
	printf "$(curl -s ifconfig.me)\n"
	read -p "Press [Enter] to countinue..." e 
}
#gets the disk info mounted on and use %
getmydisk(){
	printf -- '------------------------\n'
	printf " Disk usage info\n"
	printf -- '------------------------\n'
	printf "$(df | awk ' NR>1 {print $5 " " $6}')\n"
	read -p "Press [Enter] to countinue..." e 
}
#generates a tree of all files recursively from home directory into html by calling seperate #script
getmytree(){
	sh ./proj1.sh
}

#submenu which allows to show, kill process or bring up top else return to menu
doprocess(){
	sh ./proc.sh
}
selection
