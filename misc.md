# Linux Miscellaneous 

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


## File renames

```
for f in *.txt; do 
    mv -- "$f" "${f%.txt}.text"
done
```

## USB Drives

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

## Jupyter / IPython

From the command line

```
pip install --user jupyter
jupyter notebook
```

## Monitor the results from a command

```
watch -n 3 ls -l logs/ out/
```

## Phoronix bench tests

`yay -S phoronix-test-suite`


## Network configuration

Don't use `ifconfig` use `ip` e.g. 

```
ip a
```

and use `iw dev` to get the wifi mac address.

## Panel plugins

```
yay -S xfce4-hardware-monitor-plugin
yay -S xfce4-datetime-plugin
```

## Hamster time tracker

`sudo pacman -S hamster-time-tracker`

## Chrome

`yay -S google-chrome`

## Sublime text 3

https://www.sublimetext.com/docs/3/linux_repositories.html

## Vim / vim-plug

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


### Colourscheme

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




## git help

`git config --global user.name "Fred Basset"`
`git config --global user.email email_no_quotes`

History of file...?

`gitk filename.R`

will launch a gui viewer.

remove a file from git but keep locally

`git rm --cached somefile.ext`

## grep et al

Recursive from current directory, only *.R files.

`grep -R --include="*.R" 'contr.sum' .`


## tar archives

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

## Apps

Look into.
Nightlight (red shift)
tweaktool - window deco
libre
gparted - kde partition mgr
gimp
timeshift
geary - email

## R / RStudio (and dep) / pandoc

Debugging R

```
tryCatch({
	if(stuff){
	  # do something
	}, error = function(e) {
	
	  dump.frames(include.GlobalEnv = T19)
	  save.image(file = paste0(get_hash(), "_blast.dump.rda"))
	}

})

```

then in a new session:

```
> load("7b9ab05b_last.dump.rda")
> debugger(last.dump)
Available environments had calls:
1: sim(cfg_rar_4(trial_interface = trial_GS_RAR, outdir = "outrar4", nsim = 20
2: mclapply(X = 1:length(ld), mc.cores = ncores, FUN = function(x) {
    lmet
3: lapply(seq_len(cores), inner.do)
4: FUN(X[[i]], ...)
5: sendMaster(try(lapply(X = S, FUN = FUN, ...), silent = TRUE))
6: try(lapply(X = S, FUN = FUN, ...), silent = TRUE)
7: tryCatch(expr, error = function(e) {
    call <- conditionCall(e)
    if (!
8: tryCatchList(expr, classes, parentenv, handlers)
9: tryCatchOne(expr, names, parentenv, handlers[[1]])
10: doTryCatch(return(expr), name, parentenv, handler)
11: lapply(X = S, FUN = FUN, ...)
12: FUN(X[[i]], ...)
13: tryCatch(lpar$trial_interface(ld[[x]], lpar, x), error = function(e) {

14: tryCatchList(expr, classes, parentenv, handlers)
15: tryCatchOne(expr, names, parentenv, handlers[[1]])
16: doTryCatch(return(expr), name, parentenv, handler)
17: lpar$trial_interface(ld[[x]], lpar, x)
18: RAR_alloc(ldat, idxend + 1, nrow(ldat$d), interim = 99)
19: tryCatch({
    if (!is.null(arm_to_enable) & length(arm_to_enable) > 0 & !(
20: tryCatchList(expr, classes, parentenv, handlers)
21: tryCatchOne(expr, names, parentenv, handlers[[1]])
22: value[[3]](cond)

```
to see environment, select a number, e.g. 19 then 

```
Browse[1]> ls()
[1] "classes"      "handlers"     "parentenv"    "tryCatchList" "tryCatchOne"
Browse[1]> get("arm_to_enable", parentenv)
integer(0)
Browse[1]> length(integer(0))
[1] 0
Browse[1]> get("arms_for_p_best", parentenv)
[1] 1 2 3

```

to exit `c` should take you back to the menu then `0`.

also note that `if(logical(0))` is a bit of a horrendous bug that you should remember...


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

### Local R packages

See 
https://support.rstudio.com/hc/en-us/articles/200486518-Customizing-Package-Build-Options
https://cran.r-project.org/doc/manuals/r-release/R-exts.html

First, install dependencies by any means necessary.

```
# Build package. First cd to parent dir containing `mypackage`
cd ~/Documents
# Build (old school) version is 0.1
R CMD build mypackage
# install
R CMD INSTALL mypackage_0.1.tar.gz
```

the above builds for all architectures (slow)

```
R CMD INSTALL --preclean --no-multiarch mypackage
```

alternatively via R

```
library(devtools)
devtools::document(roclets = c('rd', 'collate', 'namespace', 'vignette'))
devtools::build()
devtools::install()
```

### Minimal set of packages

Note that if things go pear shaped with build tools just uninstall and reinstall rstudio and buildtools. 

`pkgbuild::find_rtools()` shows you if the r tools are available.

See:
http://jtleek.com/modules/01_DataScientistToolbox/02_10_rtools/#1


The .Rprofile should look something like:

```
.First <- function() {
  Sys.setenv(PATH = paste("path..../R/Rtools35/bin",
                          "path..../R/Rtools35/mingw_$(WIN)/bin",
                          Sys.getenv("PATH"), sep=";"))
  Sys.setenv(BINPREF = "path..../R/Rtools35/mingw_$(WIN)/bin/")
}

if (interactive()) {
  suppressMessages(require(usethis))
}

options(prompt="R> ")

options(usethis.full_name = "maj")

```

