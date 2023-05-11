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

while [[ !("$task" =~ "Back To Main Menu") ]]
do
	# Select what to output
	echo -e "${grenaro}${whitetxt}What would you like to output?"
	select type in "Nmap Scans" "Brute Force" "Hash Cracking"
	do
		if [[ $type == "" ]]; then # Check valid input
			continue
		else
			break
		fi
	done
	# Select the output type
	echo -e "${grenaro}${whitetxt}How would you like to output it?"
	select task in "Website" "Shell" "Back To Main Menu"
	do
		if [[ $task = "Website" ]]; then
			# Turn the output into an html file
			if [[ $type == "Nmap Scans" ]]; then
				sqlite3 -newline '<br>' -header data/database.db "select * from nmap;" > data/nmapout.html
				echo -e "${grenaro}${whitetxt}The output was saved to data/nmapout.html"
				sleep 4
				exit
			elif [[ $type == "Brute Force" ]]; then
				sqlite3 -newline '<br>' -header data/database.db "select * from hydra;" > data/hydraout.html
				echo -e "${grenaro}${whitetxt}The output was saved to data/hydraout.html"
				sleep 4
				exit
			elif [[ $type == "Hash Cracking" ]]; then
				sqlite3 -newline '<br>' -header data/database.db "select * from hashcat;" > data/hashcatout.html
				echo -e "${grenaro}${whitetxt}The output was saved to data/hashcatout.html"
				sleep 4
				exit
			fi
		elif [[ $task = "Shell" ]]; then
			# Show output and make txt file
			if [[ $type == "Nmap Scans" ]]; then
				sqlite3 -header -box data/database.db "select * from nmap;" > data/nmapout.txt
				sqlite3 -header -box data/database.db "select * from nmap;"
				echo -e "This output is saved to data/nmapout.txt"
				echo -e "${grenaro}${whitetxt}Press any key to exit."
				read -n 1
				exit
			elif [[ $type == "Brute Force" ]]; then
				sqlite3 -header -box data/database.db "select * from hydra;" > data/hydraout.txt
				sqlite3 -header -box data/database.db "select * from hydra;"
				echo -e "This output is saved to data/hydraout.txt"
				echo -e "${grenaro}${whitetxt}Press any key to exit."
				read -n 1
				exit
			elif [[ $type == "Hash Cracking" ]]; then
				sqlite3 -header -box data/database.db "select * from hashcat;" > data/hashcatout.txt
				sqlite3 -header -box data/database.db "select * from hashcat;"
				echo -e "${grenaro}${whitetxt}This output is saved to data/hashcatout.txt"
				echo -e "${grenaro}${whitetxt}Press any key to exit."
				read -n 1
				exit
			fi
		elif [[ $task = "Back To Main Menu" ]]; then
			break
		else
			echo -e "${redaro}${redtxt}Not a valid input.${whitetxt}" # Error out the user if input is not correct.
		fi
	done
done
