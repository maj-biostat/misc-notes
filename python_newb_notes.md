# Python Newb Notes

[Linux MISC](misc.md) [NEOVIM](neovim.md) [PYTHON NOTES](python_newb_notes.md) [VIM](vim.md)  

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

## Packages

Are a way of grouping code. 
Nothing more than a folder containing a special file, `__init__.py` although even this is not strictly needed since 3.3

## Virtual Env

From 3.4 create a virtual env for your projects so that you don't need to clobber system installs.

```
cd proj_dir
python -m venv env # create a virtual environment called 'env'
source env/bin/activate # on linux
env/bin/activate.bat # on windows (use deactivate.bat when you are done)
```


## Execution

Chop off their heads! 
No, much more boring. 
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
```
