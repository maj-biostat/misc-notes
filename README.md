# Manjaro

I kindly ask the perplexed to please be patient, do not panic under any circumstances, and do not allow themselves to be too upset with mistakes, omissions & other problems of this text. At the end of the day, everything will be fine, and in the long run, we will be dead anyway.

The GNU GPLv3 also lets people do almost anything they want with your project, except to distribute closed source versions.

[Neovim](neovim.md)

# To redo install
create liveusb
Press F12? to go to boot screen
boot the live install
run the installer (select free driver)

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

`sudo pacman -S yay`


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
https://github.com/junegunn/vim-plug

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


### tmux

Terminal windows.

`sudo pacman -S tmux`

For vim colors see:

https://vi.stackexchange.com/questions/7112/tmux-messing-with-vim-highlighting
https://sunaku.github.io/vim-256color-bce.html
https://stackoverflow.com/questions/10158508/lose-vim-colorscheme-in-tmux-mode


```
# Add this line to your tmux.conf file

set -g default-terminal "screen-256color"

# Add the line below to you shells rc file in my case its my .zshrc

if [[ $TERM == xterm ]]; then TERM=xterm-256color; fi 

# Add the line below to your .vimrc

set t_Co=256

```

Also see https://tmuxcheatsheet.com/

`^b` indicates `ctl key + b`

new session named snme        `tmux new -s snme`  
kill session                  `tmux kill-session -t snme`   

#### split window into panes:

split current window vert:    `^b %`    
split current window hori:    `^b "`    

#### scrolling

start scroll mode	          `^b [`      
exit scroll mode	          `q`      

#### resize panes

next pane	                  `b o`   
previous pane	              `b ;`   
  
close current pane            `^b x`       

show pane numbers	          `^b q`    
move pane left	              `^b {`    
move pane right	              `^b {`    
swap pane locations	          `^b ^o`    
resize pane down	          `^b ^j` or `^b : resize-pane -D XX`    
resize pane up	              `^b ^k` or `^b : resize-pane -U XX`    
resize pane left	          `^b ^h` or `^b : resize-pane -L`    
resize pane right	          `^b ^j` or `^b : resize-pane -R`    

toggle zoom                   `^b z`    
toggle layouts                `^b spacebar`    

#### other

new window	                  `^b c`     
close window                  `^d` or `^b x`     
kill window	                  `^b &`    
next window	                  `^b n`    

previous window	              `^b p`   
rename window	              `^b`    
list all windows	          `^b w`     
move to window number	      `^b [number]`     
split window vertically	      `^b %`    
split window horizontally	  `^b "`    

re-attach a detached session  `tmux attach`    
list sessions                 `^b s` or `tmux ls`  


## git

`git config --global user.name "Fred Basset"`
`git config --global user.email email_no_quotes`


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

`sudo pacman -S r`
`yay -S rstudio-desktop-bin`
`yay -S openblas-lapack`
`sudo pacman -S pandoc`
`sudo pacman -S pandoc-citeproc`

### JAGS

yay -S jags

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
