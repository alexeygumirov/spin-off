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
#   LF: https://github.com/gokcehan/lf
# Python:
#   neovim, neovim-remote,
# Other:
#   vim-plug: https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
#   tmux-plugings-manager: https://github.com/tmux-plugins/tpm
#   go: https://golang.org/dl/
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
xpdf\
"

SETUP_DIR=""
PLATFORM=""
BAT_VIEWER_VER="0.15.0"
FD_VER="8.0.0"
RIPGREP_VER="12.0.1"
GO_VER="1.14.2"
TOPIC=""

TOPIC="apt update & upgrade"
function aptupdupg() {
    local tmstmp=$(date +'%T.%N')
    echo "${tmstmp} : ${TOPIC} : Starting.\n"
    sudo apt-get update -y
    sudo apt-get upgrade -y
    tmstmp=$(date +%T.%N)
    echo "${tmstmp} : ${TOPIC} : Complete.\n"
}

function pkginstall() {
    local FieldSeparator=$IFS
    local IS_PKG_INSTALELD=""
    local tmstmp=""
    IFS=','
    for pkg in ${PKG_LIST};
    do
        IS_PKG_INSTALELD=$(dpkg-query -W -f='${Status}' ${pkg} | awk '{ print $3 }' | grep "^installed$")
        if [[ -z ${IS_PKG_INSTALELD} ]]; then
            tmstmp=$(date +%T.%N)
            echo -ne "${tmstmp} : ${pkg} : Installaing --- : ${timestamp}\n"
            sudo apt-get install -y ${pkg}
            tmstmp=$(date +%T.%N)
            echo -ne "${TOPIC} --- Update and upgrade complete --- : ${timestamp}\n"
        else
            echo "${pkg} - is already installed"
        fi
    done
    IFS=${FieldSeparator}
}

# add LF and lf-view script

if [[ ! -d ${HOME}/.spin-off ]]
then
    echo -ne "\n\r Setup cannot be started! Please clone \"alexeygumirov/spin-off\" project to home directory.\n"
    exit 1
else
    SETUP_DIR="${HOME}/.spin-off"
fi

if [[ ! -d ${HOME}/source ]]; then
    mkdir ${HOME}/source
fi

if [[ ! -z $(uname -m | grep "x86_64") ]]
then
    PLATFORM="x86_64"
fi

if [[ ! -z $(uname -m | grep "armv7") ]]
then
    PLATFORM="armhf"
fi

SETUP_LOG="${HOME}/my_env_setup.log"
timestamp=$(date +%T.%N)
echo -ne "\r${timestamp}: Setup of environment is starting.\n" > "${SETUP_LOG}"


### {
# Begin - Repo update and upgrade 

TOPIC="APT Repository:"
timestamp=$(date +%T.%N)
echo -ne "${TOPIC} --- Update and upgrade --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
sudo apt-get update -y | tee -a "${SETUP_LOG}" 
sudo apt-get upgrade -y | tee -a "${SETUP_LOG}" 
timestamp=$(date +%T.%N)
echo -ne "${TOPIC} --- Update and upgrade complete --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"

# End - Repo update and upgrade
### }

### {
# Begin - software properties common

TOPIC="Software properties common:"
timestamp=$(date +%T.%N)
echo -ne "${TOPIC} --- Installing --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
sudo apt-get install software-properties-common -y | tee -a "${SETUP_LOG}"
timestamp=$(date +%T.%N)
echo -ne "${TOPIC} --- Installation complete --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"

# End - software properties common
### }

### {
# Begin - curl

TOPIC="curl:"
timestamp=$(date +%T.%N)
echo -ne "${TOPIC} --- Installing --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
sudo apt-get install curl -y | tee -a "${SETUP_LOG}"
timestamp=$(date +%T.%N)
echo -ne "${TOPIC} --- Installation complete --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"

# End - curl
### }

### {
# Begin - pip & pip3

TOPIC="pip & pip3:"
timestamp=$(date +%T.%N)
echo -ne "${TOPIC} --- Installing --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
sudo apt-get install python-pip -y | tee -a "${SETUP_LOG}"
sudo apt-get install python3-pip -y | tee -a "${SETUP_LOG}"
timestamp=$(date +%T.%N)
echo -ne "${TOPIC} --- Installation complete --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"

# End - pip & pip3
### }

