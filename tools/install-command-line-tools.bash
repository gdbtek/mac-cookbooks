#!/bin/bash -e

function main()
{
    source "$(dirname "${BASH_SOURCE[0]}")/../libraries/util.bash"

    # Validations

    checkRequireMacSystem
    checkRequireNonRootUser

    # Install

    header 'INSTALLING COMMAND LINE TOOLS'

    xcode-select --install || true
}

main "${@}"