#!/bin/bash
#-------------------------------------------------------------------------------------
#	os_info.sh (for Linux)
#	Creator: Zi_WaF
#	Group: Centre for Cybersecurity (CFC311022)
#	Instructor: J. Lim
#	whatis: os_info.py	Create automation to display the Linux OS Information
#
#	Usage: bash os_info.py
#-------------------------------------------------------------------------------------

echo -e "\nOperating System:  $(uname -o)"	# print the Operating System
echo -e "Kernel Information:  $(uname -sr)\n"	# print the Kernel Name & Version

#Display the Private IP, Public IP and Default Gateway
echo "Private IP Address: $(ifconfig | grep -w broadcast | awk '{print$2}')"
echo "Public IP Address: $(curl -s ifconfig.io)"
echo "Default Gateway: $(route -n | grep -w UG | head -n 1 | awk '{print$2}')"

#Display the Hard Disk Size, Used and Free Space in Table Format
echo -e "\nFile System\t Size\t Used\t Free\n-------------------------------------"
df -H | grep -w / | awk '{print$1"\t",$2"\t",$3"\t",$4}' # df command report file system space usage

#Display the top 5 directories and their size
echo -e "\nSize\tDirectory (from Root)\n----\t---------------------"
du -h / 2>/dev/null | sort -nr | head -n 5		# any 'Permission denied' response send to null
							# only display information that have access
echo -e "\nSize\tDirectory (from Home)\n----\t---------------------"
du -h ~ 2>/dev/null | sort -nr | head -n 5		# any 'Permission denied' response send to null
							# only display information that have access
#Display CPU Usage with a prompt
while true
do
	echo -e "\nDisplay the CPU Usage? [Yes/No]:"	# to give more time when looking at above information
	read ans
	val=$(echo $ans | tr '[:upper:]' '[:lower:]')	# any input for yes/no will be standardize to lower case
	if [ $val == "yes" ]||[ $val == "y" ]
	then
		echo "Displaying Linux processes......."
		top -id 10				# hides all the idle processes, making it easier to sort
		exit					# through the list and refresh every 10 seconds
	elif [ $val == "no" ]||[ $val == "n" ]
	then
		echo "Goodbye."
		exit
	else
		echo "Input error. Please try again."	# any other inputs will return back the loop
	fi
done
