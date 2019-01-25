#!/bin/bash -e

function main()
{
    source "$(dirname "${BASH_SOURCE[0]}")/../../../libraries/util.bash"

    checkRequireMacSystem
    checkRequireRootUser

    sudo -u "${SUDO_USER}" packer --version
    chown -R "${SUDO_USER}:$(getUserGroupName "${SUDO_USER}")" "$(getUserHomeFolder "${SUDO_USER}")/.packer.d"
}

main "${@}"