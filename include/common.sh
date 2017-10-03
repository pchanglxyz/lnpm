#!/bin/bash

##
# write red text
# @param string you want write content
#
EchoRed(){
	echo -e " \e[0;31m$1\e[0m"
}

##
# write green text
# @param string you want write content
#
EchoGreen(){
	echo -e " \e[0;32m$1\e[0m"
}

##
# write yellow text
# @param string you want write content
#
EchoYellow(){
	echo -e " \e[0;33m$1\e[0m"
}

##
# write blue text
# @param string you want write content
#
EchoBlue(){
	echo -e " \e[0;34m$1\e[0m"
}

##
# write magenta text
# @param string you want write content
#
EchoMagenta(){
	echo -e " \e[0;35m$1\e[0m"
}

##
# write cyan text
# @param string you want write content
#
EchoCyan(){
	echo -e " \e[0;36m$1\e[0m"
}

##
# write flicker red text
# @param string you want write content
#
EchoFlickerRed(){
	echo -e " \e[0;31;5m$1\e[0m"
}

##
# write flicker green text
# @param string you want write content
EchoFlickerGreen(){
	echo -e " \e[0;32;5m$1\e[0m"
}

##
# write flicker yello text
# @param string you want write content
#
EchoFlickerYellow(){
	echo -e " \e[0;33;5m$1\e[0m"
}

##
# write flicker blue text
# @param string you want write content
#
EchoFlickerBlue(){
	echo -e " \e[0;34;5m$1\e[0m"
}



PrintSystemInfo() {
	cat /etc/issue;
	cat /etc/*-release;
	uname -a;
	memoryCount=`free -m | grep Mem | awk '{print $2}'`;
	echo "Memory is: ${memoryCount} MB ";
	df -h
}


CheckCommandIsSuccess() {
	if [ $? -eq 0 ]; then
		EchoFlickerRed "Error";
		#exit 1;
	fi
}