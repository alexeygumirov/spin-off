#!/bin/bash

PLATFORM=""

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
chromium-browser\
"

BAT_VIEWER_VER="0.15.0"
FD_VER="8.0.0"
RIPGREP_VER="12.0.1"
GO_VER="1.14.2"

# List format: platform:URL
DEB_LIST_x86_64="\
bat;${BAT_VIEWER_VER};https://github.com/sharkdp/bat/releases/download/v${BAT_VIEWER_VER}/bat_${BAT_VIEWER_VER}_amd64.deb,\
fd;${FD_VER};https://github.com/sharkdp/fd/releases/download/v${FD_VER}/fd_${FD_VER}_amd64.deb,\
ripgrep;${RIPGREP_VER};https://github.com/BurntSushi/ripgrep/releases/download/${RIPGREP_VER}/ripgrep_${RIPGREP_VER}_amd64.deb\
"

DEB_LIST_armhf="\
bat;${BAT_VIEWER_VER};https://github.com/sharkdp/bat/releases/download/v${BAT_VIEWER_VER}/bat_${BAT_VIEWER_VER}_armhf.deb,\
fd;${FD_VER};https://github.com/sharkdp/fd/releases/download/v${FD_VER}/fd_${FD_VER}_armhf.deb,\
"

function pkginstall() {
    local FieldSeparator=$IFS
    IFS=','
    local IS_PKG_INSTALELD=""
    for pkg in ${PKG_LIST};
    do
        IS_PKG_INSTALELD=$(dpkg-query -W -f='${Status}' ${pkg} | awk '{ print $3 }' | grep "^installed$")
        if [[ -z ${IS_PKG_INSTALELD} ]]; then
            # sudo apt-get install -y ${pkg}
            echo "${pkg} - Not installed"
        else
            echo "${pkg} - ${IS_PKG_INSTALELD}"
        fi
    done
    IFS=${FieldSeparator}
}

function printtail() {
    local FieldSeparator=$IFS
    IFS=','
    local deb_name=""
    local pkg_installed=""
    local pkg_installed_ver=""
    local pkg_ver=""
    local pkg_name=""
    local fqdn=""
    local current_path=$(pwd)
    local DEB_LIST=""
    echo "${current_path}"
    case ${PLATFORM} in
        "x86_64")
            DEB_LIST=${DEB_LIST_x86_64}
            ;;
        "armhf")
            DEB_LIST=${DEB_LIST_armhf}
            ;;
        *)
            echo -ne "Your platform is not supported"
            ;;
    esac
    for line in ${DEB_LIST};
    do
        pkg_name=$(echo "${line}" | cut -d';' -f1)
        deb_name=$(echo "${line}" | awk -F'/' '{ print $NF }')
        fqdn=$(echo "${line}" | cut -d';' -f3-)
        pkg_installed=$(dpkg-query -W -f='${Status}' ${pkg_name} 2> /dev/null | awk '{ print $3 }' | grep "^installed$")
        if [[ -z ${pkg_installed} ]]; then
            echo -e "package is not installed\n"
            cd ${HOME}/source 
            curl -OL "${fqdn}"
            cd "${current_path}"
            echo -e "${deb_name}, platform: ${platf}, URL: ${fqdn}\n"
        else
            echo -e "${pkg_name} is installed\n"
            pkg_installed_ver=$(dpkg-query -W -f='${Version}' ${pkg_name} 2> /dev/null)
            pkg_ver=$(echo "${line}" | cut -d';' -f2)
            if [[ ${pkg_installed_ver} != ${pkg_ver} ]]; then
                echo -e "${pkg_name} installed version: ${pkg_installed_ver}, new version: ${pkg_ver}.\n"
            else
                echo -e "${pkg_name} installed version: ${pkg_installed_ver}, new version: ${pkg_ver}.\n"
            fi
        fi
    done
    IFS=${FieldSeparator}
}

if [[ ! -z $(uname -m | grep "x86_64") ]]
then
    PLATFORM="x86_64"
fi

if [[ ! -z $(uname -m | grep "armv7") ]]
then
    PLATFORM="armhf"
fi

printtail
