# Ubuntu

Notes on installing and setting up Ubuntu.

- [Ubuntu](#ubuntu)
  * [<a name="install"></a>Installing 20.04 LTS](#-a-name--install----a-installing-2004-lts)
  * [Device details](#device-details)
  * [Drive management](#drive-management)
    + [Disk usage](#disk-usage)
    + [Adding drive to automount](#adding-drive-to-automount)
  * [Video drivers](#video-drivers)
  * [Monitors](#monitors)
  * [Grub](#grub)
  * [Software](#software)
    + [Management](#management)
    + [Upgrade rollback](#upgrade-rollback)
    + [nteract](#nteract)
    + [Firefox](#firefox)
    + [wget](#wget)
    + [MS Teams](#ms-teams)
    + [<a name="email"></a>Email](#-a-name--email----a-email)
    + [R install](#r-install)
    + [Zoom](#zoom)
    + [VIM](#vim)
    + [KeepassXC](#keepassxc)
    + [Network monitoring](#network-monitoring)
    + [Diff/Merge/FTP](#diff-merge-ftp)
    + [SSH](#ssh)
    + [Video/audio capture](#video-audio-capture)
    + [Virtualisation](#virtualisation)
    + [find](#find)




## Install

## Post-install

## Usage

### File renames

```
for f in *.txt; do 
    mv -- "$f" "${f%.txt}.text"
done
```

### USB Drives

Ask - what usb devices can my box see?

```
sudo lsusb
```
What devs?

```
sudo fdisk -l
```

Create a director in your home directory and mount

```
mkdir /home/fred/usb
sudo mount /dev/deviceid /home/fred/usb
```

Umount

```
sudo umount /home/fred/usb
```

### Jupyter / IPython

From the command line

```
pip install --user jupyter
jupyter notebook
```



## Monitor the results from a command

```
watch -n 3 ls -l logs/ out/
```



### Network configuration

Don't use `ifconfig` use `ip` e.g. 

```
ip a
```

and use `iw dev` to get the wifi mac address.


### Hamster time tracker

`sudo pacman -S hamster-time-tracker`



### Vim / vim-plug

`sudo pacman -S vim`

Thing is, the above installs vim-minimal (I think). This does not have clipboard enabled.

Test with:

:echo has('clipboard')

if the result is 0 then install gvim (you might need to uninstall vim). This will give you access to the system clipboard via select and middle mouse button.



Download the package `nvim-r` from here:
https://www.vim.org/scripts/script.php?script_id=2628

To install vimplug: go here, follow instruc
https://
hub.com/junegunn/vim-plug

In a nutshell:
open Nvim-R.vmb in vim and then do `:so %`


#### Vim Colourscheme

Get colourschemes from eg

https://github.com/flazz/vim-colorschemes
https://github.com/fxn/vim-monochrome
https://github.com/sjl/badwolf
https://github.com/noahfrederick/vim-noctu

Download the .vim files and copy to `~/.vim/color` directory:

mv ~/Downloads/vim-distinguished-develop/colors/*.vim ~/.vim/colors/

Edit the `~/.vimrc` file introducing:

syntax enable
colorscheme distinguished





### git help

`git config --global user.name "Fred Basset"`
`git config --global user.email email_no_quotes`

History of file...?

`gitk filename.R`

will launch a gui viewer.

remove a file from git but keep locally

`git rm --cached somefile.ext`



### grep et al

Recursive from current directory, only *.R files.

`grep -R --include="*.R" 'contr.sum' .`




### tar archives

```
tar cvf archive.tar dir1 dir2 etc
gzip archive.tar

# hash
sha256sum archive.tar.gz

# for fat32
split -b 2000M archive.tar.gz archive_part

# join back together
cat archive_part* > test.tar.gz

# hash
sha256sum test.tar.gz
```




















## <a name="install"></a>Installing 20.04 LTS

https://www.youtube.com/watch?v=n8VwTYU0Mec

Boot log is stored at `/var/log/boot.log` and `/var/log/dmesg` (kernel ring buffer) and to view use `dmesg | less` (`q` to exit). 
Alternatively, if you are in the UI, do special key and then type logs to run the Logs app.

Other useful logs (some might be binary) include:

+ `/var/log/auth.log` authorisation 
+ `/var/log/daemon.log` daemons (ssh etc)
+ `/var/log/debug`
+ `/var/log/kern.log`
+ `/var/log/syslog` if you cannot find it anywhere else, it will probably be in here `man syslogd`
+ `/var/log/Xorg.0.log` your favourite and mine
+ `/var/log/faillog` login failures
+ `/var/log/wtmp` user info, but just use `who`

## Device details

Use list hardware `lshw`, for example, computer model:

```
sudo lshw | grep product
```

# inittab

Is no longer with us. 
To switch run level use

```
systemctl get-default
 
 # Set the current run level to 3 (boot to command line mode)
systemctl set-default multi-user.target
 
 # Set the current running level to 5 (power on as a graphical interface)
systemctl set-default graphical.target
```


# Ghostscript (kind of)

`ps2pdf` is obtained via tinytex but my understanding is that this is just a wrapper to gs  
You can specify an output size as `ps2pdf -g5950x8420 kalman4.ps`

This https://stackoverflow.com/questions/30128250/ps2pdf-preserve-page-size is useful.

# To redo install
create liveusb
Press F12? to go to boot screen
boot the live install
run the installer (select free driver)

## Wget

Examples

```
# Mirror
wget --recursive --no-parent --continue --no-clobber https://urlOfInterest
# All files of type
wget ‐‐level=1 ‐‐recursive ‐‐no-parent ‐‐accept mp3,MP3 http://example.com/mp3/
# Single file
wget https://test.org/latest.zip

# All files of type
wget --spider -r --accept "*.docx" 
# List of urls
wget ‐‐input list-of-file-urls.txt

```


## Drive management

Useful commants

```
sudo lsusb
sudo fdisk -l
# mkdir /home/fred/media
sudo mount /dev/sda1 /home/fred/media
sudo umount /home/fred/media
```

### Disk usage

Size of directory and contents

```
du -sh /home/myfatdir
# breakdown
du -shc /home/myfatdir/*
```

### Adding drive to automount

Identify the device (disk) you want to mount with `sudo fdisk -l` (gives you the `/dev/blah`) then get its universal id with `sudo blkid` (gives you the id e.g. `UUID="123a-321b"`).  

Create a mount point `sudo mkdir /data` and update grouop ownership:  

```
sudo groupadd data
sudo usermod -aG data USERNAME (Where USERNAME is the name of the user to be added)
sudo chown -R :data /data
```

Add the following to the end of `/etc/fstab` (note the id is from the dummy example above):

```
UUID=123a-321b /data    auto nosuid,nodev,nofail,x-gvfs-show 0 0
```

The flags indicate:

+ `UUID=123a-321b` is the UUID of the drive
+ `/data` is the mount point for the device.
+ `auto` automatically mounts the partition at boot 
+ `nosuid` the filesystem cannot contain set userid files. This prevents root escalation and other security issues.
+ `nodev` the filesystem cannot contain special devices (to prevent access to random device hardware).
+ `nofail` removes the errorcheck.
+ `x-gvfs-show` show the mount option in the file manager
+ `0` determines which filesystems need to be dumped (0 is the default).
+ `0` determine the order in which filesystem checks are done at boot time (0 is the default).

Finally, test with `sudo mount -a`.  
If there are no errors and you can access the mount point then you should be fine to reboot.


## Video drivers

This is without doubt the most hassle you will get from linux.
Often blue screen of death relates to nvidia drivers. 
Upgrades of the drivers will result in things like external monitors not working and even entire system not booting.

Current drivers:

![VideooDrivers](sep2020vid.png "Additional drivers")

Various links of interest

https://askubuntu.com/questions/882385/dev-sda1-clean-this-message-appears-after-i-startup-my-laptop-then-it-w  
https://linoxide.com/linux-how-to/how-to-install-nvidia-driver-on-ubuntu/  
https://sourcedigit.com/25531-install-nvidia-graphics-driver-on-ubuntu-20-04/  

Note comment on grub update  
https://askubuntu.com/questions/1059965/internal-laptop-screen-not-detected-when-using-nvidia-driver  


If you need to do a boot to terminal, do, Alt-F2 then login to terminal.

```
# Graphics card and drivers
sudo hwinfo --gfxcard --short
```

This will give a brief report of the card and driver:

```
lspci -k | grep -A 2 -i "VGA"
01:00.0 VGA compatible controller: NVIDIA Corporation TU117GLM [Quadro T2000 Mobile / Max-Q] (rev a1)
	Subsystem: Dell TU117GLM [Quadro T2000 Mobile / Max-Q]
	Kernel driver in use: nvidia
```

The following gives more detail.

```
nvidia-smi

Sat Nov 14 13:55:58 2020       
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 450.80.02    Driver Version: 450.80.02    CUDA Version: 11.0     |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|                               |                      |               MIG M. |
|===============================+======================+======================|
|   0  Quadro T2000        Off  | 00000000:01:00.0  On |                  N/A |
| N/A   47C    P8     6W /  N/A |    461MiB /  3903MiB |      9%      Default |
|                               |                      |                  N/A |
+-------------------------------+----------------------+----------------------+
                                                                               
+-----------------------------------------------------------------------------+
| Processes:                                                                  |
|  GPU   GI   CI        PID   Type   Process name                  GPU Memory |
|        ID   ID                                                   Usage      |
|=============================================================================|
|    0   N/A  N/A      1092      G   /usr/lib/xorg/Xorg                161MiB |
|    0   N/A  N/A      1657      G   /usr/lib/xorg/Xorg                123MiB |
|    0   N/A  N/A      1784      G   /usr/bin/gnome-shell              109MiB |
|    0   N/A  N/A      2294      G   ...AAAAAAAAA= --shared-files       57MiB |
+-----------------------------------------------------------------------------+

# Previously was
Wed Sep 30 10:56:30 2020       
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 450.66       Driver Version: 450.66       CUDA Version: 11.0     |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|                               |                      |               MIG M. |
|===============================+======================+======================|
|   0  Quadro T2000        Off  | 00000000:01:00.0  On |                  N/A |
| N/A   50C    P0    15W /  N/A |    400MiB /  3903MiB |      3%      Default |
|                               |                      |                  N/A |
+-------------------------------+----------------------+----------------------+
                                                                               
+-----------------------------------------------------------------------------+
| Processes:                                                                  |
|  GPU   GI   CI        PID   Type   Process name                  GPU Memory |
|        ID   ID                                                   Usage      |
|=============================================================================|
|    0   N/A  N/A      1089      G   /usr/lib/xorg/Xorg                 39MiB |
|    0   N/A  N/A      1640      G   /usr/lib/xorg/Xorg                168MiB |
|    0   N/A  N/A      1768      G   /usr/bin/gnome-shell              143MiB |
|    0   N/A  N/A      4538      G   ...AAAAAAAAA= --shared-files       40MiB |
+-----------------------------------------------------------------------------+


# Previously was
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 440.100      Driver Version: 440.100      CUDA Version: 10.2     |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|===============================+======================+======================|
|   0  Quadro T2000        Off  | 00000000:01:00.0  On |                  N/A |
| N/A   35C    P8     6W /  N/A |    479MiB /  3903MiB |      2%      Default |
+-------------------------------+----------------------+----------------------+
                                                                               
+-----------------------------------------------------------------------------+
| Processes:                                                       GPU Memory |
|  GPU       PID   Type   Process name                             Usage      |
|=============================================================================|
|    0      1035      G   /usr/lib/xorg/Xorg                           161MiB |
|    0      1614      G   /usr/lib/xorg/Xorg                           125MiB |
|    0      1819      G   /usr/bin/gnome-shell                         113MiB |
|    0      2117      G   ...6454/.local/share/hiri_1.4.0.5/hirimain    22MiB |
|    0      2274      G   ...6454/.local/share/hiri_1.4.0.5/hirimain     1MiB |
|    0      2299      G   ...AAAAAAAAAAAACAAAAAAAAAA= --shared-files    44MiB |
+-----------------------------------------------------------------------------+
```






```
# suggest recommended drivers
sudo ubuntu-drivers devices
# e.g.
sudo apt install nvidia-driver-440
sudo shutdown -r now
# and pray

# switch primary card
sudo prime-select query # sept 2020 gives nvidia
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

Restarting X with `pkill X`


Now we see the Quadro T2000 running off the nvidia driver (look below at `configuration: driver=nvidia`

```
sudo lshw -c display
  *-display                 
       description: VGA compatible controller
       product: TU117GLM [Quadro T2000 Mobile / Max-Q]
       vendor: NVIDIA Corporation
       physical id: 0
       bus info: pci@0000:01:00.0
       version: a1
       width: 64 bits
       clock: 33MHz
       capabilities: pm msi pciexpress vga_controller bus_master cap_list rom
       configuration: driver=nvidia latency=0
       resources: irq:205 memory:b4000000-b4ffffff memory:70000000-7fffffff memory:80000000-81ffffff ioport:3000(size=128) memory:b5000000-b507ffff
  *-display
       description: VGA compatible controller
       product: UHD Graphics 630 (Mobile)
       vendor: Intel Corporation
       physical id: 2
       bus info: pci@0000:00:02.0
       version: 02
       width: 64 bits
       clock: 33MHz
       capabilities: pciexpress msi pm vga_controller bus_master cap_list rom
       configuration: driver=i915 latency=0
       resources: irq:203 memory:b3000000-b3ffffff memory:60000000-6fffffff ioport:4000(size=64) memory:c0000-dffff

```


```
# kernel module status
lsmod | grep video
uvcvideo               98304  0
videobuf2_vmalloc      20480  1 uvcvideo
videobuf2_memops       20480  1 videobuf2_vmalloc
videobuf2_v4l2         24576  1 uvcvideo
videobuf2_common       49152  2 videobuf2_v4l2,uvcvideo
videodev              225280  3 videobuf2_v4l2,uvcvideo,videobuf2_common
mc                     53248  4 videodev,videobuf2_v4l2,uvcvideo,videobuf2_common
video                  49152  2 dell_wmi,dell_laptop
```



## Monitors

Sometimes the external monitor works but the laptop screen doesn't.
Sometimes the reverse is true.
Why?
Honestly, I do not really know but the following details a few tips found in forums etc.

`~/.config/monitor.xml` can occassionally get munted.  
Delete the above file, disconnect external, restart, replug external.  

Note default display manager (lightdm, gdm3 etc) from `cat /etc/X11/default-display-manager`

Open the file in your favorite editor (vim, nano, gedit, etc.).

```
sudo nano /lib/modprobe.d/nvidia-kms.conf
```

And comment out the the nvidia-drm modeset option.

```
# This file was generated by nvidia-prime
# Set value to 0 to disable modesetting
# options nvidia-drm modeset=1
```

## Grub

Grub is the bootloader; the thing that starts up your system.
To get rid of the quiet splashscreen so that everything is output while loading:

```
# in /etc/default/grub
GRUB_CMDLINE_LINUX_DEFAULT="nomodeset"
sudo update-grub2
sudo shutdown -r now
```

https://www.dedoimedo.com/computers/grub-2.html


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
|apt list --installed | ? | Shows all the installed packages |

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
# upgrade a single package
sudo apt install apache2
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

### Upgrade rollback 

**WARNING:** Fraught. Do not proceed unless absolutely necessary.

```
grep -A 2 'Start-Date: 2020-09-30' /var/log/apt/history.log
```
https://www.cyberciti.biz/howto/debian-linux/ubuntu-linux-rollback-an-apt-get-upgrade/


### nteract

A desktop application that allows you to run notebooks.  

```
wget https://github.com/nteract/nteract/releases/download/v0.24.1/nteract_0.24.1_amd64.deb
sudo gdebi nteract_0.24.1_amd64.deb
```

Now open the Julia REPL and type `]` then add the `IJulia` package with `add IJulia`. 
Enter `Ctl-C`  to exit the `pkg` manager.
Find nteract in your applications and launch.


### Firefox

Completely uninstall. 

```
sudo apt-get purge firefox
rm -rf .mozilla/firefox/
sudo rm -rf /etc/firefox/
sudo rm -rf /usr/lib/firefox/
sudo rm -rf /usr/lib/firefox-addons/
```

### wget 

Examples see https://www.gnu.org/software/wget/manual/html_node/Examples.html 

```
# Retrieve the first two levels of ‘wuarchive.wustl.edu’, saving them to /tmp.
wget -r -l2 -P/tmp http://www.example.com/dir/
# You want to download all the pdfs from a directory on an HTTP server. 
wget -r -l1 --no-parent -A.pdf http://www.example.com/dir/
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

Have now resorted to using office outlook online.

Alternatively use evolution, or hiri, or mailspring (if you can stand it) or thunderbird in conjunction with DavMail, see:

https://www.youtube.com/watch?v=yCEK2hNP7bg

or Hiri (proprietary) via snap.

related links:

https://www.zimbra.com/email-server-software/email-outlook-sync-mapi-zco/  
https://zentyal.com/community/  

### R install

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
# for V8 (rstan dependency)
sudo apt install libnode-dev
```
Base R

```
sudo apt install r-base
sudo apt install r-base-dev
```

https://github.com/stan-dev/rstan/wiki/Installing-RStan-on-Linux

To install home baked packages from the commanline do:

```
R CMD INSTALL --preclean --no-multiarch mypackage

# or via R console:
library(devtools)
devtools::document(roclets = c('rd', 'collate', 'namespace', 'vignette'))
devtools::build()
devtools::install()
```

For adhoc packages use:

```
# From R console
install.packages("pkgname", dependencies = T, repos = 'https://cran.curtin.edu.au', quiet = F)
# Or from a source package
install.packages(path_to_file, repos = NULL, type="source")
```

Run script from terminal (redirect output stdout/stderr to log) in the background.

```
/usr/bin/Rscript main.R > log.txt 2>&1 &
```

Kill them all!

```
for pid in $(pgrep R); do kill -9 $pid; done
```

List the jobs (stop with ctl-z).

```
jobs
# bring job 1 into the foreground
fg % 1
# to background
bg % 1
```

**Packages containing `rstan` models:**

Use `rstantools`; provide the full path, which will end in the name of the package, in this case package is "fred".

```
library("rstantools")
rstan_create_package(path = '/home/ubuntu/fred') 
```
update DESCRIPTION  
delete Read-and-delete-me  
add stan file into inst/stan (just put one stan file in for now)  
add following R file  

```
# Save this file as `R/mystaninferface.R` (or something more sensible)

#' Bayesian linear regression with Stan
#'
#' @export
#' @param ld Just the list of data stuff that you would normally pass into sampling
#' @param ... Arguments passed to `rstan::sampling` (e.g. iter, chains).
#' @return An object of class `stanfit` returned by `rstan::sampling`
#'
myfunctiontocallmodel <- function(ld, ...) {
  out <- rstan::sampling(stanmodels$lm, data = ld, ...)
  return(out)
}
```

update the `fred-package.R` file
run (and watch it fail)

```
try(roxygen2::roxygenize(load_code = sourceDir), silent = TRUE)
pkgbuild::compile_dll()
roxygen2::roxygenize()
```

add to NAMESPACE (I know it says don't)

```
# Generated by roxygen2: do not edit by hand

export(myfunctiontocallmodel)
import(Rcpp)
import(methods)
importFrom(rstan,sampling)
useDynLib(fred, .registration = TRUE)
```

close down rstudio, go to the terminal, `cd` to above the package dir and do:

```
R CMD INSTALL --preclean fred
```

once you are convinced that it is working, go back to rstudio, and do a clean/rebuild/document (via the build dropdown) or:

```
devtools::document(roclets = c('rd', 'collate', 'namespace'))
```

and start adding other models etc.
The `NAMESPACE` should now update on `roxygen2::roxygenize()` but you know what to do if not.


also see https://cran.r-project.org/web/packages/rstantools/vignettes/minimal-rstan-package.html but note the instructions tend to not work.


### Zoom

Use sso to login (uni-sydney).
Note, there is something wrong with the sound drivers on my system.
However, when I use wireless headphone/mic setup, that works ok.
Urgh.
Sometimes it is easier to use `zoom`, `teams` etc via a VM, see Virtualbox.

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

Tools for converting a ppk from win box format to ssh key. 

**NOTE** 
When specifying a port `scp` uses a capital `-P` whereas `ssh uses a small `-p`. Urgh.

```
sudo apt-get install putty-tools
# convert priv - here you need to use the passphrase associated with the ppk file. 
# if you need to create a ppk file:
puttygen -t rsa -C "my home key" -o mykey.ppk
# if you do not have it, you are stuffed.
puttygen id_dsa.ppk -O private-openssh -o id_dsa
puttygen id_dsa.ppk -O public-openssh -o id_dsa.pub
# agent running?
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_dsa
# use passphrase from original to get in
# then just
ssh -p portnum usernamem@199.19.19.1
```

or do it from scratch: https://support.pawsey.org.au/documentation/display/US/Logging+in+with+SSH

To copy files across, you can use `scp`, e.g.

```
scp -P 1234 file.tar ubuntu@1.2.3.4:/home/userdir
```

### Video/audio capture

```
sudo apt install guvcview
sudo apt install audacity
sudo apt install vlc
```


### Virtualisation

Virtual box.

https://www.youtube.com/watch?v=2oO9CeZXjTY

If everything has gone to plan, you will be prompted on clicking Device -> Insert guest additions to download.  
Download, then insert the iso as a cd then install the guest additions on the virtual windows box.

```
sudo apt search virtualbox
sudo apt install virtualbox-ext-pack
```

If you forget to install the extension pack (like I did) then your webcam (for example) won't work in your virtual machine. 
To rectify this, start your windows vm, then in the linux terminal do:

```
# The the webcam devices, the integrated cam in a laptop will be the first
VBoxManage list webcams
# Then add the webcam to the vm
VBoxManage controlvm "win10_or_whatever_you_called_your_vm" webcam attach /dev/vid123 
```

The windows OS should register the webcam and set it up for you and after that you will be able to use the webcam on the vm.


### find


```
# all files modified since:
find . -type f -newermt 2020-11-19
# pdfs accessed in last 3 days
find . -iname "*.pdf" -atime -3 -type f
# modified in the last 24 hours
find . -iname "*.pdf" -mtime 0 -type d
```
