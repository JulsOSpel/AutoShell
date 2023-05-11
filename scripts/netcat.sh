#!/bin/bash
# Text Format
bluetxt="\033[1;34m"
cyantxt="\033[1;36m"
greentxt="\033[1;37m"
whitetxt="\033[1;37m"
redtxt="\033[1;31m"
nocolor="\033[0m"
# Symbol Format
grenaro="\033[0;32m➤ "
redaro="\033[0;31m➤ "
# Backend Variables
ip=""
task=""
port=""
while [[ !("$task" =~ "Back To Main Menu") ]]
do
	# Ask the user what type of shell they to connect to.
	echo -e "${grenaro}${whitetxt}What type of nmap scan would you like to do?"
	select task in "Bind Shell" "Reverse Shell" "Back To Main Menu"
	do
		if [[ $task = "Bind Shell" ]]; then
			# Get port/IP info.
			echo -e "${grenaro}${whitetxt}Enter the port you want to connect to."
			read port
			echo -e "${grenaro}${whitetxt}Enter the IP you want to connect to.${nocolor}"
			read ip
			# Check if the user inputed data.
			if [[ $ip = "" || $port = "" ]]; then
				echo -e "${redaro}${redtxt}You did not input a port/IP.${whitetxt}"
				break
			fi
			nc $ip $port
			break
		elif [[ $task = "Reverse Shell" ]]; then
			echo -e "${grenaro}${whitetxt}Enter the port you want the listener to listen to.${nocolor}"
			read port
			# Check if the user inputed data.
			if [[ $ip = "" || $port = "" ]]; then
				# Get port info.
				echo -e "${redaro}${redtxt}You did not input a port.${whitetxt}"
				break
			fi
			nc -lvnp $port
			break
		# Take user back to main menu.
		elif [[ $task = "Back To Main Menu" ]]; then
			break
		else
			echo -e "${redaro}${redtxt}Not a supported task.${whitetxt}"
		fi
	done
done
