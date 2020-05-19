#!/bin/bash
#####################################################
#           _    ____                   __          #
#          / \  / ___|  ___ ___  _ __  / _|         #
#         / _ \| |  _  / __/ _ \| '_ \| |_          #
#        / ___ \ |_| || (_| (_) | | | |  _|         #
#       /_/   \_\____(_)___\___/|_| |_|_|           #
#                                                   #
#       Alexey Gumirov's generic config for         #
#       Ubuntu based operating systems.             #
#####################################################

# This script installs my configs and tools (neovim, fzf, etc.)
# List of packages
# APT packages:
#    software-properties-common, curl, python-pip, python-pip3, pkg-config, libcairo2-dev, libgirepository1.0-dev, neovim, python3-pip, vim, tmux, powerline, silversearcher-ag, tree, fonts-powerline, mediainfo, p7zip, unrar, xpdf
# PPA:
#     ppa:neovim-ppa/unstable
# DEB:
#   FD: https://github.com/sharkdp/fd
#   Ripgrep: https://github.com/BurntSushi/ripgrep
#   FZF: https://github.com/junegunn/fzf ### is installed from the GitHub repo and updated with the NVIM plugin automatically.
#   BAT: https://github.com/sharkdp/bat
# Python:
#   neovim, neovim-remote,
# Other:
#   vim-plug: https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
#   tmux-plugings-manager: https://github.com/tmux-plugins/tpm
#   go: https://golang.org/dl/
#   LF: https://github.com/gokcehan/lf # installed via go installation
# dpkg-query -W -f='${Status}' python3 | awk '{ print $3 }' | grep "^installed$"

PKG_LIST="software-properties-common,\
curl,\
python-pip,\
pkg-config,\
libcairo2-dev,\
libgirepository1.0-dev,\
neovim,\
python3-pip,\
vim,\
tmux,\
powerline,\
silversearcher-ag,\
tree,\
fonts-powerline,\
mediainfo,\
p7zip,\
unrar,\
xpdf,\
libicu-dev\
"


