#!/bin/bash
# Julian did this whole file
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
name=""
task=""
scantype=""
subnet+=("/1" "/2" "/3" "/4" "/5" "/6" "/7" "/8" "/9" "/10" "/11" "/12" "/13" "/14" "/15" "/16" "/17" "/18" "/19" "/20" "/21" "/22" "/23" "/24" "/25" "/26" "/27" "/28" "/29" "/30" "/31" "/32" "/34" "/35" "/36")
intpn=""
pn=""
while [[ !("$task" =~ "Back To Main Menu") ]]
do
	# Ask the user if they want a full scan of the network or not.
	echo -e "${grenaro}${whitetxt}Will this be a full scan of the subnet? yes/no"
	read scantype
	# Ask user for the ip of the network needed to be scaned.
	echo -e "${grenaro}${whitetxt}Enter the IP you want to scan."
	read ip
	# Ask user if the target firewall is blocking ICMP requests.
	echo -e "${grenaro}${whitetxt}Does your target block ping requests? yes/no"
	read 
	if [[ $intpn =~ ^([yY][eE][sS])$ ]]; then
		echo yes
		pn="-Pn"
	fi
	# If the user says "yes" then the user will be taken to a subnet scan.
	if [[ $scantype =~ ^([yY][eE][sS])$ ]]; then
		echo -e "${grenaro}${whitetxt}What subnet is the network on?"
		select net in ${subnet[@]}
		do
			if [[ $net == "" ]]; then # If user's input is not valid keep running the menu.
				continue
			else
				break
			fi
		done
		# Ask the user what type of nmap scan they would like to do.
		echo -e "${grenaro}${whitetxt}What type of nmap scan would you like to do?"
		select task in "TCP SYN Scan (Stealth)" "TCP ACK Scan" "TCP Connect Scan" "Version Scan" "Back To Main Menu"
		do
			if [[ $task = "TCP SYN Scan (Stealth)" ]]; then
				# Check if the user is in root.
				while true
				do
					echo -e "${grenaro}${whitetxt}Note: You need to be in root for this scan to work.${nocolor}"
					sudo echo -e "${grenaro}${whitetxt}Authenticated!" && break
					sleep 1
				done
				# Run the nmap scan in the background.
				sudo nmap $ip${net} -sS -T3 -oX data.xml $pn &>/dev/null &
				PID=$!
				i=1
				sp="/-\|"
				echo -e "${grenaro}${whitetxt}scanning..."
				# Loading animation.
				echo -n ' '
				while [ -d /proc/$PID ]
				do
					printf "\b${sp:i++%${#sp}:1}"
					sleep .5
				done
				echo ""
				# Start the xml to database script.
				python3 scripts/nmap/nmapSYN.py
				# Remove the xml file.
				sudo rm data.xml
				# Let know the user the task is done.
				echo -e "${grenaro}${whitetxt}Your scan is complete. Going back to main menu..."
				sleep 4
				exit
			elif [[ $task = "TCP ACK Scan" ]]; then
				# Check if the user is in root.
				while true
				do
					echo -e "${grenaro}${whitetxt}Note: You need to be in root for this scan to work.${nocolor}"
					sudo echo -e "${grenaro}${whitetxt}Authenticated!" && break
					sleep 1
				done
				# Run the nmap scan in the background.
				sudo nmap $ip${net} -sA -T3 -oX data.xml $pn &>/dev/null &
				PID=$!
				i=1
				sp="/-\|"
				echo -e "${grenaro}${whitetxt}scanning..."
				# Loading animation.elif [[ $task = "Version Scan" ]]; then
				echo -n ' '
				while [ -d /proc/$PID ]
				do
					printf "\b${sp:i++%${#sp}:1}"
					sleep .5
				done
				echo ""
				# Start the xml to database script.
				python3 scripts/nmap/nmapACK.py
				# Remove the xml file.
				sudo rm data.xml
				# Let know the user the task is done.
				echo -e "${grenaro}${whitetxt}Your scan is complete. Going back to main menu..."
				sleep 4
				exit
			elif [[ $task = "TCP Connect Scan" ]]; then
				# Run the nmap scan in the background.
				nmap $ip${net} -sT -oX data.xml $pn &>/dev/null &
				PID=$!
				i=1
				sp="/-\|"
				echo -e "${grenaro}${whitetxt}scanning..."
				# Loading animation.
				echo -n ' '
				while [ -d /proc/$PID ]
				do
					printf "\b${sp:i++%${#sp}:1}"
					sleep .5
				done
				echo ""
				# Start the xml to database script.
				python3 scripts/nmap/nmapConnect.py
				# Remove the xml file.
				rm data.xml
				# Let know the user the task is done.
				echo -e "${grenaro}${whitetxt}Your scan is complete. Going back to main menu..."
				sleep 4
				exit
			elif [[ $task = "Version Scan" ]]; then
				# Run the nmap scan in the background.
				nmap $ip${net} -sV -T3 -oX data.xml $pn &>/dev/null &
				PID=$!
				i=1
				sp="/-\|"
				echo -e "${grenaro}${whitetxt}scanning..."
				# Loading animation.
				echo -n ' '
				while [ -d /proc/$PID ]
				do
					printf "\b${sp:i++%${#sp}:1}"
					sleep .5
				done
				echo ""
				# Start the xml to database script.
				python3 scripts/nmap/nmapVersion.py
				# Remove the xml file.
				rm data.xml
				# Let know the user the task is done.
				echo -e "${grenaro}${whitetxt}Your scan is complete. Going back to main menu..."
				sleep 4
				exit
			elif [[ $task = "Back To Main Menu" ]]; then
				break
			fi
		done
	# If the user does not want to do a scan of a subnet.
	elif [[ $scantype =~ ^([Nn][Oo])$ ]]; then
		echo -e "${grenaro}${whitetxt}What type of nmap scan would you like to do?"
		select task in "TCP SYN Scan (Stealth)" "TCP ACK Scan" "TCP Connect Scan" "Version Scan" "Back To Main Menu"
		do
			if [[ $task = "TCP SYN Scan (Stealth)" ]]; then
				# Check if the user is in root.
				while true
				do
					echo -e "${grenaro}${whitetxt}Note: You need to be in root for this scan to work.${nocolor}"
					sudo echo -e "${grenaro}${whitetxt}Authenticated!" && break
					sleep 1
				done
				# Run the nmap scan in the background.
				sudo nmap $ip -sS -T3 -oX data.xml $pn &>/dev/null &
				PID=$!
				i=1
				sp="/-\|"
				echo -e "${grenaro}${whitetxt}scanning..."
				# Loading animation.
				echo -n ' '
				while [ -d /proc/$PID ]
				do
					printf "\b${sp:i++%${#sp}:1}"
					sleep .5
				done
				echo ""
				# Start the xml to database script.
				python3 scripts/nmap/nmapSYN.py
				# Remove the xml file.
				sudo rm data.xml
				# Let know the user the task is done.
				echo -e "${grenaro}${whitetxt}Your scan is complete. Going back to main menu..."
				sleep 4
				exit
			elif [[ $task = "TCP ACK Scan" ]]; then
				# Check if the user is in root.
				while true
				do
					echo -e "${grenaro}${whitetxt}Note: You need to be in root for this scan to work.${nocolor}"
					sudo echo -e "${grenaro}${whitetxt}Authenticated!" && break
					sleep 1
				done
				# Run the nmap scan in the background.
				sudo nmap $ip -sA -T3 -oX data.xml $pn &>/dev/null &
				PID=$!
				i=1
				sp="/-\|"
				echo -e "${grenaro}${whitetxt}scanning..."
				# Loading animation.elif [[ $task = "Version Scan" ]]; then
				echo -n ' '
				while [ -d /proc/$PID ]
				do
					printf "\b${sp:i++%${#sp}:1}"
					sleep .5
				done
				echo ""
				# Start the xml to database script.
				python3 scripts/nmap/nmapACK.py
				# Remove the xml file.
				sudo rm data.xml
				# Let know the user the task is done.
				echo -e "${grenaro}${whitetxt}Your scan is complete. Going back to main menu..."
				sleep 4
				exit
			elif [[ $task = "TCP Connect Scan" ]]; then
				# Run the nmap scan in the background.
				nmap $ip -sT -oX data.xml $pn &>/dev/null &
				PID=$!
				i=1
				sp="/-\|"
				echo -e "${grenaro}${whitetxt}scanning..."
				# Loading animation.
				echo -n ' '
				while [ -d /proc/$PID ]
				do
					printf "\b${sp:i++%${#sp}:1}"
					sleep .5
				done
				echo ""
				# Start the xml to database script.
				python3 scripts/nmap/nmapConnect.py
				# Remove the xml file.
				rm data.xml
				# Let know the user the task is done.
				echo -e "${grenaro}${whitetxt}Your scan is complete. Going back to main menu..."
				sleep 4
				exit
			elif [[ $task = "Version Scan" ]]; then
				# Run the nmap scan in the background.
				nmap $ip -sV -T3 -oX data.xml $pn &>/dev/null &
				PID=$!
				i=1
				sp="/-\|"
				echo -e "${grenaro}${whitetxt}scanning..."
				# Loading animation.
				echo -n ' '
				while [ -d /proc/$PID ]
				do
					printf "\b${sp:i++%${#sp}:1}"
					sleep .5
				done
				echo ""
				# Start the xml to database script.
				python3 scripts/nmap/nmapVersion.py
				# Remove the xml file.
				rm data.xml
				# Let know the user the task is done.
				echo -e "${grenaro}${whitetxt}Your scan is complete. Going back to main menu..."
				sleep 4
				exit
			elif [[ $task = "Back To Main Menu" ]]; then
				exit
			fi
		done
	else
		echo -e "${redaro}${redtxt}Not a valid input.${whitetxt}" # Error out the user if input is not y/n.
	fi
done
