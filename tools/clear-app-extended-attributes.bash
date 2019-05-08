#!/bin/bash -e

function clearAppExtendedAttributesOfPath()
{
    local -r appPath="${1}"
    local -r fileNameRegex="${2}"

    if [[ -d "${appPath}" ]]
    then
        # Get App Path List

        local -r OLD_IFS="${IFS}"
        IFS=$'\n'

        local -r appPathList=($(
            find "${appPath}" \
                -type d \
                -name "${fileNameRegex}" \
                -maxdepth 2 |
            sort -f
        ))

        IFS="${OLD_IFS}"

        # Clear Extended Attributes

        clearMacAppExtendedAttributes "CLEARING EXTENDED ATTRIBUTES OF ${appPath}" "${appPathList[@]}"
    fi
}

function main()
{
    local -r folderPath="${1}"

    source "$(dirname "${BASH_SOURCE[0]}")/../libraries/util.bash"

    # Validations

    checkRequireMacSystem
    checkRequireRootUser

    # Clear Extended Attributes

    if [[ "$(isEmptyString "${folderPath}")" = 'true' ]]
    then
        clearAppExtendedAttributesOfPath '/Applications' '*.app'
        clearAppExtendedAttributesOfPath "$(getCurrentUserHomeFolder)/Applications" '*.app'
    else
        checkExistFolder "${folderPath}"
        clearAppExtendedAttributesOfPath "${folderPath}" '*'
    fi
}

main "${@}"