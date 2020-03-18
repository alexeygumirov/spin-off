#!/bin/bash

# This script installs my configs and tools (neovim, fzf, etc.)

SETUP_DIR=""
PLATFORM=""

if [[ ! -d $HOME/.spin-off ]]
then
    echo -ne "\n\r Setup cannot be started! Please clone \"alexeygumirov/spin-off\" project to home directory.\n"
    exit 1
else
    SETUP_DIR="$HOME/.spin-off"
fi

if [[ ! -z $(uname -m | grep "x86_64") ]]
then
    PLATFORM="x86_64"
fi

if [[ ! -z $(uname -m | grep "armv7") ]]
then
    PLATFORM="armhf"
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
# Begin - software properties common

TOPIC="Software properties common:"
timestamp=$(date +%T.%N)
echo -ne "$TOPIC --- Installing --- : $timestamp\n" | tee -a "$SETUP_LOG"
sudo apt-get install software-properties-common -y | tee -a "$SETUP_LOG"
timestamp=$(date +%T.%N)
echo -ne "$TOPIC --- Installation complete --- : $timestamp\n" | tee -a "$SETUP_LOG"

# End - software properties common
### }

### {
# Begin - curl

TOPIC="curl:"
timestamp=$(date +%T.%N)
echo -ne "$TOPIC --- Installing --- : $timestamp\n" | tee -a "$SETUP_LOG"
sudo apt-get install curl -y | tee -a "$SETUP_LOG"
timestamp=$(date +%T.%N)
echo -ne "$TOPIC --- Installation complete --- : $timestamp\n" | tee -a "$SETUP_LOG"

# End - curl
### }

### {
# Begin - pip & pip3

TOPIC="pip & pip3:"
timestamp=$(date +%T.%N)
echo -ne "$TOPIC --- Installing --- : $timestamp\n" | tee -a "$SETUP_LOG"
sudo apt-get install python-pip -y | tee -a "$SETUP_LOG"
sudo apt-get install python3-pip -y | tee -a "$SETUP_LOG"
timestamp=$(date +%T.%N)
echo -ne "$TOPIC --- Installation complete --- : $timestamp\n" | tee -a "$SETUP_LOG"

# End - pip & pip3
### }

### {
# Begin - pkg-config

TOPIC="pkg-config:"
timestamp=$(date +%T.%N)
echo -ne "$TOPIC --- Installing --- : $timestamp\n" | tee -a "$SETUP_LOG"
sudo apt-get install pkg-config -y | tee -a "$SETUP_LOG"
timestamp=$(date +%T.%N)
echo -ne "$TOPIC --- Installation complete --- : $timestamp\n" | tee -a "$SETUP_LOG"

# End - pkg-config
### }

### {
# Begin - libcairo2-dev

TOPIC="libcairo2-dev:"
timestamp=$(date +%T.%N)
echo -ne "$TOPIC --- Installing --- : $timestamp\n" | tee -a "$SETUP_LOG"
sudo apt-get install libcairo2-dev -y | tee -a "$SETUP_LOG"
timestamp=$(date +%T.%N)
echo -ne "$TOPIC --- Installation complete --- : $timestamp\n" | tee -a "$SETUP_LOG"

# End - libcairo2-dev
### }

### {
# Begin - libgirepository1.0-dev

TOPIC="libgirepository1.0-dev:"
timestamp=$(date +%T.%N)
echo -ne "$TOPIC --- Installing --- : $timestamp\n" | tee -a "$SETUP_LOG"
sudo apt install libgirepository1.0-dev -y | tee -a "$SETUP_LOG"
timestamp=$(date +%T.%N)
echo -ne "$TOPIC --- Installation complete --- : $timestamp\n" | tee -a "$SETUP_LOG"

# End - libgirepository1.0-dev
### }

### {
# Begin - Install NeoVIM

TOPIC="NeoVIM:"
NEOVIM_PLUG_DIR="$HOME/.local/share/nvim/site/autoload"
NEOVIM_PLUGINS_DIR="$HOME/.local/share/nvim/plugged"
NEOVIM_CONFIG_DIR="$HOME/.config/nvim"

timestamp=$(date +%T.%N)
echo -ne "$TOPIC --- Adding repository --- : $timestamp\n" | tee -a "$SETUP_LOG"
sudo add-apt-repository ppa:neovim-ppa/stable -y | tee -a "$SETUP_LOG"

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
echo -ne "\n\r$TOPIC --- Installing \"pip3\" --- : $timestamp\n" | tee -a "$SETUP_LOG"
sudo apt-get install python3-pip -y | tee -a "$SETUP_LOG"

