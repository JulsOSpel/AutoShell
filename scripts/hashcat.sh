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
task=""
hashtype+=("MD5" "SHA3-512" "SHA512(Unix)" "NTLM")
hashitself=""
password=()
touch data/hashcat.potfile
potfile="data/hashcat.potfile"
database="data/database.db"
wordlist=""

while [[ !("$task" =~ "Back To Main Menu") ]]
do
	# Ask for hash
	echo -e "${grenaro}${whitetxt}Enter the hash value or the path to the file containing the value."
	read hashitself
	# Ask for hash type
	echo -e "${grenaro}${whitetxt}What is the hash type?"
	select ht1 in ${hashtype[@]}
	do
		if [[ $ht1 == "" ]]; then # Check valid input
			continue
		else
			break
		fi
	done
	# Translates user imput to hashcat arguments
	if [[ $ht1 == "MD5" ]]; then
		ht2=0
	elif [[ $ht1 == "SHA3-512" ]]; then
		ht2=17600
	elif [[ $ht1 == "SHA512(Unix)" ]]; then
		ht2=1800
	elif [[ $ht1 == "NTLM" ]]; then
		ht2=1000
	fi
	# Ask for the attack mode
	echo -e "${grenaro}${whitetxt}How would you like to attack it?"
	select task in "Dictionary Attack" "Brute-force Attack (can take long)" "Back To Main Menu"
	do
		if [[ $task = "Dictionary Attack" ]]; then
			echo -e "${grenaro}${whitetxt}Enter the path to your wordlist."
			read wordlist
			hashcat -o $potfile --outfile-format 2 -m $ht2 -a 0 $hashitself $wordlist &>/dev/null &
			PID=$!
			i=1
			sp="/-\|"
			echo -e "${grenaro}${whitetxt}cracking..."
			# Loading animation.
			echo -n ' '
			while [ -d /proc/$PID ]
			do
				printf "\b${sp:i++%${#sp}:1}"
				sleep .5
			done
			echo ""
			# Check the last line in the output file and place data into database
			while IFS= read -r line; do
				password=$(echo "$line" | tail -1)
				if [[ $password != "" ]]; then
					sqlite3 "$database" "INSERT INTO hashcat (password, hashtype, hash) VALUES('$password', '$ht1', '$hashitself');"
				fi
			done < $potfile
			rm $potfile
			# Let know the user the task is done.
			echo -e "${grenaro}${whitetxt}Your crack is complete. Going back to main menu..."
			sleep 4
			exit
		elif [[ $task = "Brute-force Attack (can take long)" ]]; then
			hashcat -o $potfile --outfile-format 2 -m $ht2 -a 3 $hashitself -1 ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 ?1?1?1?1?1?1?1 &>/dev/null &
			PID=$!
			i=1
			sp="/-\|"
			echo -e "${grenaro}${whitetxt}cracking..."
			# Loading animation.
			echo -n ' '
			while [ -d /proc/$PID ]
			do
				printf "\b${sp:i++%${#sp}:1}"
				sleep .5
			done
			echo ""
			# Check the last line in the output file and place data into database
			while IFS= read -r line; do
				password=$(echo "$line" | tail -1)
				if [[ $password != "" ]]; then
					sqlite3 "$database" "INSERT INTO hashcat (password, hashtype, hash) VALUES('$password', '$ht1', '$hashitself');"
				fi
			done < $potfile
			rm $potfile
			# Let know the user the task is done.
			echo -e "${grenaro}${whitetxt}Your crack is complete. Going back to main menu..."
			sleep 4
			exit
		elif [[ $task = "Back To Main Menu" ]]; then
			break
		else
			echo -e "${redaro}${redtxt}Not a valid input.${whitetxt}" # Error out the user if input is not correct.
		fi
	done
done