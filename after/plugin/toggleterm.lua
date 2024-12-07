local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
	vim.log("Toggleterm not found!")
end

local shell = vim.o.shell
if GET_OS() == "Windows" then
	shell = "powershell.exe"
end

toggleterm.setup({
	-- size can be a number or function which is passed the current terminal
	size = 20,
	open_mapping = [[<C-\>]], -- "<leader>tt",
	hide_numbers = true, -- hide the number column in toggleterm buffers
	shade_filetypes = {},
	autochdir = false, -- when neovim changes it current directory the terminal will change it's own when next it's opened
	shade_terminals = true, -- NOTE: this option takes priority over highlights specified so if you specify Normal highlights you should set this to false
	shading_factor = 2, -- the percentage by which to lighten terminal background, default: -30 (gets multiplied by -3 if background is light)
	start_in_insert = true,
	insert_mappings = true, -- whether or not the open mapping applies in insert mode
	terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
	persist_size = true,
	persist_mode = true, -- if set to true (default) the previous terminal mode will be remembered
	direction = "float", -- 'vertical' | 'horizontal' | 'tab'
	close_on_exit = true, -- close the terminal window when the process exits
	-- Change the default shell. Can be a string or a function returning a string
	shell = shell,
	auto_scroll = true, -- automatically scroll to the bottom on terminal output
	-- This field is only relevant if direction is set to 'float'
	float_opts = {
		-- The border key is *almost* the same as 'nvim_open_win'
		-- see :h nvim_open_win for details on borders however
		-- the 'curved' border is a custom border type
		-- not natively supported but implemented in this plugin.
		border = "curved", -- 'single' | 'double' | 'shadow'
		-- like `size`, width, height, row, and col can be a number or function which is passed the current terminal
		winblend = 0,
		-- highlights = {
		--         border = "Normal",
		--         background = "Normal",
		--     },
	},
})

local opts = { noremap = true }
function _G.set_terminal_keymaps()
	vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
local Terminal = require("toggleterm.terminal").Terminal

if GET_OS() == "Windows" then
	local cmd_terminal = Terminal:new({ cmd = "cmd.exe", hidden = true })
	function _CMD_TERMINAL()
		cmd_terminal:toggle()
	end

	-- Requires C:\Program Files\Git\bin\ in path
	local shell_terminal = Terminal:new({ cmd = '"bash.exe"', hidden = true })
	function _SHELL_TERMINAL()
		shell_terminal:toggle()
	end

    local wsl_terminal = Terminal:new({ cmd = '"wsl"', hidden = true })
	function _WSL_TERMINAL()
		wsl_terminal:toggle()
	end

    vim.api.nvim_set_keymap("n", [[c<C-\>]], ":lua _CMD_TERMINAL()<CR>", opts)
    vim.api.nvim_set_keymap("n", [[s<C-\>]], ":lua _SHELL_TERMINAL()<CR>", opts)
    vim.api.nvim_set_keymap("n", [[w<C-\>]], ":lua _WSL_TERMINAL()<CR>", opts)
end

local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

function _LAZYGIT_TOGGLE()
	lazygit:toggle()
end

local python = Terminal:new({ cmd = "python", hidden = true })

function _PYTHON_TOGGLE()
	python:toggle()
end

vim.api.nvim_set_keymap("n", [[g<C-\>]], ":lua _LAZYGIT_TOGGLE()<CR>", opts)
vim.api.nvim_set_keymap("n", [[p<C-\>]], ":lua _PYTHON_TOGGLE()<CR>", opts)