timestamp=$(date +%T.%N)
echo -ne "\n\r$TOPIC --- Installing \"neovim\" --- : $timestamp\n" | tee -a "$SETUP_LOG"
pip3 install --user neovim | tee -a "$SETUP_LOG"

timestamp=$(date +%T.%N)
echo -ne "\n\r$TOPIC --- Installing \"neovim-remote\" --- : $timestamp\n" | tee -a "$SETUP_LOG"
pip3 install --user neovim-remote | tee -a "$SETUP_LOG"

timestamp=$(date +%T.%N)
echo -ne "\n\r$TOPIC --- Intstallation of \"neovim-remote\" complete --- : $timestamp\n" | tee -a "$SETUP_LOG"

echo -ne "\n\r$TOPIC --- Intstallation complete --- : $timestamp\n" | tee -a "$SETUP_LOG"

# End - Install NeoVIM
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
cp ~/.bashrc ~/.bashrc_original.bak | tee -a "$SETUP_LOG"
cp "$SETUP_DIR"/configs/.bashrc "$HOME"/ | tee -a "$SETUP_LOG"
cp "$SETUP_DIR"/configs/.bashrc_aliases "$HOME"/ | tee -a "$SETUP_LOG"
cp "$SETUP_DIR"/configs/.inputrc "$HOME"/ | tee -a "$SETUP_LOG"
echo -ne "$TOPIC --- Bash setup is complete --- : $timestamp\n" | tee -a "$SETUP_LOG"

# End - Setup Bash environment
### }

### {
# Begin - Install FZF and FD

TOPIC="FZF & FD:"

timestamp=$(date +%T.%N)
case $PLATFORM in
    "x86_64")
        echo -ne "\n\r$TOPIC --- Installting fd --- : $timestamp\n" | tee -a "$SETUP_LOG"
        curl -OL https://github.com/sharkdp/fd/releases/download/v7.4.0/fd_7.4.0_amd64.deb | tee -a "$SETUP_LOG"
        sudo dpkg -i fd_7.4.0_amd64.deb | tee -a "$SETUP_LOG"
        rm -f fd_7.4.0_amd64.deb | tee -a "$SETUP_LOG"
        ;;
    "armhf")
        echo -ne "\n\r$TOPIC --- Installting fd --- : $timestamp\n" | tee -a "$SETUP_LOG"
        curl -OL https://github.com/sharkdp/fd/releases/download/v7.4.0/fd_7.4.0_armhf.deb | tee -a "$SETUP_LOG"
        sudo dpkg -i fd_7.4.0_armhf.deb | tee -a "$SETUP_LOG"
        rm -f fd_7.4.0_armhf.deb | tee -a "$SETUP_LOG"
        ;;
    *)
        echo -ne "\n\r$TOPIC --- FD cannot be installed. Please visit https://github.com/sharkdp/fd/releases for version to your platform. --- : $timestamp\n" | tee -a "$SETUP_LOG"
        ;;
esac

timestamp=$(date +%T.%N)
echo -ne "\n\r$TOPIC --- Installting silversearcher-ag --- : $timestamp\n" | tee -a "$SETUP_LOG"
sudo apt-get install -y silversearcher-ag | tee -a "$SETUP_LOG"

timestamp=$(date +%T.%N)
case $PLATFORM in
    "x86_64")
        echo -ne "\n\r$TOPIC --- Installting ripgrep --- : $timestamp\n" | tee -a "$SETUP_LOG"
        curl -OL https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb | tee -a "$SETUP_LOG"
        sudo dpkg -i ripgrep_11.0.2_amd64.deb | tee -a "$SETUP_LOG"
        rm -f ripgrep_11.0.2_amd64.deb | tee -a "$SETUP_LOG"
        ;;
    *)
        echo -ne "\n\r$TOPIC --- ripgrep cannot be installed. Please visit https://github.com/BurntSushi/ripgrep/releases for version to your platform. --- : $timestamp\n" | tee -a "$SETUP_LOG"
        ;;
esac

timestamp=$(date +%T.%N)
echo -ne "\n\r$TOPIC --- Installting fzf --- : $timestamp\n" | tee -a "$SETUP_LOG"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf | tee -a "$SETUP_LOG"
~/.fzf/install | tee -a "$SETUP_LOG"

timestamp=$(date +%T.%N)
echo -ne "\n\r$TOPIC --- Installation complete --- : $timestamp\n" | tee -a "$SETUP_LOG"

# End - Install FZF
### }

### {
# Begin - Install BAT viewer

TOPIC="bat:"

