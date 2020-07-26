# Multiplexer

Is a way to get multiple terminal sessions within a single display. 
`tmux` is a commonly used multiplexer.

## `tmux`

Install (on ubuntu) `sudo apt install tmux`
Install (on arch) `sudo pacman -S tmux`

## Overview

Note that `tmux` commands are prefixed with a `Ctl + b` leader (denoted `^b` here). 
You hit the leader, let go and then press the command that you want. 

From the terminal **create a new tmux session** named julia `tmux new -s julia` from which you could start a repl or whatever.
From the `tmux` command line you could type `exit` to exit or from anywhere do `^b d` to **detach** and return to the parent terminal.
Detaching from a session leaves what you were doing running in the background.  

From the parent terminal you can do `tmux ls` to get a **list of the sessions** then `tmux attach -t julia` to **re-attach** to the session named julia.  
Note that if you did not name the session then you can return by referencing the session id.  

One thing that will be awkward at first is remembering that **scroll** will no longer work as anticipated.
So, if you cat a file that is longer than a page and you try to scroll with your mouse, it will not work.
To activate scroll mode	`^b [` and use the mouse to scroll as usual.
To exist scroll mode, simply type `q`.

Some common things you will want to do include **creating** and **closing new windows**, **splitting** the terminal session and **moving between windows and panes**.

Start with **vertical and horizontal split** with `^b %`  and `^b "` from which you can `^b o` to switch to the next pane (`^b ;` to toggle b/w two panes) and then type `julia` to kick off the julia repl.



+ Create new window:  `^b c`   (initially hidden from view)
+ Choose window from list: `^b w` (cursor to the window you want; you can press `x` if you want to del)





## Basic commands

Cheatsheet https://tmuxcheatsheet.com/



new session named snme        `tmux new -s snme`  
kill session                  `tmux kill-session -t snme`   

#### split window into panes:

 

#### scrolling

   

#### resize panes

next pane	                  `b o`   
previous pane	              `b ;`   
  
close current pane            `^b x`       

show pane numbers	          `^b q`    
move pane left	              `^b {`    
move pane right	              `^b {`    
swap pane locations	          `^b ^o`    
resize pane down	          `^b ^j` or `^b : resize-pane -D XX`    
resize pane up	              `^b ^k` or `^b : resize-pane -U XX`    
resize pane left	          `^b ^h` or `^b : resize-pane -L`    
resize pane right	          `^b ^j` or `^b : resize-pane -R`    

toggle zoom                   `^b z`    
toggle layouts                `^b spacebar`    

#### other

new window	                  `^b c`     
close window                  `^d` or `^b x`     
kill window	                  `^b &`    
next window	                  `^b n`    

previous window	              `^b p`   
rename window	              `^b`    
list all windows	          `^b w`     
move to window number	      `^b [number]`     
split window vertically	      `^b %`    
split window horizontally	  `^b "`    

re-attach a detached session  `tmux attach`    
list sessions                 `^b s` or `tmux ls`  

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
