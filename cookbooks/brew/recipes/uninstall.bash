#!/bin/bash -e

function uninstall()
{
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)" || true
    rm -f -r '/usr/local/var' '/usr/local/share'
}

function main()
{
    local -r appFolderPath="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    source "${appFolderPath}/../../../libraries/util.bash"

    checkRequireMacSystem
    checkRequireRootUser

    header 'UNINSTALLING BREW'

    # Uninstall

    uninstall
}

main "${@}"