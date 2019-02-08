#!/bin/bash -e

function main()
{
    # Packages

    local -r storeAppNames=(
        'Amphetamine'
        'CopyClip 2 - Clipboard Manager'
        'Magnet'
        'Microsoft Remote Desktop 10'
        'Slack'
        'SnippetsLab'
        'Xcode'
    )

    # Install

    source "$(dirname "${BASH_SOURCE[0]}")/../../../libraries/util.bash"

    "$(dirname "${BASH_SOURCE[0]}")/../../../tools/install-mas-applications.bash" \
        --app-names "$(arrayToString "${storeAppNames[@]}")"
}

main "${@}"