#!/bin/bash

# This script installs neovim

SETUP_DIR=""

if [[ ! -d $HOME/spin-off ]]
then
    echo -ne "\n\r Setup cannot be started! Please clone \"alexeygumirov/spin-off\" project to home directory.\n"
    exit 1
else
    SETUP_DIR="$HOME/spin-off"
fi

SETUP_LOG="$HOME/my_env_setup.log"
timestamp=$(date +%T.%N)
echo -ne "\r$timestamp: Setup of environment is starting.\n" > "$SETUP_LOG"

# install NeoVIM

TOPIC="NeoVIM installation:"
timestamp=$(date +%T.%N)
echo -ne "$TOPIC --- Adding NeoVIM repository --- : $timestamp\n" | tee -a "$SETUP_LOG"
sudo add-apt-repository ppa:neovim-ppa/unstable -y | tee -a "$SETUP_LOG"
sudo apt-get update -y | tee -a "$SETUP_LOG" 
echo -ne "$TOPIC --- Installing NeoVIM --- : $timestamp\n" | tee -a "$SETUP_LOG"
sudo apt-get install neovim -y | tee -a "$SETUP_LOG"
timestamp=$(date +%T.%N)
echo -ne "\n\r$TOPIC --- Installation complete  ---: $timestamp\n" | tee -a "$SETUP_LOG"

timestamp=$(date +%T.%N)
echo -ne "\n\r$TOPIC --- Installing VIM plug-ins manager ---: $timestamp\n" | tee -a "$SETUP_LOG"

# install NeoVIM plugin manager

TOPIC="NeoVIM Plug in manager:"
VIM_PLUG_DIR="$HOME/.local/share/nvim/site/autoload/"

timestamp=$(date +%T.%N)
echo -ne "\n\r$TOPIC --- Download vim.plug ---: $timestamp\n" | tee -a "$SETUP_LOG"
curl -fLo "$VIM_PLUG_DIR"plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo -ne "\n\r$TOPIC --- Downloading of vim.plug is complete ---: $timestamp\n" | tee -a "$SETUP_LOG"

NEOVIM_PLUGINS_DIR="$HOME/.local/share/nvim/plugged/"
if [[ ! -d $NEOVIM_PLUGINS_DIR ]]
then
	mkdir -p "$NEOVIM_PLUGINS_DIR"
fi

# install python3
# install python3-pip

sudo apt-get install -y python3-pip

# install neovim-remote

pip3 install neovim-remote

# install fzf

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# setup bash environment


# create .vimrc and make basic config



# install vim as main system editor

# install tmux

sudo apt-get install -y tmux

# install tmux configuration


# Install tmux plug manager

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install powerline for bash

sudo apt-get install -y powerline

# Clone config from the repository and copy it
