local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = {
	[[                               __]],
	[[  ___     ___    ___   __  __ /\_\    ___ ___]],
	[[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\]],
	[[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \]],
	[[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
	[[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
	[[]],
	[[]],
    [[                      Meow! 🐈]],
	[[]],
	[[]],
}

dashboard.section.buttons.val = {
	dashboard.button(":e", "  New file", "<cmd>ene <CR>"),
	dashboard.button("SPC f f", "󰈞  Find file"),
	dashboard.button(":browse oldfiles", "󰊄  Recently opened files", "<cmd>bro old<CR>"),
	-- dashboard.button("SPC f r", "  Frecency/MRU"),
	dashboard.button("SPC f s", "󰈬  Find word"),
	-- dashboard.button("SPC f m", "  Jump to bookmarks"),
	dashboard.button(":source ./session.vim", "  Open last session", "<cmd>source ./session.vim<CR>"),
}

local function get_table_size(t)
  local count = 0
  for _, __ in pairs(t) do
    count = count + 1
  end
  return count
end
local opt, start = require('packer.plugin_utils').list_installed_plugins()
local plugins = get_table_size(opt) + get_table_size(start)

-- local plugins = #vim.tbl_keys(require("lazy").plugins())
local v = vim.version()
local datetime = os.date " %d-%m-%Y   %H:%M:%S"
local platform = vim.fn.has "win32" == 1 and "" or ""

dashboard.section.footer.val = {
    "",
    "",
    "  󰂖 "..plugins.." Plugins | "..platform.." | "..v.major.."."..v.minor.."."..v.patch.." | "..datetime
}

alpha.setup(dashboard.config)
