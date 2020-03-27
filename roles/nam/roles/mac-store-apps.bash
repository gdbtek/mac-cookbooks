#!/bin/bash -e

function main()
{
    # Packages

    local -r storeAppNames=(
        'Amphetamine'
        'Magnet'
        'Microsoft Remote Desktop 10'
        'Slack'
        'SnippetsLab'
        # 'CopyClip 2 - Clipboard Manager'
    )

    # Install

    source "$(dirname "${BASH_SOURCE[0]}")/../../../libraries/util.bash"

    "$(dirname "${BASH_SOURCE[0]}")/../../../tools/install-mas-applications.bash" \
        --app-names "$(arrayToString "${storeAppNames[@]}")"
}

main "${@}"