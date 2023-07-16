# Homebrew

Homebrew is a package manager for the mac.
It installs the stuff you need that Apple (or your Linux system) didn’t.
It installs packages to their own directory and then symlinks their files into `/opt/homebrew` (on Apple Silicon).
It won’t install files outside its prefix and you can place a Homebrew installation wherever you like.
For a mac, you will need the command line tools, check via `xcode-select -p`

To install homebrew

```
https://brew.sh/
```

Check it is set up correctly.

```
$ brew doctor
Your system is ready to brew.
brew help
brew commands
```

Fetch the newest version of Homebrew, along with the latest versions of the formulae you’ve installed on your machine. 

```
brew update
```

Note that by default, Homebrew updates itself every time you execute a brew command, but it doesn't hurt to run `brew update` once in a while.


Search, install, check, upgrade and uninstall a package:


```
brew search tree
brew info tree
# install the tree command
brew install tree
which tree
tree --version
# if you need to upgrade the package
brew upgrade tree
# to uninstall
brew uninstall tree
```

List all the packages

```
brew list
# dependencies
brew deps --tree --installed
```

