Steps to perform software update from 1.x to 1.5


1. Create a tar ball of the the v1.5 release code, use below proceddure on a local linux machine to do so

    1.1 Clone the release using "git clone https://github.com/AstralPresence/voyagerRelease --branch v1.5 --single-branch releaseRepo"
        (replace v1.5 with required branch name)
    
    1.2 Compress into tar ball using "tar -cvf Voyager-Zone-Controller.tar /home/pi/releaseRepo"
    
    
2. To perform software update
  
    2.1 Transfer the tar ball to "/home/pi" directory of the machine to be updated 
    2.2 Download the executable found at https://github.com/abhisheksiddaramappa/voyagerZoneController2.0/blob/dev/dist/performSoftwareUpdate into the /home/pi directory
    2.3 Give executable permission to the downloaded binary usig "sudo chmod +x /home/pi/performSoftwareUpdate"
    2.4 Run the executable using "./performSoftwareUpdate"
    
3. Check for the updated successfully message. This indicates a successfull update!
