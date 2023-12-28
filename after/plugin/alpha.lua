local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = {
	[[                                  __]],
	[[     ___     ___    ___   __  __ /\_\    ___ ___]],
	[[    / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\]],
	[[   /\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \]],
	[[   \ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
	[[    \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
	[[ ]],
	[[ ]],
	[[                    Hey Harish 😃 !!]],
	[[ ]],
	[[ ]],
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

dashboard.section.footer.val = {
    [[ ]],
    [[ ]],
    [[Spent way too much time doing this, and]],
    [[finally I have less distractions]],
    [[... ]],
    [[Hmmm! that's cool let me install that too]],
    [[                                - Meow! 🐈]],
}

alpha.setup(dashboard.config)
