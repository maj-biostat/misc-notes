# Vim

# hi, i had forgotten about you

another change

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

## Insert new line

`o` after current `O` before current line 

## Files/Buffers


## Windows

To horizontally split use `:sp` vertically, `:vs` then use `ctl w` followed by hjkl to move around.

You can increase/decrease the current height/width `ctl w` `+-<>`
