#!/bin/bash -e

function main()
{
    source "$(dirname "${BASH_SOURCE[0]}")/../libraries/util.bash"

    # Validations

    checkRequireMacSystem
    checkRequireNonRootUser

    # Upgrade Brew

    header 'UPGRADING BREW'

    brew update
    brew upgrade
    brew upgrade --cask

    # Clean Up Brew

    "$(dirname "${BASH_SOURCE[0]}")/clean-up-brew.bash"
}

main "${@}"