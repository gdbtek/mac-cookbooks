#!/bin/bash -e

function installDependencies()
{
    if [[ "$(existCommand 'brew')" = 'false' ]]
    then
        "${APP_FOLDER_PATH}/../cookbooks/brew/recipes/install.bash" 'true'
    fi
}

function install()
{
    local -r applicationName="${1}"
    local commandName="${2}"

    if [[ "$(isEmptyString "${commandName}")" = 'true' ]]
    then
        commandName="${applicationName}"
    fi

    initializeFolder "$(getCurrentUserHomeFolder)/Library/Caches/Homebrew"

    if [[ "$(existCommand "${commandName}")" = 'true' || -d "/usr/local/opt/${applicationName}" ]]
    then
        brew reinstall "${applicationName}"
    else
        brew install "${applicationName}"
    fi

    displayVersion "$(brew list --versions "${applicationName}")"
}

function main()
{
    local -r applicationName="${1}"
    local -r commandName="${2}"

    APP_FOLDER_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    source "${APP_FOLDER_PATH}/../libraries/util.bash"

    checkRequireMacSystem
    checkRequireNonRootUser
    checkNonEmptyString "${applicationName}" 'undefined application name'

    header "INSTALLING $(tr '[:lower:]' '[:upper:]' <<< "${applicationName}")"

    # Install

    installDependencies
    install "${applicationName}" "${commandName}"
}

main "${@}"