also pay attention to the path environment variable.

```
source("install_R_pkgs.R")
```


```
install.packages("ggplot2", dependencies = T, repos = 'https://cran.curtin.edu.au')
install.packages("tidyr", dependencies = T, repos = 'https://cran.curtin.edu.au')
install.packages("lintr", dependencies = T, repos = 'https://cran.curtin.edu.au')
install.packages("dplyr", dependencies = T, repos = 'https://cran.curtin.edu.au')
install.packages("pryr", dependencies = T, repos = 'https://cran.curtin.edu.au')
install.packages("Rcpp", dependencies = T, repos = 'https://cran.curtin.edu.au')
install.packages("data.table", dependencies = T, repos = 'https://cran.curtin.edu.au')
install.packages("RcppEigen", dependencies = T, repos = 'https://cran.curtin.edu.au')
install.packages("RcppArmadillo", dependencies = T, repos = 'https://cran.curtin.edu.au')
install.packages("RcppDist", dependencies = T, repos = 'https://cran.curtin.edu.au')
install.packages("msm", dependencies = T, repos = 'https://cran.curtin.edu.au')
install.packages("grid", dependencies = T, repos = 'https://cran.curtin.edu.au')
install.packages("simstudy", dependencies = T, repos = 'https://cran.curtin.edu.au')
install.packages("gridExtra", dependencies = T, repos = 'https://cran.curtin.edu.au')
install.packages("optparse", dependencies = T, repos = 'https://cran.curtin.edu.au')
install.packages("formattable", dependencies = T, repos = 'https://cran.curtin.edu.au')
install.packages("psych", dependencies = T, repos = 'https://cran.curtin.edu.au')
install.packages("RcppParallel", dependencies = T, repos = 'https://cran.curtin.edu.au')

install.packages("knitr", dependencies = T, repos = 'https://cran.curtin.edu.au')
install.packages("kableExtra", dependencies = T, repos = 'https://cran.curtin.edu.au')
install.packages("configr", dependencies = T, repos = 'https://cran.curtin.edu.au')
install.packages("futile.logger", dependencies = T, repos = 'https://cran.curtin.edu.au')
install.packages("survival", dependencies = T, repos = 'https://cran.curtin.edu.au')
install.packages("inline", dependencies = T, repos = 'https://cran.curtin.edu.au')
install.packages("doParallel", dependencies = T, repos = 'https://cran.curtin.edu.au')
install.packages("foreach", dependencies = T, repos = 'https://cran.curtin.edu.au')
install.packages("truncnorm", dependencies = T, repos = 'https://cran.curtin.edu.au')
install.packages("beepr", dependencies = T, repos = 'https://cran.curtin.edu.au')
install.packages("tinytex", dependencies = T, repos = 'https://cran.curtin.edu.au')
tinytex::install_tinytex()

install.packages("microbenchmark", dependencies = T, repos = 'https://cran.curtin.edu.au')
install.packages("coin", dependencies = T, repos = 'https://cran.curtin.edu.au')
install.packages("devtools", dependencies = T, repos = 'https://cran.curtin.edu.au')
devtools::install_github("rmcelreath/rethinking")

install.packages("eph", dependencies = T, repos = 'https://cran.curtin.edu.au')
install.packages("pch", dependencies = T, repos = 'https://cran.curtin.edu.au')
install.packages("nphsim", dependencies = T, repos = 'https://cran.curtin.edu.au')


# Stepped wedge sample size:
# https://github.com/giabaio/SWSamp

install.packages("SWSamp",
	repos=c("http://www.statistica.it/gianluca/R",
		"https://cran.rstudio.org",
		"https://inla.r-inla-download.org/R/stable"),
	dependencies=TRUE
)

# Stan follow instructions
# https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started

install.packages("rstan", dependencies = TRUE, repos = 'https://cran.curtin.edu.au')
install.packages("brms", dependencies = T, repos = 'https://cran.curtin.edu.au')
install.packages("coda", dependencies = T, repos = 'https://cran.curtin.edu.au')
install.packages("loo", dependencies = T, repos = 'https://cran.curtin.edu.au')
install.packages("rjags", dependencies = T, repos = 'https://cran.curtin.edu.au')
install.packages("pwr", dependencies = T, repos = 'https://cran.curtin.edu.au')

install.packages("mcmc", dependencies = T, repos = 'https://cran.curtin.edu.au')
install.packages("ggfortify", dependencies = T, repos = 'https://cran.curtin.edu.au')

install.packages("LaplacesDemon", dependencies = T, repos = 'https://cran.curtin.edu.au')
install.packages("invgamma", dependencies = T, repos = 'https://cran.curtin.edu.au')

install.packages(c("HRW","Ecdat","mlbench","quantreg","gam","gamlss","gamsel"),dependencies=TRUE, repos = 'https://cran.curtin.edu.au')


#### https://stackoverflow.com/questions/53397352/installing-bayeslogit-package
#### devtools::install_version("BayesLogit", "0.6")
#### devtools::install_version("tglm", "1.0")
#### devtools::install_version("EPGLM", "1.1.2")


```

### R install packages

```
R CMD build pkgname
R CMD INSTALL packagename_0.1.tar.gz
```

### yaml Header for Rmd

```
---
title: "whatevs"
editor_options:
	chunk_output_type: console
output:
	pdf_document:
		toc: yes
		toc_depth: 3
		number_sections: true
		fig_captions: yes
	html_output:
		theme: united
		toc: yes
bibliography: my.bib
---
```

Use @nameyyyy for citations.

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