### {
# Begin - pkg-config

TOPIC="pkg-config:"
timestamp=$(date +%T.%N)
echo -ne "${TOPIC} --- Installing --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
sudo apt-get install pkg-config -y | tee -a "${SETUP_LOG}"
timestamp=$(date +%T.%N)
echo -ne "${TOPIC} --- Installation complete --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"

# End - pkg-config
### }

### {
# Begin - libcairo2-dev

TOPIC="libcairo2-dev:"
timestamp=$(date +%T.%N)
echo -ne "${TOPIC} --- Installing --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
sudo apt-get install libcairo2-dev -y | tee -a "${SETUP_LOG}"
timestamp=$(date +%T.%N)
echo -ne "${TOPIC} --- Installation complete --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"

# End - libcairo2-dev
### }

### {
# Begin - libgirepository1.0-dev

TOPIC="libgirepository1.0-dev:"
timestamp=$(date +%T.%N)
echo -ne "${TOPIC} --- Installing --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
sudo apt install libgirepository1.0-dev -y | tee -a "${SETUP_LOG}"
timestamp=$(date +%T.%N)
echo -ne "${TOPIC} --- Installation complete --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"

# End - libgirepository1.0-dev
### }

### {
# Begin - Install NeoVIM

TOPIC="NeoVIM:"
NEOVIM_PLUG_DIR="${HOME}/.local/share/nvim/site/autoload"
NEOVIM_PLUGINS_DIR="${HOME}/.local/share/nvim/plugged"
NEOVIM_CONFIG_DIR="${HOME}/.config/nvim"

timestamp=$(date +%T.%N)
echo -ne "${TOPIC} --- Adding repository --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
sudo add-apt-repository ppa:neovim-ppa/unstable -y | tee -a "${SETUP_LOG}"

timestamp=$(date +%T.%N)
echo -ne "${TOPIC} --- Installing --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
sudo apt-get install neovim -y | tee -a "${SETUP_LOG}"

timestamp=$(date +%T.%N)
echo -ne "\n\r${TOPIC} --- Installation complete  --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"

timestamp=$(date +%T.%N)
echo -ne "\n\r${TOPIC} --- Download vim.plug --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
curl -fLo "$NEOVIM_PLUG_DIR"/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
timestamp=$(date +%T.%N)
echo -ne "\n\r${TOPIC} --- Downloading of vim.plug complete --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"

if [[ ! -d $NEOVIM_CONFIG_DIR ]]
then
	mkdir -p "$NEOVIM_CONFIG_DIR" | tee -a "${SETUP_LOG}"
fi
timestamp=$(date +%T.%N)
echo -ne "\n\r${TOPIC} --- Copy init.vim --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
cp "${SETUP_DIR}"/configs/neovim/init.vim "$NEOVIM_CONFIG_DIR"/ | tee -a "${SETUP_LOG}"
if [[ ! -d $NEOVIM_CONFIG_DIR/colors ]]
then
	mkdir -p "$NEOVIM_CONFIG_DIR"/colors | tee -a "${SETUP_LOG}"
fi
timestamp=$(date +%T.%N)
echo -ne "\n\r${TOPIC} --- Copy color scheme --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
cp "${SETUP_DIR}"/configs/vim_theme/PaperColor.vim "$NEOVIM_CONFIG_DIR"/colors/ | tee -a "${SETUP_LOG}"
if [[ ! -d $NEOVIM_PLUGINS_DIR ]]
then
	mkdir -p "$NEOVIM_PLUGINS_DIR" | tee -a "${SETUP_LOG}"
fi
timestamp=$(date +%T.%N)
echo -ne "\n\r${TOPIC} --- Installing \"pip3\" --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
sudo apt-get install python3-pip -y | tee -a "${SETUP_LOG}"
timestamp=$(date +%T.%N)
echo -ne "\n\r${TOPIC} --- Installing \"neovim\" --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
pip3 install --user neovim | tee -a "${SETUP_LOG}"
timestamp=$(date +%T.%N)
echo -ne "\n\r${TOPIC} --- Installing \"neovim-remote\" --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
pip3 install --user neovim-remote | tee -a "${SETUP_LOG}"
timestamp=$(date +%T.%N)
echo -ne "\n\r${TOPIC} --- Intstallation of \"neovim-remote\" complete --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
echo -ne "\n\r${TOPIC} --- Intstallation complete --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
# End - Install NeoVIM
### }

