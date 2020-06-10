#!/bin/bash -e

function main()
{
    source "$(dirname "${BASH_SOURCE[0]}")/../libraries/util.bash"

    # Validations

    checkRequireMacSystem
    checkRequireNonRootUser

    # Empty Trash

    osascript -e 'tell application "Finder" to empty the trash' 2> '/dev/null' || true
}

main "${@}"