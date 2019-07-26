# random commentary

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

if(!check_for_pkg("SWSamp")){
  remotes::install_github("rmcelreath/rethinking")
}

pkgs <- c("beepr", "bookdown", "brms", "coda", "coin", "configr", "data.table",
  "devtools", "doParallel", "dplyr", "Ecdat", # "eph",
  "foreach",
  "formattable", "futile.logger", "futile.logger", "gam", "gamlss",
  "ggfortify", "grid", "gridExtra", "HRW", "inline", "invgamma",
  "kableExtra", "knitr", "LaplacesDemon", "lintr", "loo", "lubridate",
  "mcmc", "microbenchmark", "mlbench", "msm", "mvtnorm", "nphsim", "optparse",
  "pch", "pryr", "psych", "pwr", "quantreg",
  "remotes",
  "Rcpp", "RcppArmadillo",
  "RcppDist", "RcppEigen", "RcppParallel", "rjags", "rmarkdown",
  "rstan", "simstudy", "survival", "tibble", "tidyr", "tinytex",
  "truncnorm", "tryCatchLog")

for(i in 1:length(pkgs)){
  if(!check_for_pkg(pkgs[i])){

    message(paste0("Installing    : ", pkgs[i]))

    install.packages(pkgs[i], dependencies = T, repos = 'https://cran.curtin.edu.au')
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
