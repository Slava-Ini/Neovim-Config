-- i - insert mode
-- n - all modes
-- v - visual and select mode
-- x - visual mode
local map = require("utils").map

-- Undo tree
map("n", "<Leader>u", ":UndotreeToggle<CR>")
-- Harpoon
map("n", "<Leader>e", ":lua require('harpoon.ui').toggle_quick_menu()<CR>")
map("n", "<Leader>a", ":lua require('harpoon.mark').add_file()<CR>")
-- Markdown preview
map("n", "<Leader>m", ":CocCommand markdown-preview-enhanced.openPreview<CR>")
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
-- Search and replace
map("n", "<Leader>s", ":%s//ci<Left><Left><Left>")
map("n", "<Leader>S", ":%s//i<Left><Left>")
-- Comment out selected or a line
map("", "<C-_>", "<Plug>NERDCommenterToggle", { noremap = false, silent = true }) 
-- Show hover tip
map("n", "K", ":call CocAction('doHover')<CR>", { noremap = false, silent = true})
-- Go to definition
map("n", "gd", "<Plug>(coc-definition)", { noremap = false, silent = true})
map("n", "gv", ":call CocAction('jumpDefinition', 'vsplit')<CR>", { noremap = false, silent = true})
map("n", "gh", ":call CocAction('jumpDefinition', 'split')<CR>", { noremap = false, silent = true})
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
map("", "<Leader>C", ":let @+=expand('%:p') <CR>") 
-- Copy filename
map("", "<Leader>n", ":let @+=expand('%:t') <CR>") 

-- Tabs
map("n", "<C-l>h", ":tabr<CR>")
map("n", "<C-l>l", ":tabl<CR>")
map("n", "<C-l>j", ":tabp<CR>")
map("n", "<C-n>", ":tabn<CR>")
map("n", "<C-t>", ":tabnew<CR>")
map("n", "<C-x>", ":tabc<CR>")

-- Resize
map("n", "<C-Up>", ":resize +5<CR>")
map("n", "<C-Down>", ":resize -5<CR>")
map("n", "<C-Left>", ":vertical resize +5<CR>")
map("n", "<C-Right>", ":vertical resize -5<CR>")

-- Insert semicolon in the end of line
map("i", "<A-;>", "<C-o>A;")

-- Add newline
map("n", "<CR>", "o<C-[>")
map("n", "<Leader>O", "o<C-[>")

-- Visually select all lines
map("n", "<C-a>", "ggVG")

-- Leap Nvim + Config
map("n", "s", "<Plug>(leap-forward-to)")
map("n", "S", "<Plug>(leap-backward-to)")
map("n", "<Leader>g", "<Plug>(leap-from-window)")
-- TODO: figure out how to make shorcut for repeat
-- require("leap").opts.special_keys.repeat_search = "<Leader>s"
-- require('leap').leap { opts = { labels = {} } }
-- map("n", "<Leader>s", ":LeapRepeat<CR>")
