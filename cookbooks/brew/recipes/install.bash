#!/bin/bash -e

function install()
{
    local -r confirm="${1}"

    if [[ "${confirm}" = 'true' ]]
    then
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < '/dev/null'
    else
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi

    displayVersion "$(brew -v)"
}

function main()
{
    local -r confirm="${1}"

    local -r appFolderPath="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    source "${appFolderPath}/../../../libraries/util.bash"

    checkRequireMacSystem
    checkRequireNonRootUser

    header 'INSTALLING BREW'

    # Install

    install "${confirm}"
}

main "${@}"