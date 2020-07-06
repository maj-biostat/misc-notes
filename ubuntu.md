# Ubuntu

## Installing 20.04 LTS

https://www.youtube.com/watch?v=n8VwTYU0Mec

## BSOD (black screen of death)

Usually nvidia drivers.

possibly  
https://askubuntu.com/questions/882385/dev-sda1-clean-this-message-appears-after-i-startup-my-laptop-then-it-w


Alt-F2 then login to terminal.

```
# Graphics card and drivers
sudo hwinfo --gfxcard --short
lspci -k | grep -A 2 -i "VGA"
# suggest recommended drivers
sudo ubuntu-drivers devices
# e.g.
sudo apt install nvidia-driver-440
sudo shutdown -r now
# and pray

# switch primary card
sudo prime-select query
sudo prime-select intel
sudo prime-select nvidia
sudo apt list --installed | grep nvid

# remove nvidia
sudo apt-get purge nvidia*
# default installs
sudo ubuntu-drivers autoinstall
```
https://linoxide.com/linux-how-to/how-to-install-nvidia-driver-on-ubuntu/
https://sourcedigit.com/25531-install-nvidia-graphics-driver-on-ubuntu-20-04/

## Monitor madness

External monitor works, internal screen doesn't or vice versa. Why?

`~/.config/monitor.xml` can occassionally get munted.  
Delete the above file, disconnect external, restart, replug external.  

## Software

### Management

```
# update repos
sudo apt update
# upgrade apps to lastest repos version
sudo apt upgrade
sudo apt remove apache2 vim
sudo apt-get --purge remove gimp
# also remove config
sudo apt purge apache2
sudo apt search apache2
sudo apt list --installed
# dependency
sudo apt show apache2
sudo apt depends apache2
```

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


