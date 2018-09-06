#!/bin/bash -e

function install()
{
    # Clean Up

    initializeFolder "${GOOGLE_CLOUD_SDK_INSTALL_FOLDER_PATH}"
    rm -f '/usr/local/bin/gcloud'

    # Install

    unzipRemoteFile "${GOOGLE_CLOUD_SDK_DOWNLOAD_URL}" "${GOOGLE_CLOUD_SDK_INSTALL_FOLDER_PATH}"
    "${GOOGLE_CLOUD_SDK_INSTALL_FOLDER_PATH}/install.sh" --quiet
    "${GOOGLE_CLOUD_SDK_INSTALL_FOLDER_PATH}/bin/gcloud" components update
    chown -R "${SUDO_USER}:$(getUserGroupName "${SUDO_USER}")" "${GOOGLE_CLOUD_SDK_INSTALL_FOLDER_PATH}" "$(getUserHomeFolder "${SUDO_USER}")/.config"
    ln -f -s "${GOOGLE_CLOUD_SDK_INSTALL_FOLDER_PATH}/bin/gcloud" '/usr/local/bin/gcloud'

    # Display Version

    displayVersion "$("${GOOGLE_CLOUD_SDK_INSTALL_FOLDER_PATH}/bin/gcloud" --version)"
}

function main()
{
    APP_FOLDER_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    source "${APP_FOLDER_PATH}/../../../libraries/util.bash"
    source "${APP_FOLDER_PATH}/../attributes/default.bash"

    checkRequireMacSystem
    checkRequireRootUser

    header 'INSTALLING GOOGLE-CLOUD-SDK'

    install
}

main "${@}"