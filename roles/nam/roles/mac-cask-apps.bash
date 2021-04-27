#!/bin/bash -e

function main()
{
    # Packages

    local -r caskPackageNames=(
        '1password'
        'beyond-compare'
        'dropbox'
        'google-backup-and-sync'
        'google-chrome'
        'microsoft-excel'
        'microsoft-outlook'
        'sourcetree'
        'transmit'
        'visual-studio-code'
        # 'adobe-acrobat-reader'
        # 'blue-jeans'
        # 'microsoft-word'
        # 'paw'
        # 'tower'
        # 'virtualbox'
        # 'vmware-fusion'
        # 'zoom'
    )

    # Install

    source "$(dirname "${BASH_SOURCE[0]}")/../../../libraries/util.bash"

    "$(dirname "${BASH_SOURCE[0]}")/../../../tools/install-brew-applications.bash" \
        --cask-package-names "$(arrayToString "${caskPackageNames[@]}")"
}

main "${@}"