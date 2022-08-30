lua require('init')

" Cursor doesn't stick to top or bottom but stays away from it for 'n' lines
set scrolloff=4
" Shows file type at the bottom
set filetype=on
" Shows line numbers
set number
" Allows to copy and paste directly to clipboard using yank and paste
set clipboard=unnamedplus
" Shows number of lines relative to current line
set relativenumber
" Makes tabs into spaces
set expandtab
" Makes one tab width to be 2 space
set shiftwidth=2
set splitbelow
" Makes search in files not include filename itself
" TODO: make a lua function for it
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
" Commentaries at the beggining of lines
let g:NERDDefaultAlign = 'left'
let g:NERDSpaceDelims = 1
" Encoding for vim-devicons
set encoding=UTF-8
" Shows relative numbers only in navigation mode
" TODO: make a lua function for it
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
:  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
:augroup END

call plug#begin()
  " Coc server
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  " Comments
  Plug 'scrooloose/nerdcommenter'     
  " Fuzzy finder
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  " File tree - tree, git changes, icons
  Plug 'preservim/nerdtree'
  Plug 'xuyuanp/nerdtree-git-plugin' 
  " Plug 'ryanoasis/vim-devicons'
  " Git
  Plug 'tpope/vim-fugitive'
  " Change and put surrounding pairs
  Plug 'tpope/vim-surround'
  " Auto pairs and indent
  Plug 'jiangmiao/auto-pairs'
  " Fish syntax highligh
  Plug 'dag/vim-fish'
  " Rust
  Plug 'rust-lang/rust.vim'
  " Themes
  Plug 'morhetz/gruvbox'
  Plug 'Mofiqul/vscode.nvim'
call plug#end()

set t_Co=256
syntax on
colorscheme gruvbox
