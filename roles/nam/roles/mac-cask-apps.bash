#!/bin/bash -e

function main()
{
    # Packages

    local -r caskPackageNames=(
        '1password'
        'beyond-compare'
        'blue-jeans'
        'dropbox'
        'goofy'
        'google-backup-and-sync'
        'google-chrome'
        'tower'
        'visual-studio-code'
        # 'adobe-acrobat-reader'
        # 'docker'
        # 'microsoft-teams'
        # 'paw'
        # 'transmit'
        # 'virtualbox'
        # 'vmware-fusion'
    )

    # Install

    source "$(dirname "${BASH_SOURCE[0]}")/../../../libraries/util.bash"

    "$(dirname "${BASH_SOURCE[0]}")/../../../tools/install-brew-applications.bash" \
        --cask-package-names "$(arrayToString "${caskPackageNames[@]}")"
}

main "${@}"