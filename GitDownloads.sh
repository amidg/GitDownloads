#GitDownloads
#!/bin/bash

#///////////////////////////////////////////////////////////////////////////
#REPOSITORY VARIABLES -> CHANGE SOMETHING HERE IF YOU NEED TO GET MORE REPOS DOWNLOADED AT THE SAME TIME
repositoryList=("link1" 
				"link2")

#///////////////////////////////////////////////////////////////////////////
#MAIN CODE ---> DO NOT CHANGE INITIAL CODE
echo "Welcome to Universal Git Repository Downloader by Dmitrii Gusev"

downloadPath='/c/testPull'
isPathChanged='no'
declare -i isSetupFinalized
echo "Your library installation path is set to default $downloadPath"
echo 

read -p "Do you want to use this path? Type [yes / no]: " isPathChanged

#set base value for the isSetupFinalized
isSetupFinalized=0

if [[ "$isPathChanged" == 'yes' ]]; then 
	#use default path
	echo "Default directory is selected"
elif [[ "$isPathChanged" == 'no' ]]; then
	#set new path
	echo "NOTE: DIRECTORY SPELLING MUST BE CORRECT, SCRIPT WILL GENERATE A NEW DIRECTORY IF CHOSEN DOES NOT EXIST"
	read -p "Setup your new path in the form /c/path/to/folder: " downloadPath
	echo "Your cloning location is specified to: $downloadPath"
fi

#check if folder exists and create one if needed
while [[ $isSetupFinalized == 0 ]]
do
	#check if download path exists
	if [[ -d "$downloadPath" ]]
	then
		echo "Selected directory exists, starting download..."
		isSetupFinalized=1
	else
		#if download path does not exist, create one
		echo "Selected directory does not exist! Proceeding with directory generation..."
		mkdir $downloadPath
		
		#check if desired path exists after it was created
		if [[ -d "$downloadPath" ]]
		then
			echo "Directory created! Proceeding with cloning..."
			isSetupFinalized=1
		else
			echo "ERROR! Please, restart your script!"
		fi
	fi
done

#start download if everything is good to go
if (( $isSetupFinalized == 1 )); then
	#use for-loop to perform cloning
	for repositoryList in "${repositoryList[@]}"; 
	do 
		#skip list entry if empty
		if [[ -n "$repositoryList[@]" ]] 
		then
			#set location for ActuatorControlEM
			cd 'C:/'			
			cd $downloadPath
		
			#download repository 
			git clone $repositoryList && echo "cloned"
		fi
	#end of For loop
	done
fi