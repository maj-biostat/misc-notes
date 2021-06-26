# Python Newb Notes

- [Virtual Environments](#virtual-environments)
  * [Activating virtual environments](#activating-virtual-environments)
- [Jupyter/IPython](#jupyter-ipython)
- [Parallel in Jupyter/IPython](#parallel-in-jupyter-ipython)
- [Jupyter / IPython](#jupyter---ipython)
- [Packages](#packages)
  * [Install package from a github repo](#install-package-from-a-github-repo)
  * [Install specific package version](#install-specific-package-version)
  * [Install pymupdf](install-pymupdf)
- [Execution](#execution)
- [Classes](#classes)
- [Special main](#special-main)

## Virtual Environments

Python tends to be stored in different places on different systems.
Virtual environments allow you adopt different versions of Python for different projects.

```python
> python3 --version
Python 3.8.5
```
The implementation of virtual environments have changed over time.
Prior to Python 3, the `virtualenv` tool was used.
However, from 3.6 the way to create a python virtual environment is to navigate to the project directory and do:

```python
> pwd
/tmp/test
> python3 -m venv env
```

This creates a subdirectory called `env` that contains

+ `bin` - venv files
+ `include` - C headers for compiling Python packages
+ `lib` - copy of Python version and the site-packages folder where dependencies are installed 


`venv` creates fresh and sandboxed virtual environments with user-installable libraries that are multi-python safe.
They are *fresh* because virtual environments only start with the standard libraries that ship with python; you have to install any other libraries all over again with pip install while the virtual environment is active. 
They are *sandboxed* because none of these new library installs are visible outside the virtual environment, so you can delete the whole environment and start again without worrying about impacting your base python install. 
They are *user-installable* libraries because the virtual environment's target folder is created without sudo in some directory you already own, so you won't need sudo permissions to install libraries into it. 
Finally, they are *multi-python-safe* because when virtual environments activate, the shell only sees the python version (3.4, 3.5 etc.) that was used to build that virtual environment.

More info on this [here](https://stackoverflow.com/questions/41573587/what-is-the-difference-between-venv-pyvenv-pyenv-virtualenv-virtualenvwrappe).

### Activating virtual environments

In order to use the environments packages, you have to activate:

```sh
> source env/bin/activate
(env)> deactivate
>
```

note how activate changes the prompt by adding a `(env)` prefix. 
When we deactivate, we go back to the normal terminal prompt.

If a package is only available to the global Python install, it will work as follows:

```sh
> pip3 install bcrypt
> python3 -c "import bcrypt; print(bcrypt.hashpw('pass'.encode('utf-8'), bcrypt.gensalt()))"
b'$2b$12$gOBRrRxvE/dx6hUlWBjmxONm.rBsNIOItzm.I.Q8V0kSRhJKQDYoa'
```

But in the virtual environment, we would get:

```sh
> source env/bin/activate
(env)> python3 -c "import bcrypt; print(bcrypt.hashpw('pass'.encode('utf-8'), bcrypt.gensalt()))"
Traceback (most recent call last):
  File "<string>", line 1, in <module>
ModuleNotFoundError: No module named 'bcrypt'
```

However, you can now install the package in the virtual environment using pip3 and the particular version you install will become available.

Moreover, we are now using a project-specific python and have a project specific path:

```sh
(env)> which python
/tmp/test/env/bin/python
(env)> echo $PATH
/tmp/test/env/bin:/other/paths/follow...
```

This *new* python isn't actually new.
It is just a symlink to the system python with updated versions of `sys.prefix` and `sys.exec_prefix`.

```python
Python 3.8.5 (default, Jan 27 2021, 15:41:15) 
[GCC 9.3.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import sys
>>> sys.prefix
'/tmp/test/env'
>>> sys.exec_prefix
'/tmp/test/env'
>>> import site
>>> site.getsitepackages()
['/tmp/test/env/lib/python3.8/site-packages', '/tmp/test/env/local/lib/python3.8/dist-packages', '/tmp/test/env/lib/python3/dist-packages', '/tmp/test/env/lib/python3.8/dist-packages']
```


## Jupyter/IPython

From command line `jupyter notebook`

## Parallel in Jupyter/IPython

See https://github.com/ipython/ipyparallel

```
pip install ipyparallel
# Start stop cluster
ipcluster nbextension enable
ipcluster nbextension disable
# More needed here, refer to the link above
```

## Jupyter / IPython

From the command line

```
pip install --user jupyter
jupyter notebook
```

## Packages

Are a way of grouping code. 
Nothing more than a folder containing a special file, `__init__.py` although even this is not strictly needed since 3.3

### Install package from a github repo
Sources
https://medium.com/@lynzt/install-python-packages-from-github-5866d234c4e4
https://stackoverflow.com/questions/15268953/how-to-install-python-package-from-github

First clone that repository.
Then either run the setup.py file from the relevant directory *OR* change dir to the one containing setup.py and then run `pip install .` .

Alternatively `pip install git+https://github.com/jkbr/httpie.git#egg=httpie`

### Install specific package version

```
pip3 install jaxlib=0.1.62
```

and then show what version was installed:

```
pip3 show jaxlib
```


### Install pymupdf

[pymupdf](https://github.com/pymupdf/PyMuPDF) is a python binding that uses [mupdf](https://mupdf.com/) to access pdf data.

First install mupdf

```
sudo apt install mupdf mupdf-tools
```

Now add the python bits into your virtual env

```
pip3 install pymupdf
```

Test with this snippet, which extracts annotations/comments from a pdf

```
import fitz
doc = fitz.open("example.pdf")
for i in range(doc.pageCount):
 page = doc[i]
 for annot in page.annots():
  print(annot.info["content"])
```

## Execution

*Names* refer to objects, e.g. a string `addr = "22 fredstreet"` or a dictionary:

```
employee = {
  'age': 10,
  'role': lacky,
  'abn': 000
}
```

A *namespace* is a mapping from names to objects. 
These allow you to define and organise code. 

```
# a namespace
from library.floor_two.row_three import fred
```

Methods go in classes, which go in modules, which go in packages.

## Classes

A class that does nothing.

```
class AClassCamelCase:
  pass
```

save it in a file `first_class.py`, then `python -i first_class.py` runs the code then drops into the interpreter.  

```
python -i first_class.py
a = AClassCamelCase()
print(a)
```

you can add attributes simply with `a.x = 5` `a.y = 10` they do not have to be members.

A point class; methods require a self argument (not an argument with self). This is a reference to the object. 
Used here to access attributes. Do `python -i fname.py` then `help(Point)`

```
import math


class Point:
    "Represents a point in 2d"
    
    def __init__(self):
        "Initialise a new point to 0,0"
        self.move(0, 0)
        
    def reset(self):
        self.x = 0
        self.y = 0

    def move(self, x, y):
        self.x = x
        self.y = y

    def dist(self, pt2):
        a = (self.x - pt2.x)**2
        b = (self.y - pt2.y)**2
        return math.sqrt(a + b)
```


Import a module (a file in the same dir) using `import fname`. Alternatively, (better) specify the class `from fname import ClassName` then `c = ClassName()` to instantiate the class. You can do things like import multiple classes by passing a comma separated list or give the class a new name, e.g. `from fname import ClassName as CN` then `c = CN()`.


## Special main

Used when we know that we are running the module as a script, but not when the code is imported from a different script.

```
class AClass:
    pass

def main():
    a = AClass()
    print(a)
    
if __name__ == "__main__":
    main()
```




