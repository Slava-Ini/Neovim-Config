local M = {}

-- mode -> normal/insert ("n"/"i")
-- lhs  -> custom keybinds
-- rhs  -> existing keybinds to be overwritten
-- opts -> additional options like <silent>/<noremap>

function M.map(mode, lhs, rhs, opts)
    -- default options
    local options = { noremap = true }

    if opts then
        options = vim.tbl_extend("force", options, opts)
    end

    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

return M
