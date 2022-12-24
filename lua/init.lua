local map = require("utils").map
-- i - insert mode
-- n - all modes
-- v - visual and select mode
-- x - visual mode

-- No highlight search
map("n", "<Esc>", ":noh<CR><Esc>")
-- Exit insert mode 
map("i", "jk", "<Esc>")
map("i", "kj", "<Esc>")
-- Paste from the clipboard
map("n", "<Leader>p", "\"*p") 
-- Open NERDTree
map("n", "<C-b>", ":NERDTree %<CR>")
-- File search
map("n", "<C-p>", ":Files<CR>")
-- Format document
map("", "<Leader>f", ":CocCommand prettier.forceFormatDocument<CR>") 
-- Move lines up and down
map("n", "<A-j>", ":m .+1<CR>")
map("n", "<A-k>", ":m .-2<CR>")
map("v", "<A-j>", ":m '>+1<CR>gv=gv")
map("v", "<A-k>", ":m '<-2<CR>gv=gv")
-- Occasion search
map("n", "<C-f>", ":Rg<CR>")
-- Comment out selected or a line
map("", "<C-_>", "<Plug>NERDCommenterToggle", { noremap = false, silent = true }) 
-- Show hover tip
map("n", "K", ":call CocAction('doHover')<CR>", { noremap = false, silent = true})
-- Go to definition
map("n", "gd", "<Plug>(coc-definition)", { noremap = false, silent = true})
-- Jump up and down to error
map("n", "g[", "<Plug>(coc-diagnostic-prev)", { noremap = false, silent = true})
map("n", "g]", "<Plug>(coc-diagnostic-next)", { noremap = false, silent = true})
-- Run error diagnosics
-- TODO: make better mapping
map("n", "<Leader>d", "d :<C-u>CocList diagnostics<CR>", { noremap = false, silent = true})
-- Code action
map("n", "<C-Space>", "<Plug>(coc-codeaction)", { noremap = false, silent = true})
-- Save file
map("", "<C-s>", ":w <CR>")
-- Close file
map("", "<Leader>q", ":q <CR>")

-- Copy relative path (relative to where the buffer was open)
map("", "<Leader>c", ":let @+=expand('%') <CR>") 
-- Copy full path 
map("", "<Leader>a", ":let @+=expand('%:p') <CR>") 
-- Copy filename
map("", "<Leader>n", ":let @+=expand('%:t') <CR>") 

-- Tabs
map("n", "<C-l>h", ":tabr<CR>")
map("n", "<C-l>l", ":tabl<CR>")
map("n", "<C-l>j", ":tabp<CR>")
map("n", "<C-n>", ":tabn<CR>")
map("n", "<C-t>", ":tabnew<CR>")
map("n", "<C-x>", ":tabc<CR>")

-- Insert semicolon in the end of line
map("i", "<A-;>", "<C-o>A;")

-- Add newline
-- map("", "<Leader>o", "o<Esc>")
-- map("", "<Leader>O", "O<Esc>")
map("n", "<CR>", "o<C-[>")
map("n", "<Leader>O", "o<C-[>")

-- Visually select all lines
map("n", "<C-a>", "ggVG")
