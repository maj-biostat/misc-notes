# Multiplexer

Is a way to get multiple terminal sessions within a single display. 
`tmux` is a commonly used example.

## `tmux`

Install (on ubuntu) `sudo apt install tmux`
Install (on arch) `sudo pacman -S tmux`



Also see https://tmuxcheatsheet.com/

`^b` indicates `ctl key + b`

new session named snme        `tmux new -s snme`  
kill session                  `tmux kill-session -t snme`   

#### split window into panes:

split current window vert:    `^b %`    
split current window hori:    `^b "`    

#### scrolling

start scroll mode	          `^b [`      
exit scroll mode	          `q`      

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
