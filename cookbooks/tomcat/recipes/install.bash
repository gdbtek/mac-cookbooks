#!/bin/bash

function install()
{
    # Clean Up

    rm -rf "${installFolder}"
    mkdir -p "${installFolder}"

    # Install

    unzipRemoteFile "${downloadURL}" "${installFolder}"
}

function main()
{
    appPath="$(cd "$(dirname "${0}")" && pwd)"

    source "${appPath}/../../../lib/util.bash" || exit 1
    source "${appPath}/../attributes/default.bash" || exit 1

    header 'INSTALLING TOMCAT'

    install
}

main "${@}"
