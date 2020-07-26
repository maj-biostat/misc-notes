# Neovim

## Tutorial

`:Tutor`  This should be done regularly.   
`vim tutor`  as above

## Thoughts

`vim` is mainly about editing. 
Think in terms of verbs and nouns (actions on things). 
For example, `dw` deletes the remainder of the word that is currently under the cursor. 
`vim` also remembers our edits and so if we do `.` it repeats our last edit (as a whole chunk) and if we want to undo the last edit by `u`.

## Copy and Paste from Windows

From https://github.com/equalsraf/neovim-qt/issues/327  
Until an alternative appears:

`:source $VIMRUNTIME/mswin.vim`

https://www.reddit.com/r/neovim/comments/3fricd/easiest_way_to_copy_from_neovim_to_system/

## Navigation and motion

`hjkl` are the movement keys one unit at a time    

The following coordinate motion but do not work too nicely with `.` for repeat. 
Instead use the inner operator e.g. `iw` (see later)  

`w` start of next word  
`b` back to the previous word
`e` end of next word  
 
and combine with operators e.g. `2w` move two words   

`0` start of line   
`$` end of line   

`C-g` tells you where you are in the file  (in %) and the number of lines in file     
`99G` moves you to line 99    
`GG`  bottom of file   
`gg` start of file    

## Inserts

`i` put your cursor on a letter say on the `o` of `you` then typing `i` will insert letters before the `o`   
`a` put your cursor on a letter say on the `o` of `you` then typing `a` will insert letters after the `o`    
`o` open a new line below the current line   

`I` insert at the start of a line      
`A` append to the end of a line   
`O` open a line above the current one     

`r` replace the character at the cursor with the next character typed  
`R` to replace and keep on replacing until escape    
  

`J` join lines, e.g. in the following there is no white space after the word test:      

```
this is a test
bless
```

press `J` gives     

```
this is a test bless
```

Note that a space was added automatically.

## Change

Using the "inner" modifier `i` is also very useful. 
For example, `ciw` changes the whole word under your cursor regardless of where your cursor is in the word. 
You can also do things like `cit` which means change inner tag. 
The inner operator works better with `.` the repeat.

`cw` change the current the word - note the operator is required, we cannot just do `c`   
`ce` change to the end of the word - note the operator is required, we cannot just do `c`  (no diff from cw??)   
`c$` change to end of line 

Another way to change a portion of text is to use the find and search operators. 
For example, if we had the text `about that,` and the cursor were over the `o` you could type `cf,` and then enter the text `ove this` to give you `above this`.

`cfx` change up to and including the next `x` where `x` could be any character.
`ctx` change up to and excluding the next `x` where `x` could be any character.
`c/whatever` change up to the result from forward search for the next instance of `whatever`
`c/whatever` change up to the result from backward search for the next instance of `whatever`


## Deleting

The following commands are useful but it is also useful to think in terms of the noun modifiers. 
For example, `diw` will delete the whole word from within (inner) the word.
Similarly, `dip` deletes a paragraph from within a paragraph. 
There are others:   

`di"` delete within quotes   
`das` delete a sentence   
`di)` deletes within parentheses  

And here are some standard deletes:

`x` delete character   
`dd` delete current line (using d operator)   
`2dd` delete two lines (current and next lines)   
`d$` delete to end of line (using $operator)   
`de` delete to end of word   
`d2w` delete next two words   
`d\x<cr>` delete from cursor to (and including) character x   
`dG` delete from current line to end of file (inclusive of current line)   
`dgg` deletes from current line to the beginning of a file (inclusive of current line)  

## Custom verbs

