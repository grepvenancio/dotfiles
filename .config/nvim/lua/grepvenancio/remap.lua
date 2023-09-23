vim.g.mapleader = " "
-- Move linha
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- Controlar buffer 
vim.api.nvim_set_keymap('n', '<C-n>', ':bnext<CR>', { noremap = true,  silent = true})
vim.api.nvim_set_keymap('n', '<C-b>', ':bprev<CR>', { noremap = true,  silent = true})
-- Splitar janela
vim.api.nvim_set_keymap('n', '<Leader>vs', ':vsplit<CR>', { noremap = true,  silent = true})
vim.api.nvim_set_keymap('n', '<Leader>hs', ':split<CR>', { noremap = true,  silent = true})
-- File tree
vim.api.nvim_set_keymap('n', '<leader>pv', ':NvimTreeToggle<cr>', { noremap = true, silent = true })
