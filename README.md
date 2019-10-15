Start with a fresh installation of Raspbian Stretch

 Steps to Create BASE IMAGE 
 
1. Clone the repo found here 
2. Change Directory into the cloned repo. 
3. Run installFrameworks.sh using “./installFrameworks.sh”


***************************  You have Obtained BASE IMAGE  ***********************

 Steps to Create PRE RELEASE IMAGE 

Start with BASE IMAGE
1. Run installVoyager.sh using “./installVoyager.sh branchName> installation.log”
(This will pull the mentioned branch name from the release repo found here)


***************************  You have Obtained PRE RELEASE IMAGE  ***********************

Steps to Create Release 

Start with Pre Release Image(does not matter if shrunk or not)
1. Burn image to SD card
2. to EXPAND FILE STORAGE,
   2.1 run “sudo raspi-config”
   2.2 go to “advanced settings”
   2.3 select “expand file system”
   2.4 when prompted to reboot, select “yes”
3. Restore Default Settings by running “mongorestore /home/pi/Voyager-Zone-Controller/dump/”
4. Create unique zcID by running “/home/pi/Voyager-Zone-Controller/dist/uniqueZCIDMaker”
5. Install Remote.it
6. Reboot

**************  You have Obtained RELEASE IMAGE  ************** 

Once you test this out and all tests pass, You can shrink the pre release image to fasten up the cloning process

Link for shrinking-https://softwarebakery.com/shrinking-images-on-linux

**************  You have Obtained SHRUNK PRE RELEASE IMAGE  ************** 
