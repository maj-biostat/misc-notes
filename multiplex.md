# Multiplexer

Is a way to get multiple terminal sessions within a single display. 
`tmux` is a commonly used multiplexer.

## Installation of `tmux`

Install (on ubuntu) `sudo apt install tmux`
Install (on arch) `sudo pacman -S tmux`

## Overview

Note that `tmux` commands are prefixed with a `Ctl + b` leader (denoted `^b` here). 
You hit the leader, let go and then press the command that you want.

There are a number of ways to set up and use `tmux`.
One way is to use a new `tmux` session for each project you are working on.
Within a session you can have multiple windows. 
In one window you might run `vim` and in another window you might be running a julia `repl`.
You can also split windows into `tmux` panes so that you can have multiple things running within a window, e.g. a webserver and a terminal.

For example, to **create a new tmux session** named julia type `tmux new -s julia` from the terminal.
From here we could start vim or a repl etc.
Note that from the `tmux` session you can type `exit` to exit or do `^b d` to **detach** and return to the parent terminal.
Detaching from a session leaves what you were doing running in the background.  

From the parent terminal you can do `tmux ls` to get a **list of the sessions** then `tmux attach -t julia` to **re-attach** to the session named julia.
Note that if you did not name the session then you can return by referencing the session id.  
Also, at times lsof `-U | grep "^tmux"` is useful if you need to **get the names of the active sockets**.

One thing that will be awkward at first is accepting that **scroll** will no longer work as anticipated.
For example, if you cat a file that is longer than a page and you try to scroll with your mouse, it will not work.
To activate scroll mode	`^b [` and use the mouse to scroll as usual.
To exist scroll mode, simply type `q`.

Some common things you will want to do include creating and closing new windows or panes, splitting the pane and moving between windows and panes.

Re-attach to the julia session using `tmux attach -t julia` and then create a **vertical or horizontal split** with `^b %`  or `^b "`.
In one of the panes run `vim test.jl`, **switch** to the other pane using `^b o` (or `^b ;` to just toggle b/w two panes) and kick off a julia repl with `julia`. 
Switch back to the vim pane and enter some text (the ## block functionality derived from `'hanschen/vim-ipython-cell'` plugin and allow you to execute all the code within the block), e.g.

```
##                                                                                                                                     
1+1    
println("hi fred")
##
println("this won't be run")
##
```

Move your cursor to the `1+1` and then hit `ctl + c c` (control then hit `c` twice) to run all the code in the first cell (or just highlight the bit you want to run).
At the bottom of the `vim` pane you will see the following:

```
If you started tmux with the -L or -S flag, use that same socket name or path here.
If you didn't put anything, the default name is "default".
```

So in most cases, `default` is the right name.
After that you will be quizzed about the target pane.
To **show the pane numbers** `^b q` and then use the following format to select the pane with the repl.
For example if you repl is on the LHS and vim is on the RHS and these are your only two panes in a single window then `:0.0` is the right target.

```
":"       means current window, current pane (a reasonable default)
":i"      means the ith window, current pane
":i.j"    means the ith window, jth pane
"h:i.j"   means the tmux session where h is the session identifier
          (either session name or number), the ith window and the jth pane
"%i"      means i refers the pane's unique id
"{token}" one of tmux's supported special tokens, like "{last}"
```

If you accidentally **close your target pane** (`^b x`) then you can respecify the target by invoking `:SlimeConfig` in `vim`.

If you want to **create an entirely new window** then `^b c`.
You can **list and select windows** with `^b w` (cursor to the window you want; you can press `x` if you want to del a window). 

## Basic commands

Cheatsheet https://tmuxcheatsheet.com/ but vital ones below

new session named snme        `tmux new -s snme`  
kill session                  `tmux kill-session -t snme`   

### Windows

`^b c` creates window   
`^b ,` renames window   
`^b &` close current window   
`^b n` next window  (`p` for previous)

### Panes

`^b o` next pane  
`^b ;` toggle b/w panes	  
`^b x` close current pane            
`^b q` show pane numbers	             

`^b + DOWN ARROW` resize pane down (note the `+` key means hold `^b` while pressing DOWN ARROW) 
`^b + UP ARROW` resize pane 
`^b + LEFT ARROW` resize pane 
`^b + RIGHT ARROW` resize pane 

`^b z` toggle zoom to full window
`^b spacebar` toggle layouts                

### Issues with vim colors

see:

https://vi.stackexchange.com/questions/7112/tmux-messing-with-vim-highlighting
https://sunaku.github.io/vim-256color-bce.html
https://stackoverflow.com/questions/10158508/lose-vim-colorscheme-in-tmux-mode


```
# Add this line to your tmux.conf file

set -g default-terminal "screen-256color"

# Add the line below to you shells rc file in my case its my .zshrc

if [[ $TERM == xterm ]]; then TERM=xterm-256color; fi 

# Add the line below to your .vimrc

set t_Co=256

```
