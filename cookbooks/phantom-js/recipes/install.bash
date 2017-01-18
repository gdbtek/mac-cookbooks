#!/bin/bash -e

function install()
{
    # Clean Up

    initializeFolder "${PHANTOM_JS_INSTALL_FOLDER}"

    # Install

    unzipRemoteFile "${PHANTOM_JS_DOWNLOAD_URL}" "${PHANTOM_JS_INSTALL_FOLDER}"
    chown -R "${SUDO_USER}:$(getUserGroupName "${SUDO_USER}")" "${PHANTOM_JS_INSTALL_FOLDER}"
    ln -f -s "${PHANTOM_JS_INSTALL_FOLDER}/bin/phantomjs" '/usr/local/bin/phantomjs'

    # Display Version

    displayVersion "$("${PHANTOM_JS_INSTALL_FOLDER}/bin/phantomjs" version)"
}

function main()
{
    local -r appFolderPath="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    source "${appFolderPath}/../../../libraries/util.bash"
    source "${appFolderPath}/../attributes/default.bash"

    checkRequireMacSystem
    checkRequireRootUser

    header 'INSTALLING PHANTOM-JS'

    install
}

main "${@}"