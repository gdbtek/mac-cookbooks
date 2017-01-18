#!/bin/bash -e

function install()
{
    # Clean Up

    initializeFolder "${PHANTOM_JS_INSTALL_FOLDER}"

    # Install

    unzipRemoteFile "${PHANTOM_JS_DOWNLOAD_URL}" "${PHANTOM_JS_INSTALL_FOLDER}"

    local -r unzipFolder="$(find "${PHANTOM_JS_INSTALL_FOLDER}" -maxdepth 1 -type d 2> '/dev/null' | tail -1)"

    if [[ "$(isEmptyString "${unzipFolder}")" = 'true' || "$(trimString "$(wc -l <<< "${unzipFolder}")")" != '1' ]]
    then
        fatal 'FATAL : multiple unzip folder names found'
    fi

    if [[ "$(ls -A "${unzipFolder}")" = '' ]]
    then
        fatal "FATAL : folder '${unzipFolder}' empty"
    fi

    moveFolderContent "${unzipFolder}" "${PHANTOM_JS_INSTALL_FOLDER}"
    rm -f -r "${unzipFolder}"

    # Config

    chown -R "${SUDO_USER}:$(getUserGroupName "${SUDO_USER}")" "${PHANTOM_JS_INSTALL_FOLDER}"
    ln -f -s "${PHANTOM_JS_INSTALL_FOLDER}/bin/phantomjs" '/usr/local/bin/phantomjs'

    # Display Version

    displayVersion "$("${PHANTOM_JS_INSTALL_FOLDER}/bin/phantomjs" --version)"
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