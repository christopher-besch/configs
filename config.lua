vim.opt.backup = false                     -- creates a backup file
vim.opt.clipboard = "unnamedplus"          -- allows neovim to access the system clipboard
vim.opt.cmdheight = 1                      -- more space in the neovim command line for displaying messages
vim.opt.colorcolumn = "99999"              -- fixes indentline for now
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.conceallevel = 0                   -- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8"             -- the encoding written to a file
vim.opt.foldmethod = "manual"              -- folding set to "expr" for treesitter based folding
vim.opt.foldexpr = ""                      -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
vim.opt.guifont = "monospace:h17"          -- the font used in graphical neovim applications
vim.opt.hidden = true                      -- required to keep multiple buffers and open multiple buffers
vim.opt.hlsearch = true                    -- highlight all matches on previous search pattern
vim.opt.ignorecase = true                  -- ignore case in search patterns
vim.opt.mouse = ""                         -- allow the mouse to be used in neovim
vim.opt.pumheight = 10                     -- pop up menu height
vim.opt.showmode = false                   -- we don't need to see things like -- INSERT -- anymore
vim.opt.showtabline = 2                    -- always show tabs
vim.opt.smartcase = true                   -- smart case
vim.opt.smartindent = true                 -- make indenting smarter again
vim.opt.splitbelow = true                  -- force all horizontal splits to go below current window
vim.opt.splitright = true                  -- force all vertical splits to go to the right of current window
vim.opt.swapfile = false                   -- creates a swapfile
vim.opt.termguicolors = true               -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 100                   -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.title = true                       -- set the title of window to the value of the titlestring
vim.opt.titlestring = "%<%F%=%l/%L - nvim" -- what the title of the window will be set to
vim.opt.undodir = vim.fn.stdpath "cache" .. "/undo"
vim.opt.undofile = true                    -- enable persistent undo
vim.opt.updatetime = 300                   -- faster completion
vim.opt.writebackup = false                -- if a file is being edited by another program (or was written to file while editing with another program) it is not allowed to be edited
vim.opt.expandtab = true                   -- convert tabs to spaces
vim.opt.shiftwidth = 4                     -- the number of spaces inserted for each indentation
vim.opt.tabstop = 4                        -- insert 4 spaces for a tab
vim.opt.cursorline = true                  -- highlight the current line
vim.opt.number = true                      -- set numbered lines
vim.opt.relativenumber = true              -- set relative numbered lines
vim.opt.numberwidth = 4                    -- set number column width to 2 {default 4}
vim.opt.signcolumn = "yes"                 -- always show the sign column otherwise it would shift the text each time
vim.opt.wrap = true                        -- wrap
vim.opt.spell = false
vim.opt.spelllang = "en"
vim.opt.scrolloff = 8 -- is one of my fav
vim.opt.sidescrolloff = 8

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
lvim.log.level = "error"
lvim.colorscheme = "tokyonight-night"

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

-- spelling
-- you might have to download from https://ftp.nluug.nl/pub/vim/runtime/spell/de.utf-8.spl into https://neovim.io/doc/user/options.html#'runtimepath'
lvim.builtin.which_key.mappings["r"] = { "<cmd>set invspell<CR>", "Toggle Spell" }
lvim.builtin.which_key.mappings["R"] = { "<cmd>set spelllang=de<CR>", "German Spell" }

-- hex editor
lvim.builtin.which_key.mappings["a"] = {
    name = "Hex Edit",
    o = { ":%!xxd<CR>:set ft=xxd<CR>", "Open" },
    c = { ":%!xxd -r<CR>:set ft&<CR>", "Close" },
}

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
lvim.builtin.which_key.vmappings["b"] = {
    name = "b64",
    d = { ":'<,'>!base64 -d<CR>", "Decode b64" },
    e = { ":'<,'>!base64 -e<CR>", "Encode b64" },
}

-- light colourscheme switcher
lvim.builtin.which_key.mappings["s"]["s"] = { ":colorscheme zellner<CR>", "Light Mode" }

-- plugins
lvim.builtin.autopairs.active = false
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = false
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true
lvim.builtin.project.patterns = { ".git" }

-- don't select anything before hitting <Tab> for the first time (mostly for golang)
local cmp = require "cmp"
lvim.builtin.cmp.preselect = cmp.PreselectMode.None

lvim.builtin.treesitter.ensure_installed = {
    "bash",
    "c",
    "javascript",
    "json",
    "lua",
    "python",
    "typescript",
    "tsx",
    "css",
    "rust",
    "java",
    "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true
