#!/bin/bash -e

function main()
{
    # Packages

    local -r caskPackageNames=(
        '1password'
        'beyond-compare'
        'blue-jeans'
        'dropbox'
        'google-backup-and-sync'
        'google-chrome'
        'microsoft-excel'
        'microsoft-outlook'
        'tower'
        'transmit'
        'visual-studio-code'
        'vmware-fusion'
        # 'adobe-acrobat-reader'
        # 'microsoft-word'
        # 'paw'
        # 'virtualbox'
        # 'zoom'
    )

    # Install

    source "$(dirname "${BASH_SOURCE[0]}")/../../../libraries/util.bash"

    "$(dirname "${BASH_SOURCE[0]}")/../../../tools/install-brew-applications.bash" \
        --cask-package-names "$(arrayToString "${caskPackageNames[@]}")"
}

main "${@}"