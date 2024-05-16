-- disallow the mouse
vim.opt.mouse = ""
-- make the leader menue appear earlier
vim.opt.timeoutlen = 100
-- convert tabs to spaces
vim.opt.expandtab = true
-- the number of spaces inserted for each indentation
vim.opt.shiftwidth = 4
-- insert 4 spaces for a tab
vim.opt.tabstop = 4
-- set number column width to 3 {default 4}
vim.opt.numberwidth = 3
vim.opt.wrap = true
vim.opt.relativenumber = true

-- extra file types
vim.filetype.add({
    extension = {
        mima = "asm"
    }
})

-- force spaces after formatting (mostly for golang)
lvim.format_on_save = false
lvim.autocommands = {
    {
        -- see `:h autocmd-events`
        "BufWrite",
        {
            pattern = { "*" },
            callback = function()
                require("lvim.lsp.utils").format({})
                vim.cmd("retab")
            end
        },
    },
}

-- general
lvim.colorscheme = "lunar"

-- keymappings
lvim.leader = "space"
-- buffer cycling
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

-- spelling
-- you might have to download from https://ftp.nluug.nl/pub/vim/runtime/spell/de.utf-8.spl into https://neovim.io/doc/user/options.html#'runtimepath'
lvim.builtin.which_key.mappings["r"] = { "<cmd>set invspell<CR>", "Toggle Spell" }
lvim.builtin.which_key.mappings["R"] = { "<cmd>set spelllang=de<CR>", "German Spell" }

-- sorting
lvim.builtin.which_key.vmappings["r"] = {
    name = "Sorting",
    s = { ":'<, '>sort<CR>", ":sort" },
    d = { ":'<, '>sort!<CR>", ":sort!" },
    n = { ":'<, '>sort n<CR>", ":sort n" },
    f = { ":'<, '>sort! n<CR>", ":sort! n" },
    u = { ":'<, '>sort u<CR>", ":sort u" },
}

-- base64
lvim.builtin.which_key.vmappings["6"] = {
    name = "b64",
    d = { ":'<,'>!base64 -d<CR>", "Decode b64" },
    e = { ":'<,'>!base64<CR>", "Encode b64" },
}
-- base32
lvim.builtin.which_key.vmappings["3"] = {
    name = "b32",
    d = { ":'<,'>!base32 -d<CR>", "Decode b32" },
    e = { ":'<,'>!base32<CR>", "Encode b32" },
}

-- hexdump
lvim.builtin.which_key.vmappings["h"] = { ":'<,'>!hexdump<CR>", "Hexdump" }

-- hex editor
lvim.builtin.which_key.mappings["a"] = {
    name = "Hex Edit",
    o = { ":%!xxd<CR>:set ft=xxd<CR>", "Open" },
    c = { ":%!xxd -r<CR>:set ft&<CR>", "Close" },
}

-- light colourscheme switcher
lvim.builtin.which_key.mappings["s"]["s"] = { ":colorscheme zellner<CR>", "Light Mode" }

-- plugins
lvim.builtin.autopairs.active = false
lvim.builtin.terminal.active = false

-- don't select anything before hitting <Tab> for the first time (mostly for golang)
local cmp = require "cmp"
lvim.builtin.cmp.preselect = cmp.PreselectMode.None