timestamp=$(date +%T.%N)
case $PLATFORM in
    "x86_64")
        echo -ne "\n\r$TOPIC --- Installting bat --- : $timestamp\n" | tee -a "$SETUP_LOG"
        curl -OL https://github.com/sharkdp/bat/releases/download/v0.12.1/bat_0.12.1_amd64.deb | tee -a "$SETUP_LOG"
        sudo dpkg -i bat_0.12.1_amd64.deb | tee -a "$SETUP_LOG"
        rm -f bat_0.12.1_amd64.deb
        ;;
    "armhf")
        echo -ne "\n\r$TOPIC --- Installting bat --- : $timestamp\n" | tee -a "$SETUP_LOG"
        curl -OL https://github.com/sharkdp/bat/releases/download/v0.12.1/bat_0.12.1_armhf.deb | tee -a "$SETUP_LOG"
        sudo dpkg -i bat_0.12.1_armhf.deb | tee -a "$SETUP_LOG"
        rm -f bat_0.12.1_armhf.deb
        ;;
    *)
        echo -ne "\n\r$TOPIC --- bat cannot be installed. Please visit https://github.com/sharkdp/bat/releases for version to your platform. --- : $timestamp\n" | tee -a "$SETUP_LOG"
        ;;
esac

timestamp=$(date +%T.%N)
echo -ne "\n\r$TOPIC --- Installation complete --- : $timestamp\n" | tee -a "$SETUP_LOG"

# End - Install FZF
### }

### {
# Copy of my headers

TOPIC="my headers:"

timestamp=$(date +%T.%N)
echo -ne "\n\r$TOPIC --- Copying my headers --- : $timestamp\n" | tee -a "$SETUP_LOG"
mkdir -p ~/.config/myheaders | tee -a "$SETUP_LOG"
cp "$SETUP_DIR"/configs/myheaders/* ~/.config/myheaders | tee -a "$SETUP_LOG"

timestamp=$(date +%T.%N)
echo -ne "\n\r$TOPIC --- Copying complete --- : $timestamp\n" | tee -a "$SETUP_LOG"

# End - Copy of my headers
### }

### {
# installation of 'tree'

TOPIC="tree:"

timestamp=$(date +%T.%N)

echo -ne "\n\r$TOPIC --- Installing  --- : $timestamp\n" | tee -a "$SETUP_LOG"
sudo apt-get install tree -y | tee -a "$SETUP_LOG"

timestamp=$(date +%T.%N)
echo -ne "\n\r$TOPIC --- Installation complete --- : $timestamp\n" | tee -a "$SETUP_LOG"

# End - Installation of 'tree'
### }

### {
# installation of powerline fonts

TOPIC="powerline fonts:"

timestamp=$(date +%T.%N)

echo -ne "\n\r$TOPIC --- Installing  --- : $timestamp\n" | tee -a "$SETUP_LOG"
sudo apt-get install fonts-powerline -y | tee -a "$SETUP_LOG"

timestamp=$(date +%T.%N)
echo -ne "\n\r$TOPIC --- Installation complete --- : $timestamp\n" | tee -a "$SETUP_LOG"

# End - Installation of powerline fonts
### }

### {
# Begin - copy scripts

TOPIC="copy scripts:"
timestamp=$(date +%T.%N)
echo -ne "\n\r$TOPIC --- copying  --- : $timestamp\n" | tee -a "$SETUP_LOG"
mkdir $HOME/.scripts | tee -a "$SETUP_LOG"
cp "$SETUP_DIR"/scripts/* $HOME/.scripts | tee -a "$SETUP_LOG"
chmod 774 $HOME/.scripts/* | tee -a "$SETUP_LOG"
timestamp=$(date +%T.%N)
echo -ne "\n\r$TOPIC --- copying complete --- : $timestamp\n" | tee -a "$SETUP_LOG"

# End - copy scripts
### }

### {
# Begin - Golang installation

TOPIC="Golang:"
timestamp=$(date +%T.%N)
echo -ne "\n\r$TOPIC --- Installing --- : $timestamp\n" | tee -a "$SETUP_LOG"
mkdir $HOME/source | tee -a "$SETUP_LOG"
pushd $HOME/source | tee -a "$SETUP_LOG"
curl -LO https://dl.google.com/go/go1.14.linux-amd64.tar.gz | tee -a "$SETUP_LOG"
tar zxvf go1.14.linux-amd64.tar.gz | tee -a "$SETUP_LOG"
sudo mv go /opt/ | tee -a "$SETUP_LOG"
sudo ln -s /opt/go/bin/go /usr/local/bin/go | tee -a "$SETUP_LOG"
popd | tee -a "$SETUP_LOG"
timestamp=$(date +%T.%N)
echo -ne "\n\r$TOPIC --- Installation complete --- : $timestamp\n" | tee -a "$SETUP_LOG"

# End - Golang installation
### }
