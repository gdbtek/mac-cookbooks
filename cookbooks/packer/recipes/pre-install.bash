#!/bin/bash -e

function main()
{
    source "$(dirname "${BASH_SOURCE[0]}")/../../../libraries/util.bash"

    checkRequireMacSystem
    checkRequireRootUser

    rm -f -r -v "$(getUserHomeFolder "${SUDO_USER}")/.packer.d"
}

main "${@}"