#!/bin/bash -e

function main()
{
    source "$(dirname "${BASH_SOURCE[0]}")/../../../libraries/util.bash"

    checkRequireMacSystem
    checkRequireRootUser

    sudo -u "${SUDO_USER}" terraform -version
    resetFolderPermission "$(getUserHomeFolder "${SUDO_USER}")/.terraform.d" "${SUDO_USER}" "$(getUserGroupName "${SUDO_USER}")"
}

main "${@}"