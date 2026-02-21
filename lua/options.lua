-- numbered lines with relative numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- change screen splitting behaviour
vim.opt.splitbelow = true
vim.opt.splitright = true

-- disable line wrapping
vim.opt.wrap = false

-- tab behaviour
vim.opt.expandtab = true
vim.opt.tabstop = 4

-- When indenting via >> or dedenting with << use 4 tabs
vim.opt.shiftwidth = 4

-- clipboard synchronization
vim.opt.clipboard = "unnamedplus"

-- centralize scroller
vim.opt.scrolloff = 999

-- allow visual block mode to where no characters are 
vim.opt.virtualedit = "block"

-- Shows all changes you've made in a split at bottom
vim.opt.inccommand = "split"

-- ignore lower / upper case distinction in commands
vim.opt.ignorecase = true

-- use terminal colors
vim.opt.termguicolors = true

-- define <Leader> key
vim.g.mapleader = " "

-- turn on program diagnostics from lsp
vim.diagnostic.config({
    virtual_lines = true,
})
vim.keymap.set("n", "<leader>cd", vim.cmd.Ex, { desc = "Go to project root." })

