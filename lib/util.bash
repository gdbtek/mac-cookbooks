#!/bin/bash

function header
{
    echo -e "\n\033[1;33m>>>>>>>>>> \033[1;4;35m${1}\033[0m \033[1;33m<<<<<<<<<<\033[0m\n"
}

function error()
{
    echo -e "\033[1;31m${1}\033[0m" 1>&2
}

function fatal()
{
    error "${1}"
    exit 1
}

function getFileName()
{
    local fullFileName="$(basename "${1}")"

    echo "${fullFileName%.*}"
}

function getFileExtension()
{
    local fullFileName="$(basename "${1}")"

    echo "${fullFileName##*.}"
}

function escapeSearchPattern()
{
    echo "$(echo "${1}" | sed "s@\[@\\\\[@g" | sed "s@\*@\\\\*@g" | sed "s@\%@\\\\%@g")"
}

function createFileFromTemplate()
{
    local sourceFile="${1}"
    local destinationFile="${2}"
    local data=("${@:3}")

    if [[ -f "${sourceFile}" ]]
    then
        local content="$(cat "${sourceFile}")"

        for ((i = 0; i < ${#data[@]}; i = i + 2))
        do
            local oldValue="$(escapeSearchPattern "${data[${i}]}")"
            local newValue="$(escapeSearchPattern "${data[${i} + 1]}")"

            content="$(echo "${content}" | sed "s@${oldValue}@${newValue}@g")"
        done

        echo "${content}" > "${destinationFile}"
    else
        fatal "ERROR: file '${sourceFile}' not found!"
    fi
}

function unzipRemoteFile()
{
    local downloadURL="${1}"
    local installFolder="${2}"

    local extension="$(getFileExtension "${downloadURL}")"

    if [[ "$(echo "${extension}" | grep -i 'tgz')" != '' || "$(echo "${downloadURL}" | grep -io ".tar.gz$")" != '' ]]
    then
        curl -L "${downloadURL}" | tar xz --strip 1 -C "${installFolder}"
    elif [[ "$(echo "${extension}" | grep -i 'zip')" != '' ]]
    then
        local zipFile="${installFolder}/$(basename "${downloadURL}")"

        curl -L "${downloadURL}" -o "${zipFile}"
        unzip -q "${zipFile}" -d "${installFolder}"
        rm -f "${zipFile}"
    else
        fatal "ERROR: file extension '${extension}' is not yet supported to unzip!"
    fi
}

function getRemoteFileContent()
{
    curl -s -X 'GET' "${1}"
}

function getTemporaryFolder()
{
    mktemp -d "$(formatPath "${TMPDIR}")/$(date +%m%d%Y_%H%M%S)_XXXXXXXXXX"
}

function formatPath()
{
    local string="${1}"

    while [[ "$(echo "${string}" | grep -F '//')" != '' ]]
    do
        string="$(echo "${string}" | sed -e 's/\/\/*/\//g')"
    done

    echo "${string}" | sed -e 's/\/$//g'
}