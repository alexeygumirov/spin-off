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

# Update VIM

vim +PlugInstall +qa
vim +PlugClean +qa
vim +PlugUpdate +PlugUpgrade +qa

# Update NVIM
nvim +PlugInstall +qa
nvim +PlugClean +qa
nvim +PlugUpdate +PlugUpgrade +qa
