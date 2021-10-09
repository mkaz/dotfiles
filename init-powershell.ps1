# Windows Powershell setup

scoop bucket add extras

# basics
scoop install 7zip gh git neovim

# ruby utils
scoop install bat espanso fd ripgrep starship

# Apps from extras
scoop install audacity hack-font obs-studio
scoop install languagetool obsidian sublime-text
scoop install signal slack syncthingtray

# Copy configs to correct location
# TODO: symlink or sync
Copy-Item "configs\nvim" -Destination "$HOME\AppData\Local\nvim" -Recurse

Copy-Item "configs\espanso\default.yml" -Destination "$HOME\scoop\apps\espanso\current\.espanso\default.yml"

Copy-Item "configs\git\gitattributes" -Destination "$HOME\.gitattributes"
Copy-Item "configs\git\gitconfig" -Destination "$HOME\.gitconfig"
Copy-Item "configs\git\gitignore" -Destination "$HOME\.gitignore"
