# Anaconda3

Includes python3 and the spyder ide.
Download, check the sha256 hash, run with 

```
bash Anaconda3-2020.11-Linux-x86_64.sh
```
At the end of the install, initialise and note

```
==> For changes to take effect, close and re-open your current shell. <==

If you'd prefer that conda's base environment not be activated on startup, 
   set the auto_activate_base parameter to false: 

conda config --set auto_activate_base false
```

To update conda at any time

```
conda update conda
```
This will update conda to the latest version which is necessary and important to ensure that your system is set up properly.
Ask a basic check, you can list the installed packages with

```
conda list
```


If you want to entirely uninstall then 

```
conda install anaconda-clean
anaconda-clean --yes
rm -rf ~/anaconda3
```

or whereever you installed to.
Also check the `.bash_profile` and `.bashrc` for leftover paths and other crap.
Clean up as necessary e.g.

```
export PATH="/Users/jsmith/anaconda3/bin:$PATH"
```


One way to run spyder is via the navigator.  
Go to the command prompt and do

```
anaconda-navigator
```

For more info see https://docs.anaconda.com/anaconda/navigator/getting-started/#navigator-starting-navigator

Navigator uses conda to create separate environments containing files, packages, and their dependencies that will not interact with other environments.
Environments are a completely separate and isolated area of your computer with its own installation of Python and own third-party packages.
They are independent from any other Python installation on your machine.
You can also create envs directly from the command line.
The following creates, activates and then installs `numpy` an environment based on the latest version of python3.

```
conda create --name my_env python=3
conda activate my_env
conda install --name my_env numpy
```

when you are done, enter

```
conda deactivate
```

which will take you back to the base environment.
Aside, if you want to check what environments you have set up you can do it via the navigator or command line

```
conda info --envs
```









