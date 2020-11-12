#!/bin/bash -e

function main()
{
    source "$(dirname "${BASH_SOURCE[0]}")/../libraries/util.bash"

    # Validations

    checkRequireMacSystem
    checkRequireRootUser

    # List and Update

    header 'LISTING AVAILABLE SOFTWARE UPDATES'
    softwareupdate --list

    header 'UPDATING SOFTWARE'
    softwareupdate --all --force --install
}

main "${@}"