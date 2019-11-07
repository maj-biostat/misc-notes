# Neovim (on windows)

Back to [README](README.md) .

Giving this a go, see:

https://medium.com/@hanspinckaers/setting-up-vim-as-an-ide-for-python-773722142d1d
https://thoughtbot.com/blog/my-life-with-neovim

## Install Neovim

1. Go to https://github.com/neovim/neovim/wiki/Installing-Neovim, then stable releases then grab the `nvim-win64.zip` file and download to your downloads dir.
2. Extract the zip file and move the whole directory structure to where you keep your program files
3. Run `nvim-qt.exe` to test things out. This should load neovim after a warning.
4. Close down neovim.
5. Create `C:\Users\<username>\AppData\Local\nvim`

## Install plugin manager

1. Create `autoload` dir under `C:\Users\<username>\AppData\Local\nvim` 
2. Create `plugged` dir under `C:\Users\<username>\AppData\Local\nvim` 
3. Create `init.vim` file under `C:\Users\<username>\AppData\Local\nvim`
4. Download https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim into you `C:\Users\<username>\AppData\Local\nvim\autoload`
5. Drop the following (boilerplate) content into the `init.vim` file.

```

" Plugins and config

" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('C:\Users\<username>\.config\nvim\plugged')

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


Plug 'jonathanfilip/vim-lucius'                  " nice white colortheme

" customish for python

Plug 'jonathanfilip/vim-lucius'

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

Plug 'Vimjas/vim-python-pep8-indent'  "better indenting for python
Plug 'w0rp/ale'  " python linters
Plug 'airblade/vim-gitgutter'  " show git changes to files in gutter

" Initialize plugin system
call plug#end()


filetype indent on

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
set undodir='C:\Users\mjones\.vim\undodir'
set undofile  " save undos
set undolevels=1000  " maximum number of changes that can be undone
set undoreload=1000  " maximum number lines to save for undo on a buffer reload
set laststatus=2  " alwa
set splitright  " i prefer splitting right and below
set splitbelow
set hlsearch  " highlight search and search while typing
set incsearch


" easy split movement
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l


" colorscheme options
let g:lucius_style="dark"
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
let g:airline_powerline_fonts = 1
let g:airline_section_y = ""
let g:airline#extensions#tabline#enabled = 1
let g:airline_section_error = ""
let g:airline_section_warning = ""

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" ale options
let g:ale_python_flake8_options = '--ignore=E129,E501,E302,E265,E241,E305,E402,W503'
let g:ale_python_pylint_options = '-j 0 --max-line-length=120'
let g:ale_list_window_size = 4
let g:ale_sign_column_always = 0
let g:ale_open_list = 1
let g:ale_keep_list_window_open = '1'

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







```

Now launch neovim and run `:PlugInstall` which should install the plugings listed in the `init.vim` file located in the `nvim` dir.

## Install NCM2

Autocomplete. Follow the instructions here.

https://github.com/ncm2/ncm2

## Jedi

An autocomplete for python https://github.com/davidhalter/jedi

`pip install --user jedi`

## Jedi-vim

Note that further instructions available through `:help jedi-vim`  j

Enables the above in neovim. First you have to install another plugin manager (pain). 

```
git clone --recursive https://github.com/davidhalter/jedi-vim.git ~/.vim/bundle/jedi-vim
git clone https://github.com/VundleVim/Vundle.vim.git C:\Users\<user>\AppData\Local\nvim\bundle
```

Add the following into the `init.vim` file:

```
set rtp+=C:\Users\mjones\AppData\Local\nvim\bundle\Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'davidhalter/jedi-vim'
call vundle#end()
```

Finally, startup neovim and run `:PluginInstall` 


## Tagbar and FlyGrep

Tagbar for a nice overview of tags in the file. FlyGrep for project-wide search.

Simply add the following into `init.vim` and then restart neovim and run `:PlugInstall`. See https://github.com/wsdjeg/FlyGrep.vim  and https://github.com/majutsushi/tagbar.

```
Plug 'wsdjeg/FlyGrep.vim'
Plug 'majutsushi/tagbar'
```

## Others

+ Ctrlp for fuzzy file finding.  
+ Commentary for commenting.  
+ Airline for a fancy statusline.  
+ Lucius (light) pretty black-on-white colortheme.  
+ Iosevka Term Medium a programmable typeface.  

```
Plug 'wsdjeg/FlyGrep.vim'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-commentary'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-airline/vim-airline'
```

(not VIM related: I use pudb as debugger)


