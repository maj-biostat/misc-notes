# Neovim (on windows)

Back to (README.md)[README.md].

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
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('C:\Users\<username>\AppData\Local\nvim\plugged')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-master branch
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Unmanaged plugin (manually installed and updated)
Plug '~/my-prototype-plugin'

" Initialize plugin system
call plug#end()
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








