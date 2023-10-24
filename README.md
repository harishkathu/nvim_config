# nvim_config

## Required

### Windows

- chcocolatey - to install tools in windows

- Glow (visit: https://github.com/ellisonleao/glow.nvim)
  - > choco install glow

- ripgrep
  - > choco install ripgrep


## NOTES:

- If using terminal in windows, remap Ctrl+v to Crtrl+Shift+v.
  - This will allow using Ctrl-v in nvim (visual block mode), but suprisingly -\_('-')_/- and magically XD this does not overwrite the remap. i.e. even after the remap Ctrl-v works for paste but wont work when nvim is active.

- Require node for pyright. Used nvm for installing node, migth as well do it that way.

### Treesitter

-  Treesitter requires some c compiler this can be easiy done like this

-  Without c compiler you will get an error saying no c or cpp compiler found in path 

- Install MinGW toolchain and install c, cpp compilers and add to path
    
- Run these comands in terminal
    - > choco install mingw
    - > "refreshenv" -- refresh the env in terminal ;)

- now open nvim and run these commands
    - > :TSInstall c
    - > :TSInstall cpp


## Oh My Posh

- "catppuccin_custom.omp.json" is the custom json used for oh-my-posh, use this when importing the config

## PS

- Create Profile
  - > notepda $PROFILE

- Disable venv tag
   - > $env:VIRTUAL_ENV_DISABLE_PROMPT = 1

- Disable Ctrl+l binding (clear screen)
  - > Remove-PSReadLineKeyHandler -Chord Ctrl+l
