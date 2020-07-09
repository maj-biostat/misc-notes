# Manjaro

Minimal with xfce: `manjaro-xfce-20.0.3-minimal-200606-linux56.iso`

## Software

### Management 

`pacman` https://wiki.manjaro.org/index.php?title=Pacman_Tips

Note `checkupdates` provides a safe way to check for upgrades to installed packages without running a system update at the same time.

Never install a package without updating the system first.

| command                        | desc                                       |
|--------------------------------|--------------------------------------------|
|pacman -Sy                      | download fresh copy of master package db   |
|pacman -Syu pkg                 |	Install (and update package list)         |
|pacman -S pkg                   |	Install only                              |
|pacman -R pkg                   |	Uninstall pkg                             |
|pacman -Rsu pkg                 |	Uninstall pkg and unneeded dep            |
|pacman -Ss keywords	           | Search                                     |
|pacman -Syu	                   | Upgrade everything                         |
|pacman -Qdt                     | list orphan pkgs not used by anything else |
|sudo pacman -Rs $(pacman -Qdtq) | remove all the orphans                     |
|sudo pacman -Sc                 | clear out cache                            |
|pactree -U package              | dependencies                               |
|pactree -r package              | dep                                        |
|pacman -Qe	                     | List explictly-installed packages          |
|pacman -Ql pkg	                 | What files does this package have?         |
|pacman -Qii pkg	               | List information on package                |
|pacman -Qo file	               |  Who owns this file?                       |
|pacman -Qs query	               | Search installed packages for keywords     |


Also

```
# update to closest mirror and update system
sudo pacman-mirrors --geoip  && sudo pacman -Syyu

# for local files
sudo pacman -U /var/cache/pacman/pkg/smplayer-19.5.0-1-x86_64.pkg.tar.xz
```

Urgh, install additional package manger `yay` to get to Arch User Repository.  
Commands pretty much as per `pacman`

```
sudo pacman -Syu yay
```

### Video drivers

The standard guide is here:
https://wiki.manjaro.org/index.php?title=Configure_NVIDIA_(non-free)_settings_and_load_them_on_Startup

also relevant https://wiki.archlinux.org/index.php/NVIDIA_Optimus

Note the summary here:
https://forum.manjaro.org/t/howto-set-up-prime-with-nvidia-proprietary-driver/40225

If you can deal with it then the simplest approach is to turn off the internal gpu via the uefi and to power the output ports by the gpu.  

Specifically, note the 'in short' text here:  
http://www.daknetworks.com/blog/453-dell-precision-7720-graphics

The NVIDIA guide:  
http://us.download.nvidia.com/XFree86/Linux-x86/370.28/README/index.html

Useful commands

```
# install screen configurator
sudo pacman -Syu xorg-xrandr
# List configs
xrandr
# driver
mhwd -li
# system desc
inxi -Fxxxza
inxi -G
hwinfo --display --monitor

xrandr --listproviders 
xrandr --prop
pacman -Qs | grep -Ei 'prime|nvidia|optimus|bbsw|vesa|xf86-video'
ls -laR /etc/X11 ; cat /etc/X11/xorg.conf.d/*.conf
ls -la /etc/modprobe.d ; cat /etc/modprobe.d/*.conf
ls -la /etc/modules-load.d ; cat /etc/modules-load.d/*.conf
ls -la /usr/share/X11/xorg.conf.d ; grep -v /usr/share/X11/xorg.conf.d/*.conf
```

Default res on external 3840 x 2160 16:9. Pick something more sensible e.g. 1920  x 1080.


### R

```
sudo pacman -Syu gcc-fortran
# use faster openblas - need to install prior to install r
sudo pacman -Syu openblas
sudo pacman -Syu r
yay -Syu rstudio-desktop
# select 1 rstudio-desktop
```


### Email

See around 8:15 mins for config (under gnome) at https://www.youtube.com/watch?v=yCEK2hNP7bg

```

```