### {
# Begin - Install VIM
TOPIC="VIM:"
VIM_CONFIG_DIR="${HOME}/.vim"

timestamp=$(date +%T.%N)
echo -ne "${TOPIC} --- Removing \"vim-tiny\" --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
sudo apt-get remove -y vim-tiny | tee -a "${SETUP_LOG}"

timestamp=$(date +%T.%N)
echo -ne "${TOPIC} --- Installing --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
sudo apt-get install vim -y | tee -a "${SETUP_LOG}"
timestamp=$(date +%T.%N)
echo -ne "\n\r${TOPIC} --- Installation complete  --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"

timestamp=$(date +%T.%N)
echo -ne "\n\r${TOPIC} --- Download vim.plug --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
curl -fLo "$VIM_CONFIG_DIR"/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
timestamp=$(date +%T.%N)
echo -ne "\n\r${TOPIC} --- Downloading of vim.plug complete --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"

timestamp=$(date +%T.%N)
echo -ne "\n\r${TOPIC} --- Copy .vimrc --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
cp "${SETUP_DIR}"/configs/vim/.vimrc "${HOME}"/ | tee -a "${SETUP_LOG}"

if [[ ! -d $VIM_CONFIG_DIR/colors ]]
then
	mkdir -p "$VIM_CONFIG_DIR"/colors | tee -a "${SETUP_LOG}"
fi
timestamp=$(date +%T.%N)
echo -ne "\n\r${TOPIC} --- Copy color scheme --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
cp "${SETUP_DIR}"/configs/vim_theme/PaperColor.vim "$VIM_CONFIG_DIR"/colors/ | tee -a "${SETUP_LOG}"
if [[ ! -d $VIM_CONFIG_DIR/plugged ]]
then
	mkdir -p "$VIM_CONFIG_DIR"/plugged | tee -a "${SETUP_LOG}"
fi
timestamp=$(date +%T.%N)
echo -ne "\n\r${TOPIC} --- Make VIM system editor --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
sudo update-alternatives --config editor | tee -a "${SETUP_LOG}"
timestamp=$(date +%T.%N)
echo -ne "\n\r${TOPIC} --- Intstallation complete --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
# End - Install VIM
### }

### {
# Begin - Install TMUX
TOPIC="TMUX:"
TMUX_CONFIG_DIR="${HOME}/.tmux"
timestamp=$(date +%T.%N)
echo -ne "${TOPIC} --- Installing --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
sudo apt-get install -y tmux | tee -a "${SETUP_LOG}"
if [[ ! -d $TMUX_CONFIG_DIR/plugins ]]
then
    mkdir -p $TMUX_CONFIG_DIR/plugins 
fi
timestamp=$(date +%T.%N)
echo -ne "${TOPIC} --- TMUX plug --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
git clone https://github.com/tmux-plugins/tpm "$TMUX_CONFIG_DIR"/plugins/tpm | tee -a "${SETUP_LOG}"
timestamp=$(date +%T.%N)
echo -ne "\n\r${TOPIC} --- Copy .tmux.conf --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
if [[ -f ${HOME}/.tmux.conf ]]; then
    cp ${HOME}/.tmux.conf ${HOME}/.tmux.conf.spin-off.back | tee -a "${SETUP_LOG}"
fi
cp "${SETUP_DIR}"/configs/tmux/.tmux.conf "${HOME}"/ | tee -a "${SETUP_LOG}"
timestamp=$(date +%T.%N)
echo -ne "\n\r${TOPIC} --- Intstallation complete --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
# End - Install TMUX
### }

### {
# Begin - Install powerline for bash
TOPIC="Powerline:"
POWERLINE_CONFIG_DIR="${HOME}/.config/powerline"
timestamp=$(date +%T.%N)
echo -ne "${TOPIC} --- Installing --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
sudo apt-get install -y powerline | tee -a "${SETUP_LOG}"
if [[ ! -d $POWERLINE_CONFIG_DIR ]]
then
    mkdir -p $POWERLINE_CONFIG_DIR
