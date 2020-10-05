#!/bin/bash

# Colors for UI

RED='\033[0;31m' 
GREY='\033[0;37m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color


# if the user forgot to include arguements.
if [ $# -eq 0 ]
  then
	printf "Please enter the html file\n"
	printf "Ex. ./cliCommand <theFile.txt>\n"
	exit
fi

# If the user wants to know the version
if [ $1 = "-v" ] || [ $1 = "--version" ]
  then
	printf "v0.1\n"
	exit
fi 

# keep track of the number of entries.
number=0

# Parsing file and looking for all URLS.

for i in $(grep -Eo '(http|https)://[^/"]+' $1)
  do
	let "number+=1"
	# Run curl in the background with a timeout of 3 seconds
	
	if [ "$2" = "-u" ]
	then 
		curl $i -Im 3 -A "$3" -o headers -s &
	fi	
	
	curl $i -Im 3 -o headers -s &

	# Print the status Code
	printf "$i : $(cat headers | head -n 1 | cut '-d ' '-f2') "
	
	# Save the status Code
	statusCode="$(cat headers | head -n 1 | cut '-d ' '-f2')"
	
	# time for response from curl. improves accuracy to the code.
	sleep 0.05

	if [[ $statusCode == 200 ]]
	  then 
		printf "${GREEN}Good Link${NC}\n"
	elif [[ $statusCode == 400 ]]
	  then
		printf "${RED}Bad Link${NC}\n"
	elif [[ $statusCode == 404 ]]
	  then
		printf "${RED}Bad Link${NC}\n"
	else
		printf "${GREY}Unknown${NC}\n"
	fi

done

# To ensure that all curls are terminated.
pkill curl