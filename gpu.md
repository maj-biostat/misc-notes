# GPU

Getting things running on the GPU is not exactly straight forward.
Note that the [Linux](https://github.com/maj-biostat/misc-notes/blob/master/linux.md#video-drivers-1) notes contains some generic detail on GPUs.

## Useful commands

```
clinfo -l
nvidia-smi
nvtop
# CUDA version
nvcc --version
sudo hwinfo --gfxcard --short
lspci -k | grep -A 2 -i "VGA"
```

## CUDA

[CUDA](https://developer.nvidia.com/cuda-zone) is an NVIDIA API for GPU parallel computing.
The [CUDA toolkit](https://developer.nvidia.com/cuda-downloads) gives you the libs, compiler, dev tools and runtime that you need to develop GPU accelerated apps.
You can follow from the link above, but at the time of writing, the install was:

```{sh}
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin
sudo mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget https://developer.download.nvidia.com/compute/cuda/11.3.1/local_installers/cuda-repo-ubuntu2004-11-3-local_11.3.1-465.19.01-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu2004-11-3-local_11.3.1-465.19.01-1_amd64.deb
sudo apt-key add /var/cuda-repo-ubuntu2004-11-3-local/7fa2af80.pub
sudo apt-get update
sudo apt-get -y install cuda
```

which will take about 30 mins to do depending on your connection speed.
No doubt, cuda will have installed in the wrong place so you may have to do because some GPU functionality expects the CUDA installation to be at /usr/local/cuda-X.X, where X.X should be replaced with the CUDA version number (e.g. cuda-10.2).

```
sudo ln -s /usr/lib/cuda /usr/local/cuda-11.3
```

Additionally, NVIDIA provide [cuDNN](https://developer.nvidia.com/cudnn) which is a lib for deep neural nets.
In order to install cuDNN you need to sign up for a nvidia developer account. 
However, once you have done that and downloaded the platform specific packages use `gdebi` to install:

```
sudo gdebi libcudnn8_8.2.1.32-1+cuda11.3_amd64.deb
sudo gdebi libcudnn8-dev_8.2.1.32-1+cuda11.3_amd64.deb
sudo gdebi libcudnn8-samples_8.2.1.32-1+cuda11.3_amd64.deb
```

## JAX

In statistics, computing gradients is a big deal. 
[JAX](https://github.com/google/jax) is an autograd that gives you differentiation of native Python and NumPy functions.
To install with GPU support, install CUDA and cuDNN first and then from in a [virtual environment](https://github.com/maj-biostat/misc-notes/blob/master/python.md#virtual-environments) do:

```
pip3 install --upgrade pip
pip3 install --upgrade jax==0.2.10 jaxlib==0.1.62+cuda111 -f https://storage.googleapis.com/jax-releases/jax_releases.html
```

note the specific versions of `jax` and `jaxlib` were installed to be compatible with the version of `numpyro` at the time of writing.

Test

```python
# https://github.com/google/jax/issues/989
import os
os.environ["XLA_FLAGS"]="--xla_gpu_cuda_data_dir=/usr/lib/cuda"
os.environ["CUDA_HOME"]="/usr/local/cuda-11.3"

import jax
import jax.numpy as jnp

x = jnp.arange(10)
print(x)
```

## Numpyro

[Numpyro](https://github.com/pyro-ppl/numpyro) gives you probabilistic programming with NumPy that is powered by JAX for autograd and JIT compilation to GPU/TPU/CPU.

First see JAX install above ensuring that the cuda install is performed (rather than with just CPU support).
If all goes well, you should see:

```
pip3 install numpyro
Collecting numpyro
  Using cached numpyro-0.6.0-py3-none-any.whl (218 kB)
Requirement already satisfied: jaxlib==0.1.62 in ./env/lib/python3.8/site-packages (from numpyro) (0.1.62+cuda111)
Requirement already satisfied: jax==0.2.10 in ./env/lib/python3.8/site-packages (from numpyro) (0.2.10)
Requirement already satisfied: tqdm in ./env/lib/python3.8/site-packages (from numpyro) (4.61.1)
Requirement already satisfied: absl-py in ./env/lib/python3.8/site-packages (from jax==0.2.10->numpyro) (0.13.0)
Requirement already satisfied: numpy>=1.12 in ./env/lib/python3.8/site-packages (from jax==0.2.10->numpyro) (1.21.0)
Requirement already satisfied: opt_einsum in ./env/lib/python3.8/site-packages (from jax==0.2.10->numpyro) (3.3.0)
Requirement already satisfied: flatbuffers in ./env/lib/python3.8/site-packages (from jaxlib==0.1.62->numpyro) (2.0)
Requirement already satisfied: scipy in ./env/lib/python3.8/site-packages (from jaxlib==0.1.62->numpyro) (1.7.0)
Requirement already satisfied: six in ./env/lib/python3.8/site-packages (from absl-py->jax==0.2.10->numpyro) (1.16.0)
Installing collected packages: numpyro
Successfully installed numpyro-0.6.0
```

the following example (also see other [examples](https://github.com/pyro-ppl/numpyro#more-examples) is lifted from the numpyro site for convenience:

```python
import os
os.environ["XLA_FLAGS"]="--xla_gpu_cuda_data_dir=/usr/lib/cuda"
os.environ["CUDA_HOME"]="/usr/local/cuda-11.3"

import numpy as np

J = 8
y = np.array([28.0, 8.0, -3.0, 7.0, -1.0, 1.0, 18.0, 12.0])
sigma = np.array([15.0, 10.0, 16.0, 11.0, 9.0, 11.0, 10.0, 18.0])

import numpyro
import numpyro.distributions as dist
from jax import random
from numpyro.infer import MCMC, NUTS
from numpyro.infer.reparam import TransformReparam

# standard implementation
def eight_schools(J, sigma, y=None):
  mu = numpyro.sample('mu', dist.Normal(0, 5))
  tau = numpyro.sample('tau', dist.HalfCauchy(5))
  with numpyro.plate('J', J):
    theta = numpyro.sample('theta', dist.Normal(mu, tau))
    numpyro.sample('obs', dist.Normal(theta, sigma), obs=y)

nuts_kernel = NUTS(eight_schools)
mcmc = MCMC(nuts_kernel, num_warmup=500, num_samples=1000)
rng_key = random.PRNGKey(0)
mcmc.run(rng_key, J, sigma, y=y, extra_fields=('potential_energy',))

# noncentred implementation
def eight_schools_noncentered(J, sigma, y=None):
  mu = numpyro.sample('mu', dist.Normal(0, 5))
  tau = numpyro.sample('tau', dist.HalfCauchy(5))
  with numpyro.plate('J', J):
    with numpyro.handlers.reparam(config={'theta': TransformReparam()}):
      theta = numpyro.sample('theta',dist.TransformedDistribution(dist.Normal(0., 1.),dist.transforms.AffineTransform(mu, tau)))
    numpyro.sample('obs', dist.Normal(theta, sigma), obs=y)

nuts_kernel = NUTS(eight_schools_noncentered)
mcmc = MCMC(nuts_kernel, num_warmup=500, num_samples=1000)
rng_key = random.PRNGKey(0)
mcmc.run(rng_key, J, sigma, y=y, extra_fields=('potential_energy',))
mcmc.print_summary(exclude_deterministic=False)
pe = mcmc.get_extra_fields()['potential_energy']

from numpyro.infer import Predictive

def new_school():
  mu = numpyro.sample('mu', dist.Normal(0, 5))
  tau = numpyro.sample('tau', dist.HalfCauchy(5))
  return numpyro.sample('obs', dist.Normal(mu, tau))

predictive = Predictive(new_school, mcmc.get_samples())
samples_predictive = predictive(random.PRNGKey(1))
print(np.mean(samples_predictive['obs'])) 
```


