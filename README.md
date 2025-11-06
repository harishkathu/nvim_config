# Nvim Config

- [Requirements](#requirements)
  - [Windows](#windows)
- [Notes](#notes)
  - [Treesitter](#treesitter)
- [Oh My Posh](#oh-my-posh)
- [Wezterm](#wezterm)
- [PowerShell](#powershell)
<!--toc:end-->
## Requirements

- Nvim v0.10.*
- npm, node (use nvm to install both)

### Windows

- chcocolatey - to install tools in windows

- ripgrep

  - ```ps1
    choco install ripgrep
    ```

- fd (for better find files)
  - ```ps1
    choco install fd
    ```

## Notes

- If using terminal in windows, remap Ctrl+v to Crtrl+Shift+v.

  - This will allow using Ctrl-v in nvim (visual block mode), but surprisingly
    -\\_('-')\_/- and magically XD this does not overwrite the remap. i.e. even
    after the remap Ctrl-v works for paste but won't work when nvim is active.

- Require node for pyright. Used nvm for installing node.

### Treesitter

- Treesitter requires some c compiler this can be easily done like this

- Without c compiler you will get an error saying no c or cpp compiler found in path

- Install MinGW toolchain and install c, cpp compilers and add to path
- Run these commands in terminal

  - ```ps1
    choco install mingw
    ```
  - ```ps1
    "refreshenv" -- refresh the env in terminal ;)
    ```

- now open nvim and run these commands
  - ```vim
    :TSInstall c
    ```
  - ```vim
    :TSInstall cpp
    ```

## Oh My Posh

- "catppuccin_custom.omp.json" is the custom json used for oh-my-posh, use this
  when importing the config

## Wezterm

- For wezterm config just add the below env variable

> WEZTERM_CONFIG_FILE = "<path_to_this_folder>\wezterm.lua"

## PowerShell

- Create Profile

  - ```ps1
    notepad $PROFILE
    ```

- To use catppuccin_custom theme (in $PROFILE)
  - ```ps1
    oh-my-posh init pwsh --config "C:\Users\emb-harikat\AppData\Local\nvim\catppuccin_custom.omp.json" --eval | Invoke-Expression
    ```
- Disable venv tag (in $PROFILE)

  - ```ps1
    $env:VIRTUAL_ENV_DISABLE_PROMPT = 1
    ```

- Disable Ctrl+l binding (clear screen) (in $PROFILE)
  - ```ps1
    Remove-PSReadLineKeyHandler -Chord Ctrl+l
    ```
