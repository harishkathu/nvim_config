local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)

-- Save File --
keymap("n", "<leader>w", ":w<CR>", opts)
keymap("n", "<leader>wa", ":wa<CR>", opts)
keymap("n", "<leader>wqa", ":wqa<CR>", opts)
keymap("n", "<leader>wq", ":wq<CR>", opts)
keymap("n", "<leader>q", ":q<CR>", opts)
keymap("n", "<leader>fq", ":q!<CR>", opts)

-- Insert empty line without entering insert mode
--keymap('n', '<leader>o', ':<C-u>call append(line("."), repeat([""], v:count1))<CR>', opts)
--keymap('n', '<leader>O', ':<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>', opts)

-- Keep search in the middle
keymap('n', 'n', 'nzzzv', opts)
keymap('n', 'N', 'Nzzzv', opts)

-- Yamk into clipboard
keymap('n', '<leader>y', [["+y]], opts)
keymap('v', '<leader>y', [["+y]], opts)
keymap('n', '<leader>Y', [["+Y]], opts)

-- Yamk into clipboard
keymap('n', '<leader>p', [["+p]], opts)
keymap('v', '<leader>p', [["+p]], opts)
keymap('n', '<leader>P', [["+P]], opts)

-- find and replace curr word
keymap('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], opts)

-- source file
keymap('n', '<leader><leader>', '<cmd>so<CR>', opts)

-- QuickFix list nav
--keymap("n", "<leader>K", "<cmd>cnext<CR>zz", opts)
--keymap("n", "<leader>J", "<cmd>cprev<CR>zz", opts)
--keymap("n", "<leader>k", "<cmd>lnext<CR>zz", opts)
--keymap("n", "<leader>j", "<cmd>lprev<CR>zz", opts)

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<leader>bd", ":bdelete<CR>", opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("n", "<A-j>", ":m .+1<CR>==", opts)
keymap("n", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
