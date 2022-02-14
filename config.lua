vim.opt.backup = false -- creates a backup file
vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
vim.opt.cmdheight = 1 -- more space in the neovim command line for displaying messages
vim.opt.colorcolumn = "99999" -- fixes indentline for now
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.conceallevel = 0 -- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8" -- the encoding written to a file
vim.opt.foldmethod = "manual" -- folding set to "expr" for treesitter based folding
vim.opt.foldexpr = "" -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
vim.opt.guifont = "monospace:h17" -- the font used in graphical neovim applications
vim.opt.hidden = true -- required to keep multiple buffers and open multiple buffers
vim.opt.hlsearch = true -- highlight all matches on previous search pattern
vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.mouse = "" -- allow the mouse to be used in neovim
vim.opt.pumheight = 10 -- pop up menu height
vim.opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
vim.opt.showtabline = 2 -- always show tabs
vim.opt.smartcase = true -- smart case
vim.opt.smartindent = true -- make indenting smarter again
vim.opt.splitbelow = true -- force all horizontal splits to go below current window
vim.opt.splitright = true -- force all vertical splits to go to the right of current window
vim.opt.swapfile = false -- creates a swapfile
vim.opt.termguicolors = true -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 200 -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.title = true -- set the title of window to the value of the titlestring
vim.opt.titlestring = "%<%F%=%l/%L" -- what the title of the window will be set to
-- vim.opt.undodir = CACHE_PATH .. "/undo" -- set an undo directory
vim.opt.undofile = true -- enable persistent undo
vim.opt.updatetime = 300 -- faster completion
vim.opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program) it is not allowed to be edited
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.shiftwidth = 4 -- the number of spaces inserted for each indentation
vim.opt.tabstop = 4 -- insert 2 spaces for a tab
vim.opt.cursorline = true -- highlight the current line
vim.opt.number = true -- set numbered lines
vim.opt.relativenumber = true -- set relative numbered lines
vim.opt.numberwidth = 4 -- set number column width to 2 {default 4}
vim.opt.signcolumn = "yes" -- always show the sign column otherwise it would shift the text each time
vim.opt.wrap = true -- display lines as one long line
vim.opt.spell = false
vim.opt.spelllang = "en"
vim.opt.scrolloff = 8 -- is one of my fav
vim.opt.sidescrolloff = 8

-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "onedarker"

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"

-- disable scrolling
lvim.keys.normal_mode["<up>"] = "<nop>"
lvim.keys.normal_mode["<down>"] = "<nop>"
lvim.keys.insert_mode["<up>"] = "<nop>"
lvim.keys.insert_mode["<down>"] = "<nop>"

-- todo: auto tab completion doesn't work
-- _G.tab_complete = function(dir)
--     if vim.fn.pumvisible() == 1 then
--         if (dir == "F") then
--             return term_codes '<C-n>'
--         elseif (dir == "B") then
--             return term_codes '<C-p>'
--         end
--     else
--         if (dir == "F") then
--             return term_codes '<Tab>'
--         elseif (dir == "B") then
--             return term_codes '<S-Tab>'
--         end
--     end
-- end
-- lvim.keys.insert_mode["<Tab>"] = "v:lua.tab_complete('F')"
-- lvim.keys.insert_mode["<S-Tab>"] = "v:lua.tab_complete('B')"

-- handle spell checking
lvim.builtin.which_key.mappings["r"] = { "<cmd>set invspell<CR>", "Toggle Spell" }
lvim.builtin.which_key.mappings["R"] = { "<cmd>set spelllang=de<CR>", "German Spell" }
-- you might have to download from https://ftp.nluug.nl/pub/vim/runtime/spell/de.utf-8.spl into https://neovim.io/doc/user/options.html#'runtimepath'

-- handle stupid german umlauts
-- todo: partly broken
lvim.builtin.which_key.vmappings["a"] = { "<cmd>'<,'>s/ae/ä/g<CR>", "Replace ae" }
lvim.builtin.which_key.vmappings["o"] = { "<cmd>'<,'>s/oe/ö/g<CR>", "Replace oe" }
lvim.builtin.which_key.vmappings["u"] = { "<cmd>'<,'>s/ue/ü/g<CR>", "Replace ue" }
lvim.builtin.which_key.vmappings["s"] = { "<cmd>'<,'>s/ss/ß/g<CR>", "Replace ss" }
lvim.builtin.which_key.mappings["u"] = { "/ae\\|oe\\|ue\\|ss<CR>", "Find Umlauts" }

-- sorting
lvim.builtin.which_key.vmappings["r"] = {
    name = "Sorting",
    s = { ":'<, '>sort<CR>", ":sort" },
    d = { ":'<, '>sort!<CR>", ":sort!" },
    n = { ":'<, '>sort n<CR>", ":sort n" },
    f = { ":'<, '>sort! n<CR>", ":sort! n" },
    u = { ":'<, '>sort u<CR>", ":sort u" },
}

-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = "maintained"
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- lvim.autocommands.custom_groups = {
--     -- set sensible c++ comments
--     { "BufEnter", "*.cpp,*.h,*.hpp,*.cxx", ':lua vim.api.nvim_buf_set_option(0, "commentstring", "// %s")' },
--     { "BufFilePost", "*.cpp,*.h,*.hpp,*.cxx", ':lua vim.api.nvim_buf_set_option(0, "commentstring", "// %s")' },
-- }

-- plugins
lvim.plugins = {
    {"farmergreg/vim-lastplace"},
}

-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--     { exe = "autopep8" },
--     { exe = "clang_format" },
--     -- { exe = "latexindent" },
-- }
