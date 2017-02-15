#!/bin/bash -e

function installDependencies()
{
    if [[ "$(existCommand 'brew')" = 'false' ]]
    then
        "${APP_FOLDER_PATH}/../../brew/recipes/install.bash"
    fi
}

function install()
{
    initializeFolder "$(getUserHomeFolder "${SUDO_USER}")/Library/Caches/Homebrew"

    su -l "${SUDO_USER}" -c "${DIALOG_BREW_INSTALL_FOLDER_PATH}/bin/brew install dialog"

    if [[ "${DIALOG_BREW_INSTALL_FOLDER_PATH}" != '/usr/local' ]]
    then
        ln -f -s "${DIALOG_BREW_INSTALL_FOLDER_PATH}/bin/dialog" '/usr/local/bin/dialog'
    fi

    displayVersion "$(dialog -V)"
}

function main()
{
    APP_FOLDER_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    source "${APP_FOLDER_PATH}/../../../libraries/util.bash"
    source "${APP_FOLDER_PATH}/../attributes/default.bash"

    checkRequireMacSystem
    checkRequireRootUser

    header 'INSTALLING DIALOG'

    # Install

    installDependencies
    install
}

main "${@}"