#!/bin/bash -e

function main()
{
    source "$(dirname "${BASH_SOURCE[0]}")/../libraries/util.bash"

    # Validations

    checkRequireMacSystem
    checkRequireNonRootUser

    # Upgrade Brew

    header 'UPGRADING BREW'

    if [[ "$(existCommand 'brew')" = 'false' ]]
    then
        export PATH="/opt/homebrew/bin:${PATH}"
    fi

    brew update
    brew upgrade
    brew upgrade --cask

    # Clean Up Brew

    "$(dirname "${BASH_SOURCE[0]}")/clean-up-brew.bash"
}

main "${@}"