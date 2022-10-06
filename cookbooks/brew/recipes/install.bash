#!/bin/bash -e

function install()
{
    local -r confirm="${1}"

    if [[ "${confirm}" = 'true' ]]
    then
        bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" < '/dev/null'
    else
        bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    initializeFolder "$(brew --cache)"
    displayVersion "$(brew -v)" 'BREW'
}

function main()
{
    local -r confirm="${1}"

    source "$(dirname "${BASH_SOURCE[0]}")/../../../libraries/util.bash"

    header 'INSTALLING BREW'

    checkRequireMacSystem
    checkRequireNonRootUser

    install "${confirm}"
}

main "${@}"