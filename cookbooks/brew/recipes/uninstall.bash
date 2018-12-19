#!/bin/bash -e

function uninstall()
{
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)" || true
    rm -f -r '/usr/local/.com.apple.installer.keep' \
             '/usr/local/bin' \
             '/usr/local/Caskroom' \
             '/usr/local/Cellar' \
             '/usr/local/etc' \
             '/usr/local/Frameworks' \
             '/usr/local/Homebrew' \
             '/usr/local/include' \
             '/usr/local/lib' \
             '/usr/local/opt' \
             '/usr/local/sbin' \
             '/usr/local/share' \
             '/usr/local/var'
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