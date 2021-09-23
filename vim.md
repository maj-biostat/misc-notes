# Vim

Introductory vim configuration and usage.
Focus is on `neovim` rather than traditional `vim`.

`vim` is mainly about editing so think in terms of verbs and nouns (actions on things). 
For example, `dw` deletes the remainder of the word that is currently under the cursor. 

`vim` remembers our editing, so if we do `.` it repeats our last edit (as a whole chunk) and if we want to undo the last edit by `u`.

For a fresh install, you will want a plugin manager installed. 
I use [vim-plug](https://github.com/junegunn/vim-plug), follow the installation instructions at the link.


- [Neovim](#neovim)
  * [Usage](#usage)
    + [Tutorial](#tutorial)
    + [Help](#help)
    + [Current environment setup](#current-environment-setup)
    + [Navigation](#navigation)
    + [Insert](#insert)
    + [Change](#change)
    + [Delete](#delete)
    + [Relative number](#relative-number)
    + [Search and Substitute](#search-and-substitute)
    + [Yanking (aka copy)](#yanking--aka-copy-)
    + [Pasting](#pasting)
    + [Indenting](#indenting)
    + [External commands](#external-commands)
    + [Files](#files)
    + [Window, Buffer etc management](#window--buffer-etc-management)
    + [Macro](#macro)
    + [Custom verbs](#custom-verbs)
  * [Plugins](#plugins)
    + [Linux plugin install](#linux-plugin-install)
    + [Plugin Management](#plugin-management)
    + [Windows plugin install](#windows-plugin-install)
    + [Plugins Overview](#plugins-overview)
      - [Align](#align)
      - [vim-slime](#vim-slime)
      - [vim-ipython-cell](#vim-ipython-cell)
      - [julia-vim](#julia-vim)
      - [Surround](#surround)
      - [Commentary](#commentary)
      - [ReplaceWitRegister](#replacewitregister)
      - [Titlecase](#titlecase)
      - [Sort-motion](#sort-motion)
  * [Vim config `init.vim`](#vim-config--initvim-)
    + [Example 1 simple plugin content](#example-1-simple-plugin-content)
    + [Example 2 expanded plugin content](#example-2-expanded-plugin-content)
  * [Tips and issues](#tips-and-issues)
    + [Useful commands](#useful-commands)
    + [Issues](#issues)
    + [Lint](#lint)
  * [Installation NEOVIM](#installation-neovim)
  * [Post-install](#post-install)
    + [Copy and Paste from Windows](#copy-and-paste-from-windows)
- [VIM (traditional vim)](#vim--traditional-vim-)
  * [Tutorial](#tutorial-1)
  * [Changing dir, opening files.](#changing-dir--opening-files)
  * [Visual Mode, Block select](#visual-mode--block-select)
  * [Yank](#yank)
  * [useful settings](#useful-settings)
  * [Word movement](#word-movement)
  * [Repeat text](#repeat-text)
  * [Find/search and replace](#find-search-and-replace)
  * [Delete](#delete-1)
  * [Insert new line](#insert-new-line)
  * [Windows](#windows)
  * [Vim / vim-plug](#vim---vim-plug)
  * [Vim Colourscheme](#vim-colourscheme)
- [References](#references)


## Neovim

Improved vim.


### Usage

#### Tutorial

Do `:Tutor`  regularly.

See:

+ https://learnvimscriptthehardway.stevelosh.com/
+ https://bencrowder.net/files/vim-fu/

#### Help

`:help` 

Scroll through the list of topics. 
Put your cursor above a topic then do `ctl + ]`.
Type `:bd` to close the topic once you are done.

Help on a specific topic `:he write`

#### Current environment setup

`:version`

and to see the current value of a config item, add a `?`, e.g. `:set tabstop?`

#### Navigation

`hjkl` are the movement keys one unit at a time

The following coordinate motion but do not work too nicely with `.` for repeat. 
Instead use the inner operator e.g. `iw` (see later)

```
w - start of next word
b - back to the previous word
e - end of next word
```
 
combine with operators e.g. `2w` move two words

```
0   - start of line
$   - end of line
C-g - tells you where you are in the file  (in %) and the number of lines in file
99G - moves you to line 99
GG  - bottom of file
gg  - start of file
H   - home - move the cursor to the top of the screen but do NOT scroll an inch!
M   - middle - move the cursor to the middle of the screen but do NOT scroll an inch!
L   - last - move the cursor to the bottom of the screen but do NOT scroll an inch!
z.  - move current line to centre of screen
z-  - move current line to bottom of screen
zz  - recentre
```
scrolling

```
<Ctl>-u - scroll half a page up 
<Ctl>-d - scroll half a page down
<Ctl>-b - scroll full page up
<Ctl>-f - scroll full page down
```

#### Insert

```
i cursor on the `o` of `you` type `i` insert letters before the `o`
a cursor on the `o` of `you` type `a` insert letters after the `o`
o open a new line below the current line
I insert at the start of a line
A append to the end of a line
O open a line above the current one
r replace the character at the cursor with the next character typed
R to replace and keep on replacing until escape
J join lines, e.g. in the following there is no white space after the word test
```

Join example:

```
this is a test,
bless
```

press `J` gives

```
this is a test, bless
```

A space was added automatically between `,` and `bless`.

#### Change

The "inner" modifier `i` is very useful. 
Example: `ciw` changes the whole word under your cursor regardless of where your cursor is in the word. 
You can also do things like `cit` which means change inner tag. 
The inner operator works better with `.` the repeat.

Change - note that postfix is required, we cannot just do `c` 

```
cw - change current word - postfix `w` is required, we cannot just do `c`  
ce - change to end of word - postfix is required, we cannot just do `c`
c$ - change to end of line 
```
Also, change a portion of text by using find and search operators. 

Example: if we had the text `about that,` and the cursor were over the `o` you could type `cf,` and then enter the text `ove this` to give you `above this`.

```
cfx        - change up to and including the next `x` where `x` could be any character.
ctx        - change up to and excluding the next `x` where `x` could be any character.
c/whatever - change up to the result from forward search for the next instance of `whatever`
c/whatever - change up to the result from backward search for the next instance of `whatever`
```

#### Delete

It is also useful to think in terms of the noun modifiers for delete.
Example: `diw` will delete the whole word from within (inner) the word.
Similarly, `dip` deletes a paragraph from within a paragraph. 
Others:

```
di" - delete within quotes   
das - delete a sentence   
di) - deletes within parentheses  
```

Some standard deletes:

```
x        - delete character   
dd       - delete line (using d operator)   
2dd      - delete two lines (current and next lines)   
d$       - delete to end of line (using $operator)   
de       - delete to end of word   
d2w      - delete next two words   
d\x<cr>  - delete from cursor to (and including) character x   
dG       - delete from current line to end of file (inclusive of current line)   
dgg      - delete from current line to the beginning of a file (inclusive of current line)  
```

#### Relative number

With relative number turned off `:set norelativenumber` the line numbers remain static giving you the absolute line number. 
Turning it on `set relativenumber` allows you to make multiline changes really easy. 
So, if you want to change from the current line down to 3 lines below, you just look at the relative numbering on the left and do `c3j` interpreted as change from and including the current line to the next 3 lines below.

```
3
2 more on This Bsocks
1 more carrots                                                                                                                        
10 THIS IS THE CURRENT LINE (which is also the ABSOLUTE line number)
1 and more money
2 ok, when is it going to be done?
3 i said, when is it?                                                                                                                  4 umph          
```

Hitting `c3j` gives the following putting the cursor at the line marked by `10`:

```
3
2 more on This Bsocks
1 more carrots                                                                                                                        
10 
1 umph          
```

#### Search and Substitute  

NICE:

1. Select the character currently under the cursor with `*` i.e. `shift-8`.
2. Now `:%s//new-string/g` e.g. `:%s///g` to delete all in the file.

```
:nohl        - after you are done with your search, turn off the highlighting
:set ic      - ignore case
:set noic    - make case sensitive
```

```
/ - start forward search e.g. `/fred`, once found, press enter then `n` to find the next  `N` to find the previous.
? - start a backward search e.g. `/fred`, once found press enter then `n` to find the previous   
% - find matching parentheses   
```

```
:s/old/new/g   - search and sub old for new.   
:%s/old/new/g  - search and sub old for new in the whole file  
:%s/old/new/gc - with a confirm prompt 
```

Removing windows end of line characters i.e. `^M`.

```
:%s/<ctl v><ctl m>//g
```

the `<ctl v><ctl m>` gives you `^M`.

#### Yanking (aka copy)

For visual mode do `v`, highlight what you want then `y`, go to the line where you want the paste to start then `p`.

`yy` yank current line
`yw` yank a word (`y5w` yank five words from the character you are over) 

#### Pasting

Can use in combination with delete.
Example: `dd` then move to the **line above** where you want to paste then do `p`.

#### Indenting

In visual mode, select some text then do `>` or `5>>` to indent next 5 lines.

```
:set tabstop=8     - tabs are at proper location
:set expandtab     - don't use actual tab character (ctrl-v)
:set shiftwidth=4  - indenting is 4 spaces
:set autoindent    - turns it on
:set smartindent   - does the right thing (mostly) in programs
:set cindent       - stricter rules for C programs
```

#### External commands

`:!ls` note the bang !
`:!mkdir blah` note the bang !

#### Files

```
:w filename_you_choose   - write a file
:rm filename_you_choose  - delete a file
:e path to file          - open a new file
:bd                      - close a buffer (without quitting vim)
```

#### Window, Buffer etc management

Buffers (are good) you should try to use them:

```
:ls list buffers (active files) note the absence of bang !
:b <buffer name or num>  - to switch to that buffer
:badd <filename>         - add a new buffer session
:ball                    - layout all the current buffers
:bp                      - previous buffer
:bn                      - next buffer
```

Windows in vim

```
:sp    - horizontal split   
:vs    - vertical split    
:close - closes the currently active window (without closing the buffer)   
```

```
C-w _  - minimises a split   
C-w =  - minimises a split   
C-w 5+ - increases the current window by 5 lines   
C-w 2> - increase width by 2 units
C-w <  - increase width by 1 unit
```

With the following mappings in the `init.vim` you can use ctl + nav keys to switch window focus.

```
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
```

#### Macro

Start recording a macro to register `a` with `qa`, press `q` to stop recording and `@a` to run the macro.
If you do `10@a` it will repeat the macro 10 times.

Example: align all &

```
# Go to the line you want to change and execute
# Start recording
qa 
0f&50i<Space><Esc>039lvf&hxj
# Stop recording
q
# Run 10 times
10@a
```

#### Custom verbs

Something to look at later on... 
Look at [textobj-user wiki](https://github.com/kana/vim-textobj-user/wiki). 

Examples:

+ Indent `ii`
+ Entire `ee`
+ Line `il`



### Plugins

#### Linux plugin install

```
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

create `/home/user/.config/nvim/init.vim` and add the following to test out:

```
" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'tpope/vim-sensible'
Plug 'junegunn/seoul256.vim'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()
```

#### Plugin Management

+ Start `nvim` and run `:PlugInstall`.
+ Edit config then `:PlugUpdate` to refresh.
+ Delete unwanted from config then `:PlugClean`

Under `~/.config/nvim` create `colors` directory then clone the dracula repo (for revised color scheme): 

```
git clone https://github.com/dracula/vim.git dracula
```

#### Windows plugin install

1. Create `autoload` dir under `C:\Users\<username>\AppData\Local\nvim` 
2. Create `plugged` dir under `C:\Users\<username>\AppData\Local\nvim` 
3. Create `init.vim` file under `C:\Users\<username>\AppData\Local\nvim`
4. Download https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim into you `C:\Users\<username>\AppData\Local\nvim\autoload`
5. Drop the example content into the `init.vim` file.

#### Plugins Overview

##### Align

You could write a macro (see [Macro](#macro) section) to align text, but using a plugin is easier.

See https://github.com/junegunn/vim-easy-align

```
# Align on all &
gaip*&
```

##### vim-slime

For use in conjunction with a multiplexer to (for example) send commands from an R script to an R shell.

##### vim-ipython-cell

For defining blocks in the code.

##### julia-vim

Stuff for julia support

##### Surround

```
s    - becomes a verb modifier for surround
ds"  - delete surrounding `"`
ys"  - add surrounding `"` around current word
cs"' - change surround `"` to single quote
```

##### Commentary

For toggling commenting.

```
cml  - comment current line
cmj  - comment current and line below
cmip - comment the entire paragraph
```

##### ReplaceWitRegister

`griw` replace the inner word with the current register

##### Titlecase

`gtip'` Capitalise the whole para

##### Sort-motion

`gsip` 







### Vim config `init.vim`

```
> /home/<user>/.config/nvim
> ls
d 4096 Mar 20 17:11 plugged
d 4096 Feb  8 16:45 pack
-  179 Jan 14 10:12 .netrwhist
- 3542 Mar 24 17:28 init.vim
d 4096 Jul 11  2020 autoload
```

Launch neovim and run `:PlugInstall` which should install the plugings listed in the `init.vim` file located in the `nvim` dir.

#### Example 1 simple plugin content

The `vim-slime` allows you to select a block of code in a file that is open in `vim` in one `tmux` pane to a `repl` that is open in another pane.
However, `tmux` is not the default so you have to add the `slime_target` modifier, see more in [](multiplex.md).

See [init.vim1](init.vim1).

#### Example 2 expanded plugin content

See [init.vim2](init.vim2).












### Tips and issues

#### Useful commands

+ Forward search for word under cursor (in normal mode) `*`
+ Reverse search for word under cursor (in normal mode) `#`
+ Repeat what I just did `.`
+ Jump to matching brace `%`
+ Macro start record `qa` (saves to the `a` register)
+ Macro stop recording with `q` 
+ Macro replay with `@a` in normal model.

#### Issues 

Recent versions of `vim` will have the `pi_paren.txt` aka `matchparen` plugin installed by default.
This can be maddening to a nube (to say the least) because your cursor will bounce all over the place while trying to navigate through parentheses. 

Turn it off with `:NoMatchParen` and turn it back on again with `:DoMatchParen` should you wish to.

See https://vimhelp.org/pi_paren.txt.html and also see https://vimawesome.com/plugin/vim-matchup for a seemingly viable alternative 

Note that to turn this off via `.vimrc` or `init.vim` add `set noshowmatch`.


#### Lint

To use the autolint functionality available through the `ale` plugin you need to have `pylint` installed and have it in your path. Should be something like:

```
python -m pip install --user pylint
# pylint located -> C:\Users\<username>\programs\python-3.6.0\Scripts\;
```
also see https://nicedoc.io/w0rp/ale  for detailed instruction into use of ALE   







### Installation NEOVIM

1. Go to https://github.com/neovim/neovim/wiki/Installing-Neovim, then stable releases then grab the `nvim-win64.zip` file and download to your downloads dir.
2. Extract the zip file and move the whole directory structure to where you keep your program files
3. Run `nvim-qt.exe` to test things out. This should load neovim after a warning.
4. Close down neovim.
5. Create `C:\Users\<username>\AppData\Local\nvim`




















### Post-install

#### Copy and Paste from Windows

From https://github.com/equalsraf/neovim-qt/issues/327
Until an alternative appears:

`:source $VIMRUNTIME/mswin.vim`

https://www.reddit.com/r/neovim/comments/3fricd/easiest_way_to_copy_from_neovim_to_system/


















## VIM (traditional vim)

### Tutorial

Do `:Tutor` on a regular basis.

### Changing dir, opening files.

```
:pwd        - present working dir
:cd <dir>   - make dir current working dir e.g. :cd ~
```

### Visual Mode, Block select

http://vimcasts.org/transcripts/22/en/

ctl-v to enter visual mode then highlight using the hjkl keys. 
use the `o` key if you want to change the expanding corner of the visual block.
if you want to select to the end of the line `$`
if a single column is selected, you can start to insert text using `ctl I` 
if you have selected more than a single character you may delete (and copy to a buffer) the currently selected text with `d`
similarly you can change a selection entirely with `c`. this does a delete followed by putting you into insert mode
you can replace every single character you have selected with the next character you press by using `r`
using . will repeat the last command so you could repeatedly delete etc.

### Yank

Yank (copy) a single character, simply `yl`, 
Put it before the cursor position `P` (or `[p`)  otherwise `p` for after

### useful settings

turn off word wrap            :set nowrap
turn on line highlighter      :set cursorline

### Word movement 

`w` next word
`b` beginning of current word
`e` end of current word

### Repeat text

`3igo` followed by `escape` inserts "go" 3 times

### Find/search and replace

`/` then type what you are looking for. 
if found press `enter` and off you go. 
you can use `n` to find the next occurrence.
if you just want to find a letter do `fp` to find then next "p"

```
# Search for each occurrence of 'foo' (in all lines), and replace it with 'bar'.
:%s/foo/bar/g

# Search for each occurrence of 'foo' (in the current line only), and replace it with 'bar'.
:s/foo/bar/g

# Change each 'foo' to 'bar', but ask for confirmation first.
:%s/foo/bar/gc

# Change only whole words exactly matching 'foo' to 'bar'; ask for confirmation.
:%s/\<foo\>/bar/gc

# Change each 'foo' (case insensitive due to the i flag) to 'bar'; ask for confirmation.
:%s/foo/bar/gci

# This may be wanted after using :set noignorecase to make searches case sensitive (the default).
:%s/foo\c/bar/gc is the same because \c makes the search case insensitive.

# Change each 'foo' (case sensitive due to the I flag) to 'bar'; ask for confirmation.
:%s/foo/bar/gcI

# This may be wanted after using :set ignorecase to make searches case insensitive.
:%s/foo\C/bar/gc is the same because \C makes the search case sensitive.
```

### Delete 

```
# from cursor up to (and including) character x:
d\x<cr>
# from current line to end of file
dG
```

### Insert new line

`o` after current `O` before current line 

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

### Vim / vim-plug

`sudo pacman -S vim`

Thing is, the above installs vim-minimal (I think), which does not have clipboard enabled.
You can test with:
```
:echo has('clipboard')
```
if the result is 0 then install gvim (you might need to uninstall vim).
This will give you access to the system clipboard via select and middle mouse button.

Download the package `nvim-r` from here:
https://www.vim.org/scripts/script.php?script_id=2628

To install vimplug: go here, follow instruc
https://github.com/junegunn/vim-plug

In a nutshell:
open Nvim-R.vmb in vim and then do `:so %`

### Vim Colourscheme

Get colourschemes from e.g.

https://github.com/flazz/vim-colorschemes
https://github.com/fxn/vim-monochrome
https://github.com/sjl/badwolf
https://github.com/noahfrederick/vim-noctu

Download the .vim files and copy to `~/.vim/color` directory:

```
mv ~/Downloads/vim-distinguished-develop/colors/*.vim ~/.vim/colors/
```

Edit the `~/.vimrc` file introducing:

```
syntax enable
colorscheme distinguished
```





## References

https://medium.com/@hanspinckaers/setting-up-vim-as-an-ide-for-python-773722142d1d  
https://thoughtbot.com/blog/my-life-with-neovim  
https://nicedoc.io/w0rp/ale  

