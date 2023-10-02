#!/bin/bash -e

function main()
{
    source "$(dirname "${BASH_SOURCE[0]}")/../libraries/util.bash"

    # Validations

    checkRequireMacSystem
    checkRequireNonRootUser

    # Clean Up

    header 'CLEANING UP BREW'

    if [[ "$(existCommand 'brew')" = 'false' ]]
    then
        export PATH="/opt/homebrew/bin:${PATH}"
    fi

    brew cleanup
    initializeFolder "$(brew --cache)"
    brew doctor || true
}

main "${@}"