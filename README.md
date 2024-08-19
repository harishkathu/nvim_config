# Nvim Config

- [Requirements](#requirements)
- [Windows](#windows)
- [Notes](#notes)
- [Treesitter](#treesitter)
- [Oh My Posh](#oh-my-posh)
- [PowerShell](#powershell)

## Requirements

- npm (use nvm to install)

### Windows

- chcocolatey - to install tools in windows

- ripgrep

  - > choco install ripgrep

- fd (for better find files)
  - > choco install fd

## Notes

- If using terminal in windows, remap Ctrl+v to Crtrl+Shift+v.

  - This will allow using Ctrl-v in nvim (visual block mode), but suprisingly
    -\_('-')\_/- and magically XD this does not overwrite the remap. i.e. even
    after the remap Ctrl-v works for paste but wont work when nvim is active.

- Require node for pyright. Used nvm for installing node,
  migth as well do it that way.

### Treesitter

- Treesitter requires some c compiler this can be easiy done like this

- Without c compiler you will get an error saying no c or cpp compiler found in path

- Install MinGW toolchain and install c, cpp compilers and add to path
- Run these comands in terminal

  - > choco install mingw
  - > "refreshenv" -- refresh the env in terminal ;)

- now open nvim and run these commands
  - > :TSInstall c
  - > :TSInstall cpp

## Oh My Posh

- "catppuccin_custom.omp.json" is the custom json used for oh-my-posh, use this
  when importing the config

## Wezterm
- For wezterm config just add the below env variable
>  WEZTERM_CONFIG_FILE = "<path_to_this_folder>\wezterm.lua"

## PowerShell

- Create Profile

  - > notepda $PROFILE

- Disable venv tag

  - > $env:VIRTUAL_ENV_DISABLE_PROMPT = 1

- Disable Ctrl+l binding (clear screen)
  - > Remove-PSReadLineKeyHandler -Chord Ctrl+l
