# Linux Miscellaneous 









## NVIDIA

You need to have done the install using the free drivers.
Edit grub (/etc/default/grub) then `sudo update-grub` as per dorian dot slash then go to [https://wiki.manjaro.org/index.php?title=Configure_NVIDIA_(non-free)\_settings_and_load_them_on_Startup and follow instructions]

## Pacman tips

https://wiki.manjaro.org/index.php?title=Pacman_Tips

```
# first:
# run checkupdates, which is included with the pacman, provides a safe way 
# to check for upgrades to installed packages without running a system 
# update at the same time
checkupdates

# update to closest mirror and update system
sudo pacman-mirrors --geoip  && sudo pacman -Syyu
# search
pacman -Ss pkg_name 
# download fresh copy of master package db 
pacman -Sy
# install a package
pacman -S pkg_name
# upgrade 
pacman -Su
# remove 
pacman -R package_name

# update the package database and update all packages on the system
sudo pacman -Syu

# dependencies
pactree -U package
pactree -r package

```

Use https://www.archlinux.org/mirrorlist/ to generate new list of mirrors.

## Yay

https://www.ostechnix.com/yay-found-yet-another-reliable-aur-helper/

```
sudo pacman -S yay
# Uninstall package (although you can just use pacman -R)
yay -Rns pkgname
```




## Phoronix bench tests

`yay -S phoronix-test-suite`



## Panel plugins

```
yay -S xfce4-hardware-monitor-plugin
yay -S xfce4-datetime-plugin
```



## Chrome

`yay -S google-chrome`

## Sublime text 3

https://www.sublimetext.com/docs/3/linux_repositories.html






## Apps

Look into.
Nightlight (red shift)
tweaktool - window deco
libre
gparted - kde partition mgr
gimp
timeshift
geary - email


### Install R from command line to local folder

Update 2020-03-26:

The approach https://forum.manjaro.org/t/using-the-statistical-package-r-in-manjaro-with-rstudio/484 

seems to work just fine. 

The following is retained for posterity.

```
The easiest way to do this is to install R from source:

$ wget http://cran.rstudio.com/src/base/R-3/R-3.4.1.tar.gz
$ tar xvf R-3.4.1.tar.gz
$ cd R-3.4.1
$ ./configure --prefix=$HOME/myr
$ make && make install
```

The configure part is very important. 
It specifies the directory you will install to.

Next you might want to specify where your packages are installed. 
I create a `.Rprofile` file with the line `.libPaths("/home/me/myrlib/3.6")`.

```
sudo pacman -S r
yay -S rstudio-desktop-bin
# multicore support
yay -S openblas-lapack
sudo pacman -S pandoc
sudo pacman -S pandoc-citeproc
```

### JAGS

yay -S jags







## atom


I think I had to uninstall language-r and then let lintr install it as a dependency.

Also note:
https://jstaf.github.io/2018/03/25/atom-ide.html

```
yay -S atom
yay -S apm
apm install ide-r language-r
sed -i '0,/Grep/{s/Grep/Grep 2/}' ~/.atom/packages/language-r/snippets/language-r.cson
sed -i '0,/Cummulative max/{s/Cummulative max/Cummulative max 2/}' ~/.atom/packages/language-r/snippets/language-r.cson
apm install language-markdown
apm install atom-ide-ui ide-python
apm install block-select
apm install column-select
```



## Hardware details

```
sudo pacman -S hardinfo

sudo dmidecode

sudo dmidecode --type memory


cat /proc/cpuinfo
cat /proc/cpuinfo | grep processor | wc -l
lscpu

sudo pacman -S i-nex libcpuid
```



## Hardware

Intel Xeon Silver 4110 LGA3647 2.1GHz 8-Core CPU Processor
SKU# AC08317, Model# BX806734110



# XFCE things

Switch workspace `ctl alt left/right arrow`

