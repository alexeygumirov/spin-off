#!/bin/bash

# This script installs neovim

SETUP_DIR=""

if [[ ! -d $HOME/.spin-off ]]
then
    echo -ne "\n\r Setup cannot be started! Please clone \"alexeygumirov/spin-off\" project to home directory.\n"
    exit 1
else
    SETUP_DIR="$HOME/.spin-off"
fi

SETUP_LOG="$HOME/my_env_setup.log"
timestamp=$(date +%T.%N)
echo -ne "\r$timestamp: Setup of environment is starting.\n" > "$SETUP_LOG"

### {
# Begin - Repo update and upgrade 

TOPIC="APT Repository:"
timestamp=$(date +%T.%N)
echo -ne "$TOPIC --- Update and upgrade --- : $timestamp\n" | tee -a "$SETUP_LOG"
sudo apt-get update -y | tee -a "$SETUP_LOG" 
sudo apt-get upgrade -y | tee -a "$SETUP_LOG" 
timestamp=$(date +%T.%N)
echo -ne "$TOPIC --- Update and upgrade complete --- : $timestamp\n" | tee -a "$SETUP_LOG"

# End - Repo update and upgrade
### }


### {
# Begin - Install NeoVIM

TOPIC="NeoVIM:"
NEOVIM_PLUG_DIR="$HOME/.local/share/nvim/site/autoload"
NEOVIM_PLUGINS_DIR="$HOME/.local/share/nvim/plugged"
NEOVIM_CONFIG_DIR="$HOME/.config/nvim"

timestamp=$(date +%T.%N)
echo -ne "$TOPIC --- Adding repository --- : $timestamp\n" | tee -a "$SETUP_LOG"
sudo add-apt-repository ppa:neovim-ppa/unstable -y | tee -a "$SETUP_LOG"

timestamp=$(date +%T.%N)
echo -ne "$TOPIC --- Installing --- : $timestamp\n" | tee -a "$SETUP_LOG"
sudo apt-get install neovim -y | tee -a "$SETUP_LOG"

timestamp=$(date +%T.%N)
echo -ne "\n\r$TOPIC --- Installation complete  --- : $timestamp\n" | tee -a "$SETUP_LOG"

timestamp=$(date +%T.%N)
echo -ne "\n\r$TOPIC --- Download vim.plug --- : $timestamp\n" | tee -a "$SETUP_LOG"
curl -fLo "$NEOVIM_PLUG_DIR"/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
timestamp=$(date +%T.%N)
echo -ne "\n\r$TOPIC --- Downloading of vim.plug complete --- : $timestamp\n" | tee -a "$SETUP_LOG"

if [[ ! -d $NEOVIM_CONFIG_DIR ]]
then
	mkdir -p "$NEOVIM_CONFIG_DIR" | tee -a "$SETUP_LOG"
fi
timestamp=$(date +%T.%N)
echo -ne "\n\r$TOPIC --- Copy init.vim --- : $timestamp\n" | tee -a "$SETUP_LOG"
cp "$SETUP_DIR"/configs/neovim/init.vim "$NEOVIM_CONFIG_DIR"/ | tee -a "$SETUP_LOG"

if [[ ! -d $NEOVIM_CONFIG_DIR/colors ]]
then
	mkdir -p "$NEOVIM_CONFIG_DIR"/colors | tee -a "$SETUP_LOG"
fi

timestamp=$(date +%T.%N)
echo -ne "\n\r$TOPIC --- Copy color scheme --- : $timestamp\n" | tee -a "$SETUP_LOG"
cp "$SETUP_DIR"/configs/vim_theme/PaperColor.vim "$NEOVIM_CONFIG_DIR"/colors/ | tee -a "$SETUP_LOG"

if [[ ! -d $NEOVIM_PLUGINS_DIR ]]
then
	mkdir -p "$NEOVIM_PLUGINS_DIR" | tee -a "$SETUP_LOG"
fi

timestamp=$(date +%T.%N)
echo -ne "\n\r$TOPIC --- Installing \"neovim-remote\" --- : $timestamp\n" | tee -a "$SETUP_LOG"
sudo apt-get install python3-pip -y | tee -a "$SETUP_LOG"
pip3 install -y neovim-remote | tee -a "$SETUP_LOG"

timestamp=$(date +%T.%N)
echo -ne "\n\r$TOPIC --- Intstallation of \"neovim-remote\" complete --- : $timestamp\n" | tee -a "$SETUP_LOG"

echo -ne "\n\r$TOPIC --- Intstallation complete --- : $timestamp\n" | tee -a "$SETUP_LOG"

# End - Install NeoVIM
### }


### {
# Begin - Install FZF

TOPIC="FZF:"

timestamp=$(date +%T.%N)
echo -ne "\n\r$TOPIC --- Installting --- : $timestamp\n" | tee -a "$SETUP_LOG"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf | tee -a "$SETUP_LOG"
~/.fzf/install | tee -a "$SETUP_LOG"

timestamp=$(date +%T.%N)
echo -ne "\n\r$TOPIC --- Installation complete --- : $timestamp\n" | tee -a "$SETUP_LOG"

# End - Install FZF
### }


### {
# Begin - Install VIM

TOPIC="VIM:"
VIM_CONFIG_DIR="$HOME/.vim"

timestamp=$(date +%T.%N)
echo -ne "$TOPIC --- Removing \"vim-tiny\" --- : $timestamp\n" | tee -a "$SETUP_LOG"
sudo apt-get remove -y vim-tiny | tee -a "$SETUP_LOG"

