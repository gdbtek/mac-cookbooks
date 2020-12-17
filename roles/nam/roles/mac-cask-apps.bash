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
        'microsoft-word'
        'tower'
        'transmit'
        'visual-studio-code'
        'vmware-fusion'
        # 'adobe-acrobat-reader'
        # 'paw'
        # 'virtualbox'
    )

    # Install

    source "$(dirname "${BASH_SOURCE[0]}")/../../../libraries/util.bash"

    "$(dirname "${BASH_SOURCE[0]}")/../../../tools/install-brew-applications.bash" \
        --cask-package-names "$(arrayToString "${caskPackageNames[@]}")"
}

main "${@}"