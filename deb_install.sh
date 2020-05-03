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

# This script installs my deb packages
# DEB:
#   FD: https://github.com/sharkdp/fd
#   Ripgrep: https://github.com/BurntSushi/ripgrep
#   FZF: https://github.com/junegunn/fzf ### is installed from the GitHub repo and updated with the NVIM plugin automatically.
#   BAT: https://github.com/sharkdp/bat
#   LF: https://github.com/gokcehan/lf

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
fd;${FD_VER};https://github.com/sharkdp/fd/releases/download/v${FD_VER}/fd_${FD_VER}_armhf.deb\
"

function debinstall() {
    local FieldSeparator=$IFS
    IFS=','
    local pkg_name=""
    local pkg_version=""
    local pkg_curr_version=""
    local deb_name=""
    local fqdn=""
    local platf=""
    local current_path=$(pwd)
    local uname_res=$(uname -m)
    local DEB_LIST=""
    case ${uname_res} in
        armv*)
            DEB_LIST=${DEB_LIST_armhf}
            ;;
        x86_64)
            DEB_LIST=${DEB_LIST_x86_64}
            ;;
        *)
            echo "Your platform is not supported"
            return 1
            ;;
    esac
    for line in ${DEB_LIST};
    do
        pkg_name=$(echo "${line}" | cut -d';' -f1)
        pkg_version=$(echo "${line}" | cut -d';' -f2)
        fqdn=$(echo "${line}" | cut -d';' -f3-)
        deb_name=$(echo "${line}" | awk -F'/' '{ print $NF }')
        if [[ ${PLATFORM} = ${platf} ]]; then
            pkg_installed=$(dpkg-query -W -f='${Status}' ${pkg_name} 2> /dev/null | awk '{ print $3 }' | grep "^installed$")
            if [[ -z ${pkg_installed} ]]; then
                tmstmp=$(date +%T.%N)
                echo -ne "${tmstmp} : ${deb_name} : Installing.\n"
                cd ${HOME}/source 
                curl -OL "${fqdn}"
                sudo dpkg -i "${deb_name}"
                cd "${current_path}"
                tmstmp=$(date +%T.%N)
                echo -ne "${tmstmp} : ${pkg} : Installation complete.\n"
            else
                pkg_curr_version=$(dpkg-query -W -f='${Version}' ${pkg_name} 2> /dev/null)
                if [[ ${pkg_version} != ${pkg_curr_version} ]]; then
                    tmstmp=$(date +%T.%N)
                    echo -ne "${tmstmp} : ${deb_name} : Updating.\n"
                    cd ${HOME}/source 
                    curl -OL "${fqdn}"
                    sudo dpkg -i "${deb_name}"
                    cd "${current_path}"
                    tmstmp=$(date +%T.%N)
                    echo -ne "${tmstmp} : ${pkg} : Update complete.\n"
                fi
            fi
        fi
    done
    IFS=${FieldSeparator}
    return 0
}

if [[ ! -d ${HOME}/source ]]; then
    mkdir ${HOME}/source
fi

debinstall
