#!/bin/bash -e

function main()
{
    source "$(dirname "${BASH_SOURCE[0]}")/../libraries/util.bash"

    # Validations

    checkRequireMacSystem
    checkRequireNonRootUser

    # Clean Up

    header 'CLEANING UP BREW'

    HOMEBREW_NO_ENV_HINTS=TRUE
    HOMEBREW_NO_INSTALL_CLEANUP=FALSE

    brew cleanup
    initializeFolder "$(brew --cache)"
    brew doctor || true
}

main "${@}"