fi
timestamp=$(date +%T.%N)
echo -ne "${TOPIC} --- Copy configs --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
cp -r "${SETUP_DIR}"/configs/powerline/* "$POWERLINE_CONFIG_DIR"/ | tee -a "${SETUP_LOG}"
timestamp=$(date +%T.%N)
echo -ne "${TOPIC} --- Installation complete --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
# End - Install powerline for bash
### }

### {
# Begin - Setup Bash environment
TOPIC="Bash environment:"
timestamp=$(date +%T.%N)
echo -ne "${TOPIC} --- creating my .bashrc file --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
if [[ -f ${HOME}/.bashrc ]]; then
    cp ${HOME}/.bashrc ${HOME}/.bashrc.spin-off.bak | tee -a "${SETUP_LOG}"
fi
cp "${SETUP_DIR}"/configs/.bashrc "${HOME}"/ | tee -a "${SETUP_LOG}"

if [[ -f ${HOME}/.bashrc_aliases ]]; then
    cp ${HOME}/.bashrc_aliases ${HOME}/.bashrc_aliases.spin-off.bak | tee -a "${SETUP_LOG}"
fi
cp "${SETUP_DIR}"/configs/.bashrc_aliases "${HOME}"/ | tee -a "${SETUP_LOG}"

if [[ -f ${HOME}/.inputrc ]]; then
    cp ${HOME}/.inputrc ${HOME}/.inputrc.spin-off.bak | tee -a "${SETUP_LOG}"
fi
cp "${SETUP_DIR}"/configs/.inputrc "${HOME}"/ | tee -a "${SETUP_LOG}"

if [[ -f ${HOME}/.dircolors ]]; then
    cp ${HOME}/.dircolors ${HOME}/.dircolors.spin-off.bak | tee -a "${SETUP_LOG}"
fi
cp "${SETUP_DIR}"/configs/.dircolors "${HOME}"/ | tee -a "${SETUP_LOG}"
echo -ne "${TOPIC} --- Bash setup is complete --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
# End - Setup Bash environment
### }

### {
# Begin - Install FZF and FD
TOPIC="FZF & FD:"
timestamp=$(date +%T.%N)
echo -ne "\n\r${TOPIC} --- Installting fd --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
FD_x64="https://github.com/sharkdp/fd/releases/download/v${FD_VER}/fd_${FD_VER}_amd64.deb"
FD_ARM="https://github.com/sharkdp/fd/releases/download/v${FD_VER}/fd_${FD_VER}_armhf.deb"
case ${PLATFORM} in
    "x86_64")
        pushd ${HOME}/source | tee -a "${SETUP_LOG}"
        curl -OL "${FD_x64}" | tee -a "${SETUP_LOG}"
        sudo dpkg -i fd_${FD_VER}_amd64.deb | tee -a "${SETUP_LOG}"
        popd  | tee -a "${SETUP_LOG}"
        ;;
    "armhf")
        pushd ${HOME}/source | tee -a "${SETUP_LOG}"
        curl -OL "${FD_ARM}" | tee -a "${SETUP_LOG}"
        sudo dpkg -i fd_${FD_VER}_armhf.deb | tee -a "${SETUP_LOG}"
        popd  | tee -a "${SETUP_LOG}"
        ;;
    *)
        echo -ne "\n\r${TOPIC} --- FD cannot be installed. Please visit https://github.com/sharkdp/fd/releases for version to your platform. --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
        ;;
esac
timestamp=$(date +%T.%N)
echo -ne "\n\r${TOPIC} --- Installting silversearcher-ag --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
sudo apt-get install -y silversearcher-ag | tee -a "${SETUP_LOG}"
timestamp=$(date +%T.%N)
RIPGREP_x64="https://github.com/BurntSushi/ripgrep/releases/download/${RIPGREP_VER}/ripgrep_${RIPGREP_VER}_amd64.deb"
case ${PLATFORM} in
    "x86_64")
        echo -ne "\n\r${TOPIC} --- Installting ripgrep --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
        pushd ${HOME}/source | tee -a "${SETUP_LOG}"
        curl -OL "${RIPGREP_x64}" | tee -a "${SETUP_LOG}"
        sudo dpkg -i ripgrep_${RIPGREP_VER}_amd64.deb | tee -a "${SETUP_LOG}"
        popd  | tee -a "${SETUP_LOG}"
        ;;
    *)
        echo -ne "\n\r${TOPIC} --- ripgrep cannot be installed. Please visit https://github.com/BurntSushi/ripgrep/releases for version to your platform. --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
        ;;
esac
timestamp=$(date +%T.%N)
echo -ne "\n\r${TOPIC} --- Installting fzf --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf | tee -a "${SETUP_LOG}"
~/.fzf/install | tee -a "${SETUP_LOG}"
timestamp=$(date +%T.%N)
echo -ne "\n\r${TOPIC} --- Installation complete --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"

# End - Install FZF
### }

### {
# Begin - Install BAT viewer
TOPIC="bat:"
timestamp=$(date +%T.%N)
BAT_VIEWER_x64="https://github.com/sharkdp/bat/releases/download/v${BAT_VIEWER_VER}/bat_${BAT_VIEWER_VER}_amd64.deb"
BAT_VIEWER_ARM="https://github.com/sharkdp/bat/releases/download/v${BAT_VIEWER_VER}/bat_${BAT_VIEWER_VER}_armhf.deb"
echo -ne "\n\r${TOPIC} --- Installting bat --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
case ${PLATFORM} in
    "x86_64")
        pushd ${HOME}/source | tee -a "${SETUP_LOG}"
        curl -OL "${BAT_VIEWER_x64}" | tee -a "${SETUP_LOG}"
        sudo dpkg -i bat_${BAT_VIEWER_VER}_amd64.deb | tee -a "${SETUP_LOG}"
        popd  | tee -a "${SETUP_LOG}" | tee -a "${SETUP_LOG}"
        mkdir -p ${HOME}/.config/bat | tee -a "${SETUP_LOG}"
        cp ${SETUP_DIR}/configs/bat/config ${HOME}/.config/bat/ | tee -a "${SETUP_LOG}"
        ;;
    "armhf")
        pushd ${HOME}/source | tee -a "${SETUP_LOG}"
        curl -OL "${BAT_VIEWER_ARM}" | tee -a "${SETUP_LOG}"
        sudo dpkg -i bat_${BAT_VIEWER_VER}_armhf.deb | tee -a "${SETUP_LOG}"
        popd  | tee -a "${SETUP_LOG}"
        mkdir -p ${HOME}/.config/bat | tee -a "${SETUP_LOG}"
        cp ${SETUP_DIR}/configs/bat/config ${HOME}/.config/bat/ | tee -a "${SETUP_LOG}"
        ;;
    *)
        echo -ne "\n\r${TOPIC} --- bat cannot be installed. Please visit https://github.com/sharkdp/bat/releases for version to your platform. --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
        ;;
esac
timestamp=$(date +%T.%N)
echo -ne "\n\r${TOPIC} --- Installation complete --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
# End - Install FZF
### }

### {
# Copy of my headers
TOPIC="my headers:"
timestamp=$(date +%T.%N)
echo -ne "\n\r${TOPIC} --- Copying my headers --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
mkdir -p ~/.config/myheaders | tee -a "${SETUP_LOG}"
cp "${SETUP_DIR}"/configs/myheaders/* ~/.config/myheaders | tee -a "${SETUP_LOG}"
timestamp=$(date +%T.%N)
echo -ne "\n\r${TOPIC} --- Copying complete --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
# End - Copy of my headers
### }

### {
# installation of 'tree'
TOPIC="tree:"
timestamp=$(date +%T.%N)
echo -ne "\n\r${TOPIC} --- Installing  --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
sudo apt-get install tree -y | tee -a "${SETUP_LOG}"
timestamp=$(date +%T.%N)
echo -ne "\n\r${TOPIC} --- Installation complete --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
# End - Installation of 'tree'
### }

### {
# installation of powerline fonts
TOPIC="powerline fonts:"
timestamp=$(date +%T.%N)
echo -ne "\n\r${TOPIC} --- Installing  --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
sudo apt-get install fonts-powerline -y | tee -a "${SETUP_LOG}"
timestamp=$(date +%T.%N)
echo -ne "\n\r${TOPIC} --- Installation complete --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
# End - Installation of powerline fonts
### }

### {
# Begin - copy scripts
TOPIC="copy scripts:"
timestamp=$(date +%T.%N)
echo -ne "\n\r${TOPIC} --- copying  --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
mkdir ${HOME}/.scripts | tee -a "${SETUP_LOG}"
cp "${SETUP_DIR}"/scripts/* ${HOME}/.scripts | tee -a "${SETUP_LOG}"
chmod 774 ${HOME}/.scripts/* | tee -a "${SETUP_LOG}"
timestamp=$(date +%T.%N)
echo -ne "\n\r${TOPIC} --- copying complete --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
# End - copy scripts
### }

### {
# Begin - Golang installation
TOPIC="Golang:"
timestamp=$(date +%T.%N)
echo -ne "\n\r${TOPIC} --- Installing --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
GO_x64="https://dl.google.com/go/go${GO_VER}.linux-amd64.tar.gz"
GO_ARM="https://dl.google.com/go/go${GO_VER}.linux-armv6l.tar.gz"
case ${PLATFORM} in
    "x86_64")
        pushd ${HOME}/source | tee -a "${SETUP_LOG}"
        curl -LO "${GO_x64}" | tee -a "${SETUP_LOG}"
        sudo rm -Rf /usr/local/go | tee -a "${SETUP_LOG}"
        sudo tar -C /usr/local -xzf go${GO_VER}.linux-amd64.tar.gz | tee -a "${SETUP_LOG}"
        popd | tee -a "${SETUP_LOG}"
        ;;
    "armhf")
        pushd ${HOME}/source | tee -a "${SETUP_LOG}"
        curl -LO "${GO_ARM}" | tee -a "${SETUP_LOG}"
        sudo rm -Rf /usr/local/go | tee -a "${SETUP_LOG}"
        sudo tar -C /usr/local -xzf go${GO_VER}.linux-rmfv6l.tar.gz | tee -a "${SETUP_LOG}"
        popd | tee -a "${SETUP_LOG}"
        ;;
    *)
        echo -ne "\n\r${TOPIC} --- golang cannot be installed. Please visit https://golang.org/dl/ for version to your platform. --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
        ;;
esac
timestamp=$(date +%T.%N)
echo -ne "\n\r${TOPIC} --- Installation complete --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
# End - Golang installation
### }


### {
# Begin - Mediainfo installation
TOPIC="Mediainfo:"
timestamp=$(date +%T.%N)
echo -ne "\n\r${TOPIC} --- Installing --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
sudo apt-get install mediainfo -y | tee -a "${SETUP_LOG}"
timestamp=$(date +%T.%N)
echo -ne "\n\r${TOPIC} --- Installation complete --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
# End - Mediainfo installation
### }

### {
# Begin - p7zip installation
TOPIC="p7zip:"
timestamp=$(date +%T.%N)
echo -ne "\n\r${TOPIC} --- Installing --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
sudo apt-get install p7zip -y | tee -a "${SETUP_LOG}"
timestamp=$(date +%T.%N)
echo -ne "\n\r${TOPIC} --- Installation complete --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
# End - p7zip installation
### }

### {
# Begin - unrar installation
TOPIC="unrar:"
timestamp=$(date +%T.%N)
echo -ne "\n\r${TOPIC} --- Installing --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
sudo apt-get install unrar -y | tee -a "${SETUP_LOG}"
timestamp=$(date +%T.%N)
echo -ne "\n\r${TOPIC} --- Installation complete --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
# End - unrar installation
### }

### {
# Begin - xpdf installation
TOPIC="xpdf:"
timestamp=$(date +%T.%N)
echo -ne "\n\r${TOPIC} --- Installing --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
sudo apt-get install xpdf -y | tee -a "${SETUP_LOG}"
timestamp=$(date +%T.%N)
echo -ne "\n\r${TOPIC} --- Installation complete --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
# End - xpdf installation
### }

### {
# Begin - install lf from the source
TOPIC="LF:"
timestamp=$(date +%T.%N)
if [[ -z $(type -P go) ]]; then
   echo -ne "\n\r${TOPIC}: LF cannot be installed, please install Golang first." | tee -a "${SETUP_LOG}" 
else
    echo -ne "\n\r${TOPIC} --- Installing --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
    go get -u github.com/gokcehan/lf | tee -a "${SETUP_LOG}"
    timestamp=$(date +%T.%N)
    echo -ne "\n\r${TOPIC} --- Installation complete --- : ${timestamp}\n" | tee -a "${SETUP_LOG}"
    mkdir -p ${HOME}/.config/lf | tee -a "${SETUP_LOG}"
    cp ${SETUP_DIR}/configs/lf/lfrc ${HOME}/.config/lf/ | tee -a "${SETUP_LOG}"
fi
# End - LF installation
### }
