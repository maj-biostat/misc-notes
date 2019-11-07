# Vim

[MISC](misc.md)    
[NEOVIM](neovim.md)   
[README](README.md)    
[VIM](vim.md)   

This is in no particular order. I will add some structure one day.

## Changing dir, opening files.

```
:pwd        - present working dir
:cd <dir>   - make dir current working dir e.g. :cd ~
```

## Visual Mode, Block select

http://vimcasts.org/transcripts/22/en/

ctl-v to enter visual mode then highlight using the hjkl keys. 
use the `o` key if you want to change the expanding corner of the visual block.
if you want to select to the end of the line `$`
if a single column is selected, you can start to insert text using `ctl I` 
if you have selected more than a single character you may delete (and copy to a buffer) the currently selected text with `d`
similarly you can change a selection entirely with `c`. this does a delete followed by putting you into insert mode
you can replace every single character you have selected with the next character you press by using `r`
using . will repeat the last command so you could repeatedly delete etc.

## Yank

to yank a single character, simply `yl`, to put it before the cursor position `P` (or `[p`)  otherwise `p` for after

## useful settings

turn off word wrap            :set nowrap
turn on line highlighter      :set cursorline

## Word movement 

`w` next word
`b` beginning of current word
`e` end of current word

## Repeat text

`3igo` followed by `escape` inserts "go" 3 times

## Find

`/` then type what you are looking for. if found press `enter` and off you go. you can use `n` to find the next occurrence.
if you just want to find a letter do `fp` to find then next "p"  

```
:%s/foo/bar/g
Find each occurrence of 'foo' (in all lines), and replace it with 'bar'.
:s/foo/bar/g
Find each occurrence of 'foo' (in the current line only), and replace it with 'bar'.
:%s/foo/bar/gc
Change each 'foo' to 'bar', but ask for confirmation first.
:%s/\<foo\>/bar/gc
Change only whole words exactly matching 'foo' to 'bar'; ask for confirmation.
:%s/foo/bar/gci
Change each 'foo' (case insensitive due to the i flag) to 'bar'; ask for confirmation.
:%s/foo\c/bar/gc is the same because \c makes the search case insensitive.
This may be wanted after using :set noignorecase to make searches case sensitive (the default).
:%s/foo/bar/gcI
Change each 'foo' (case sensitive due to the I flag) to 'bar'; ask for confirmation.
:%s/foo\C/bar/gc is the same because \C makes the search case sensitive.
This may be wanted after using :set ignorecase to make searches case insensitive.
```

## Insert new line

`o` after current `O` before current line 

## Files/Buffers

### Windows

To horizontally split use `:sp` vertically, `:vs` then use `ctl w` followed by hjkl to move around.

You can increase/decrease the current height/width `ctl w` `+-<>`

```
:e filename      - edit another file
:split filename  - split window and load another file
ctrl-w up arrow  - move cursor up a window
ctrl-w ctrl-w    - move cursor to another window (cycle)
ctrl-w_          - maximize current window
ctrl-w=          - make all equal size
10 ctrl-w+       - increase window size by 10 lines
:vsplit file     - vertical split (same as ctrl-w v)
:hsplit file     - vertical split (same as ctrl-w h)
:sview file      - same as split, but readonly
:hide            - close current window
:q               - close window with current focus
:only            - keep only this window open
:ls              - show current buffers
:b 2             - open buffer #2 in this window
```


