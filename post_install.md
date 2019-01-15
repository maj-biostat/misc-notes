
# Manjaro (post) install

## NVIDIA

Select free drivers, edit grub (/etc/default/grub) then sudo update-grub as per dorian dot slash then go to https://wiki.manjaro.org/index.php?title=Configure_NVIDIA_(non-free)_settings_and_load_them_on_Startup and follow instructions.

## Pacman tips

https://wiki.manjaro.org/index.php?title=Pacman_Tips

search -Ss pkg_name
download fresh copy of master package db -Sy
install -S pkg_name
upgrade -Su
remove -R package_name
many others...

## Yay

sudo pacman -S yay
https://www.ostechnix.com/yay-found-yet-another-reliable-aur-helper/

## Phoronix bench tests

yay -S phoronix-test-suite

## Chrome

yay -S google-chrome

## Sublime text 3 

Follow instructions
https://www.sublimetext.com/docs/3/linux_repositories.html

## Vim / vim-plug

sudo pacman -S vim

Go here, follow instruc
https://github.com/junegunn/vim-plug

## git

git config --global user.name "Mark Jones"
git config --global user.email email_no_quotes

## R / RStudio (and dep)

sudo pacman -S r
yay -S rstudio-desktop-bin
yay -S openblas-lapack
sudo pacman -S pandoc
sudo pacman -S pandoc-citeproc


### JAGS

yay -S jags

### Minimal set of packages

```
install.packages("ggplot2", dependencies = T)
install.packages("tidyr", dependencies = T)
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

install.packages("knitr", dependencies = T)
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
https://github.com/giabaio/SWSamp

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


