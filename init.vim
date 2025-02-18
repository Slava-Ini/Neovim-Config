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
" Hide CMD when inactive
set cmdheight=0
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
" Requires `sudo apt install clang-format`
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
  Plug 'sainnhe/everforest'
  " Neovim Leap
  Plug 'ggandor/leap.nvim'
  " Fennel configuration
  " Plug 'Olical/conjure'
  " Plug 'Olical/nvim-local-fennel'
  " Plug 'Olical/aniseed'
  " C++ formatter
  Plug 'rhysd/vim-clang-format'
  " Display overloads on lsp hover
  Plug 'Issafalcon/lsp-overloads.nvim'
  " Markdown Preview
  " Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }
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

if has('termguicolors')
  set termguicolors
endif

" set t_Co=256
" highlight Normal ctermbg=NONE
" highlight nonText ctermbg=NONE

set background=dark
syntax on
let g:everforest_background = 'hard'
colorscheme everforest

" Markdown Preview Config
" set to 1, nvim will open the preview window after entering the Markdown buffer
" default: 0
" let g:mkdp_auto_start = 1

" set to 1, the nvim will auto close current preview window when changing
" from Markdown buffer to another buffer
" default: 1
" let g:mkdp_auto_close = 1

" set to 1, Vim will refresh Markdown when saving the buffer or
" when leaving insert mode. Default 0 is auto-refresh Markdown as you edit or
" move the cursor
" default: 0
" let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be used for all files,
" by default it can be use in Markdown files only
" default: 0
" let g:mkdp_command_for_global = 0

" set to 1, the preview server is available to others in your network.
" By default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page.
" Useful when you work in remote Vim and preview on local browser.
" For more details see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" for path with space
" valid: `/path/with\ space/xxx`
" invalid: `/path/with\\ space/xxx`
" default: ''
let g:mkdp_browser = '/usr/bin/google-chrome'

" set to 1, echo preview page URL in command line when opening preview page
" default is 0
let g:mkdp_echo_preview_url = 1

" a custom Vim function name to open preview page
" this function will receive URL as param
" default is empty
let g:mkdp_browserfunc = ''

" options for Markdown rendering
" mkit: markdown-it options for rendering
" katex: KaTeX options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: whether to disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: means the cursor position is always at the middle of the preview page
"   top: means the Vim top viewport always shows up at the top of the preview page
"   relative: means the cursor position is always at relative positon of the preview page
" hide_yaml_meta: whether to hide YAML metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
" content_editable: if enable content editable for preview page, default: v:false
" disable_filename: if disable filename header for preview page, default: 0
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0,
    \ 'toc': {}
    \ }


" use a custom Markdown style. Must be an absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = ''

" use a custom highlight style. Must be an absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = ''

" use a custom port to start server or empty for random
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'

" use a custom location for images
let g:mkdp_images_path = "/home/user/.markdown_images"

" recognized filetypes
" these filetypes will have MarkdownPreview... commands
let g:mkdp_filetypes = ['markdown']

" set default theme (dark or light)
" By default the theme is defined according to the preferences of the system
let g:mkdp_theme = 'dark'

" combine preview window
" default: 0
" if enable it will reuse previous opened preview window when you preview markdown file.
" ensure to set let g:mkdp_auto_close = 0 if you have enable this option
let g:mkdp_combine_preview = 0

" auto refetch combine preview contents when change markdown buffer
" only when g:mkdp_combine_preview is 1
let g:mkdp_combine_preview_auto_refresh = 1
