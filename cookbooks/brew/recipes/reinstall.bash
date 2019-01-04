#!/bin/bash -e

function main()
{
    local -r confirm="${1}"

    local -r appFolderPath="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    source "${appFolderPath}/../../../libraries/util.bash"

    checkRequireMacSystem
    checkRequireRootUser

    "${appFolderPath}/uninstall.bash" "${confirm}"
    sudo -u "${SUDO_USER}" "${appFolderPath}/install.bash" "${confirm}"
}

main "${@}"