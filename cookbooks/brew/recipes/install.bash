#!/bin/bash -e

function install()
{
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    displayVersion "$(brew -v)"
}

function main()
{
    local -r appFolderPath="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    source "${appFolderPath}/../../../libraries/util.bash"

    checkRequireMacSystem

    header 'INSTALLING BREW'

    # Install

    install
}

main "${@}"