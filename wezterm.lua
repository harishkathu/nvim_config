local wezterm = require "wezterm"

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

local config = wezterm.config_builder()

print(wezterm.gui.enumerate_gpus())

config = {
    automatically_reload_config = true,

    hide_mouse_cursor_when_typing = true,

    use_fancy_tab_bar = false,

    -- Remove the Title bar and enable resizable bars
    window_decorations = "INTEGRATED_BUTTONS | RESIZE",

    front_end = 'WebGpu',
    webgpu_power_preference = "HighPerformance",
    webgpu_preferred_adapter = wezterm.gui.enumerate_gpus()[1],

    max_fps = 144,
    animation_fps = 60,

    color_scheme = scheme_for_appearance(wezterm.gui.get_appearance()),

    window_background_opacity = 0.5,
    win32_system_backdrop = 'Acrylic',

    keys = {
      {
        key = 'w',
        mods = 'CTRL|ALT',
        action = wezterm.action.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' },
      },
      { key = 'n', mods = 'CTRL|ALT', action = wezterm.action.SwitchWorkspaceRelative(1) },
      { key = 'p', mods = 'CTRL|ALT', action = wezterm.action.SwitchWorkspaceRelative(-1) },
    },

    colors = {
        -- https://catppuccin.com/palette refer Mocha
        tab_bar = {
            background = 'rgba(24, 24, 37, 0.8)',  -- Mantle
            active_tab = {
                bg_color = 'rgba(49, 50, 68, 0.8)', -- Surface 0
                fg_color = 'rgba(180, 190, 254, 1.0)', -- Lavender
            },

            inactive_tab = {
                bg_color = 'rgba(24, 24, 37, 0.8)', -- Mantle
                fg_color = 'rgba(180, 190, 254, 0.8)', -- Lavender
            },

            inactive_tab_hover = {
                bg_color = 'rgba(180, 190, 254, 1.0)', -- Lavender
                fg_color = 'rgba(24, 24, 37, 0.8)', -- Mantle
            },

            new_tab = {
                bg_color = 'rgba(24, 24, 37, 0.8)', -- Mantle
                fg_color = 'rgba(180, 190, 254, 1.0)', -- Lavender
            },

            new_tab_hover = {
                bg_color = 'rgba(180, 190, 254, 1.0)', -- Lavender
                fg_color = 'rgba(24, 24, 37, 0.8)', -- Mantle
            },
        },
    },

    -- Required Git-Bash
    -- or change arg to launch fav terminal as default
    default_prog = { 'bin/sh.exe' },

    -- Required Hack Nerd font
    font = wezterm.font_with_fallback {
        'Hack Nerd Font Mono',
    },

    -- Right-click on '+' to see the lunch menu
    launch_menu = {
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
            -- set_environment_variables ration option described above
            -- set_environment_variables = { FOO = "bar" },
        },
    },

    window_padding = {
        left = 3,
        right = 3,
        top = 0,
        bottom = 0,
    },
}

-- Must return a map
return config
