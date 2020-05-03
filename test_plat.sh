#!/bin/bash

platform=$(uname -m)

case ${platform} in
    armv*)
        echo "${platform} is ARM 32 bit based"
        ;;
    arm64)
        echo "${platform} is ARM 64 bit based"
        ;;
    x86_64)
        echo "${platform} is Intex x86/AMD64"
        ;;
    *)
        echo "Your platform is not supported"
        ;;
esac
