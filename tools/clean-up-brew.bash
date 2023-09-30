#!/bin/bash -e

function main()
{
    source "$(dirname "${BASH_SOURCE[0]}")/../libraries/util.bash"

    # Validations

    checkRequireMacSystem
    checkRequireNonRootUser

    # Clean Up

    header 'CLEANING UP BREW'

    '/opt/homebrew/bin/brew' cleanup
    initializeFolder "$('/opt/homebrew/bin/brew' --cache)"
    '/opt/homebrew/bin/brew' doctor || true
}

main "${@}"