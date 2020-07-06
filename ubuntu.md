# Ubuntu

## Installing 20.04 LTS

https://www.youtube.com/watch?v=n8VwTYU0Mec

## Software

Package description https://packages.ubuntu.com/focal/

```
# update file list (then upgrade if necessary)
sudo apt update

# to install .deb files with their dependencies
sudo apt -y install gdebi-core

# e.g.  but note there are also other ways to do this
sudo gdebi rstudio-1.2.5019-amd64.deb

```

### MS Teams

https://www.howtoforge.com/how-to-install-microsoft-teams-linux-on-ubuntu-and-centos/

### Email

Use evolution, or hiri, or mailspring (if you can stand it) or thunderbird in conjunction with DavMail, see:

https://www.youtube.com/watch?v=yCEK2hNP7bg

or Hiri (proprietary).

related    

https://www.zimbra.com/email-server-software/email-outlook-sync-mapi-zco/  
https://zentyal.com/community/  

## R

Add `deb https://cloud.r-project.org/bin/linux/ubuntu focal-cran40/` to `etc/apt/sources.list`.  

If on `apt update` you get   

```
The following signatures couldn't be verified because the public key is not available: NO_PUBKEY 759347893
```

then do  

`sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 759347893`


more information here https://cran.r-project.org/bin/linux/ubuntu/README.html under Secure APT.  


