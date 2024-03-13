local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
augroup packer_user_config
autocmd!
autocmd BufWritePost packer.lua source <afile> | PackerSafeUpdate
augroup end
]])

local last_snapshot = vim.fn.stdpath("data") .. "/last-snapshot-date"

vim.api.nvim_create_user_command("PackerSafeUpdate", function()
	local packer = require("packer")
	local name = vim.fn.strftime("%Y-%m-%dT%H_%M_%S")

	packer.snapshot(name)
	vim.fn.writefile({ name }, last_snapshot)

	local timer = vim.loop.new_timer()
	local wait_ms = 1000

	timer:start(wait_ms, 0, function()
		timer:stop()
		timer:close()
		packer.sync()
	end)
end, {})

vim.api.nvim_create_user_command("PackerRestore", function()
	local ok, name = pcall(vim.fn.readfile, last_snapshot, 1)
	if not ok then
		return
	end

	require("packer").rollback(name[1])
end, {})

-- Use a protected call so we don"t error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	vim.notify("Packer not found")
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- Important good to have plugins
	use("wbthomason/packer.nvim") -- Have packer manage itself

	--  These two plugisn are used by a lot of other ones
	use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
	use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins

	-- Alpha nvim (Greeter)
	use({
		"goolord/alpha-nvim",
		-- config = function()
		--     require 'alpha'.setup(require 'alpha.themes.dashboard'.config)
		-- end
	})
	-- Colorscheme
	use({ "catppuccin/nvim", as = "catppuccin" })

	-- Autopairs
	use("windwp/nvim-autopairs")

	-- WhichKey
	use("folke/which-key.nvim")

	-- Comments
	use("numToStr/Comment.nvim")
	use("JoosepAlviste/nvim-ts-context-commentstring") -- Integrated with treesitter setup in treesitter.lua

	-- Bufferline
	use({
		"akinsho/bufferline.nvim",
		tag = "*",
		requires = "nvim-tree/nvim-web-devicons",
		after = "catppuccin",
		config = function()
			require("bufferline").setup({
				highlights = require("catppuccin.groups.integrations.bufferline").get(),
			})
		end,
	})
	use("moll/vim-bbye")

	-- Lualine - Status line
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
	})

	-- GitSigns (https:/github.com/lewis6991/gitsigns.nvim)
	use("lewis6991/gitsigns.nvim")

	-- UFO (code folding)
	use({
		"kevinhwang91/nvim-ufo",
		requires = {
			"kevinhwang91/promise-async",
			{
				"luukvbaal/statuscol.nvim",
				config = function()
					local builtin = require("statuscol.builtin")
					require("statuscol").setup({
						relculright = true,
						segments = {
							{ text = { builtin.foldfunc }, click = "v:lua.ScFa" },
							{ text = { "%s" }, click = "v:lua.ScSa" },
							{ text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
						},
					})
				end,
			},
		},
	})

	-- Nvim Tree (https:/github.com/nvim-tree/nvim-tree.lua)
	use("nvim-tree/nvim-web-devicons")
	use("nvim-tree/nvim-tree.lua")

	-- Telescope
	use("nvim-telescope/telescope.nvim")
    use {
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "make"
    }

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	use("p00f/nvim-ts-rainbow")
	use("nvim-treesitter/playground")

	-- ToggleTerm
	use("akinsho/toggleterm.nvim")

	-- Markdown Preview (requires npn)
	use({
		"iamcco/markdown-preview.nvim",
		run = "cd app && npm install",
		setup = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	})

	-- null-ls
	-- use "jose-elias-alvarez/null-ls.nvim"
	-- We use none-ls instead, this is a fork and community managed
	use({
        "nvimtools/none-ls.nvim",
        lock = true,
    })

	-- Lsp_zero and Nvim-Cmp related
	use({
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		requires = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },
			{ "hrsh7th/cmp-cmdline" },

			-- Snippets
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },

			-- Other things i found
			{ "hrsh7th/cmp-emoji" },
			{ "chrisgrieser/cmp-nerdfont" },
			{ "kdheepak/cmp-latex-symbols" },
		},
	})
	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
