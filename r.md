# R

Installation and usage.

- [Rscript](#rscript)
- [System utilities](#system-utilities)
- [Debugging R](#debugging-r)
- [Local R packages](#local-r-packages)
- [yaml Header for Rmd](#yaml-header-for-rmd)
- [Auto install code](#auto-install-code)
- [tensorflow and greta](#tensorflow-and-greta)
- [bioconductor](#bioconductor)
- [R install](#r-install)
- [Packages containing rstan models](#packages-containing-rstan-models)
- [Minimal set of packages](#minimal-set-of-packages)

## Rscript

Run script from terminal (redirect output stdout/stderr to log) in the background.

```
/usr/bin/Rscript main.R > log.txt 2>&1 &
```

Render rmarkdown (includes passing arguments)

```
/usr/bin/Rscript -e "rmarkdown::render('example.Rmd', params=list(args = myarg))"
```

in the rmarkdown yaml:

```
---
title: "Simple example"
output:
  pdf_document: default
params:
  args: myarg
---
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


## System utilities

### curl

Use [curl](https://cran.r-project.org/web/packages/curl/vignettes/intro.html) or [RCurl](https://cran.r-project.org/web/packages/RCurl/index.html).




## Debugging R

Catch an error and create a core dump.

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

In a new R session:

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


## Local R packages

See:

+ https://support.rstudio.com/hc/en-us/articles/200486518-Customizing-Package-Build-Options
+ https://cran.r-project.org/doc/manuals/r-release/R-exts.html

Install dependencies

```
# Build package. First cd to parent dir containing `mypackage`
cd ~/Documents
# Build (old school) version is 0.1
R CMD build mypackage
```

Now install
```
# install
R CMD INSTALL mypackage_0.1.tar.gz
```

the above builds for all architectures (slow), alternatively:

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

## yaml Header for Rmd

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




## Auto install code

R code for installing a set of packages.

```
# checking for rtools:
pkgbuild::find_rtools(debug = TRUE)
pkgbuild::check_rtools(debug = T)

# location
callr::rcmd_safe("config", "CC")$stdout

dotinytex <- FALSE

if(dotinytex){
  message("Installing packages and Tex install.")
} else {
  message("Installing packages, NO Tex install.")
}

message("")

check_for_pkg <- function(x){
  as.character(x) %in% rownames(installed.packages())
}

# do this first otherwise get a load error
if(!check_for_pkg("remotes")){
  install.packages("remotes", dependencies = T, repos = 'https://cran.curtin.edu.au')
  message("Installed remotes, now exiting, restart to complete installations.")
  quit()
}

# Linux rstan install
dotR <- file.path(Sys.getenv("HOME"), ".R")
if (!file.exists(dotR)) dir.create(dotR)
M <- file.path(dotR, "Makevars")
if (!file.exists(M)) file.create(M)
cat("\nCXX14FLAGS=-O3 -march=native -mtune=native -fPIC",
    "CXX14=g++", # or clang++ but you may need a version postfix
    file = M, sep = "\n", append = TRUE)

Sys.setenv(MAKEFLAGS = "-j6") # six cores used
options(install.packages.compile.from.source = "both")
install.packages("rstan", repos = 'https://cran.curtin.edu.au', quiet = F)


# For brms
pkgs <- c("Rcpp", 
           "ggplot2",                                                                                      
          "loo",       
          "rstantools", 
           "bayesplot", 
           "shinystan",                                                                                 
           "glue", 
           "matrixStats", 
           "nleqslv", 
           "coda", 
           "abind", 
           "future", 
           "backports")

for(i in 1:length(pkgs)){
  if(!check_for_pkg(pkgs[i])){
    
    message(paste0("Installing    : ", pkgs[i]))
    # Change to turn off interactive and install from source if available 
    options(install.packages.compile.from.source = "both")
    install.packages(pkgs[i], repos = 'https://cran.curtin.edu.au', quiet = F)
  }
}

if(!check_for_pkg("rethinking")){
  remotes::install_github("rmcelreath/rethinking")
}

pkgs <- c("beepr", "bookdown",  "coin", "configr", "data.table",
  "devtools", "doParallel", "dplyr", "Ecdat", # "eph",
  "foreach",
  "formattable", "futile.logger", "futile.logger", "gam", "gamlss",
  "ggfortify", "grid", "gridExtra", "HRW", "inline", "invgamma",
  "kableExtra", "knitr", "LaplacesDemon", "lintr",  "lubridate",
  "mcmc", "microbenchmark", "mlbench", "msm", "mvtnorm", "nphsim", "optparse",
  "pch", "pryr", "psych", "pwr", "quantreg",
 "RcppArmadillo",
  "RcppDist", "RcppEigen", "RcppParallel", "rjags", "rmarkdown",
  "rstan", "simstudy", "survival", "tibble", "tidyr", "tinytex",
  "truncnorm", "tryCatchLog")

for(i in 1:length(pkgs)){
  if(!check_for_pkg(pkgs[i])){
    
    message(paste0("Installing    : ", pkgs[i]))
    # Change to turn off interactive and install from source if available 
    options(install.packages.compile.from.source = "both")
    install.packages(pkgs[i], repos = 'https://cran.curtin.edu.au', quiet = F)
  }
}

if(!check_for_pkg("SWSamp")){
  install.packages("SWSamp",
	repos=c("http://www.statistica.it/gianluca/R",
		"https://cran.rstudio.org",
		"https://inla.r-inla-download.org/R/stable"),
	dependencies=TRUE
  )
}
if(!check_for_pkg("nphsim")){
  remotes::install_github("keaven/nphsim")
}

pkgs <- c(pkgs,
  "SWSamp", "rethinking", "nphsim")

for(i in 1:length(pkgs)){
  if(check_for_pkg(pkgs[i])){
    message(paste0("Installed     : ", pkgs[i]))
  } else {
    message(paste0("NOT installed : ", pkgs[i]))
  }
}

if(dotinytex){
  tinytex::install_tinytex(T)
}
```

## tensorflow and greta

This was a bit of a dick on but I really wanted to test out greta, see:

+ https://rviews.rstudio.com/2018/04/23/on-first-meeting-greta/
+ https://greta-stats.org/articles/get_started.html

Greta depends on tensorflow and the suggested way to install relies on anaconda, which I didn't want to use. 
Also there is a dependency issue on tensorflow 1.10 from rstudio whereas tensorflow is currently up to 1.12. So I installed from scratch:

```
pip install virtualenv
yay -S tensorflow
yay -S python-tensorflow
pip install --user tensorflow-probability
```

Unfortunately I do not presently have a clue about virtualenv.
However, in R you can then do:

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

## bioconductor

You need to specify the applicable lib path

```
BiocManager::install(lib = "/home/mjon6454/R/x86_64-pc-linux-gnu-library/4.1")
BiocManager::install("graph", lib = "/home/mjon6454/R/x86_64-pc-linux-gnu-library/4.1")
```

## INLA

Again you need to specify the lib path

```
Rscript -e 'install.packages("INLA",repos=c(getOption("repos"),INLA="https://inla.r-inla-download.org/R/stable"), dep=TRUE)' > log.txt 2>&1 &
```

## R install

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



## Packages containing rstan models

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



## Minimal set of packages

Note that if things go pear shaped with build tools just uninstall and reinstall rstudio and buildtools. 

`pkgbuild::find_rtools()` shows you if the r tools are available.

+ http://jtleek.com/modules/01_DataScientistToolbox/02_10_rtools/#1

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



