#!/bin/bash -e

function main()
{
    source "$(dirname "${BASH_SOURCE[0]}")/../../../libraries/util.bash"

    checkRequireMacSystem
    checkRequireRootUser

    sudo -u "${SUDO_USER}" npm install -g 'npm@latest' || true
    displayVersion "$(npm --version)" 'NPM'
}

main "${@}"