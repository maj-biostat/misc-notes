# EMACS (mainly for Python) (on Windows)

Back to [README](README.md).

## Sources

https://realpython.com/emacs-the-best-python-editor/  


## Basic

First, in all the following `C = CTL` `M = ALT`.

If you find yourself in the mini-buffer (command buffer) `C-g` to get back to where you were.

To do the tutorial `C-H T`

### Frames, Windows, Buffers

"Frames" frame the "Window(s)" which contain "Buffers"

You can create *frames* whereever you want, in which you will put one or more *window(s)* through which you can view the contents *buffer* of the house. 
The contents may be a file, or the output from some code etc. 

### File Functions

Open file `C-x` `C-f` then you write in the dir and file and press RET. 
If no file exists then one is created for you. 
Save `C-x` `C-s`

### Config

Is stored in ~/.emacs.d/init.el and gives access to the package manager. 
Here is an example `init.el` that supports various python related tools. 
Note that you need to do `pip `

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

### Package manager 

`M-x` then type `package-show-package-list`.
To filter by name `f`, to exit press `q`.




















