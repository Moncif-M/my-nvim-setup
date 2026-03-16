vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.wrap = false

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.opt.clipboard = "unnamedplus"

vim.opt.scrolloff = 999

vim.opt.virtualedit = "block"

vim.opt.inccommand = "split"

vim.opt.ignorecase = true

vim.opt.termguicolors = true

vim.g.mapleader = " "

vim.diagnostic.config({
    virtual_lines = true,
})

vim.keymap.set("n", "<Leader>d", function ()
    vim.diagnostic.open_float({scope="line"})
end)
vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true })
vim.keymap.set('n', '<C-Up>',    '<C-w>+')
vim.keymap.set('n', '<C-Down>',  '<C-w>-')
vim.keymap.set('n', '<C-Left>',  '<C-w><')
vim.keymap.set('n', '<C-Right>', '<C-w>>')
-- keymap for executing js files
vim.api.nvim_set_keymap(
  'n',
  '<leader>r',
  ':split | terminal node %<CR>',
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  'n',
  '<leader>p',
  ':split | terminal python3 %<CR>',
  { noremap = true, silent = true }
)
