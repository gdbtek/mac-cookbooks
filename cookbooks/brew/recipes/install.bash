#!/bin/bash -e

function install()
{
    local -r confirm="${1}"

    if [[ "${confirm}" = 'true' ]]
    then
        bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" < '/dev/null'
        # ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < '/dev/null'
    else
        bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        # ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
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