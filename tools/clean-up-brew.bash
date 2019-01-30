#!/bin/bash -e

function main()
{
    source "$(dirname "${BASH_SOURCE[0]}")/../libraries/util.bash"

    # Validations

    checkRequireMacSystem
    checkRequireNonRootUser

    # Update Brew

    header 'UPDATING AND UPGRADING BREW'

    brew update
    brew upgrade

    # Clean Up

    header 'CLEANING UP BREW'

    brew cleanup
    initializeFolder "$(brew --cache)"
    brew doctor || true
}

main "${@}"