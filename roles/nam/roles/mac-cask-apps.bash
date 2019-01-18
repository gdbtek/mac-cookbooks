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
        'iterm2'
        'tower'
        'transmit'
        'visual-studio-code'
        'vmware-fusion'
    )

    # Install

    source "$(dirname "${BASH_SOURCE[0]}")/../../../libraries/util.bash"

    checkRequireNonRootUser

    "$(dirname "${BASH_SOURCE[0]}")/../../../tools/install-brew-applications.bash" \
        --cask-package-names "$(arrayToString "${caskPackageNames[@]}")"

    postUpMessage
}

main "${@}"