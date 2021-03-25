# EMACS (python testing on Windows) 

- [Frames, Windows, Buffers](#frames--windows--buffers)
- [File Functions](#file-functions)
- [Config](#config)
- [Package manager](#package-manager)
- [Jupyter](#jupyter)
- [Python Related](#python-related)
  * [Open project dir](#open-project-dir)
  * [Unit Tests](#unit-tests)
  * [Debug](#debug)
- [Git](#git)

See: (https://realpython.com/emacs-the-best-python-editor/)

First, in all the following `C = CTL` `M = ALT`.

If you find yourself in the mini-buffer (command buffer) `C-g` to get back to where you were.

To do the tutorial `C-H T`

## Frames, Windows, Buffers

"Frames" frame the "Window(s)" which contain "Buffers"

You can create *frames* whereever you want, in which you will put one or more *window(s)* through which you can view the contents *buffer* of the house. 
The contents may be a file, or the output from some code etc. 

`C-x k` close current buff  
`C-x 0` close current window   
`C-x 1` close all window  
   
`C-x 2` Split vertically    
`C-x 3` Split horizontally   
   
`C-x o` Move to next window  

`C-x` `C-b` Splits the window, shows current available buffers.   
`C-x b` Minibuffer prompt for the name of the buffer you want.   

`C-x ^` Make horizontal window one line bigger    
`C-x z` Repeat (then use `z` to repeat again and again).    
`C-u 4 C-x ^` Expand the horizontal split - make your window 4 lines bigger   
`C-x }` make wider
`C-x {` make narrower



## File Functions

`C-x` `C-f` Open file  then you write in the dir and file and press RET. If no file exists then one is created for you.  
`C-x` `C-s`  Save  

`C-x d` Open directory  

## Config

Is stored in ~/.emacs.d/init.el and gives access to the package manager. 
Here is an example `init.el` that supports various python related tools. 
Note that you need to do `pip install --user black` first. 

```
;; .emacs.d/init.el

;; ===================================
;; MELPA Package Support
;; ===================================
;; Enables basic packaging support
(require 'package)

;; Adds the Melpa archive to the list of available repositories
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

;; Initializes the package infrastructure
(package-initialize)

;; If there are no archived package contents, refresh them
(when (not package-archive-contents)
  (package-refresh-contents))

;; Installs packages
;;
;; myPackages contains a list of package names
(defvar myPackages
  '(better-defaults                 ;; Set up some better Emacs defaults
    material-theme                  ;; Theme
    )
  )

;; Scans the list in myPackages
;; If the package listed is not already installed, install it
(mapc #'(lambda (package)
          (unless (package-installed-p package)
            (package-install package)))
      myPackages)

;; ===================================
;; Basic Customization
;; ===================================

(setq inhibit-startup-message t)    ;; Hide the startup message
(load-theme 'material t)            ;; Load material theme
(global-linum-mode t)               ;; Enable line numbers globally

;; User-Defined init.el ends here
```

## Package manager 

`M-x` then type `package-show-package-list`.
To filter by name `f`, to exit press `q`.

## Jupyter

Seems a bit crap. 
If the `ein` package is installed you can do `M-x` `ein:jupyter-server-start` to start up a jupyter instance.  

## Python Related

### Open project dir

`C-x d` Open directory as previously, split the window.  
Switch to the window you wan to use `C-x o`.  
Cursor to your desired file and enter to select.  
Resize the window with 

### Unit Tests

If you have unit tests coded using base module `unittest` then you can run them by `C-x` `C-t`

### Debug

`M-x pdb` to start the debugger then when prompted as to how to run, type `python -m pdb foo.py`.  

## Git

Obtained via `magit` package.   

`M-x magit-status` to get status. 

`tab` expands or contracts sections  
`s` for stage  
`u` for unstage  
`g` refresh contents  
`c` commit  














