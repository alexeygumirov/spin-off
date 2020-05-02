#!/bin/bash

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

function pkginstall() {
    FieldSeparator=$IFS
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
    local IS_PKG_INSTALELD="Unknown"
    IFS=${FieldSeparator}
}

pkginstall
