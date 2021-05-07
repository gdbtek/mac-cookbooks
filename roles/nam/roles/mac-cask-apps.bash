#!/bin/bash -e

function main()
{
    # Packages

    local -r caskPackageNames=(
        '1password'
        'dropbox'
        'google-backup-and-sync'
        'microsoft-teams'
        'sourcetree'
        'visual-studio-code'
        # 'adobe-acrobat-reader'
        # 'beyond-compare'
        # 'google-chrome'
        # 'transmit'
        # 'vmware-fusion'
    )

    # Install

    source "$(dirname "${BASH_SOURCE[0]}")/../../../libraries/util.bash"

    "$(dirname "${BASH_SOURCE[0]}")/../../../tools/install-brew-applications.bash" \
        --cask-package-names "$(arrayToString "${caskPackageNames[@]}")"
}

main "${@}"