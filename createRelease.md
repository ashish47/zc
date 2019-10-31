Steps to prepare binaries release

Start with work environment

1. Remove existing backend and ui folders using below commands
"sudo rm -rf /home/pi/Voyager-Zone-Controller"
"sudo rm -rf /home/pi/voyagerZoneControllerUI2.0"

2. Run below command from "/home/pi/" to clone the backend into "Voyager-Zone-Controller" folder
"git clone https://github.com/rajeshmanapat/Voyager-Zone-Controller.git --branch dev --single-branch Voyager-Zone-Controller"

   2.1 Freeze all the required binaries 
   
   
3. Run below command from "/home/pi/" to clone the UI folder 
"git clone https://github.com/abhisheksiddaramappa/voyagerZoneControllerUI2.0"

4. Copy the makeRelease file into /home/pi directory using the below command
"sudo cp /home/pi/Voyager-Zone-Controller/misc/makeRelease.sh /home/pi/makeRelease.sh"



5. Run the makeRelease script from the /home/pi directory with the version name as argument as shown below
    5.1 Give execute permissions to makeRelease script using "sudo chmod +x makeRelease.sh"
    5.2 Run "./makeRelease v1.5
    
    
This will make a release and push it to the branch name v1.5 of astralPresence/voyagerRelease repo
