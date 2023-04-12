#!/bin/bash
# Text Format
bluetxt="\033[1;34m"
cyantxt="\033[1;36m"
greentxt="\033[1;37m"
whitetxt="\033[1;37m"
redtxt="\033[1;31m"
# Symbol Format
grenaro="\033[0;32m➤ "
redaro="\033[0;31m➤ "
# Backend Variables
user=$(whoami)
task=""
# When $task is "Quit" stop the loop.
while [[ !("$task" =~ "Quit") ]]
do
	clear
	echo -e "${bluetxt}
 █████╗ ██╗   ██╗████████╗ ██████╗     ███████╗██╗  ██╗███████╗██╗     ██╗     
██╔══██╗██║   ██║╚══██╔══╝██╔═══██╗    ██╔════╝██║  ██║██╔════╝██║     ██║     
███████║██║   ██║   ██║   ██║   ██║    ███████╗███████║█████╗  ██║     ██║     
██╔══██║██║   ██║   ██║   ██║   ██║    ╚════██║██╔══██║██╔══╝  ██║     ██║     
██║  ██║╚██████╔╝   ██║   ╚██████╔╝    ███████║██║  ██║███████╗███████╗███████╗
╚═╝  ╚═╝ ╚═════╝    ╚═╝    ╚═════╝     ╚══════╝╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝
                                                                               ${cyantxt}
                     A Helper Script For Pen Testing
                                  v0.1                       "
	echo -e "${grenaro}${whitetxt}Hello $user, What type of task would you like to do?"
	# Selection menu for different tasks.
	select task in "Nmap Scans" "Brute Force" "Hash Cracking" "Shell Attack" "Quit"
	do
		if [[ "$task" = "Nmap Scans" ]]; then
			# If nmap.sh has execute permission start nmap.sh.
			if [[ $(ls -l scripts/nmap.sh | grep "rwxr-xr-x") = *"-rwxr-xr-x"* ]]; then
				./scripts/nmap.sh
				sleep 2
				break
			# Else nmap.sh does not have execute permission give nmap.sh execute permission.
			else 
				chmod +x scripts/nmap.sh
				./scripts/nmap.sh
				break
			fi
		elif [[ "$task" = "Brute Force" ]]; then
			# If hydra.sh has execute permission start hydra.sh.
			if [[ $(ls -l scripts/hydra.sh | grep "rwxr-xr-x") = *"-rwxr-xr-x"* ]]; then
				./scripts/hydra.sh
				sleep 2
				break
			# Else hydra.sh does not have execute permission give hydra.sh execute permission.
			else 
				chmod +x scripts/hydra.sh
				./scripts/hydra.sh
				break
			fi
		elif [[ "$task" = "Hash Cracking" ]]; then
			# If hashcat.sh has execute permission start hashcat.sh.
			if [[ $(ls -l scripts/hashcat.sh | grep "rwxr-xr-x") = *"-rwxr-xr-x"* ]]; then
				./scripts/hashcat.sh
				sleep 2
				break
			# Else hashcat.sh does not have execute permission give hashcat.sh execute permission.
			else 
				chmod +x scripts/hashcat.sh
				./scripts/hashcat.sh
				break
			fi
		elif [[ "$task" = "Shell Attack" ]]; then
			# If netcat.sh has execute permission start netcat.sh.
			if [[ $(ls -l scripts/netcat.sh | grep "rwxr-xr-x") = *"-rwxr-xr-x"* ]]; then
				./scripts/netcat.sh
				sleep 2
				break
			# Else netcat.sh does not have execute permission give netcat.sh execute permission.
			else 
				chmod +x scripts/netcat.sh
				./scripts/netcat.sh
				break
			fi
		elif [[ "$task" = "Quit" ]]; then
			# Break user from loops when quitting.
			break
		else
			# Print error if user does not input valid response.
			echo -e "${redaro}${redtxt}Not a supported task.${whitetxt}"
		fi
	done
done
