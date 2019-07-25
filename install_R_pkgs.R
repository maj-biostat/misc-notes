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


install.packages("knitr", dependencies = T, repos = "https://cran.curtin.edu.au")
install.packages("kableExtra", dependencies = T, repos = "https://cran.curtin.edu.au")
install.packages("configr", dependencies = T, repos = "https://cran.curtin.edu.au")
install.packages("futile.logger", dependencies = T, repos = "https://cran.curtin.edu.au")
install.packages("survival", dependencies = T, repos = "https://cran.curtin.edu.au")
install.packages("inline", dependencies = T, repos = "https://cran.curtin.edu.au")
install.packages("doParallel", dependencies = T, repos = "https://cran.curtin.edu.au")
install.packages("foreach", dependencies = T, repos = "https://cran.curtin.edu.au")
install.packages("truncnorm", dependencies = T, repos = "https://cran.curtin.edu.au")
install.packages("beepr", dependencies = T, repos = "https://cran.curtin.edu.au")
install.packages("tinytex", dependencies = T, repos = "https://cran.curtin.edu.au")


install.packages("microbenchmark", dependencies = T, repos = "https://cran.curtin.edu.au")
install.packages("coin", dependencies = T, repos = "https://cran.curtin.edu.au")
install.packages("devtools", dependencies = T, repos = "https://cran.curtin.edu.au")
devtools::install_github("rmcelreath/rethinking")

install.packages("eph", dependencies = T, repos = "https://cran.curtin.edu.au")
install.packages("pch", dependencies = T, repos = "https://cran.curtin.edu.au")
install.packages("nphsim", dependencies = T, repos = "https://cran.curtin.edu.au")


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

install.packages("rstan", dependencies = TRUE, repos = "https://cran.curtin.edu.au")
install.packages("brms", dependencies = T, repos = "https://cran.curtin.edu.au")
install.packages("coda", dependencies = T, repos = "https://cran.curtin.edu.au")
install.packages("loo", dependencies = T, repos = "https://cran.curtin.edu.au")
install.packages("rjags", dependencies = T, repos = "https://cran.curtin.edu.au")
install.packages("pwr", dependencies = T, repos = "https://cran.curtin.edu.au")

install.packages("mcmc", dependencies = T, repos = "https://cran.curtin.edu.au")
install.packages("ggfortify", dependencies = T, repos = "https://cran.curtin.edu.au")

install.packages("LaplacesDemon", dependencies = T, repos = "https://cran.curtin.edu.au")
install.packages("invgamma", dependencies = T, repos = "https://cran.curtin.edu.au")

install.packages(c("HRW"),dependencies=TRUE, repos = "https://cran.curtin.edu.au")
install.packages(c("Ecdat"),dependencies=TRUE, repos = "https://cran.curtin.edu.au")
install.packages(c("mlbench"),dependencies=TRUE, repos = "https://cran.curtin.edu.au")
install.packages(c("quantreg"),dependencies=TRUE, repos = "https://cran.curtin.edu.au")
install.packages(c("gam"),dependencies=TRUE, repos = "https://cran.curtin.edu.au")
install.packages(c("gamlss"),dependencies=TRUE, repos = "https://cran.curtin.edu.au")


install.packages("tibble", dependencies = T, repos = "https://cran.curtin.edu.au")
install.packages("futile.logger", dependencies = T, repos = "https://cran.curtin.edu.au")
install.packages("tryCatchLog", dependencies = T, repos = "https://cran.curtin.edu.au")
install.packages("bookdown", dependencies = T, repos = "https://cran.curtin.edu.au")
install.packages("rmarkdown", dependencies = T, repos = "https://cran.curtin.edu.au")
install.packages("lubridate", dependencies = T, repos = "https://cran.curtin.edu.au")

tinytex::install_tinytex(T)