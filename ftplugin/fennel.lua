local map = require("utils").map

-- Format document
map("", "<Leader>f", ":execute '!fnlfmt --fix ' . expand('%:t') | <CR> | <CR>") 
