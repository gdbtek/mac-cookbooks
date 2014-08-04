#!/bin/bash -e

########################
# FILE LOCAL UTILITIES #
########################

function createFileFromTemplate()
{
    local sourceFile="${1}"
    local destinationFile="${2}"
    local data=("${@:3}")

    if [[ -f "${sourceFile}" ]]
    then
        local content="$(cat "${sourceFile}")"
        local i=0

        for ((i = 0; i < ${#data[@]}; i = i + 2))
        do
            local oldValue="$(escapeSearchPattern "${data[${i}]}")"
            local newValue="$(escapeSearchPattern "${data[${i} + 1]}")"

            content="$(echo "${content}" | sed "s@${oldValue}@${newValue}@g")"
        done

        echo "${content}" > "${destinationFile}"
    else
        fatal "FATAL: file '${sourceFile}' not found!"
    fi
}

function getFileExtension()
{
    local fullFileName="$(basename "${1}")"

    echo "${fullFileName##*.}"
}

function getFileName()
{
    local fullFileName="$(basename "${1}")"

    echo "${fullFileName%.*}"
}

#########################
# FILE REMOTE UTILITIES #
#########################

function getRemoteFileContent()
{
    local url="${1}"

    # Get Content

    curl -s -X 'GET' "${url}"
}

function unzipRemoteFile()
{
    local downloadURL="${1}"
    local installFolder="${2}"
    local extension="${3}"

    # Find Extension

    if [[ "$(isEmptyString "${extension}")" = 'true' ]]
    then
        extension="$(getFileExtension "${downloadURL}")"
        local exExtension="$(echo "${downloadURL}" | rev | cut -d '.' -f 1-2 | rev)"
    fi

    # Unzip

    if [[ "$(echo "${extension}" | grep -i '^tgz$')" != '' ||
          "$(echo "${extension}" | grep -i '^tar\.gz$')" != '' ||
          "$(echo "${exExtension}" | grep -i '^tar\.gz$')" != '' ]]
    then
        echo
        curl -L "${downloadURL}" | tar xz --strip 1 -C "${installFolder}"
    elif [[ "$(echo "${extension}" | grep -i '^zip$')" != '' ]]
    then
        # Unzip

        if [[ "$(existCommand 'unzip')" = 'true' ]]
        then
            local zipFile="${installFolder}/$(basename "${downloadURL}")"

            echo
            curl -L "${downloadURL}" -o "${zipFile}"
            unzip -q "${zipFile}" -d "${installFolder}"
            rm -f "${zipFile}"
        else
            fatal "FATAL: install 'unzip' command failed!"
        fi
    else
        fatal "FATAL: file extension '${extension}' is not yet supported to unzip!"
    fi
}

####################
# STRING UTILITIES #
####################

function error()
{
    echo -e "\033[1;31m${1}\033[0m" 1>&2
}

function escapeSearchPattern()
{
    echo "$(echo "${1}" | sed "s@\[@\\\\[@g" | sed "s@\*@\\\\*@g" | sed "s@\%@\\\\%@g")"
}

function fatal()
{
    error "${1}"
    exit 1
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

function header()
{
    echo -e "\n\033[1;33m>>>>>>>>>> \033[1;4;35m${1}\033[0m \033[1;33m<<<<<<<<<<\033[0m\n"
}

function info()
{
    echo -e "\033[1;36m${1}\033[0m"
}

function isEmptyString()
{
    if [[ "$(trimString ${1})" = '' ]]
    then
        echo 'true'
    else
        echo 'false'
    fi
}

function trimString()
{
    echo "${1}" | sed -e 's/^ *//g' -e 's/ *$//g'
}

####################
# SYSTEM UTILITIES #
####################

function existCommand()
{
    local command="${1}"

    if [[ "$(which "${command}")" = '' ]]
    then
        echo 'false'
    else
        echo 'true'
    fi
}

function getTemporaryFolder()
{
    local temporaryDirectory='/tmp'

    if [[ "$(isEmptyString "${TMPDIR}")" = 'false' ]]
    then
        temporaryDirectory="$(formatPath "${TMPDIR}")"
    fi

    mktemp -d "${temporaryDirectory}/$(date +%m%d%Y_%H%M%S)_XXXXXXXXXX"
}