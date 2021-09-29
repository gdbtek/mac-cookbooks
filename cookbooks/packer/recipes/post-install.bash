#!/bin/bash -e

function main()
{
    source "$(dirname "${BASH_SOURCE[0]}")/../../../libraries/util.bash"

    checkRequireMacSystem
    checkRequireRootUser

    sudo -u "${SUDO_USER}" packer --version

    if [[ -d "$(getUserHomeFolder "${SUDO_USER}")/.packer.d" ]]
    then
        resetFolderPermission "$(getUserHomeFolder "${SUDO_USER}")/.packer.d" "${SUDO_USER}" "$(getUserGroupName "${SUDO_USER}")"
    fi
}

main "${@}"