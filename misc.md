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





## python

already installed

## tensorflow and greta

This was a bit of a dick on but I really wanted to test out greta, see:

+ https://rviews.rstudio.com/2018/04/23/on-first-meeting-greta/
+ https://greta-stats.org/articles/get_started.html

Greta depends on tensorflow and the suggested way to install relies on anaconda, which I didn't want to use. Also there is a dependency issue on tensorflow 1.10 from rstudio whereas tensorflow is currently up to 1.12. So I installed from scratch:

```
pip install virtualenv
yay -S tensorflow
yay -S python-tensorflow
pip install --user tensorflow-probability
```

Unfortunately I do not presently have a clue about virtualenv.

In R you can then do:

```
devtools::install_github("greta-dev/greta")
# at the time of writing the above required an update to purrr
# lets you easily specify python to use
# install.packages("reticulate")
library(reticulate)
reticulate::use_python("/usr/bin/python")

library(greta)
library(bayesplot)

intercept <- normal(0, 5)
coef <- normal(0, 3)
sd <- lognormal(0, 3)

x <- iris$Petal.Length
y <- iris$Sepal.Length
mean <- intercept + coef * x
distribution(y) <- normal(mean, sd)
m <- model(intercept, coef, sd)

draws <- greta::mcmc(m, n_samples = 1000, chains = 4)
bayesplot::mcmc_trace(draws)
```



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


## GPG

Allows you to encrypt and sign your data and communication.

Works in much the same way an SSH key or an SSL cert works, you have a public key which encrypts things and a matching private key which decrypts those things.

It’s safe to give out your public key but not your private key.

Here is the arch guide: https://wiki.archlinux.org/index.php/GnuPG. What you need is below.

### Create a key pair

```
gpg --full-gen-key

# the RSA (sign only) and a RSA (encrypt only) key.
# a keysize of the default value (2048).
# an expiration date - 1 year is good enough. Expiration can be extended without having to re-issue a new key.
# name and email address (seen by anybody who imports your key).
# You can add multiple identities to the same key later
# a secure passphrase.

# If you lose your secret key or it is compromised, you will want to revoke your
# key by uploading the revocation certificate to a public keyserver - assumes you uploaded your public key to a keyserver
# print out then store securely.

gpg --gen-revoke --armor --output=RevocationCertificate.asc <user-id>

# list public and secret keys
gpg --list-keys
gpg --list-secret-keys

# edit keys
gpg --edit-key <user-id>

```
### Export your public key

So that others can encrypt messages for you (stored in public.key file). User id is email.

```
gpg --output public.key --armor --export user-id
```

### Import a public key

In order to encrypt messages to others, as well as verify their signatures, you need their public key (below assumed to be stored in a file with the filename public.key). Verify the authenticity of the retrieved public key.

```
gpg --import public.key
```

### Encrypt and decrypt

After importing a public key. For decrypt, `gpg` will prompt you for your passphrase and then decrypt and write the data from doc.gpg to doc.

```
gpg --recipient user-id --encrypt doc
gpg --output doc --decrypt doc.gpg
```

note that to export your secret key for backup you can do `gpg2 --export-secret-keys > secret.gpg` but never put this anywhere unsafe as once it is in someone elses hands you are compromised.

## pass

is a command line password manager. set up gpg first. then install with the usual pacman command.  initialise a new store with:

```
pass init email
# add a password - automatically created a 10 character password
# will output what the password is:
pass generate test 10
# review the passwords in the store
pass
```
typing `pass test` will prompt you for the gpg passphrase then show you the requested password. if you use `pass -c test` the password will be copied to the clipboard for 45 seconds. remove the password using `pass rm test` 

## job management, e.g. pgrep

is something i was unaware of but is very useful for killing a number of instances of the same application, e.g. 

```
for pid in $(pgrep R); do kill -9 $pid; done
```

Start a job in the background piping to stdout and stderr to file.

```
./run_sim_3.sh > logs/test.log 2>&1 &
```
## useful shell commands to used in conjunction with pipes

These can be used for extracting columns, seeing the number of words in a file and selcting unique entries from a file respectively.
```
cut -d , -f 2 fname.txt
wc -l fname.txt | sort -n
uniq fname.txt

# use all 3!!
cut -d , -f 2 animals.txt | sort | uniq
```

## shell scripts

Just some basic examples:

Simple script processing a few command line args.

```
# Select lines from the middle of a file.
# Usage: bash middle.sh filename end_line num_lines
head -n "$2" "$1" | tail -n "$3"
```

Here we use the `"$@"` command to say that all command line arguments passed in should be used.
```
# Sort filenames by their length.
# Usage: bash sorted.sh one_or_more_filenames
wc -l "$@" | sort -n
```

Here is a snazzy thing to redo the last 4 commands in the history.

```
history | tail -5 | cut -d " " -f 2 | head -4
```

Wordcount on files identified with `find`:

```
wc -l $(find . -name "asterix.dat") | sort -n 
```

Find all files from current dir and sort them by date/time

```
find . your-options -printf "%T+\t%p\n" | sort
```

Find all files of a specified type in a given dir then grep them for a term

```
find . -type f -name '*.R' -print0 | xargs -0 grep -o 'new.env()'
```


Invoke command on other machine when your command has quotes within quotes:

```
ssh username@machinename "sh -c 'R CMD REMOVE '\''rstanmodels'\'' &'"

ssh username@machinename "sh -c 'R CMD INSTALL --preclean rstanmodels'"
```


## openssh

`sshd`, `sftp` and other things. 

After diligently updating `/etc/ssh/sshd_config` use the following to control the status of the ssh demon.

```
# this has the sshd running continually - bad
sudo systemctl enable sshd.service

# so change it:
sudo systemctl disable sshd.service

# manual start is 
sudo systemctl start sshd.service

# and stop with
sudo systemctl stop sshd.service

# check status
sudo systemctl status sshd.service
```

On the client do

```
ssh -p portnum user@ipaddr
```

## screen

Linux Screen allows you to:

+ Use multiple shell windows from a single SSH session.
+ Keep a shell active even through network disruptions.
+ Disconnect and re-connect to a shell sessions from multiple locations.
+ Run a long running process without maintaining an active shell session.

```
sudo pacman -S extra/screen
```

Note that to scroll up in `screen` you need to invoke `ctl A` then hit escape, then use the arrow keys (up and down) or page up/down. When you are done hit escape again.


Commands:

```
# create a screen session
screen             
# detach current screen session
Ctrl a + d   
# reattach latest screen session
screen -RR         
# list all screen sessions
screen -ls          
# reattach session
screen -R <session id (from screen -ls)>   
# kill all
ctrl a + \
```

# XFCE things

Switch workspace `ctl alt left/right arrow`

