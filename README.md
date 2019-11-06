Start with a fresh SD card.

 Steps to create Raspbian Stretch OS Installation
1. Download OS image from here http://downloads.raspberrypi.org/raspbian/images/raspbian-2019-04-09/2019-04-08-raspbian-stretch.zip
2. Install balena etcher or any other disk writing software and write the downloaded image to the SD card
3. Add a an empty file named ".ssh" into the boot drive of SD card
4. Connect RPi to router using ethernet, find the IP in the router page and ssh into it using username "pi" and password "raspberry"


 Steps to Create BASE IMAGE 
 
1. Clone the repo found here using "git clone https://github.com/AstralPresence/zc"
2. Change Directory into the cloned repo. 
3. Run installFrameworks.sh using “./installFrameworks.sh”


***************************  You have Obtained BASE IMAGE  ***********************

 Steps to Create PRE RELEASE IMAGE 

Start with BASE IMAGE
1. Clone the release repo from "/home/pi" directory using the below command, remember to replace $1 with the required branch name
"git clone https://github.com/astralpresence/voyagerRelease --branch $1 --single-branch Voyager-Zone-Controller"
2. Run installVoyager.sh using “./installVoyager.sh > installation.log”


***************************  You have Obtained PRE RELEASE IMAGE  ***********************

Steps to Create Release 

Start with Pre Release Image(does not matter if shrunk or not)
1. Burn image to SD card
2. Insert SD card into ZC
3. Connect wifi to Hotspot of ZC named "Voyager_default_zoneID"
4. SSH into 192.168.4.1 with username "pi" and password "sunshine"
5. to EXPAND FILE STORAGE,
   5.1 run “sudo raspi-config”
   5.2 go to “advanced settings”
   5.3 select “expand file system”
   5.4 when prompted to reboot, select “yes”
6. Restore Default Settings using “mongorestore /home/pi/Voyager-Zone-Controller/dump/”
7. Create unique zcID using “/home/pi/Voyager-Zone-Controller/dist/uniqueZCIDMaker”
8. Install Remote.it
   8.1 run "sudo apt update" then "sudo apt full−upgrade"
   8.2 run "sudo apt install connectd"
   8.3 run "sudo connectd_installer"
   
9. Reboot using "sudo reboot"

**************  You have Obtained RELEASE IMAGE  ************** 

Once you test this out and all tests pass, You can shrink the pre release image to fasten up the cloning process

Link for shrinking-https://softwarebakery.com/shrinking-images-on-linux

**************  You have Obtained SHRUNK PRE RELEASE IMAGE  ************** 
