# Ubuntu

## <a name="install"></a>Installing 20.04 LTS

https://www.youtube.com/watch?v=n8VwTYU0Mec

Aside 

```
sudo lsusb
sudo fdisk -l
# mkdir /home/fred/media
sudo mount /dev/sda1 /home/fred/media
sudo umount /home/fred/media
```

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

# in gnome
nvidia-settings
```
https://linoxide.com/linux-how-to/how-to-install-nvidia-driver-on-ubuntu/
https://sourcedigit.com/25531-install-nvidia-graphics-driver-on-ubuntu-20-04/

Note comment on grub update  
https://askubuntu.com/questions/1059965/internal-laptop-screen-not-detected-when-using-nvidia-driver


Restarting X with `pkill X`

## Monitor madness

External monitor works, internal screen doesn't or vice versa. Why?

`~/.config/monitor.xml` can occassionally get munted.  
Delete the above file, disconnect external, restart, replug external.  

Note default display manager (lightdm, gdm3 etc) from `cat /etc/X11/default-display-manager`

## GRUB

Get rid of the quiet splash:

```
# in /etc/default/grub
GRUB_CMDLINE_LINUX_DEFAULT="nomodeset"
sudo update-grub2
sudo shutdown -r now
```

## Software

### Management

`apt` gives a simplified interface compared to `apt-get` etc.


|apt command     |	the command it replaces	|function of the command                                  |
|----------------|--------------------------|---------------------------------------------------------|
|apt install	   | apt-get install	        | Installs a package                                      |
|apt remove	     |apt-get remove	          | Removes a package                                       |
|apt purge	     |apt-get purge	            | Removes package with configuration                      |
|apt update	     |apt-get update	          | Refreshes repository index                              |
|apt upgrade	   |apt-get upgrade	          | Upgrades all upgradable packages                        |
|apt autoremove	 |  apt-get autoremove	    | Removes unwanted packages                               |
|apt full-upgrade|	apt-get dist-upgrade	  | Upgrades packages with auto-handling of dependencies    |
|apt search	     |apt-cache search	        | Searches for the program                                |
|apt show	       |apt-cache show	          | Shows package details                                   |

Examples:

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

### Firefox

Completely uninstall. 

```
sudo apt-get purge firefox
rm -rf .mozilla/firefox/
sudo rm -rf /etc/firefox/
sudo rm -rf /usr/lib/firefox/
sudo rm -rf /usr/lib/firefox-addons/
```


### MS Teams

Download the deb package from the link to link below then rather than use `dpkg` use:

```
# for deb packages
sudo apt install gdebi-core
sudo gdebi skype.deb
```

https://www.howtoforge.com/how-to-install-microsoft-teams-linux-on-ubuntu-and-centos/

### <a name="email"></a>Email

Use evolution, or hiri, or mailspring (if you can stand it) or thunderbird in conjunction with DavMail, see:

https://www.youtube.com/watch?v=yCEK2hNP7bg

or Hiri (proprietary) via snap.

related    

https://www.zimbra.com/email-server-software/email-outlook-sync-mapi-zco/  
https://zentyal.com/community/  

### R

Add `deb https://cloud.r-project.org/bin/linux/ubuntu focal-cran40/` to `etc/apt/sources.list`.  

If on `apt update` you get   

```
The following signatures couldn't be verified because the public key is not available: NO_PUBKEY 759347893
```

then do  

`sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 759347893`


more information here https://cran.r-project.org/bin/linux/ubuntu/README.html under Secure APT.  

Necessary libs:

```
sudo apt install libgdal-dev 
sudo apt install libudunits2-dev
sudo apt install libgdal-dev
# for bookdownplus
sudo apt install libmagick++-dev
```

https://github.com/stan-dev/rstan/wiki/Installing-RStan-on-Linux

### Zoom

Use sso to login (uni-sydney).

### VIM

Use neovim instead `sudo apt install neovim`. Nb `nvim` to execute.


### KeepassXC

Open source version of KeePass. Cross platform. Can import Keepass db.

### Network monitoring

```
sudo apt install bmon
sudo apt install slurm
sudo apt tcptrack
sudo apt vnstat
```

https://www.tecmint.com/linux-network-bandwidth-monitoring-tools/

### Diff/Merge/FTP

```
sudo apt install meld
sudo apt install filezilla
```

### SSH

Tools for converting ppk from win box to ssh key. 

```
sudo apt-get install putty-tools
# convert priv
puttygen id_dsa.ppk -O private-openssh -o id_dsa
puttygen id_dsa.ppk -O public-openssh -o id_dsa
# agent running?
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_dsa
# use passphrase from original to get in
# then just
ssh -p portnum usernamem@199.19.19.1
```

or do it from scratch: https://support.pawsey.org.au/documentation/display/US/Logging+in+with+SSH