These are something to look at later on... look at [textobj-user wiki](https://github.com/kana/vim-textobj-user/wiki). 

Examples:

+ Indent `ii`
+ Entire `ee`
+ Line `il`

## Relative number

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


## The Mighty Search and Substitute  

`:nohl` after you are done with your search, turn off the highlighting

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


## Yanking (aka copy)

For visual mode do `v`, highlight what you want then `y`, go to the line where you want the paste to start then `p`.   

`yy` yank current line
`yw` yank a word (`y5w` yank five words from the character you are over) 

## Pasting

Can use in combination with delete, e.g. do `dd` move to the **line above** where you want to paste then do `p`.   

## Indenting

In visual mode, select some text then do `>` or `5>>` to indent next 5 lines.


## External commands

`:!ls` note the bang !
`:!mkdir blah` note the bang !

## Files

`:w filename_you_choose`  write a file   
`:rm filename_you_choose`  delete a file   
`:e path to file` open a new file
`:bd` close a buffer (without quitting vim)

## Window, Buffer etc management

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

** Buffers (are good) you should try to use them **
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

Depends on whether you run linux or win:

### Linux

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

Start `nvim` and run `:PlugInstall`.  
Edit config then `:PlugUpdate` to refresh.  
Delete unwanted from config then `:PlugClean`

Under `~/.config/nvim` create `colors` directory then clone the dracula repo (for revised color scheme):  

```
git clone https://github.com/dracula/vim.git dracula
```
### Windows

1. Create `autoload` dir under `C:\Users\<username>\AppData\Local\nvim` 
2. Create `plugged` dir under `C:\Users\<username>\AppData\Local\nvim` 
3. Create `init.vim` file under `C:\Users\<username>\AppData\Local\nvim`
4. Download https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim into you `C:\Users\<username>\AppData\Local\nvim\autoload`
5. Drop the example content into the `init.vim` file.


## Plugins

### vim-slime

For use in conjunction with a multiplexer to (for example) send commands from an R script to an R shell.

### vim-ipython-cell

For defining blocks in the code.

### julia-vim

Stuff for julia support

### Surround

`s` becomes a verb modifier for surround
`ds"` delete surrounding `"`
`ys"` add surrounding `"` around current word
`cs"'` change surround `"` to single quote

### Commentary

For toggling commenting.

`cml` comment current line
`cmj` comment current and line below
`cmip` comment the entire paragraph

### ReplaceWitRegister

`griw` replace the inner word with the current register

### Titlecase

`gtip'` Capitalise the whole para

### Sort-motion

`gsip` 

### System-copy


## Examples `init.vim`

### Example 1 simple plugin content

The `vim-slime` allows you to select a block of code in a file that is open in `vim` in one `tmux` pane to a `repl` that is open in another pane.
However, `tmux` is not the default so you have to add the `slime_target` modifier, see more in [](multiplex.md).

```
"*****************************************************************************
"" Vim-PLug core
"*****************************************************************************
if has('vim_starting')
  set nocompatible               " Be iMproved
endif

let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')

" let g:vim_bootstrap_langs = "javascript,php,python,ruby"
" let g:vim_bootstrap_editor = "nvim"				" nvim or vim

if !filereadable(vimplug_exists)
  echo "Installing Vim-Plug..."
  echo ""
  silent !\curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

" Required:
call plug#begin(expand('~/.config/nvim/plugged'))

Plug 'dracula/vim'
Plug 'tomasr/molokai'

Plug 'jpalardy/vim-slime', { 'for': ['python', 'julia']}
Plug 'hanschen/vim-ipython-cell', { 'for': ['python', 'julia'] }
Plug 'JuliaEditorSupport/julia-vim'

call plug#end()

" Required:
filetype plugin indent on

"*****************************************************************************
"" Basic Setup
"*****************************************************************************"
"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set bomb
set binary

"" Fix backspace indent
set backspace=indent,eol,start

"" Tabs. May be overriten by autocmd rules
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab

"" Map leader to ,
let mapleader=','

"" Enable hidden buffers
set hidden

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

"" Directories for swp files
set nobackup
set noswapfile

set fileformats=unix,dos,mac
set showcmd
set shell=/bin/sh

"" Slime - tmux is not the default
let g:slime_target = "tmux"

"*****************************************************************************
"" Visual Settings
"*****************************************************************************
syntax on
set ruler
set number

let no_buffers_menu=1
if !exists('g:not_finish_vimplug')
  colorscheme molokai
endif

set mousemodel=popup
set t_Co=256
set guioptions=egmrti
set gfn=Monospace\ 10

if has("gui_running")
  if has("gui_mac") || has("gui_macvim")
    set guifont=Menlo:h12
    set transparency=7
  endif
else
  let g:CSApprox_loaded = 1

  " IndentLine
  let g:indentLine_enabled = 1
  let g:indentLine_concealcursor = 0
  let g:indentLine_char = '┆'
  let g:indentLine_faster = 1  
endif

"" Disable the blinking cursor.
set gcr=a:blinkon0
set scrolloff=3

"" Status bar
set laststatus=2

"" Use modeline overrides
set modeline
set modelines=10

set title
set titleold="Terminal"
set titlestring=%F

set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

if exists("*fugitive#statusline")
  set statusline+=%{fugitive#statusline()}
endif
```


### Example 2 expanded plugin content

```
"*****************************************************************************
"" Vim-PLug core
"*****************************************************************************
if has('vim_starting')
  set nocompatible               " Be iMproved
endif

let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')

let g:vim_bootstrap_langs = "javascript,php,python,ruby"
let g:vim_bootstrap_editor = "nvim"				" nvim or vim

if !filereadable(vimplug_exists)
  echo "Installing Vim-Plug..."
  echo ""
  silent !\curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

" Required:
call plug#begin(expand('~/.config/nvim/plugged'))

"*****************************************************************************
"" Plug install packages
"*****************************************************************************
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'dracula/vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'vim-scripts/grep.vim'
Plug 'vim-scripts/CSApprox'
Plug 'bronson/vim-trailing-whitespace'
Plug 'Raimondi/delimitMate'
Plug 'majutsushi/tagbar'
Plug 'scrooloose/syntastic'
Plug 'Yggdroot/indentLine'
Plug 'avelino/vim-bootstrap-updater'

let g:make = 'gmake'
if exists('make')
        let g:make = 'make'
endif
Plug 'Shougo/vimproc.vim', {'do': g:make}

"" Vim-Session
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'

if v:version >= 703
  Plug 'Shougo/vimshell.vim'
endif

if v:version >= 704
  "" Snippets
  Plug 'SirVer/ultisnips'
  Plug 'FelikZ/ctrlp-py-matcher'
endif

Plug 'honza/vim-snippets'

"" Color
Plug 'tomasr/molokai'

"*****************************************************************************
"" Custom bundles
"*****************************************************************************

" javascript
"" Javascript Bundle
Plug 'jelera/vim-javascript-syntax'


" php
"" PHP Bundle
Plug 'arnaud-lb/vim-php-namespace'


" python
"" Python Bundle
Plug 'davidhalter/jedi-vim'


" ruby
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-projectionist'
Plug 'thoughtbot/vim-rspec'
Plug 'ecomba/vim-ruby-refactoring'


"*****************************************************************************
"*****************************************************************************

"" Include user's extra bundle
if filereadable(expand("~/.config/nvimrc.local.bundles"))
  source ~/.config/nvimrc.local.bundles
endif

call plug#end()

" Required:
filetype plugin indent on


"*****************************************************************************
"" Basic Setup
"*****************************************************************************"
"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set bomb
set binary


"" Fix backspace indent
set backspace=indent,eol,start

"" Tabs. May be overriten by autocmd rules
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab

"" Map leader to ,
let mapleader=','

"" Enable hidden buffers
set hidden

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

"" Directories for swp files
set nobackup
set noswapfile

set fileformats=unix,dos,mac
set showcmd
set shell=/bin/sh

" session management
let g:session_directory = "~/.config/nvim/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1

"*****************************************************************************
"" Visual Settings
"*****************************************************************************
syntax on
set ruler
set number

let no_buffers_menu=1
if !exists('g:not_finish_vimplug')
  colorscheme molokai
endif

set mousemodel=popup
set t_Co=256
set guioptions=egmrti
set gfn=Monospace\ 10

if has("gui_running")
  if has("gui_mac") || has("gui_macvim")
    set guifont=Menlo:h12
    set transparency=7
  endif
else
  let g:CSApprox_loaded = 1

  " IndentLine
  let g:indentLine_enabled = 1
  let g:indentLine_concealcursor = 0
  let g:indentLine_char = '┆'
  let g:indentLine_faster = 1

  
endif



"" Disable the blinking cursor.
set gcr=a:blinkon0
set scrolloff=3

"" Status bar
set laststatus=2

"" Use modeline overrides
set modeline
set modelines=10

set title
set titleold="Terminal"
set titlestring=%F

set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

if exists("*fugitive#statusline")
  set statusline+=%{fugitive#statusline()}
endif

" vim-airline
let g:airline_theme = 'powerlineish'
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline_skip_empty_sections = 1

"*****************************************************************************
"" Abbreviations
"*****************************************************************************
"" no one is really happy until you have this shortcuts
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

"" NERDTree configuration
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 50
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite
nnoremap <silent> <F2> :NERDTreeFind<CR>
noremap <F3> :NERDTreeToggle<CR>

" grep.vim
nnoremap <silent> <leader>f :Rgrep<CR>
let Grep_Default_Options = '-IR'
let Grep_Skip_Files = '*.log *.db'
let Grep_Skip_Dirs = '.git node_modules'

" vimshell.vim
let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
let g:vimshell_prompt =  '$ '

" terminal emulation
if g:vim_bootstrap_editor == 'nvim'
  nnoremap <silent> <leader>sh :terminal<CR>
else
  nnoremap <silent> <leader>sh :VimShellCreate<CR>
endif

"*****************************************************************************
"" Functions
"*****************************************************************************
if !exists('*s:setupWrapping')
  function s:setupWrapping()
    set wrap
    set wm=2
    set textwidth=79
  endfunction
endif

"*****************************************************************************
"" Autocmd Rules
"*****************************************************************************
"" The PC is fast enough, do syntax highlight syncing from start
augroup vimrc-sync-fromstart
  autocmd!
  autocmd BufEnter * :syntax sync fromstart
augroup END

"" Remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

"" txt
augroup vimrc-wrapping
  autocmd!
  autocmd BufRead,BufNewFile *.txt call s:setupWrapping()
augroup END

"" make/cmake
augroup vimrc-make-cmake
  autocmd!
  autocmd FileType make setlocal noexpandtab
  autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
augroup END

set autoread

"*****************************************************************************
"" Mappings
"*****************************************************************************
"" Split
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

"" Git
noremap <Leader>ga :Gwrite<CR>
noremap <Leader>gc :Gcommit<CR>
noremap <Leader>gsh :Gpush<CR>
noremap <Leader>gll :Gpull<CR>
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gb :Gblame<CR>
noremap <Leader>gd :Gvdiff<CR>
noremap <Leader>gr :Gremove<CR>

" session management
nnoremap <leader>so :OpenSession<Space>
nnoremap <leader>ss :SaveSession<Space>
nnoremap <leader>sd :DeleteSession<CR>
nnoremap <leader>sc :CloseSession<CR>

"" Tabs
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>

"" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

"" Opens an edit command with the path of the currently edited file filled in
noremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

"" Opens a tab edit command with the path of the currently edited file filled
noremap <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

"" ctrlp.vim
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist)|(\.(swp|tox|ico|git|hg|svn))$'
let g:ctrlp_user_command = "find %s -type f | grep -Ev '"+ g:ctrlp_custom_ignore +"'"
let g:ctrlp_use_caching = 1

" The Silver Searcher
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
endif

cnoremap <C-P> <C-R>=expand("%:p:h") . "/" <CR>
noremap <leader>b :CtrlPBuffer<CR>
let g:ctrlp_map = '<leader>e'
let g:ctrlp_open_new_file = 'r'
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'

" snippets
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
let g:UltiSnipsEditSplit="vertical"

" syntastic
let g:syntastic_always_populate_loc_list=1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_style_error_symbol = '✗'
let g:syntastic_style_warning_symbol = '⚠'
let g:syntastic_auto_loc_list=1
let g:syntastic_aggregate_errors = 1

" Tagbar
nmap <silent> <F4> :TagbarToggle<CR>
let g:tagbar_autofocus = 1

" Disable visualbell
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

"" Copy/Paste/Cut
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif

noremap YY "+y<CR>
noremap <leader>p "+gP<CR>
noremap XX "+x<CR>

if has('macunix')
  " pbcopy for OSX copy/paste
  vmap <C-x> :!pbcopy<CR>
  vmap <C-c> :w !pbcopy<CR><CR>
endif

"" Buffer nav
noremap <leader>z :bp<CR>
noremap <leader>q :bp<CR>
noremap <leader>x :bn<CR>
noremap <leader>w :bn<CR>

"" Close buffer
noremap <leader>c :bd<CR>

"" Clean search (highlight)
nnoremap <silent> <leader><space> :noh<cr>

"" Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

"" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"" Open current line on GitHub
nnoremap <Leader>o :.Gbrowse<CR>

"*****************************************************************************
"" Custom configs
"*****************************************************************************

" javascript
let g:javascript_enable_domhtmlcss = 1

" vim-javascript
augroup vimrc-javascript
  autocmd!
  autocmd FileType javascript set tabstop=4|set shiftwidth=4|set expandtab softtabstop=4 smartindent
augroup END


" php


" python
" vim-python
augroup vimrc-python
  autocmd!
  autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8 colorcolumn=79
      \ formatoptions+=croq softtabstop=4 smartindent
      \ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
augroup END

" jedi-vim
let g:jedi#popup_on_dot = 0
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = "<leader>d"
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#rename_command = "<leader>r"
let g:jedi#show_call_signatures = "0"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#smart_auto_mappings = 0

" syntastic
let g:syntastic_python_checkers=['python', 'flake8']

" vim-airline
let g:airline#extensions#virtualenv#enabled = 1


" ruby
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1

augroup vimrc-ruby
  autocmd!
  autocmd BufNewFile,BufRead *.rb,*.rbw,*.gemspec setlocal filetype=ruby
  autocmd FileType ruby set tabstop=2|set shiftwidth=2|set expandtab softtabstop=2 smartindent
augroup END

let g:tagbar_type_ruby = {
    \ 'kinds' : [
        \ 'm:modules',
        \ 'c:classes',
        \ 'd:describes',
        \ 'C:contexts',
        \ 'f:methods',
        \ 'F:singleton methods'
    \ ]
\ }

" RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

" Ruby refactory
nnoremap <leader>rap  :RAddParameter<cr>
nnoremap <leader>rcpc :RConvertPostConditional<cr>
nnoremap <leader>rel  :RExtractLet<cr>
vnoremap <leader>rec  :RExtractConstant<cr>
vnoremap <leader>relv :RExtractLocalVariable<cr>
nnoremap <leader>rit  :RInlineTemp<cr>
vnoremap <leader>rrlv :RRenameLocalVariable<cr>
vnoremap <leader>rriv :RRenameInstanceVariable<cr>
vnoremap <leader>rem  :RExtractMethod<cr>


"*****************************************************************************
"*****************************************************************************

"" Include user's local vim config
if filereadable(expand("~/.config/nvimrc.local"))
  source ~/.config/nvimrc.local
endif

"*****************************************************************************
"" Convenience variables
"*****************************************************************************

" vim-airline
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

if !exists('g:airline_powerline_fonts')
  let g:airline#extensions#tabline#left_sep = ' '
  let g:airline#extensions#tabline#left_alt_sep = '|'
  let g:airline_left_sep          = '▶'
  let g:airline_left_alt_sep      = '»'
  let g:airline_right_sep         = '◀'
  let g:airline_right_alt_sep     = '«'
  let g:airline#extensions#branch#prefix     = '⤴' "➔, ➥, ⎇
  let g:airline#extensions#readonly#symbol   = '⊘'
  let g:airline#extensions#linecolumn#prefix = '¶'
  let g:airline#extensions#paste#symbol      = 'ρ'
  let g:airline_symbols.linenr    = '␊'
  let g:airline_symbols.branch    = '⎇'
  let g:airline_symbols.paste     = 'ρ'
  let g:airline_symbols.paste     = 'Þ'
  let g:airline_symbols.paste     = '∥'
  let g:airline_symbols.whitespace = 'Ξ'
else
  let g:airline#extensions#tabline#left_sep = ''
  let g:airline#extensions#tabline#left_alt_sep = ''

  " powerline symbols
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.linenr = ''
endif

set t_Co=16
syntax enable                   "Use syntax highlighting
let g:airline#extensions#tabline#enabled = 1

"" set default identation
set tabstop=4
set shiftwidth=4
set expandtab
set laststatus=2

"" set shortcut for open Nerdtree
map <C-n> :NERDTreeToggle<CR>

"" Turn-on dracula color scheme
syntax on
color dracula

"" ctrlP key for ctrlP plugin
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

"" Make Nerdtree show .files by default
let NERDTreeShowHidden=1

```

Now launch neovim and run `:PlugInstall` which should install the plugings listed in the `init.vim` file located in the `nvim` dir.

## A word on lint

To use the autolint functionality available through the `ale` plugin you need to have `pylint` installed and have it in your path. Should be something like:

```
python -m pip install --user pylint
# pylint located -> C:\Users\<username>\programs\python-3.6.0\Scripts\;
```
also see https://nicedoc.io/w0rp/ale  for detailed instruction into use of ALE   





## References

https://medium.com/@hanspinckaers/setting-up-vim-as-an-ide-for-python-773722142d1d  
https://thoughtbot.com/blog/my-life-with-neovim  
https://nicedoc.io/w0rp/ale  
