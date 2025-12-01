#!/bin/bash -e

function main()
{
    source "$(dirname "${BASH_SOURCE[0]}")/../../../libraries/util.bash"

    header 'INSTALLING CAMERAS/VDC-ASSISTANT'

    checkRequireMacSystem
    checkRequireNonRootUser

    local -r plistSourceFilePath="$(dirname "${BASH_SOURCE[0]}")/../files/com.user.camera.vdc-assistant.plist"
    local -r plistDestinationFilePath="$(getCurrentUserHomeFolder)/Library/LaunchAgents/$(basename "${plistSourceFilePath}")"

    mkdir -m '0700' -p "$(dirname "${plistDestinationFilePath}")"
    cp "${plistSourceFilePath}" "${plistDestinationFilePath}"
    cat "${plistDestinationFilePath}"
    sudo launchctl load "${plistDestinationFilePath}"
}

main "${@}"