#!/bin/bash -e

function install()
{
    # Clean Up

    rm -rf "${installBinFolder}" "${installConfigFolder}" "${installDataFolder}"
    mkdir -p "${installBinFolder}" "${installConfigFolder}" "${installDataFolder}"

    # Install

    local currentPath="$(pwd)"
    local tempFolder="$(getTemporaryFolder)"

    unzipRemoteFile "${downloadURL}" "${tempFolder}"
    cd "${tempFolder}"
    make
    find "${tempFolder}/src" -type f ! -name "*.sh" -perm -u+x -exec cp -f {} "${installBinFolder}" \;
    rm -rf "${tempFolder}"
    cd "${currentPath}"

    # Config Server

    local serverConfigData=(
        '__INSTALL_DATA_FOLDER__' "${installDataFolder}"
        6379 "${port}"
    )

    createFileFromTemplate "${appPath}/../files/conf/redis.conf" "${installConfigFolder}/redis.conf" "${serverConfigData[@]}"
}

function main()
{
    appPath="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    source "${appPath}/../../../lib/util.bash" || exit 1
    source "${appPath}/../attributes/default.bash" || exit 1

    header 'INSTALLING REDIS'

    install
}

main "${@}"