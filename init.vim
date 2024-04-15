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
" Commentaries at the beginning of lines
let g:NERDDefaultAlign = 'left'
let g:NERDSpaceDelims = 1
" Temporal all comments are jsx-like for nerdcommenter while I'm fixing the
" issue
let g:NERDCustomDelimiters = { 'typescriptreact': { 'left': '{/*', 'right': '*/}' } , 'javascriptreact': { 'left': '{/*', 'right': '*/}' }}


" Set up C++ formatter
let g:clang_format#style_options = {
            \ "AccessModifierOffset" : -4,
            \ "AllowShortIfStatementsOnASingleLine" : "true",
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "Standard" : "C++11",
            \ "BreakBeforeBraces" : "Stroustrup"}


" Encoding for vim-devicons
set encoding=UTF-8

" Shows relative numbers only in navigation mode
" TODO: make a lua function for it
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
:  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
:augroup END

" NERDTree show line numbers
:let g:NERDTreeShowLineNumbers=1
:autocmd BufEnter NERD_* setlocal rnu

"Conjure fennel stdio
let g:conjure#filetype#fennel = "conjure.client.fennel.stdio"
let g:conjure#mapping#doc_word = v:false

call plug#begin()
  " Undo tree
  Plug 'mbbill/undotree'
  " Harpoon
  Plug 'nvim-lua/plenary.nvim' 
  Plug 'ThePrimeagen/harpoon'
  " Debugger
  Plug 'mfussenegger/nvim-dap'
  " Copilot
  Plug 'github/copilot.vim'
  " Spelling
  Plug 'kamykn/popup-menu.nvim'
  Plug 'kamykn/spelunker.vim'
  " Coc server
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  " Comments
  Plug 'scrooloose/nerdcommenter'     
  " Fuzzy finder
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  " File tree - tree, git changes
  Plug 'preservim/nerdtree'
  Plug 'xuyuanp/nerdtree-git-plugin' 
  " Git
  Plug 'tpope/vim-fugitive'
  " Change and put surrounding pairs
  Plug 'tpope/vim-surround'
  " Disable temporaly (comments), people on github say this may work with jsx
  " out of the box and it does but not with tsx
  " Plug 'tomtom/tcomment_vim'
  " Next 3 plugins from video https://www.youtube.com/watch?v=aH50njzReXQ
  Plug 'numToStr/Comment.nvim'
  " Improve syntax highlight (For nightly version, check out later for more
  " info, should provide better syntax highlight for at least TS and lua)
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'JoosepAlviste/nvim-ts-context-commentstring'
  " Treesitter context
  Plug 'nvim-treesitter/nvim-treesitter-context'
  " Auto pairs and indent
  Plug 'jiangmiao/auto-pairs'
  " Fish syntax highligh
  Plug 'dag/vim-fish'
  " Rust
  Plug 'rust-lang/rust.vim'
  " Go
  Plug 'darrikonn/vim-gofmt', { 'do': ':GoUpdateBinaries' }
  " Themes
  Plug 'morhetz/gruvbox'
  Plug 'Mofiqul/vscode.nvim'
  Plug 'olimorris/onedarkpro.nvim'
  Plug 'rebelot/kanagawa.nvim'
  Plug 'NLKNguyen/papercolor-theme'
  Plug 'junegunn/seoul256.vim'
  " Neovim Leap
  Plug 'ggandor/leap.nvim'
  " Fennel configuration
  Plug 'Olical/conjure'
  Plug 'Olical/nvim-local-fennel'
  Plug 'Olical/aniseed'
  " C++ formatter
  Plug 'rhysd/vim-clang-format'
call plug#end()

lua << EOF
require("Comment").setup {
    pre_hook = function(ctx)
        -- Only calculate commentstring for tsx filetypes
        if vim.bo.filetype == 'typescriptreact' then
            local U = require('Comment.utils')

            -- Determine whether to use linewise or blockwise commentstring
            local type = ctx.ctype == U.ctype.linewise and '__default' or '__multiline'

            -- Determine the location where to calculate commentstring from
            local location = nil
            if ctx.ctype == U.ctype.blockwise then
                location = require('ts_context_commentstring.utils').get_cursor_location()
            elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
                location = require('ts_context_commentstring.utils').get_visual_start_location()
            end

            return require('ts_context_commentstring.internal').calculate_commentstring({
                key = type,
                location = location,
            })
        end
    end,
}
EOF

" For 'vim-treesitter/nvim-treesitter'
lua << EOF
require('nvim-treesitter.configs').setup {
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
    }
  }
EOF

" Set terminal colors
set t_Co=256
syntax on

" Change theme depending on time
" if strftime("%H") < 11  
"   colorscheme kanagawa 
"   set background=light
" else
  colorscheme gruvbox 
" endif


