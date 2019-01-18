#!/bin/bash -e

function main()
{
    # Packages

    local -r storeAppNames=(
        'Amphetamine'
        'CopyClip 2'
        'Magnet'
        'Microsoft Remote Desktop 10'
        'Slack'
        'SnippetsLab'
    )

    # Install

    source "$(dirname "${BASH_SOURCE[0]}")/../../../libraries/util.bash"

    checkRequireNonRootUser

    "$(dirname "${BASH_SOURCE[0]}")/../../../tools/install-mas-applications.bash" \
        --app-names "$(arrayToString "${storeAppNames[@]}")"

    postUpMessage
}

main "${@}"