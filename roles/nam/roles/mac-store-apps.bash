#!/bin/bash -e

function main()
{
    # Packages

    local -r storeAppNames=(
        'Amphetamine'
        'CopyClip 2 - Clipboard Manager'
        'Microsoft Excel'
        'Microsoft Outlook'
        'Slack'
        'SnippetsLab'
        # 'Final Cut Pro'
        # 'Magnet'
        # 'Microsoft Word'
        # 'Numbers'
        # 'Page Screenshot for Safari'
        # 'Pages'
    )

    # Install

    source "$(dirname "${BASH_SOURCE[0]}")/../../../libraries/util.bash"

    "$(dirname "${BASH_SOURCE[0]}")/../../../tools/install-mas-applications.bash" \
        --app-names "$(arrayToString "${storeAppNames[@]}")"
}

main "${@}"