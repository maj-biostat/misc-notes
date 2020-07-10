# Neovim (on windows)

[MISC](misc.md) [NEOVIM](neovim.md) [README](README.md) [VIM](vim.md)   

## Contents

1. [Sources](#Sources)
2. [Tutorial](#Tutorial)
3. [Install Neovim](#Install-Neovim)
4. [Install plugin manager](#Install-plugin-manager)


## Sources

https://medium.com/@hanspinckaers/setting-up-vim-as-an-ide-for-python-773722142d1d  
https://thoughtbot.com/blog/my-life-with-neovim  
https://nicedoc.io/w0rp/ale  

## Tutorial

This should be done regularly.  
`:Tutor`  

You can also get to it (sometimes) with `vim tutor`   

## Copy and Paste from Windows

From https://github.com/equalsraf/neovim-qt/issues/327  
Until an alternative appears:

`:source $VIMRUNTIME/mswin.vim`

https://www.reddit.com/r/neovim/comments/3fricd/easiest_way_to_copy_from_neovim_to_system/

### Navigation

`hjkl` are the movement keys one unit at a time    
`wb` start of next/previous word  
`e` end of next word  
 
and combine with operators e.g. `2w` move two words   

`0` start of line   
`$` end of line   

`C-g` tells you where you are in the file  (in %) and the number of lines in file     
`99G` moves you to line 99    
`GG`  bottom of file   
`gg` start of file    

### The Mighty Search and Substitute  

`:set ic` ignore case
`:set noic` make case sensitive

`/`  Start a forward search e.g. `/fred`, once found press enter then `n` to find the next  `N` to find the previous.   
`?`  Start a backward search e.g. `/fred`, once found press enter then `n` to find the previous   
`%` find matching parentheses   

`:s/old/new/g`  search and sub old for new.   
`:%s/old/new/g`  search and sub old for new in the whole file  
`:%s/old/new/gc`  with a confirm prompt   

*AWESOME*

1. Select the character currently under the cursor with `*` i.e. `shift-8`.  
2. Now `:%s//new-string/g` e.g. `:%s///g` to delete all in the file.


### Inserts etc

`i` put your cursor on a letter say on the `o` of `you` then typing `i` will insert letters before the `o`   
`a` put your cursor on a letter say on the `o` of `you` then typing `a` will insert letters after the `o`    
`o` open a new line below the current line   

`I` insert at the start of a line      
`A` append to the end of a line   
`O` open a line above the current one     

`r` replace the character at the cursor with the next character typed  
`R` to replace and keep on replacing until escape    
`cw` change the current the word - note the operator is required, we cannot just do `c`   
`ce` change to the end of the word - note the operator is required, we cannot just do `c`  (no diff from cw??)   
`c$` change to end of line    

`J` join lines, e.g. in the following there is no white space after the word test:      

```
this is a test
bless
```

press `J` gives     

```
this is a test bless
```

Note that a space was added.    

### Deleting

`x` delete character   
`dd` delete current line (using d operator)   
`2dd` delete two lines (current and next lines)   
`d$` delete to end of line (using $operator)   
`de` delete to end of word   
`d2w` delete next two words   

## Yanking (aka copy)

For visual mode do `v`, highlight what you want then `y`, go to the line where you want the paste to start then `p`.   

`yy` yank current line
`yw` yank a word (`y5w` yank five words from the character you are over) 

### Pasting

Can use in combination with delete, e.g. do `dd` move to the **line above** where you want to paste then do `p`.   

### Indent

In visual mode, select some text then do `>` or `5>>` to indent next 5 lines.

### External commands

`:!ls` note the bang !
`:!mkdir blah` note the bang !

### Files

`:w filename_you_choose`  write a file   
`:rm filename_you_choose`  delete a file   

### Window, Buffer etc management

`:sp` horizontal split   
`:vs` vertical split    
`:close` closes the currently active window (without closing the buffer)   

`C-w _` minimises a split   
`C-w =` minimises a split   
`C-w 5+` increases the current window by 5 lines   
`C-w 2>` increase width by 2 units
`C-w <` increase width by 1 unit


With the following mappings in the `init.vim` you can use ctl + nav keys to switch window focus.   

```
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
```

** Buffers (are good) **
`:ls` list buffers (active files) note the absence of bang !     
`:b <buffer name or num>` to switch to that buffer      
`:badd <filename>` add a new buffer session     
`:ball` layout all the current buffers    
`:bp` previous buffer   
`:bn` next buffer    




## Install Neovim

1. Go to https://github.com/neovim/neovim/wiki/Installing-Neovim, then stable releases then grab the `nvim-win64.zip` file and download to your downloads dir.
2. Extract the zip file and move the whole directory structure to where you keep your program files
3. Run `nvim-qt.exe` to test things out. This should load neovim after a warning.
4. Close down neovim.
5. Create `C:\Users\<username>\AppData\Local\nvim`

## Install plugin manager 

### Linux

```
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

create `/home/user/.config/nvim/init.vim` and add:

```
" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'tpope/vim-sensible'
Plug 'junegunn/seoul256.vim'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()
```

start `nvim` and run `:PlugInstall`.  Edit config then `:PlugUpdate` to refresh.

### Windows

1. Create `autoload` dir under `C:\Users\<username>\AppData\Local\nvim` 
2. Create `plugged` dir under `C:\Users\<username>\AppData\Local\nvim` 
3. Create `init.vim` file under `C:\Users\<username>\AppData\Local\nvim`
4. Download https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim into you `C:\Users\<username>\AppData\Local\nvim\autoload`
5. Drop the example content into the `init.vim` file.

### Example plugin content

```

" Plugins and config

" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('C:\Users\mjones\AppData\Local\nvim\plugged')

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'
" Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
Plug 'scrooloose/nerdtree'                       " file list
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'   "to highlight files in nerdtree
" God knows
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
Plug 'fatih/vim-go', { 'tag': '*' }
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug '~/my-prototype-plugin'

Plug 'junegunn/vim-easy-align'          

" customish for python

Plug 'jonathanfilip/vim-lucius'                  " nice white colortheme

Plug 'ncm2/ncm2'                                 " auto-complete 
Plug 'roxma/nvim-yarp'                           " dependency of ncm2
Plug 'ncm2/ncm2-jedi'                            " python autocomplete
Plug 'ncm2/ncm2-bufword'                         " not sure
Plug 'ncm2/ncm2-path'                            " filepaths

Plug 'davidhalter/jedi-vim'                      " call sigs for doco
Plug 'majutsushi/tagbar'                         " show tags in a bar
Plug 'wsdjeg/FlyGrep.vim'                        " project wide grep
Plug 'ctrlpvim/ctrlp.vim'                        " fuzzy file find
Plug 'tpope/vim-commentary'                      " comments
Plug 'vim-airline/vim-airline'                   " make statusline awesome
Plug 'vim-airline/vim-airline-themes'            " themes for statuslin
" another status line option Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}

Plug 'Vimjas/vim-python-pep8-indent'             "better indenting for python

" python linters - ** you need to have pylint or flake8 installed **
" flake8 is generally recommended
Plug 'dense-analysis/ale'                        " python linters
Plug 'airblade/vim-gitgutter'                    " show git changes to files in gutter
Plug 'tmhedberg/SimpylFold'                      "  fold code blocks


" Initialize plugin system
call plug#end()


cd ~

filetype indent on



set nu
set foldmethod=indent
set foldlevel=99
nnoremap <space> za   " remaps space to fold things
set encoding=utf-8
set mouse=a  " change cursor per mode
set number  " always show current line number
set smartcase  " better case-sensitivity when searching
set wrapscan  
set expandtab
set tabstop=4
set shiftwidth=4
set history=1000  " remember more commands and search history
set breakindent  " preserve horizontal whitespace when wrapping
set showbreak=..
set lbr  " wrap words
set nowrap  " i turn on wra
set scrolloff=3 "
" set undodir='C:\Users\mjones\.vim\undodir'
" set undofile  " save undos
set undolevels=1000  " maximum number of changes that can be undone
set undoreload=1000  " maximum number lines to save for undo on a buffer reload
set laststatus=2  " alwa
set splitright  " i prefer splitting right and below
set splitbelow
set hlsearch  " highlight search and search while typing
set incsearch


" nerdtree directory on open
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" easy movement around windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l


" colorscheme options
let g:lucius_style="light"
let g:lucius_contrast="high"
color lucius
set background=light


let g:py3 = 'C:\Users\mjones\programs\python-3.6.0\python.exe'

" ncm2 settings
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=menuone,noselect,noinsert
" make it FAST
let ncm2#popup_delay = 5
let ncm2#complete_length = [[1,1]]
let g:ncm2#matcher = 'substrfuzzy'

set pumheight=5

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <silent> <expr> <CR> (pumvisible() && empty(v:completed_item)) ?  "\<c-y>\<cr>" : "\<CR>"

" airline stuff
" let g:airline_powerline_fonts = 1
" let g:airline_section_y = ""
" let g:airline#extensions#tabline#enabled = 1
" let g:airline_section_error = ""
" let g:airline_section_warning = ""

" if !exists('g:airline_symbols')
"     let g:airline_symbols = {}
" endif

" ale options
" let g:ale_python_flake8_options = '--ignore=E129,E501,E302,E265,E241,E305,E402,W503'
" let g:ale_python_pylint_options = '-j 0 --max-line-length=120'
" let g:ale_list_window_size = 4
" let g:ale_sign_column_always = 0
" let g:ale_open_list = 1
" let g:ale_keep_list_window_open = '1'


" Ale
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_linters = {'python': ['flake8']}
" Airline

let g:airline_left_sep  = ''
let g:airline_right_sep = ''
let g:airline#extensions#ale#enabled = 1
let airline#extensions#ale#error_symbol = 'E:'
let airline#extensions#ale#warning_symbol = 'W:'

" Options are in .pylintrc!
highlight VertSplit ctermbg=253

" jedi options
let g:jedi#auto_initialization = 1
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#smart_auto_mappings = 0
let g:jedi#popup_on_dot = 0
let g:jedi#completions_command = ""
let g:jedi#show_call_signatures = "1"
let g:jedi#show_call_signatures_delay = 0
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#show_call_signatures_modes = 'i'  " ni = also in normal mode
let g:jedi#enable_speed_debugging=0


nmap <F6> :NERDTreeToggle<CR>

```

Now launch neovim and run `:PlugInstall` which should install the plugings listed in the `init.vim` file located in the `nvim` dir.

## A word on lint

To use the autolint functionality available through the `ale` plugin you need to have `pylint` installed and have it in your path. Should be something like:

```
python -m pip install --user pylint
# pylint located -> C:\Users\<username>\programs\python-3.6.0\Scripts\;
```
also see https://nicedoc.io/w0rp/ale  for detailed instruction into use of ALE   

