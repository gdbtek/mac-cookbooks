#!/bin/bash

function install()
{
    # Clean Up

    sudo rm -rf "${installFolder}"
    mkdir -p "${installFolder}"

    # Install

    unzipRemoteFile "${downloadURL}" "${installFolder}" 'tar.gz'

    "${installFolder}/bin/brew" doctor
    "${installFolder}/bin/brew" update
}

function main()
{
    appPath="$(cd "$(dirname "${0}")" && pwd)"

    source "${appPath}/../../../lib/util.bash" || exit 1
    source "${appPath}/../attributes/default.bash" || exit 1

    header 'INSTALLING BREW'

    install
}

main "${@}"
