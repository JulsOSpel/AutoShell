#!/usr/bin/perl
# Created by Dustin Roberts


#===Colors (For Text)===
$RedText = "\033[1;31m";        #Red
$GreenText = "\033[1;32m";      #Green
$CyanText = "\033[1;36m";       #Cyan
$WhiteText = "\033[0;37m";      #White

#===Symbols (For Text)=====
$GreenArrow = "\033[0;32m➤ ";
$RedArrow = "\033[0;31m➤ ";



# ====== Main ========

#Menu
while ($Menu != 3)
{
	#Menu Display
	print("\n${GreenArrow}${GreenText}Enter the number for the nmap scan would you like to do?: \n");
	print("${CyanText} 1) Bind Shell \n 2) Reverse Shell \n 3) Back to Main Menu \n ${WhiteText}");
	
	$Menu = <>;
	if ($Menu == "1")
	{
		BindShell();
		$Menu = "";
	}
	elsif ($Menu == "2")
	{
		ReverseShell();
		$Menu = "";
	}
	elsif ($Menu == "3")
	{
		break;
	}
	else 
	{
		print("${RedArrow}${RedText} Not a supported option");
	}
}

sub BindShell
{
	$PortNumber;
	$IpAddress;

	#Collect Values
        print("${GreenArrow}${GreenText}Enter the port you wish to connect to: \n  ${WhiteText}");
        $PortNumber = <>;
        print("${GreenArrow}${GreenText}Enter the IP you wish to connect to: \n  ${WhiteText}");
        $IpAddress = <>;
	
        #Check Values
	ValueChecker($PortNumber,"Port");
	ValueChecker($IpAddress,"IP");

	nc $IpAddress $PortNumber;
	break;
}

sub ReverseShell
{
	$PortNumber;
	
	#Collect Values
        print("${GreenArrow}${GreenText}Enter the port you wish to listen to: \n  ${WhiteText}");
	$PortNumber = <>;
	
	#Check Values
	ValueChecker($PortNumber,"Port");

	nc -lvnp $PortNumber;
	#break;
}

#Function to check to make sure IP and Port are not blank
sub ValueChecker
{
	#Values to pass in
	$Value = @_[0];
	$Type = @_[1];

	#Checker    [Note: Empty Variables have a value of 1]
	if (length $Value < 2)
	{
		print("${RedArrow}${RedText}You did not enter a $Type value. \n");
	}
}
