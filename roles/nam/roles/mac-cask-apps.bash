#!/bin/bash -e

function main()
{
    # Packages

    local -r caskPackageNames=(
        '1password'
        'adobe-acrobat-reader'
        'beyond-compare'
        'blue-jeans'
        'docker'
        'dropbox'
        'goofy'
        'google-backup-and-sync'
        'google-chrome'
        'microsoft-teams'
        'paw'
        'tower'
        'transmit'
        'virtualbox'
        'visual-studio-code'
        'vmware-fusion'
    )

    # Install

    source "$(dirname "${BASH_SOURCE[0]}")/../../../libraries/util.bash"

    "$(dirname "${BASH_SOURCE[0]}")/../../../tools/install-brew-applications.bash" \
        --cask-package-names "$(arrayToString "${caskPackageNames[@]}")"
}

main "${@}"