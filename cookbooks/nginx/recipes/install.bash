#!/bin/bash

function install()
{
    # Clean Up

    rm -rf "${installFolder}"
    mkdir -p "${installFolder}"

    # Download PCRE

    local pcreTempFolder="$(getTemporaryFolder)"

    unzipRemoteFile "${pcreDownloadURL}" "${pcreTempFolder}"

    # Install

    local currentPath="$(pwd)"
    local nginxTempFolder="$(getTemporaryFolder)"

    unzipRemoteFile "${nginxDownloadURL}" "${nginxTempFolder}"
    cd "${nginxTempFolder}"
    "${nginxTempFolder}/configure" --prefix="${installFolder}" --with-cc-opt="-Wno-deprecated-declarations" --with-http_ssl_module --with-pcre="${pcreTempFolder}/$(getFileName "${pcreDownloadURL}")"
    make
    make install
    rm -rf "${pcreTempFolder}" "${nginxTempFolder}"
    cd "${currentPath}"

    # Config Server

    local serverConfigData=('__PORT__' "${port}")

    createFileFromTemplate  "${appPath}/../files/conf/nginx.conf" "${installFolder}/conf/nginx.conf" "${serverConfigData[@]}"
}

function main()
{
    appPath="$(cd "$(dirname "${0}")" && pwd)"

    source "${appPath}/../../../lib/util.bash" || exit 1
    source "${appPath}/../attributes/default.bash" || exit 1

    header 'INSTALLING NGINX'

    install
}

main "${@}"