timestamp=$(date +%T.%N)
echo -ne "$TOPIC --- Installing --- : $timestamp\n" | tee -a "$SETUP_LOG"
sudo apt-get install vim -y | tee -a "$SETUP_LOG"
timestamp=$(date +%T.%N)
echo -ne "\n\r$TOPIC --- Installation complete  --- : $timestamp\n" | tee -a "$SETUP_LOG"

timestamp=$(date +%T.%N)
echo -ne "\n\r$TOPIC --- Download vim.plug --- : $timestamp\n" | tee -a "$SETUP_LOG"
curl -fLo "$VIM_CONFIG_DIR"/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
timestamp=$(date +%T.%N)
echo -ne "\n\r$TOPIC --- Downloading of vim.plug complete --- : $timestamp\n" | tee -a "$SETUP_LOG"

timestamp=$(date +%T.%N)
echo -ne "\n\r$TOPIC --- Copy .vimrc --- : $timestamp\n" | tee -a "$SETUP_LOG"
cp "$SETUP_DIR"/configs/vim/.vimrc "$HOME"/ | tee -a "$SETUP_LOG"

if [[ ! -d $VIM_CONFIG_DIR/colors ]]
then
	mkdir -p "$VIM_CONFIG_DIR"/colors | tee -a "$SETUP_LOG"
fi
timestamp=$(date +%T.%N)
echo -ne "\n\r$TOPIC --- Copy color scheme --- : $timestamp\n" | tee -a "$SETUP_LOG"
cp "$SETUP_DIR"/configs/vim_theme/PaperColor.vim "$VIM_CONFIG_DIR"/colors/ | tee -a "$SETUP_LOG"

if [[ ! -d $VIM_CONFIG_DIR/plugged ]]
then
	mkdir -p "$VIM_CONFIG_DIR"/plugged | tee -a "$SETUP_LOG"
fi

timestamp=$(date +%T.%N)
echo -ne "\n\r$TOPIC --- Make VIM system editor --- : $timestamp\n" | tee -a "$SETUP_LOG"
sudo update-alternatives --config editor | tee -a "$SETUP_LOG"

timestamp=$(date +%T.%N)
echo -ne "\n\r$TOPIC --- Intstallation complete --- : $timestamp\n" | tee -a "$SETUP_LOG"

# End - Install VIM
### }


### {
# Begin - Install TMUX

TOPIC="TMUX:"
TMUX_CONFIG_DIR="$HOME/.tmux"

timestamp=$(date +%T.%N)
echo -ne "$TOPIC --- Installing --- : $timestamp\n" | tee -a "$SETUP_LOG"
sudo apt-get install -y tmux | tee -a "$SETUP_LOG"

if [[ ! -d $TMUX_CONFIG_DIR/plugins ]]
then
    mkdir -p $TMUX_CONFIG_DIR/plugins 
fi
timestamp=$(date +%T.%N)
echo -ne "$TOPIC --- TMUX plug --- : $timestamp\n" | tee -a "$SETUP_LOG"
git clone https://github.com/tmux-plugins/tpm "$TMUX_CONFIG_DIR"/plugins/tpm | tee -a "$SETUP_LOG"

timestamp=$(date +%T.%N)
echo -ne "\n\r$TOPIC --- Copy .tmux.conf --- : $timestamp\n" | tee -a "$SETUP_LOG"
cp ~/.tmux.conf ~/.tmux.conf.back | tee -a "$SETUP_LOG"
cp "$SETUP_DIR"/configs/tmux/.tmux.conf "$HOME"/ | tee -a "$SETUP_LOG"

timestamp=$(date +%T.%N)
echo -ne "\n\r$TOPIC --- Intstallation complete --- : $timestamp\n" | tee -a "$SETUP_LOG"

# End - Install TMUX
### }


### {
# Begin - Install powerline for bash

TOPIC="Powerline:"
POWERLINE_CONFIG_DIR="$HOME/.config/powerline"
timestamp=$(date +%T.%N)

echo -ne "$TOPIC --- Installing --- : $timestamp\n" | tee -a "$SETUP_LOG"
sudo apt-get install -y powerline | tee -a "$SETUP_LOG"

if [[ ! -d $POWERLINE_CONFIG_DIR ]]
then
    mkdir -p $POWERLINE_CONFIG_DIR
fi
timestamp=$(date +%T.%N)
echo -ne "$TOPIC --- Copy configs --- : $timestamp\n" | tee -a "$SETUP_LOG"
cp -r "$SETUP_DIR"/configs/powerline/* "$POWERLINE_CONFIG_DIR"/ | tee -a "$SETUP_LOG"

timestamp=$(date +%T.%N)
echo -ne "$TOPIC --- Installation complete --- : $timestamp\n" | tee -a "$SETUP_LOG"

# End - Install powerline for bash
### }


### {
# Begin - Setup Bash environment

TOPIC="Bash environment:"
timestamp=$(date +%T.%N)
echo -ne "$TOPIC --- creating my .bashrc file --- : $timestamp\n" | tee -a "$SETUP_LOG"
cp ~/.bashrc ~/.bashrc_copy | tee -a "$SETUP_LOG"
sed -i_back 's/\(shopt -s histappend\|^HIST*\)/# &/' ~/.bashrc | tee -a "$SETUP_LOG"
cat "$SETUP_DIR"/configs/.bash_mine ~/.bashrc_copy > ~/.bashrc | tee -a "$SETUP_LOG"
rm -f ~/.bashrc_copy | tee -a "$SETUP_LOG"
cp "$SETUP_DIR"/configs/.inputrc "$HOME"/ | tee -a "$SETUP_LOG"
echo -ne "$TOPIC --- Bash setup is complete --- : $timestamp\n" | tee -a "$SETUP_LOG"

# End - Setup Bash environment
### }

source ~/.bashrc
