# R Package install code

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
           "bridgesampling",                                                                                  
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
