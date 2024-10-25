local wezterm = require "wezterm"

local config = {}

-- Loading the best Theme there is
-- Autimatically switches to Dark and Light themes
-- based on OS settings
local function scheme_for_appearance(appearance)
  if appearance:find "Light" then
    return "Catppuccin Latte"
  else
    return "Catppuccin Mocha"
  end
end

config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())

-- Required Git-Bash
-- or change arg to launch fav terminal as default
config.default_prog = { 'bin/sh.exe' }

-- Required Hack Nerd font 
config.font = wezterm.font_with_fallback {
    'Hack Nerd Font Mono',
}

-- Right-click on '+' to see the lunch menu
config.launch_menu = {
  {
    label = 'Powershell',
  args = { 'powershell.exe' },
  },
  {
    -- Optional label to show in the launcher. If omitted, a label
    -- is derived from the `args`
    label = 'Git-Bash',
    -- The argument array to spawn.  If omitted the default program
    -- will be used as described in the documentation above
    args = { 'bin/sh.exe', '--login' },
    -- You can specify an alternative current working directory;
    -- if you don't specify one then a default based on the OSC 7
    -- escape sequence will be used (see the Shell Integration
    -- docs), falling back to the home directory.
    -- cwd = "/some/path"

    -- You can override environment variables just for this command
    -- by setting this here.  It has the same semantics as the main
    -- set_environment_variables configuration option described above
    -- set_environment_variables = { FOO = "bar" },
  },
}

config.hide_mouse_cursor_when_typing = true

-- Remove the Title bar and enable resizable bars
config.window_decorations = "INTEGRATED_BUTTONS | RESIZE"

config.max_fps = 144
config.animation_fps = 60

-- Must return a map
return config
