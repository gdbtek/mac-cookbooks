#!/bin/bash -e

function uninstall()
{
    local -r confirm="${1}"

    if [[ "${confirm}" = 'true' ]]
    then
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)" < '/dev/null' || true
    else
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)" || true
    fi

    rm -f -r \
        '/usr/local/.com.apple.installer.keep' \
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
        '/usr/local/var'

    sudo rm -f -r '/usr/local/share'
}

function main()
{
    local -r confirm="${1}"

    local -r appFolderPath="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    source "${appFolderPath}/../../../libraries/util.bash"

    checkRequireMacSystem
    checkRequireNonRootUser

    header 'UNINSTALLING BREW'

    # Uninstall

    uninstall "${confirm}"
}

main "${@}"