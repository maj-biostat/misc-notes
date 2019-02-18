
# Manjaro (post) install

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


search `pacman -Ss pkg_name`
download fresh copy of master package db `pacman -Sy`
install `pacman -S pkg_name`
upgrade `pacman -Su`
remove `pacman -R package_name`
many others...

## Yay

https://www.ostechnix.com/yay-found-yet-another-reliable-aur-helper/

`sudo pacman -S yay`

## Phoronix bench tests

`yay -S phoronix-test-suite`

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

## git

`git config --global user.name "Fred Basset"`
`git config --global user.email email_no_quotes`

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

```
install.packages("ggplot2", dependencies = T)
install.packages("tidyr", dependencies = T)
install.packages("lintr", dependencies = T)
install.packages("dplyr", dependencies = T)
install.packages("pryr", dependencies = T)
install.packages("Rcpp", dependencies = T)
install.packages("data.table", dependencies = T)
install.packages("RcppEigen", dependencies = T)
install.packages("RcppArmadillo", dependencies = T)
install.packages("RcppDist", dependencies = T)
install.packages("msm", dependencies = T)
install.packages("grid", dependencies = T)
install.packages("gridExtra", dependencies = T)
install.packages("optparse", dependencies = T)
install.packages("formattable", dependencies = T)
install.packages("psych", dependencies = T)

install.packages("knitr", dependencies = T)
install.packages("kableExtra", dependencies = T)
install.packages("configr", dependencies = T)
install.packages("futile.logger", dependencies = T)
install.packages("survival", dependencies = T)
install.packages("inline", dependencies = T)
install.packages("doParallel", dependencies = T)
install.packages("foreach", dependencies = T)
install.packages("truncnorm", dependencies = T)
install.packages("beepr", dependencies = T)
install.packages("tinytex", dependencies = T)
tinytex::install_tinytex()

install.packages("microbenchmark", dependencies = T)
install.packages("coin", dependencies = T)
install.packages("devtools", dependencies = T)
devtools::install_github("rmcelreath/rethinking")

install.packages("eph", dependencies = T)
install.packages("pch", dependencies = T)
install.packages("nphsim", dependencies = T)


# Stepped wedge sample size:
# https://github.com/giabaio/SWSamp

install.packages("SWSamp",
	repos=c("http://www.statistica.it/gianluca/R",
		"https://cran.rstudio.org",
		"https://www.math.ntnu.no/inla/R/stable"),
	dependencies=TRUE
)

# Stan follow instructions
# https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started

install.packages("rstan", repos = "https://cloud.r-project.org/", dependencies = TRUE)
install.packages("brms", dependencies = T)
install.packages("coda", dependencies = T)
install.packages("loo", dependencies = T)
install.packages("rjags", dependencies = T)
install.packages("pwr", dependencies = T)


install.packages("LaplacesDemon", dependencies = T)
install.packages("invgamma", dependencies = T)

#### https://stackoverflow.com/questions/53397352/installing-bayeslogit-package
#### devtools::install_version("BayesLogit", "0.6")
#### devtools::install_version("tglm", "1.0")
#### devtools::install_version("EPGLM", "1.1.2")
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

## pgrep

is something i was unaware of but is very useful for killing a number of instances of the same application, e.g. 

```
for pid in $(pgrep R); do kill -9 $pid; done
```

