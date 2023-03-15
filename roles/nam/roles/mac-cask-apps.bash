#!/bin/bash -e

function main()
{
    # Packages

    local -r packageNames=(
        '1password'
        'dropbox'
        'google-chrome'
        'google-drive'
        'microsoft-teams'
        'sourcetree'
        'visual-studio-code'
        # 'adobe-acrobat-reader'
        # 'beyond-compare'
        # 'transmit'
        # 'vmware-fusion'
    )

    # Install

    source "$(dirname "${BASH_SOURCE[0]}")/../../../libraries/util.bash"

    "$(dirname "${BASH_SOURCE[0]}")/../../../tools/install-brew-applications.bash" \
        --package-names "$(arrayToString "${packageNames[@]}")"
}

main "${@}"