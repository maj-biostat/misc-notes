# stan 

Installation, usage etc

- [cmdstan install](#cmdstan-install)

## cmdstan install

Go to [https://mc-stan.org/docs/2_29/cmdstan-guide/cmdstan-installation.html#source-installation] or at least the equivalent for the version of `cmdstan` you want to install.

I generally just build from the releases but if you want you can clone the github source code and install from that. 
The remainder of this assumes you just get hold of a release tar file and install that.

So, basically, download the release, gzip and tar to a given dir e.g. `./dir/cmdstan-29.0`, `cd` to that dir then do `make build` and wait.
Alternatively, you can install cmdstan by using `cmdstanr::install_cmdstan(cores = 2)` but I prefer to do it this way around.

To use `cmdstan` via rstudio it is usually best to install a fresh version of `cmdstanr`.
The instructions for this are at [https://mc-stan.org/cmdstanr/articles/cmdstanr.html] but in a nutshell:

```
install.packages("cmdstanr", repos = c("https://mc-stan.org/r-packages/", getOption("repos")))
```

Once this is install, make sure to check the tool chain:

```
# The library call will tell you which version of `cmdstan` is being referenced.
library(cmdstanr)
check_cmdstan_toolchain()
```

To change the version of `cmdstan` being used do:

```
set_cmdstan_path("/prefix.../cmdstan/cmdstan-2.29.0")
```

The `CMDSTAN` environment variable can be used to set this value permanently and the best way to set this variable is via the `.Renviron` file located in your home directory (you will need to restart rstudio to pick the value up).

In order to test the install do:

```
file <- file.path(cmdstan_path(), "examples", "bernoulli", "bernoulli.stan")
mod <- cmdstan_model(file)
mod$print()
data_list <- list(N = 10, y = c(0,1,0,0,0,0,0,0,0,1))

fit <- mod$sample(
  data = data_list, 
  seed = 123, 
  chains = 4, 
  parallel_chains = 4,
  refresh = 500
)
fit$summary()
```

If that all runs, then you are good to go.


