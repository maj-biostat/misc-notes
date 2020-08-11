# Ubuntu

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

## Drive management

Useful commants

```
sudo lsusb
sudo fdisk -l
# mkdir /home/fred/media
sudo mount /dev/sda1 /home/fred/media
sudo umount /home/fred/media
```

Also, if you want to see how much space a directory is taking up (disk usage):

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

Often blue screen of death relates to nvidia drivers.

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
nvidia-smi
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



## Monitor madness

External monitor works, internal screen doesn't or vice versa. Why?

`~/.config/monitor.xml` can occassionally get munted.  
Delete the above file, disconnect external, restart, replug external.  

Note default display manager (lightdm, gdm3 etc) from `cat /etc/X11/default-display-manager`

## Grub

Get rid of the quiet splash:

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
```

Run script from terminal.

```
/usr/bin/Rscript main.R
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
Note, it is easier to use `zoom`, `teams` etc via a VM, see Virtualbox.

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
# convert priv - here you need to use the passphrase associated with the ppk file. 
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


