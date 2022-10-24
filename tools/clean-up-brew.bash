#!/bin/bash -e

function main()
{
    source "$(dirname "${BASH_SOURCE[0]}")/../libraries/util.bash"

    # Validations

    checkRequireMacSystem
    checkRequireNonRootUser

    # Clean Up

    header 'CLEANING UP BREW'

    export HOMEBREW_NO_ENV_HINTS=1

    brew cleanup
    initializeFolder "$(brew --cache)"
    brew doctor || true
}

main "${@}"